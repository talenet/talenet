import Vue from 'vue'

import { subscribeKeys, subscribeValue } from '../util/store'

/**
 * Constraints for messages.
 */
const MESSAGE_CONSTRAINTS = {
  text: {
    required: true
  }
}

const SUBSCRIBER_ID = 'store/privmsgs'

export default function ({ postAdapter }) {
  return {
    namespaced: true,

    state () {
      return {
        overviewMessages: [],
        openThreads: {} // { %threadKey: [msgs, ...], ... }
      }
    },

    getters: {
      constraints () {
        return MESSAGE_CONSTRAINTS
      },

      all (state) {
        return state.overviewMessages
      },

      threadByKey (state) {
        const ot = state.openThreads
        return (key) => {
          return ot[key] || []
        }
      }
    },

    mutations: {
      setPMs (state, msgs) { // currently only used for the overview
        state.overviewMessages = msgs
      },

      replaceThread (state, newMsgs) {
        if (newMsgs.length > 0) {
          const tk = newMsgs[0].value.content.root || newMsgs[0].key // threadKey
          Vue.set(state.openThreads, tk, [...newMsgs])
        }
      }
    },

    actions: {
      startThread (context, data) {
        return postAdapter.startPrivateThread(data)
      },

      publishReply (context, data) {
        return postAdapter.publishPrivate(data)
      },

      // currently only used for the overview
      subscribeOverview (context) {
        return subscribeValue(context, 'setPMs', SUBSCRIBER_ID, postAdapter.subscribeOverview.bind(postAdapter))
      },

      // maybe same source for new/live and prev messages?
      subscribeByThread (context, threadKey) {
        return subscribeKeys(
          context,
          threadKey,
          'replaceThread',
          SUBSCRIBER_ID,
          postAdapter.subscribeThread.bind(postAdapter)
        )
      }
    }
  }
}
