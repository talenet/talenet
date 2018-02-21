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
        showGrid: false,
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

      showGrid (state) {
        return state.showGrid
      },

      skilliverseDebug (state) {
        return state.skilliverseDebug
      }
    },

    mutations: {
      toggleGrid (state) {
        state.showGrid = !state.showGrid
      },

      toggleSkilliverseDebug (state, field) {
        Vue.set(state.skilliverseDebug, field, !state.skilliverseDebug[field])
      }
    },

    actions: {
      showElectronDevTools () {
        ipcRenderer.send('showDevTools')
      },

      toggleGrid ({ commit }) {
        commit('toggleGrid')
      },

      toggleSkilliverseDebug ({ commit }, field) {
        commit('toggleSkilliverseDebug', field)
      }
    }
  }
}
