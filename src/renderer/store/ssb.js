import renderMarkdown from '../util/markdown'

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
      aboutObs: null
    },

    mutations: {
      disconnect (state) {
        state.connected = false
        // wait and trigger connect action?
      },

      connected (state, { id, about }) {
        state.id = id
        state.connected = true
        state.aboutObs = about
      },

      latest (state, msgs) {
        state.latest = msgs
      },

      renderPreview (state, msg) {
        state.msgText = msg
        state.msgPreview = renderMarkdown(msg)
      },

      newmsg (state, newMsg) {
        state.latest.unshift(newMsg)
        state.msgText = ''
        state.msgPreview = ''
        state.publishedKey = newMsg.key
      }
    },

    getters: {
      connected: (state) => {
        return state.connected
      },

      whoami: (state) => {
        return state.id
      },

      abouts: (state) => (id, prop) => {
        let placeholder = {
          'name': id.substr(0, 6) + '...',
          'image': '&thatCatBlob.sha256'
        }

        // do we have anything about this id
        let aboutId = state.aboutObs[id]
        if (!aboutId) return placeholder[prop]

        // reduce to property (name, image, ...)
        let byProp = aboutId[prop]
        if (!byProp) return placeholder[prop]

        // abouts I made about myself
        var myAbouts = byProp[id]
        if (myAbouts) return myAbouts[0]

        // TODO: or abouts from others
        return placeholder[prop]
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
