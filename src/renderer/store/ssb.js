import Vue from 'vue'

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
      pubs: {},
      connected: false,
      initialized: false,
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

      initialized (state) {
        state.initialized = true
      },

      addPub (state, pub) {
        Vue.set(state.pubs, pub.key(), pub)
      }
    },

    getters: {
      connected: (state) => {
        return state.connected
      },

      initialized (state) {
        return state.initialized
      },

      blobUrl: (state) => (blob) => {
        return state.blobServer + blob
      },

      pubs (state) {
        return state.pubs
      },

      inviteConstraints () {
        return INVITE_CONSTRAINTS
      }
    },

    actions: {
      subscribePubs ({ commit }) {
        return ssbAdapter.subscribePubs(pub => {
          commit('addPub', pub)
        })
      },

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
