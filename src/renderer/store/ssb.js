import renderMarkdown from '../util/markdown'

/**
 * Constraints for accepting an invite.
 */
const INVITE_CONSTRAINTS = {
  inviteCode: {
    required: true
  }
}

/**
 * Store module holding connection to our scuttlebot
 */
export default function ({ ssbAdapter }) {
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
      },

      inviteConstraints () {
        return INVITE_CONSTRAINTS
      }
    },

    actions: {
      /**
       * Accept an invite to a ssb pub.
       *
       * @return Promise providing the an object with a success field.
       */
      acceptInvite (context, inviteCode) {
        return ssbAdapter.acceptInvite(inviteCode)
      }
    }
  }
}
