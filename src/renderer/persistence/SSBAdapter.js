import ssbClient from 'ssb-client'
import pull from 'pull-stream'

import Idea from '../models/Idea'

const PROTOCOL_VERSION = 1

const TALENET_TYPE_PREFIX = 'talenet-'
const IDEA_TYPE_PREFIX = TALENET_TYPE_PREFIX + 'idea-'

const TYPE_CREATE_IDEA = IDEA_TYPE_PREFIX + 'create'
const TYPE_UPDATE_IDEA = IDEA_TYPE_PREFIX + 'update'
const TYPE_IDEA_HAT = IDEA_TYPE_PREFIX + 'hat'
const TYPE_IDEA_ASSOCIATION = IDEA_TYPE_PREFIX + 'association'
const TYPE_IDEA_COMMENT = IDEA_TYPE_PREFIX + 'comment'
const TYPE_IDEA_COMMENT_REPLY = IDEA_TYPE_PREFIX + 'comment_reply'

/**
 * Adapter for querying, creating and storing TALEnet data from / to SSB.
 */
export default class SSBAdapter {
  constructor () {
    this._sbot = null
    this._store = null
  }

  connect (store) {
    this._store = store

    return new Promise((resolve, reject) => {
      // TODO: use config from loady
      ssbClient((err, sbot) => {
        if (err) {
          return reject(err)
        }

        this._sbot = sbot
        resolve()

        store.commit('ssb/connected', { id: sbot.id })

        this._pullMessages()

        sbot.on('closed', () => {
          store.commit('ssb/disconnect')
        })
      })
    })
  }

  _pullSsbDemo () {
    pull(
      this._sbot.createLogStream({ live: false, reverse: true, limit: 20 }),
      pull.collect((err, msgs) => {
        if (err) {
          return this._store.commit('error', err)
        }

        this._store.commit('ssb/latest', msgs)
      })
    )

    // demo of using ssb-links to collect messages linking to our id using {about: id}
    pull(
      this._sbot.links({ dest: this._sbot.id, rel: 'about', values: true, reverse: true }),
      pull.map(function (msg) {
        let c = msg.value.content || {}
        return Object.keys(c).filter(function (key) {
          return key !== 'about' &&
            key !== 'type' &&
            key !== 'recps'
        }).map(function (key) {
          let value = c[key]
          return {
            id: msg.key,
            author: msg.value.author,
            timestamp: msg.value.timestamp,
            prop: key,
            value: value,
            remove: value && value.remove
          }
        })
      }),
      pull.flatten(),
      pull.collect((err, abouts) => {
        if (err) throw err
        this._store.commit('ssb/newabouts', { 'id': this._sbot.id, 'abouts': abouts })
      })
    )
  }

  _pullMessages () {
    this._pullSsbDemo()
    pull(
      this._sbot.createLogStream({ live: true }),
      pull.drain((msg) => this._handleMessage(msg))
    )
  }

  _handleMessage (msg) {
    const value = msg.value
    if (!value) {
      return
    }

    const content = value.content
    if (!content) {
      return
    }

    const type = content.type
    if (typeof type !== 'string') {
      return
    }

    if (type.startsWith(IDEA_TYPE_PREFIX)) {
      return this._handleIdeaMessage(msg, type)
    }

    console.warn('Unsupported message type: ', type)
  }

  _getIdeaFromStore (key) {
    return this._store.getters['idea/get'](key) || new Idea({ key })
  }

  _handleIdeaMessage (msg, type) {
    const key = type === TYPE_CREATE_IDEA ? msg.key : msg.value.content.ideaKey
    let idea = this._getIdeaFromStore(key)

    switch (type) {
      case TYPE_CREATE_IDEA:
        SSBAdapter._handleIdeaCreation(idea, msg.value)
        break

      case TYPE_UPDATE_IDEA:
        idea = idea.withSsbUpdate(msg)
        break

      case TYPE_IDEA_HAT:
        idea = idea.withSsbHatUpdate(msg)
        break

      case TYPE_IDEA_ASSOCIATION:
        idea = idea.withSsbIdeaAssociation(msg)
        break

      case TYPE_IDEA_COMMENT:
        idea = idea.withSsbIdeaComment(msg)
        break

      case TYPE_IDEA_COMMENT_REPLY:
        idea = idea.withSsbIdeaCommentReply(msg)
        break

      default:
        console.error('Unexpected message type for idea update:', type)
    }

    this._store.commit('idea/set', idea)
  }

  static _handleIdeaCreation (idea, value) {
    return idea.withCreationTimestamp(value.timestamp)
  }

  ideaExists (ideaKey) {
    return new Promise((resolve) => {
      this._sbot.get(ideaKey, (err, value) => {
        if (err) {
          console.error(err)
          return resolve({ ideaKey, exists: false })
        }

        const exists = value && value.content && value.content.type === TYPE_CREATE_IDEA

        if (exists) {
          const idea = SSBAdapter._handleIdeaCreation(this._getIdeaFromStore(ideaKey), value)
          this._store.commit('idea/set', idea)
        }

        resolve({ ideaKey, exists })
      })
    })
  }

  loadIdea (ideaKey) {
    return this.ideaExists(ideaKey)
      .then((result) => {
        if (!result.exists) {
          return result
        }

        return new Promise((resolve, reject) => {
          pull(
            this._sbot.query.read({
              query: [{ $filter: { value: { content: { ideaKey } } } }],
              live: false
            }),
            pull.collect((err, msgs) => {
              if (err) {
                return reject(err)
              }

              for (const msg of msgs) {
                this._handleMessage(msg)
              }

              resolve(result)
            })
          )
        })
      })
  }

  _publish (type, payload) {
    return new Promise((resolve, reject) => {
      let msg = {
        ...payload,
        type: type,
        version: PROTOCOL_VERSION
      }
      this._sbot.publish(msg, (err, publishedMsg) => {
        if (err) {
          return reject(err)
        }

        resolve(publishedMsg)
      })
    })
  }

  publishPost (msg) {
    return this._publish('post', { text: msg })
  }

  createIdea (idea) {
    return this._publish(TYPE_CREATE_IDEA, {})
      .then((msg) => {
        return this.associateWithIdea(msg.key)
      }).then((ideaKey) => {
        return this.takeHat(ideaKey)
      }).then((ideaKey) => {
        return this.updateIdea(idea.withKey(ideaKey).asUpdate())
      })
  }

  updateIdea (ideaUpdate) {
    return this._publish(TYPE_UPDATE_IDEA, ideaUpdate.asSsbUpdate())
      .then(() => {
        return ideaUpdate.ideaKey()
      })
  }

  _updateHat (ideaKey, action) {
    return this._publish(TYPE_IDEA_HAT, {
      ideaKey,
      action
    }).then(() => {
      return ideaKey
    })
  }

  takeHat (ideaKey) {
    return this._updateHat(ideaKey, 'take')
  }

  discardHat (ideaKey) {
    return this._updateHat(ideaKey, 'discard')
  }

  _updateIdeaAssociation (ideaKey, action) {
    return this._publish(TYPE_IDEA_ASSOCIATION, {
      ideaKey,
      action
    }).then(() => {
      return ideaKey
    })
  }

  associateWithIdea (ideaKey) {
    return this._updateIdeaAssociation(ideaKey, 'associate')
  }

  disassociateFromIdea (ideaKey) {
    return this._updateIdeaAssociation(ideaKey, 'disassociate')
  }

  postIdeaComment (ideaComment) {
    return this._publish(TYPE_IDEA_COMMENT, ideaComment.asSsbComment())
      .then((msg) => msg.key)
  }

  replyToIdeaComment (ideaCommentReply) {
    return this._publish(TYPE_IDEA_COMMENT_REPLY, ideaCommentReply.asSsbCommentReply())
      .then((msg) => msg.key)
  }

  getAbouts (id) {
    console.dir(this._sbot.about)
  }
}
