import ssbClient from 'ssb-client'
import pull from 'pull-stream'

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

      sbot.on('closed', () => {
        store.commit('ssb/disconnect')
      })
    })
  }

  publishPost (msg) {
    return new Promise((resolve, reject) => {
      this._sbot.publish({ type: 'post', text: msg }, (err, newmsg) => {
        if (err) {
          return reject(err)
        }

        resolve(newmsg)
      })
    })
  }

  createIdea (idea) {
    return new Promise((resolve) => {
      // TODO: Publish to ssb and set the ssb key.
      resolve({
        key: Date.now().toString(),
        ...idea
      })
    })
  }
}
