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
      }
    },

    getters: {
      version () {
        return version
      }
    },

    mutations: {},

    actions: {
      showElectronDevTools () {
        ipcRenderer.send('showDevTools')
      }
    }
  }
}
