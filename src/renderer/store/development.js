import { version } from '../../../package.json'
import { ipcRenderer } from 'electron'

/**
 * Store module development tools.
 */
export default function () {
  return {
    namespaced: true,

    state () {
      return {
        skilliverseDebug: false
      }
    },

    getters: {
      version () {
        return version
      },

      skilliverseDebug (state) {
        return state.skilliverseDebug
      }
    },

    mutations: {
      toggleSkilliverseDebug (state) {
        state.skilliverseDebug = !state.skilliverseDebug
      }
    },

    actions: {
      showElectronDevTools () {
        ipcRenderer.send('showDevTools')
      },

      toggleSkilliverseDebug ({ commit }) {
        commit('toggleSkilliverseDebug')
      }
    }
  }
}
