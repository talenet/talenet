import { subscribeValue } from '../util/store'

const SUBSCRIBER_ID = 'store/privmsgs'

export default function ({ postAdapter }) {
  return {
    namespaced: true,

    state () {
      return {
        msgs: []
      }
    },

    getters: {
      all (state) {
        return state.msgs
      }
    },

    mutations: {
      setPMs (state, msgs) {
        state.msgs = msgs
      }
    },

    actions: {
      subscribeAll (context) {
        return subscribeValue(context, 'setPMs', SUBSCRIBER_ID, postAdapter.subscribeAllPrivateMessages.bind(postAdapter))
      }
    }
  }
}
