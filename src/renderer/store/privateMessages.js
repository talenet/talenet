import Vue from 'vue'

import { subscribeKeys, subscribeValue } from '../util/store'

const SUBSCRIBER_ID = 'store/privmsgs'

export default function ({ postAdapter }) {
  return {
    namespaced: true,

    state () {
      return {
        msgs: [], // TODO: rename overviewMsgs
        openThreads: {} // { %threadKey: [msgs, ...], ... }
      }
    },

    getters: {
      all (state) {
        return state.msgs
      },

      threadByKey (state) {
        return (key) => {
          return state.openThreads[key] || []
        }
      }
    },

    mutations: {
      // currently only used for the overview
      setPMs (state, msgs) {
        state.msgs = msgs
      },

      replaceThread (state, newMsgs) {
        if (newMsgs.length > 0) { // might be nicer to append.. brainfart
          const tk = newMsgs[0].value.content.root || newMsgs[0].key // threadKey
          Vue.set(state.openThreads, tk, [...newMsgs])
        }
      }

    },

    actions: {
      // currently only used for the overview
      subscribeAll (context) {
        return subscribeValue(context, 'setPMs', SUBSCRIBER_ID, postAdapter.subscribeAllPrivateMessages.bind(postAdapter))
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
