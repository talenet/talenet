import { ipcRenderer } from 'electron'

/**
 * Store module development tools.
 */
export default function () {
  return {
    namespaced: true,

    state () {
      return {
      }
    },

    getters: {},

    mutations: {},

    actions: {
      showElectronDevTools () {
        ipcRenderer.send('showDevTools')
      }
    }
  }
}
