import ssbClient from 'ssb-client'
import ssbKeys from 'ssb-keys'
import ssbRef from 'ssb-ref'
import path from 'path'
import pull from 'pull-stream'
import FileReaderStream from 'pull-file-reader'
import pullFlatmap from 'pull-flatmap'
import pullCat from 'pull-cat'
import pullParamap from 'pull-paramap'
import Promise from 'bluebird'
import _ from 'lodash'
import Pub from '../models/Pub'
import Post from '../models/Post'

/**
 * Adapter for querying, creating and storing tale:net data from / to SSB.
 */
export default class SSBAdapter {
  static PROTOCOL_VERSION = 1

  static TALENET_TYPE_PREFIX = 'talenet-'
  static TALENET_VERSION_FIELD = SSBAdapter.TALENET_TYPE_PREFIX + 'version'

  static TYPE_SSB_POST = 'post'
  static TYPE_SSB_CONTACT = 'contact' // predefined by ssb, thus no prefix
  static TYPE_SSB_BLOCK_AUTHOR = SSBAdapter.TYPE_SSB_CONTACT
  static TYPE_SSB_PUB = 'pub'

  _messageHandlers = {}
  _blockedAuthors = new Set()
  _subscribedBlockListAuthors = new Set()
  _pubs = {}
  _pubSubscriptions = {}
  _pubPostsSubscriptions = {}
  _activity = 'initializing'

  constructor () {
    this._sbot = null
    this._config = null

    this.registerMessageHandlers({
      [SSBAdapter.TYPE_SSB_POST]: this._handlePost.bind(this),
      [SSBAdapter.TYPE_SSB_CONTACT]: this._handleContact.bind(this),
      [SSBAdapter.TYPE_SSB_PUB]: this._handlePub.bind(this)
    })

    // You can use this for easier testing / debugging
    window.ssbAdapter = this
  }

  registerMessageHandlers (handlers) {
    this._messageHandlers = {
      ...this._messageHandlers,
      ...handlers
    }
  }

  connect (store) {
    return new Promise((resolve, reject) => {
      ssbClient((err, sbot, config) => {
        if (err) {
          return reject(err)
        }
        this._sbot = sbot
        this._config = config

        if (!this._sbot.about) {
          return reject(new Error('tale:net needs the ssb-about plugin'))
        }

        this._sbot.about.get((err, about) => {
          this._about = about
          console.log('about:', err, this._about)
        })

        if (!this._sbot.friends) {
          return reject(new Error('tale:net needs the ssb-friends plugin'))
        }

        if (!this._sbot.private) {
          return reject(new Error('tale:net needs the ssb-private plugin'))
        }

        if (!this._sbot.talequery) {
          return reject(new Error('tale:net needs the ssb-talequery plugin. If you want to use your own \'sbot server\' please use \'sbot plugins.install ssb-talequery\' to install it.'))
        }

        this._subscribedBlockListAuthors.add(this._sbot.id)

        store.commit('ssb/connected')
        sbot.on('closed', () => {
          store.commit('ssb/disconnect')
        })

        console.time('tale:init')
        Promise.all([
          this._loadUsedPubs().then(() => this._loadBlockedAuthors()),
          this._setupActivityMonitor(store)
        ]).then(() => {
          this._pullTaleNetMessages()
          this._pullPubPosts()

          // then make sure new incoming blocks at least affect new incoming messages
          this._pullBlockedAuthors()

          store.commit('ssb/initialized')
          resolve()
          return null
        }).catch(err => {
          reject(err)
        }).finally(() => {
          console.timeEnd('tale:init')
        })
      })
    })
  }

  _setupActivityMonitor (store) {
    return new Promise((resolve, reject) => {
      const statusApi = this._sbot.status
      if (!statusApi) {
        reject(new Error('tale:net needs the sbot status api'))
        return
      }
      const i = setInterval(() => {
        statusApi((err, status) => {
          if (err) {
            return console.error(err) // TODO: internal error delegation
          }
          /*
          let connectedCount = 0
          for (const pid of Object.keys(status.gossip)) {
            const peer = status.gossip[pid]
            if (peer.state) {
              if (peer.state === 'connected') {
                connectedCount++
              }
            }
          }
          // TODO: show the connected peers in the dev:tools?
          console.log('connected to ' + connectedCount + ' peers')
          */

          const prevActivity = this._activity

          const i = status.progress.indexes
          if (!status.sync.sync) {
            this._activity = 'downloading'
            // console.log('downloading new messages.')
          } else {
            const msgsTODO = i.target - i.current
            if (msgsTODO > 0) {
              // console.log('indexing! diff:' + msgsTODO)
              // TODO: pass amount?
              this._activity = 'indexing'
            } else if (msgsTODO === 0) {
              this._activity = 'ready'
            }
          }

          if (this._activity !== prevActivity) {
            store.commit('ssb/activity', this._activity)
          }
        })
      }, 500)
      resolve(i)
    })
  }

  _pullTaleNetMessages () {
    pull(
      this._sbot.query.read({
        query: [{ $filter: { value: { content: { type: { $prefix: SSBAdapter.TALENET_TYPE_PREFIX } } } } }],
        live: true
      }),
      this._filterBlockedMessages(),
      pull.drain(msg => this.handleMessage(msg))
    )
  }

  _pullPubPosts () {
    pull(
      this._sbot.messagesByType({
        type: SSBAdapter.TYPE_SSB_POST,
        live: true
      }),
      this._filterBlockedMessages(),
      pull.filter(msg => this._isPubMessageAfterAcceptedInvite(msg)),
      pull.drain(msg => this.handleMessage(msg))
    )
  }

  _isPubMessageAfterAcceptedInvite (msg) {
    const value = msg.value
    const pub = value && this._pubs[value.author]

    if (!pub) {
      return false
    }

    return pub.timestamp() < msg.value.timestamp
  }

  // pulling pubs for initial blocklist
  _loadUsedPubs () {
    return new Promise((resolve, reject) => {
      pull(
        this._sbot.query.read({
          query: [{
            $filter: {
              value: {
                author: this._sbot.id,
                content: { type: SSBAdapter.TYPE_SSB_PUB }
              }
            }
          }],
          live: false
        }),
        pull.collect((err, pubs) => {
          if (err) {
            return reject(err)
          }
          for (const p of pubs) {
            this._handlePub(p)
          }
          resolve()
        })
      )
    })
  }

  _loadBlockedAuthors () {
    const promises = []
    this._subscribedBlockListAuthors.forEach((author) => {
      promises.push(new Promise((resolve, reject) => {
        pull(
          this._sbot.query.read({
            query: [{
              $filter: {
                value: {
                  author: author,
                  content: {
                    type: SSBAdapter.TYPE_SSB_CONTACT,
                    blocking: true // TODO: warning - unblocking won't work like this. check if ssb-friends persists this using flume reduce
                  }
                }
              }
            }],
            live: false
          }),
          this._filterBlockedMessages(),
          pull.collect((err, msgs) => {
            if (err) {
              return reject(err)
            }

            for (const msg of msgs) {
              this._handleContact(msg)
            }

            resolve()
          })
        )
      }))
    })
    return Promise.all(promises)
  }

  _pullBlockedAuthors () {
    pull(
      this.streamByType(SSBAdapter.TYPE_SSB_CONTACT, true),
      pull.drain(msg => {
        this._handleContact(msg)
      })
    )
  }

  _filterBlockedMessages () {
    return pull.filter(msg => {
      return !this._msgIsBlocked(msg)
    })
  }

  _msgIsBlocked (msg) {
    const value = msg.value
    if (!value) {
      return false
    }

    return this._valueIsBlocked(value)
  }

  _valueIsBlocked (value) {
    return this._authorIsBlocked(value.author)
  }

  _authorIsBlocked (key) {
    return this._blockedAuthors.has(key)
  }

  _isFromSubscribedAuthor (author) {
    return this._subscribedBlockListAuthors.has(author)
  }

  isIdentityKey (value) {
    return ssbRef.isFeedId(value)
  }

  isMessageKey (value) {
    return ssbRef.isMsgId(value)
  }

  getValueByKey (key) {
    if (key === undefined) {
      console.error(new Error('Trying to get value by undefined key.'))
    }
    return new Promise((resolve, reject) => {
      // TODO: maybe use (async)memo to reduce load
      this._sbot.get(key, (err, value) => {
        if (err) {
          return reject(err)
        }
        if (this._valueIsBlocked(value)) {
          return reject(new Error('Message for key is blocked: ' + key))
        }
        if (typeof value.content === 'string') {
          // const u = this._sbot.private.unbox(value.content) // < BUGGED! somehow the unbox is okay in ssb-private but garbage once returned
          value.content = this.shittyUnbox(value.content)
          if (typeof value.content !== 'object') {
            return reject(new Error('unable to unbox msg: ' + key))
          }
          value.private = true
        }
        resolve(value)
      })
    })
  }

  streamByType (type, live = false) {
    if (type === undefined) {
      console.error(new Error('Trying to stream by undefined type.'))
    }
    return pull(
      this._sbot.query.read({
        query: [{ $filter: { value: { content: { type } } } }],
        live
      }),
      this._filterBlockedMessages()
    )
  }

  streamByIdea (ideaKey, live = false) {
    if (ideaKey === undefined) {
      console.error(new Error('Trying to stream by undefined idea.'))
    }
    return pull(
      this._sbot.talequery.read({
        query: [{ $filter: { value: { content: { ideaKey } } } }],
        live
      }),
      this._filterBlockedMessages()
    )
  }

  streamAbouts (identityKeyFilter) {
    // let sync = false
    // let collectedKeys = new Set()

    return pull(
      this._sbot.about.stream({ live: true }),
      pull.map(msg => {
        // console.log(msg)
        // if (!msg) {
        //   return []
        // }

        // console.log(msg.sync)

        // if (msg.sync) {
        //   debugger
        //   sync = msg.sync
        //   const keys = collectedKeys.entries()
        //   collectedKeys = new Set()
        //   return keys
        // }
        //
        // if (!sync) {
        //   for (const key in Object.keys(msg)) {
        //     collectedKeys.add(key)
        //   }
        //
        //   return []
        // }

        return Object.keys(msg)
      }),
      pullFlatmap(keys => {
        return keys
      }),
      pull.filter(key => !this._authorIsBlocked(key)),
      pull.filter(identityKeyFilter),
      pull.asyncMap((key, callback) =>
        this.getAbout(key)
          .then(about => callback(null, about))
          .catch(err => callback(err))
      )
    )
  }

  getAbout (key) {
    if (this._authorIsBlocked(key)) {
      return Promise.reject(new Error('Cannot get about info from blocked author: ' + key))
    }

    return new Promise((resolve, reject) => {
      this._sbot.about.get((err, about) => {
        if (err) {
          return reject(err)
        }

        resolve({ author: key, about: about[key] })
      })
    })
  }

  streamPrivate (q) {
    const opts = {
      ...q,
      query: [{
        $filter: {
          // content: { type: 'post' }, // <= doesn't work - not indexed?
          timestamp: {
            // $lte: Number(q.lt) || Date.now(),
            $gte: Number(q.gt) || -Infinity
          }
        }
      }]
    }
    return pull(
      this._sbot.private.read(opts),
      this._filterBlockedMessages(),
      pull.filter((msg) => {
        if (msg === false) {
          return false
        }
        if (msg && msg.sync) {
          return false
        }
        return msg.value.content && msg.value.content.type === 'post'
      })
    )
  }

  collectThread (key) {
    return this.getValueByKey(key).then((value) => {
      const msg = { key: key, value: value }
      return new Promise((resolve, reject) => {
        pull(
          pullCat([pull.once(msg), this._sbot.links({ dest: key, values: true })]), // TODO: maybe backlinks?
          pull.unique('key'),
          pullParamap(this.maybeUnboxAsync.bind(this)),
          pull.collect((err, msgs) => {
            if (err) {
              return reject(err)
            }
            resolve(msgs)
          })
        )
      })
    })
  }

  // TODO: see BUGGED above.
  // somehow I can't use ssb-private.unbox() across the muxrpc barrier between frontend and sbot hidden window.
  // maybe it's an es6/babel <> sodium bindings thing, no idea..
  // this works but we should load private on each call
  shittyUnbox (ciphertext) {
    const cfg = this._config
    const priv = ssbKeys.loadSync(path.join(cfg.path, 'secret')).private
    var data
    try {
      data = ssbKeys.unbox(ciphertext, priv)
    } catch (e) {
      throw e
    }
    return data
  }

  maybeUnboxAsync (msg, cb) {
    const c = msg && msg.value && msg.value.content
    if (typeof c !== 'string') cb(null, msg)
    else {
      const u = this.shittyUnbox(c)
      if (typeof u !== 'object') {
        return cb(new Error('couldn\'t unbox msg'))
      }
      msg.value.content = u
      msg.value.privte = true
      cb(null, msg)
    }
  }

  static getMessageType (msg) {
    const value = msg.value
    if (!value) {
      return null
    }

    const content = value.content
    if (!content) {
      return null
    }

    const type = content.type
    if (typeof type !== 'string') {
      return null
    }

    return type
  }

  handleMessage (msg) {
    if (this._msgIsBlocked(msg)) {
      return
    }

    const type = SSBAdapter.getMessageType(msg)
    if (!type) {
      return
    }

    const handler = this._messageHandlers[type]
    if (handler) {
      handler(msg)
    }
  }

  _handlePost (msg) {
    if (!this._isPubMessageAfterAcceptedInvite(msg)) {
      // TODO: Handling of other posts
      return
    }

    const post = Post.fromSsb(msg)
    SSBAdapter.propagateUpdate(this._pubPostsSubscriptions, post)
  }

  _handleContact (msg) {
    const value = msg.value
    if (!value) {
      return
    }

    const author = value.author
    const content = value.content

    if (!author || !content) {
      return
    }

    const ownMessage = author === this.ownId()
    const contact = content.contact
    const blocking = content.blocking

    if ((ownMessage || this._isFromSubscribedAuthor(author)) && _.isString(contact) && contact !== this.ownId() && blocking) {
      this._blockedAuthors.add(contact)
    }
  }

  _handlePub (msg) {
    const value = msg.value
    if (!value) {
      return
    }

    const content = value.content
    if (!content) {
      return
    }

    const address = content.address
    if (!address) {
      return
    }

    const pubKey = address.key
    if (!pubKey) {
      return
    }

    this._subscribedBlockListAuthors.add(pubKey)

    const pub = Pub.fromSsb(address, value.timestamp)
    this._pubs[pubKey] = pub
    SSBAdapter.propagateUpdate(this._pubSubscriptions, pub)
  }

  publish (type, payload) {
    if (type === undefined) {
      return Promise.reject(new Error('Trying to publish message with undefined type: ', payload))
    }
    return new Promise((resolve, reject) => {
      const msg = {
        ...payload,
        type,
        [SSBAdapter.TALENET_VERSION_FIELD]: SSBAdapter.PROTOCOL_VERSION
      }
      const cb = (err, publishedMsg) => {
        if (err) {
          return reject(err)
        }
        this.handleMessage(publishedMsg)
        resolve(publishedMsg)
      }
      if (Array.isArray(payload.recps)) {
        this._sbot.private.publish(msg, payload.recps, cb)
      } else {
        this._sbot.publish(msg, cb)
      }
    })
  }

  isFollowing (src, dest) {
    if (typeof src !== 'string') {
      return Promise.reject(new Error('isFollowing needs src param as string'))
    }

    if (typeof dest !== 'string') {
      return Promise.reject(new Error('isFollowing needs dest param as string'))
    }

    if (src === dest) {
      return Promise.reject(new Error('isFollowing called with equal src and dest'))
    }

    const qry = {
      source: src,
      dest: dest
    }

    return new Promise((resolve, reject) => {
      this._sbot.friends.get(qry, (err, currState) => {
        if (err) {
          return reject(err)
        }
        resolve(!!currState)
      })
    })
  }

  setFollow (dest, doFollow) {
    if (dest === undefined) {
      return Promise.reject(new Error('Trying to follow undefined identity.'))
    }

    if (dest === this.ownId()) {
      return Promise.reject(new Error('Trying to follow own identity: ', dest))
    }

    return this.isFollowing(this.ownId(), dest).then((isFollowing) => {
      if (doFollow === isFollowing) {
        return { following: doFollow }
      }
      return this.publish(SSBAdapter.TYPE_SSB_CONTACT, {
        contact: dest,
        following: !isFollowing
      }).then(() => {
        return { following: doFollow }
      })
    })
  }

  blockAuthor (id) {
    if (id === undefined) {
      return Promise.reject(new Error('Trying to block undefined identity.'))
    }

    if (id === this.ownId()) {
      return Promise.reject(new Error('Trying to block own identity: ', id))
    }

    return this.publish(SSBAdapter.TYPE_SSB_BLOCK_AUTHOR, {
      contact: id,
      blocking: true
    }).then(() => {
      return id
    })
  }

  subscribePubs (subscriptionId, onUpdate) {
    const subscription = this.subscribe(subscriptionId, this._pubSubscriptions, null, onUpdate)

    for (const pub of Object.values(this._pubs)) {
      onUpdate(pub)
    }

    return subscription
  }

  subscribePubPosts (subscriptionId, onUpdate) {
    return this.subscribe(subscriptionId, this._pubPostsSubscriptions, null, onUpdate)
  }

  subscribe (subscriptionId, subscriptions, keys, onUpdate, onCancel) {
    const subscription = {
      promise: new Promise((resolve, reject, onPromiseCancel) => {
        onPromiseCancel(() => {
          this._unsubscribe(subscriptionId, subscriptions, subscription, keys)
          if (_.isFunction(onCancel)) {
            onCancel()
          }
        })
      }),
      propagateUpdate: onUpdate
    }

    if (keys) {
      for (const key of new Set(keys)) {
        const subscriptionsForKey = subscriptions[key] || {}
        const subscriptionsForId = subscriptionsForKey[subscriptionId] || []
        subscriptionsForId.push(subscription)
        subscriptionsForKey[subscriptionId] = subscriptionsForId
        subscriptions[key] = subscriptionsForKey
      }
    } else {
      const subscriptionsForId = subscriptions[subscriptionId] || []
      subscriptionsForId.push(subscription)
      subscriptions[subscriptionId] = subscriptionsForId
    }

    return subscription.promise
  }

  _unsubscribe (subscriptionId, subscriptions, subscription, keys) {
    if (keys) {
      for (const key of new Set(keys)) {
        const subscriptionsForKey = subscriptions[key][subscriptionId]
        if (subscriptionsForKey) {
          _.remove(subscriptionsForKey, (s) => s === subscription)
          if (_.isEmpty(subscriptionsForKey)) {
            delete subscriptions[key][subscriptionId]
          }
          if (_.isEmpty(subscriptions[key])) {
            delete subscriptions[key]
          }
        }
      }
    } else {
      _.remove(subscriptions[subscriptionId], (s) => s === subscription)
      if (_.isEmpty(subscriptions[subscriptionId])) {
        delete subscriptions[subscriptionId]
      }
    }
  }

  static propagateUpdate (subscriptions, value, ...keys) {
    if (keys && !_.isEmpty(keys)) {
      for (const key of keys) {
        SSBAdapter._doPropagateUpdate(subscriptions, value, key)
      }
    } else {
      SSBAdapter._doPropagateUpdate(subscriptions, value)
    }
  }

  static _doPropagateUpdate (subscriptions, value, key = null) {
    let subscriptionsById = subscriptions
    if (key) {
      subscriptionsById = subscriptions[key]
    }

    for (const subscriptionsForId of Object.values(subscriptionsById || {})) {
      if (!_.isEmpty(subscriptionsForId)) {
        // Optimization: For each subscription id we only propagete the update once.
        subscriptionsForId[0].propagateUpdate(value)
      }
    }
  }

  storeFile (file) {
    return new Promise((resolve, reject) => {
      pull(
        FileReaderStream(file),
        this._sbot.blobs.add((err, key) => {
          if (err) {
            return reject(err)
          }

          resolve(key)
        })
      )
    })
  }

  ownId () {
    return this._sbot.id
  }

  secretKeys () {
    return ssbKeys.loadSync(path.join(this._config.path, 'secret'))
  }

  acceptInvite (inviteCode) {
    return new Promise((resolve, reject) => {
      this._sbot.invite.accept(inviteCode.trim(), (err, msgs) => {
        if (err) {
          console.error(err)
          return resolve({
            success: false
          })
        }

        for (const msg of msgs) {
          this.handleMessage(msg)
        }

        // TODO: Load pub messages

        resolve({
          success: true
        })
      })
    })
  }
}
