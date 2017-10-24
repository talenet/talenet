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
      allIdeas (state) {
        return state.ideas
      }
    },

    mutations: {
      addIdea (state, idea) {
        state.ideas[idea.key] = idea
      }
    },

    actions: {
      /**
       * Creates a new idea.
       *
       * @return A promise that provides the created idea.
       */
      create ({ commit }, newIdea) {
        return persistence
          .createIdea(newIdea)
          .then((createdIdea) => {
            commit('addIdea', createdIdea)
            return createdIdea
          })
      }
    }
  }
}
