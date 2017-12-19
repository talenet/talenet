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
      blobServer: 'http://localhost:8989/blobs/get/'
    },

    mutations: {
      disconnect (state) {
        state.connected = false
        // wait and trigger connect action?
      },

      connected (state) {
        state.connected = true
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
