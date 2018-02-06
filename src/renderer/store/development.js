import { version } from '../../../package.json'
import { ipcRenderer } from 'electron'
import Vue from 'vue'

/**
 * Store module development tools.
 */
export default function () {
  return {
    namespaced: true,

    state () {
      return {
        skilliverseDebug: {
          showClickAreas: false,
          showResumeSimulationButton: false,
          showVotes: false
        }
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
      toggleSkilliverseDebug (state, field) {
        Vue.set(state.skilliverseDebug, field, !state.skilliverseDebug[field])
      }
    },

    actions: {
      showElectronDevTools () {
        ipcRenderer.send('showDevTools')
      },

      toggleSkilliverseDebug ({ commit }, field) {
        commit('toggleSkilliverseDebug', field)
      }
    }
  }
}
