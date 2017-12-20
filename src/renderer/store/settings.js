// import { ipcRenderer } from 'electron' <= doesn't work.
// looks like webpack-foo related: https://stackoverflow.com/questions/44008674/how-to-import-the-electron-ipcrenderer-in-a-react-webpack-2-setup
const ipcRenderer = require('electron').ipcRenderer

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
        // could be it's own button...?
        ipcRenderer.send('toggleDevMode', state.devMode)
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
