import { ipcRenderer } from 'electron'
import { subscribeValue } from '../util/store'
import Vue from 'vue'

/**
 * Constraints for accepting an invite.
 */
const INVITE_CONSTRAINTS = {
  inviteCode: {
    required: true
  }
}

const SUBSCRIBER_ID = 'store/ssb'

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
      activity: 'ready',
      blobServer: 'http://localhost:8989/blobs/get/',
      latestPubPost: null
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

      activity (state, activity) {
        state.activity = activity
      },

      addPub (state, pub) {
        Vue.set(state.pubs, pub.key(), pub)
      },

      updateLatestPubPost (state, post) {
        if (!state.latestPubPost || state.latestPubPost.timestamp() < post.timestamp()) {
          state.latestPubPost = post
        }
      }
    },

    getters: {
      connected: (state) => {
        return state.connected
      },

      initialized (state) {
        return state.initialized
      },

      activity (state, activity) {
        return state.activity
      },

      blobUrl: (state) => (blob) => {
        return state.blobServer + blob
      },

      pubs (state) {
        return state.pubs
      },

      inviteConstraints () {
        return INVITE_CONSTRAINTS
      },

      latestPubPost (state) {
        return state.latestPubPost
      }
    },

    actions: {
      subscribePubs (context) {
        return subscribeValue(context, 'addPub', SUBSCRIBER_ID, ssbAdapter.subscribePubs.bind(ssbAdapter))
      },

      subscribeLatestPubPost (context) {
        return subscribeValue(
          context,
          'updateLatestPubPost',
          SUBSCRIBER_ID,
          ssbAdapter.subscribePubPosts.bind(ssbAdapter)
        )
      },

      /**
       * Accept an invite to a ssb pub.
       *
       * @return Promise providing the an object with a success field.
       */
      acceptInvite (context, inviteCode) {
        return ssbAdapter.acceptInvite(inviteCode)
      },

      getInviteFromPub () {
        return new Promise((resolve, reject) => {
          ipcRenderer.once('getInviteFromPub-reply', (event, response) => {
            if (response.result === 'success') {
              resolve(response.invite)
            } else {
              reject(response.error)
            }
          })
          ipcRenderer.send('getInviteFromPub')
        })
      }
    }
  }
}
