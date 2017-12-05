/**
 * Store module for holding settings data.
 */
export default function () {
  return {
    namespaced: true,

    state () {
      return {
        introductions: {}
      }
    },

    getters: {
      isIntroductionRead (state) {
        return (name) => {
          const introduction = state.introductions[name] || {}
          return introduction.read || false
        }
      }
    },

    mutations: {
      markIntroductionAsRead (state, name) {
        const introductions = { ...state.introductions }
        if (!introductions[name]) {
          introductions[name] = {}
        }
        introductions[name].read = true

        state.introductions = introductions
      },

      resetIntroductions (state) {
        state.introductions = {}
      }
    },

    actions: {
      markIntroductionAsRead ({ commit }, name) {
        commit('markIntroductionAsRead', name)
      },

      resetIntroductions ({ commit }) {
        commit('resetIntroductions')
      }
    }
  }
}
