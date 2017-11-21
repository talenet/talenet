import ssbClient from 'ssb-client'
import pull from 'pull-stream'
import cat from 'pull-cat'

import Idea from '../models/Idea'

const PROTOCOL_VERSION = 1
const IDEA_UPDATE_TYPES = ['update_idea', 'idea_hat', 'idea_association']

/**
 * Adapter for querying, creating and storing TALEnet data from / to SSB.
 */
export default class SSBAdapter {
  constructor () {
    this._sbot = null
    this._store = null
    this._ideas = {}
  }

  connect (store) {
    this._store = store

    return new Promise((resolve, reject) => {
      // TODO: use config from loady
      ssbClient((err, sbot) => {
        this._sbot = sbot

        if (err) {
          return reject(err)
        }

        resolve()

        store.commit('ssb/connected', { id: sbot.id })

        pull(
          sbot.createLogStream({ live: false, reverse: true, limit: 20 }),
          pull.collect((err, msgs) => {
            if (err) {
              return store.commit('error', err)
            }
            store.commit('ssb/latest', msgs)
          })
        )

        // demo of using ssb-links to collect messages linking to our id using {about: id}
        pull(
          sbot.links({ dest: sbot.id, rel: 'about', values: true, reverse: true }),
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
            store.commit('ssb/newabouts', { 'id': sbot.id, 'abouts': abouts })
          })
        )

        /* ssb-about uses observable objects.. doesn't play nice with the store
          // todo: remove ssb-about plugin
          sbot.about.stream({live: true}),
          pull.drain((abouts) => {
            store.commit('ssb/newabouts', abouts)
          }, (done) => {
            console.warn('ssbAbouts: stream done?!', done)
          })
         */

        this._pullIdeas()

        sbot.on('closed', () => {
          store.commit('ssb/disconnect')
        })
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
    return this._publish('create_idea', {})
      .then((msg) => {
        return this.associateWithIdea(msg.key)
      }).then((ideaKey) => {
        return this.takeHat(ideaKey)
      }).then((ideaKey) => {
        return this.updateIdea(idea.withKey(ideaKey).asUpdate())
      })
  }

  updateIdea (ideaUpdate) {
    return this._publish('update_idea', ideaUpdate.asSsbUpdate())
      .then(() => {
        return ideaUpdate.ideaKey()
      })
  }

  _ideaUpdatesStream (live, optIdeaKey) {
    const streams = []

    for (const type of IDEA_UPDATE_TYPES) {
      const contentFilter = { type: type }

      if (optIdeaKey) {
        contentFilter.ideaKey = optIdeaKey
      }

      streams.push(this._sbot.query.read({
        query: [{ $filter: { value: { content: contentFilter } } }],
        live: live
      }))
    }

    return cat(streams)
  }

  _handleIdeaUpdate (msg) {
    if (!msg.value) {
      return null
    }

    const key = msg.value.content.ideaKey
    let idea = this._ideas[key] || new Idea({ key })

    const type = msg.value.content.type
    switch (type) {
      case 'update_idea':
        idea = idea.withSsbUpdate(msg)
        break

      case 'idea_hat':
        idea = idea.withSsbHatUpdate(msg)
        break

      case 'idea_association':
        idea = idea.withSsbIdeaAssociation(msg)
        break

      default:
        console.error('Unexpected message type for idea update:', type)
    }

    this._ideas[key] = idea
    return idea
  }

  _pullIdeas () {
    pull(
      this._ideaUpdatesStream(true),
      pull.drain((msg) => {
        const idea = this._handleIdeaUpdate(msg)
        if (idea) {
          this._store.commit('idea/set', idea)
        }
      })
    )
  }

  loadIdea (key) {
    return new Promise((resolve, reject) => {
      pull(
        this._ideaUpdatesStream(false, key),
        pull.collect((err, msgs) => {
          if (err) {
            return reject(err)
          }

          let idea = null

          for (const msg of msgs) {
            idea = this._handleIdeaUpdate(msg) || idea
          }

          if (idea) {
            this._store.commit('idea/set', idea)
            resolve({ exists: true })
          } else {
            resolve({ exists: false })
          }
        })
      )
    })
  }

  _updateHat (ideaKey, action) {
    return this._publish('idea_hat', {
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
    return this._publish('idea_association', {
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

  getAbouts (id) {
    console.dir(this._sbot.about)
  }
}
