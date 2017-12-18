import ssbClient from 'ssb-client'
import ssbKeys from 'ssb-keys'
import path from 'path'
import pull from 'pull-stream'
import FileReaderStream from 'pull-file-reader'
import pullFlatmap from 'pull-flatmap'
import Promise from 'bluebird'
import _ from 'lodash'

/**
 * Adapter for querying, creating and storing TALEnet data from / to SSB.
 */
export default class SSBAdapter {
  static PROTOCOL_VERSION = 1

  static TALENET_TYPE_PREFIX = 'talenet-'
  static TALENET_VERSION_FIELD = SSBAdapter.TALENET_TYPE_PREFIX + 'version'

  _messageHandlers = {}

  constructor () {
    this._sbot = null
    this._config = null

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

        store.commit('ssb/connected')
        sbot.on('closed', () => {
          store.commit('ssb/disconnect')
        })

        if (!this._sbot.about) {
          return reject(new Error('TALEnet needs the ssb-about plugin'))
        }

        if (!this._sbot.talequery) {
          return reject(new Error('TALEnet needs the ssb-talequery plugin. If you want to use your own \'sbot server\' please use \'sbot plugins.install ssb-talequery\' to install it.'))
        }

        this._pullMessages()
        resolve()
      })
    })
  }

  _pullMessages () {
    pull(
      this._sbot.query.read({
        query: [{ $filter: { value: { content: { type: { $prefix: SSBAdapter.TALENET_TYPE_PREFIX } } } } }],
        live: true
      }),
      pull.drain((msg) => this.handleMessage(msg))
    )
  }

  getValueByKey (key) {
    return new Promise((resolve, reject) => {
      this._sbot.get(key, (err, value) => {
        if (err) {
          return reject(err)
        }

        resolve(value)
      })
    })
  }

  streamByType (type, live = false) {
    return this._sbot.query.read({
      query: [{ $filter: { value: { content: { type } } } }],
      live
    })
  }

  streamByIdea (ideaKey, live = false) {
    return this._sbot.talequery.read({
      query: [{ $filter: { value: { content: { ideaKey } } } }],
      live
    })
  }

  streamAbouts () {
    return pull(
      this._sbot.about.stream({ live: true }),
      pull.asyncMap((msg, callback) => this._sbot.about.get((err, about) => callback(err, { about, msg }))),
      pullFlatmap(({ about, msg }) => {
        const abouts = []
        for (const authorIdentityKey in msg) {
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
    const type = SSBAdapter.getMessageType(msg)
    if (!type) {
      return
    }

    const handler = this._messageHandlers[type]
    if (handler) {
      handler(msg)
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
      this._sbot.invite.accept(inviteCode, (err, result) => {
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
