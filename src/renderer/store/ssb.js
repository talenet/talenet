import Vue from 'vue'
import marked from 'ssb-marked'

/**
 * Store module holding connection to our scuttlebot
 */
export default function ({ persistence }) {
  return {
    namespaced: true,

    state: {
      connected: false,
      msgText: '',
      msgPreview: '',
      publishedKey: '',
      id: '',
      latest: [],
      abouts: {}
    },

    mutations: {
      disconnect (state) {
        state.connected = false
        // wait and trigger connect action?
      },

      connected (state, { id }) {
        state.id = id
        state.connected = true
      },

      latest (state, msgs) {
        state.latest = msgs
      },

      renderPreview (state, msg) {
        state.msgText = msg
        state.msgPreview = marked(msg)
      },

      newmsg (state, newMsg) {
        state.latest.unshift(newMsg)
        state.msgText = ''
        state.msgPreview = ''
        state.publishedKey = newMsg.key
      },

      newabouts (state, payload) {
        // couldn't figure out how to pass multiple arguments to a mutation
        let id = payload.id
        let rawAbouts = payload.abouts
        // TODO(cryptix): will be moved back into the query in perst
        // transform mapped abouts from perst layer, could also be done there.
        // abouts[id][prop (name,image,...)][author]
        let a = state.abouts[id] || {}
        for (let i in rawAbouts) {
          let r = rawAbouts[i] // raw
          var t = a[r.prop] || {} // transformed
          t[r.author] = r
          a[r.prop] = t
        }
        // howto deep-state mutations:
        Vue.set(state.abouts, id, a)
      }
    },

    getters: {
      connected: (state) => {
        return state.connected
      },

      whoami: (state) => {
        return state.id
      },

      abouts: (state) => (id) => {
        let abouts = state.abouts[id]
        if (!abouts) return
        console.dir(abouts)
        return abouts
      }
    },

    actions: {
      publishPost ({ commit, state }) {
        if (state.msgText === '') {
          return
        }
        console.log('publishing:' + state.msgText)
        persistence.publishPost(state.msgText)
          .then((newmsg) => {
            commit('newmsg', newmsg)
          })
          .catch((err) => {
            commit('error', err, { root: true })
          })
      }
    }
  }
}
