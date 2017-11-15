import Vue from 'vue'

/**
 * Store module for holding idea data.
 */
export default function ({ persistence }) {
  return {
    namespaced: true,

    state () {
      return {
        ideas: {}
      }
    },

    getters: {
      all (state) {
        return Object.values(state.ideas)
      },

      get (state) {
        return (key) => state.ideas[key]
      }
    },

    mutations: {
      set (state, idea) {
        Vue.set(state.ideas, idea.key(), idea)
      }
    },

    actions: {
      /**
       * Creates a new idea.
       *
       * @return A promise that provides the key of the created idea.
       */
      create (context, newIdea) {
        return persistence.createIdea(newIdea)
      },

      /**
       * Make sure the idea with the specified key is loaded.
       *
       * @return Promise providing an object with the field 'exists' specifying if the idea exists.
       */
      load (context, key) {
        return persistence.loadIdea(key)
      }
    }
  }
}
