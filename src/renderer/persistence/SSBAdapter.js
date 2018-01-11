import ssbClient from 'ssb-client'
import ssbKeys from 'ssb-keys'
import path from 'path'
import pull from 'pull-stream'
import FileReaderStream from 'pull-file-reader'
import pullFlatmap from 'pull-flatmap'
import Promise from 'bluebird'
import _ from 'lodash'
import Pub from '../models/Pub'

/**
 * Adapter for querying, creating and storing tale:net data from / to SSB.
 */
export default class SSBAdapter {
  static PROTOCOL_VERSION = 1

  static TALENET_TYPE_PREFIX = 'talenet-'
  static TALENET_VERSION_FIELD = SSBAdapter.TALENET_TYPE_PREFIX + 'version'

  static TYPE_SSB_CONTACT = 'contact' // predefined by ssb, thus no prefix
  static TYPE_SSB_BLOCK_AUTHOR = SSBAdapter.TYPE_SSB_CONTACT
  static TYPE_SSB_PUB = 'pub'

  _messageHandlers = {}
  _blockedAuthors = new Set()
  _subscribedBlockListAuthors = new Set()
  _pubs = {}
  _pubSubscriptions = []

  constructor () {
    this._sbot = null
    this._config = null

    this.registerMessageHandlers({
      [SSBAdapter.TYPE_SSB_CONTACT]: this._handleContact.bind(this),
      [SSBAdapter.TYPE_SSB_PUB]: this._handlePub.bind(this)
    })

    // You can use this for easier testing / debugging
    // window.ssbAdapter = this
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

        if (!this._sbot.talequery) {
          return reject(new Error('tale:net needs the ssb-talequery plugin. If you want to use your own \'sbot server\' please use \'sbot plugins.install ssb-talequery\' to install it.'))
        }

        store.commit('ssb/connected')
        sbot.on('closed', () => {
          store.commit('ssb/disconnect')
        })

        Promise.all([
          this._loadUsedPubs(),
          this._setupActivityMonitor(store)
        ]).then(() => {
          return this._loadBlockedAuthors()
        }).then(() => {
          this._pullMessages()

          // then make sure new incoming blocks at least affect new incoming messages
          this._pullBlockedAuthors()

          store.commit('ssb/initialized')
          resolve()

          return null
        }).catch(err => {
          reject(err)
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
          const i = status.progress.indexes
          if (!status.sync.sync) {
            store.commit('ssb/activity', 'downloading')
            // console.log('downloading new messages.')
          } else {
            const msgsTODO = i.target - i.current
            if (msgsTODO > 0) {
              // console.log('indexing! diff:' + msgsTODO)
              // TODO: pass amount?
              store.commit('ssb/activity', 'indexing')
            } else if (msgsTODO === 0) {
              store.commit('ssb/activity', 'ready')
            }
          }
        })
      }, 5000)
      resolve(i)
    })
  }

  _pullMessages () {
    pull(
      this._sbot.query.read({
        query: [{ $filter: { value: { content: { type: { $prefix: SSBAdapter.TALENET_TYPE_PREFIX } } } } }],
        live: true
      }),
      this._filterBlockedMessages(),
      pull.drain((msg) => this.handleMessage(msg))
    )
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
    return new Promise((resolve, reject) => {
      pull(
        this.streamByType(SSBAdapter.TYPE_SSB_CONTACT),
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
    })
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

  getValueByKey (key) {
    if (key === undefined) {
      console.error(new Error('Trying to get value by undefined key.'))
    }
    return new Promise((resolve, reject) => {
      this._sbot.get(key, (err, value) => {
        if (err) {
          return reject(err)
        }

        if (this._valueIsBlocked(value)) {
          return reject(new Error('Message for key is blocked: ' + key))
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

  streamAbouts () {
    return pull(
      this._sbot.about.stream({ live: true }),
      pull.asyncMap((msg, callback) => this._sbot.about.get((err, about) => callback(err, { about, msg }))),
      pullFlatmap(({ about, msg }) => {
        const abouts = []
        for (const authorIdentityKey of Object.keys(msg)) {
          if (this._authorIsBlocked(authorIdentityKey)) {
            continue
          }
          abouts.push({ author: authorIdentityKey, about: about[authorIdentityKey] })
        }
        return abouts
      })
    )
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
      Promise.reject(new Error('Trying to publish message with undefined type: ', payload))
    }
    return new Promise((resolve, reject) => {
      let msg = {
        ...payload,
        type,
        [SSBAdapter.TALENET_VERSION_FIELD]: SSBAdapter.PROTOCOL_VERSION
      }
      this._sbot.publish(msg, (err, publishedMsg) => {
        if (err) {
          return reject(err)
        }

        this.handleMessage(msg)

        resolve(publishedMsg)
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

  subscribePubs (onUpdate) {
    const subscription = this.subscribe(this._pubSubscriptions, null, onUpdate)

    for (const pub of Object.values(this._pubs)) {
      onUpdate(pub)
    }

    return subscription
  }

  subscribe (subscriptions, keys, onUpdate, onCancel) {
    const subscription = {
      promise: new Promise((resolve, reject, onPromiseCancel) => {
        onPromiseCancel(() => {
          this._unsubscribe(subscriptions, subscription, keys)
          if (_.isFunction(onCancel)) {
            onCancel()
          }
        })
      }),
      propagateUpdate: onUpdate
    }

    if (keys) {
      for (const key of new Set(keys)) {
        const subscriptionsForKey = subscriptions[key] || []
        subscriptionsForKey.push(subscription)
        subscriptions[key] = subscriptionsForKey
      }
    } else {
      subscriptions.push(subscription)
    }

    return subscription.promise
  }

  _unsubscribe (subscriptions, subscription, keys) {
    if (keys) {
      for (const key of new Set(keys)) {
        const subscriptionsForKey = subscriptions[key]
        if (subscriptionsForKey) {
          _.remove(subscriptionsForKey, (s) => s === subscription)
          if (_.isEmpty(subscriptionsForKey)) {
            delete subscriptions[key]
          }
        }
      }
    } else {
      _.remove(subscriptions, (s) => s === subscription)
    }
  }

  static propagateUpdate (subscriptions, value) {
    for (const subscription of subscriptions || []) {
      subscription.propagateUpdate(value)
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
      this._sbot.invite.accept(inviteCode.trim(), (err, result) => {
        if (err) {
          console.error(err)
          return resolve({
            success: false
          })
        }

        // TODO: Handle pub info in result.

        resolve({
          success: true
        })
      })
    })
  }
}
