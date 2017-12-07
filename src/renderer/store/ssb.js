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
      latest: [],
      blobServer: 'http://localhost:8989/blobs/get/'
    },

    mutations: {
      disconnect (state) {
        state.connected = false
        // wait and trigger connect action?
      },

      connected (state) {
        state.connected = true
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

      blobUrl: (state) => (blob) => {
        return state.blobServer + blob
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
