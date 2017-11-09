import ssbClient from 'ssb-client'
import pull from 'pull-stream'

const PROTOCOL_VERSION = 1

/**
 * Adapter for querying, creating and storing TALEnet data from / to SSB.
 */
export default class SSBAdapter {
  constructor () {
    this._store = null
    this._sbot = null
  }

  connect (store) {
    this._store = store

    // TODO: use config from loady
    ssbClient((err, sbot) => {
      this._sbot = sbot

      if (err) {
        return store.commit('error', err)
      }

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
        sbot.links({dest: sbot.id, rel: 'about', values: true, reverse: true}),
        pull.map(function (msg) {
          var c = msg.value.content || {}
          return Object.keys(c).filter(function (key) {
            return key !== 'about' &&
                     key !== 'type' &&
                     key !== 'recps'
          }).map(function (key) {
            var value = c[key]
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
          store.commit('ssb/newabouts', {'id': sbot.id, 'abouts': abouts})
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

      sbot.on('closed', () => {
        store.commit('ssb/disconnect')
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
      .then((createdIdea) => {
        return this.updateIdea({
          ...idea,
          key: createdIdea.key
        })
      })
  }

  updateIdea (idea) {
    let { key, ...ideaData } = idea
    ideaData.ideaKey = key

    return this._publish('update_idea', ideaData)
      .then(() => {
        // TODO: Flatten idea with updated data an return it
        return ideaData
      })
  }

  getAbouts (id) {
    console.dir(this._sbot.about)
  }
}
