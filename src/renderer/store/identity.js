import Vue from 'vue'

import { subscribeKeys } from '../util/store'

/**
 * Store module for holding identity data.
 */
export default function ({ persistence }) {
  return {
    namespaced: true,

    state () {
      return {
        ownIdentityKey: null,
        identities: {}
      }
    },

    getters: {
      /**
       * Returns a function to get the identity for a identity key.
       */
      get (state) {
        return (identityKey) => state.identities[identityKey]
      },

      /**
       * Returns the users own identity.
       */
      own (state) {
        return state.identities[state.ownIdentityKey]
      },

      /**
       * The users own identity key.
       */
      ownIdentityKey (state) {
        return state.ownIdentityKey
      }
    },

    mutations: {
      /**
       * Sets the users own identity key.
       */
      setOwnIdentityKey (state, key) {
        state.ownIdentityKey = key
      },

      /**
       * Sets the given identity on the store.
       */
      set (state, identity) {
        Vue.set(state.identities, identity.key(), identity)
      }
    },

    actions: {
      /**
       * Subscribe for the users own identity key. The current identity key
       * can then be retrieved via the getter 'identity/ownIdentityKey'.
       *
       * The component subscribing is responsible for cancelling the subscription if
       * it is no longer needed.
       *
       * @return Promise to cancel the subscription (just call <code>cancel()</code>).
       */
      subscribeOwnIdentityKey ({ commit }) {
        return persistence.subscribeOwnIdentityKey((key) => {
          commit('setOwnIdentityKey', key)
        })
      },

      /**
       * Subscribe for one or more identities to recieve updates via the store. The current
       * state of each identity can then be retrieved via the getter 'identity/get'.
       *
       * The component subscribing is responsible for cancelling the subscription if
       * it is no longer needed.
       *
       * @return Promise to cancel the subscription (just call <code>cancel()</code>).
       */
      subscribe (context, identityKeys) {
        return subscribeKeys(context, identityKeys, 'set', persistence.subscribeIdentities.bind(persistence))
      }
    }
  }
}
