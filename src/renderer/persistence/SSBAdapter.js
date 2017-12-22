import ssbClient from 'ssb-client'
import ssbKeys from 'ssb-keys'
import path from 'path'
import pull from 'pull-stream'
import FileReaderStream from 'pull-file-reader'
import pullFlatmap from 'pull-flatmap'
import Promise from 'bluebird'
import _ from 'lodash'

/**
 * Adapter for querying, creating and storing tale:net data from / to SSB.
 */
export default class SSBAdapter {
  static PROTOCOL_VERSION = 1

  static TALENET_TYPE_PREFIX = 'talenet-'
  static TALENET_VERSION_FIELD = SSBAdapter.TALENET_TYPE_PREFIX + 'version'

  static TYPE_SSB_CONTACT = 'contact' // predefined by ssb, thus no prefix
  static TYPE_SSB_BLOCK_AUTHOR = SSBAdapter.TYPE_SSB_CONTACT

  _messageHandlers = {}
  _blockedAuthors = new Set()
  _usedPubKeys = new Set()

  constructor () {
    this._sbot = null
    this._config = null

    this.registerMessageHandlers({
      [SSBAdapter.TYPE_SSB_CONTACT]: this.handleContact.bind(this)
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

        this._loadUsedPubKeys().then(() => {
          return this._loadBlockedAuthors()
        }).then(() => {
          this._pullMessages()

          // then make sure new incoming blocks at least affect new incoming messages
          this._pullBlockedAuthors()

          resolve()
        }).catch(err => {
          reject(err)
        })
      })
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
  _loadUsedPubKeys () {
    return new Promise((resolve, reject) => {
      pull(
        // all the messages authored by my key with type:pub
        this._sbot.query.read({
          query: [{ $filter: {
            value: {
              author: this._sbot.id,
              content: {type: 'pub'} } } }],
          live: false
        }),
        pull.collect((err, pubs) => {
          if (err) {
            return reject(err)
          }
          for (const p of pubs) {
            this._usedPubKeys.add(p.value.content.address.key)
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
            this.handleContact(msg)
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
        this.handleContact(msg)
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

  _isFromUsedPub (author) {
    return this._usedPubKeys.has(author)
  }

  getValueByKey (key) {
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
    return pull(
      this._sbot.query.read({
        query: [{ $filter: { value: { content: { type } } } }],
        live
      }),
      this._filterBlockedMessages()
    )
  }

  streamByIdea (ideaKey, live = false) {
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
        for (const authorIdentityKey in msg) {
          if (this._authorIsBlocked(authorIdentityKey)) {
            continue
          }
          if (msg.hasOwnProperty(authorIdentityKey)) {
            abouts.push({ author: authorIdentityKey, about: about[authorIdentityKey] })
          }
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

  handleContact (msg) {
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

    if ((ownMessage || this._isFromUsedPub(author)) && _.isString(contact) && blocking) {
      this._blockedAuthors.add(contact)
    }
  }

  publish (type, payload) {
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

        resolve(publishedMsg)
      })
    })
  }

  blockAuthor (id) {
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
        resolve({
          success: true
        })
      })
    })
  }
}
