/**
 * Store module for holding settings data.
 */
export default function () {
  return {
    namespaced: true,

    state () {
      return {
        devMode: false,
        landingPageInviteDone: false,
        introductions: {}
      }
    },

    getters: {
      isDevMode (state) {
        return state.devMode
      },

      isLandingPageInviteDone (state) {
        return state.landingPageInviteDone
      },

      isIntroductionRead (state) {
        return (name) => {
          const introduction = state.introductions[name] || {}
          return introduction.read || false
        }
      }
    },

    mutations: {
      markLandingPageInviteAsDone (state) {
        state.landingPageInviteDone = true
      },

      resetLandingPageInvite (state) {
        state.landingPageInviteDone = false
      },

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
      },

      setDevMode (state, active) {
        state.devMode = active || false
      }
    },

    actions: {
      markLandingPageInviteAsDone ({ commit }) {
        commit('markLandingPageInviteAsDone')
      },

      resetLandingPageInvite ({ commit }) {
        commit('resetLandingPageInvite')
      },

      markIntroductionAsRead ({ commit }, name) {
        commit('markIntroductionAsRead', name)
      },

      resetIntroductions ({ commit }) {
        commit('resetIntroductions')
      },

      setDevMode ({ commit }, active) {
        commit('setDevMode', active)
      }
    }
  }
}
