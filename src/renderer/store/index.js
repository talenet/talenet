import Vue from 'vue'
import Vuex from 'vuex'
import createPersistedState from 'vuex-persistedstate'

import Persistence from '../persistence/SSBAdapter'

import i18n from '../i18n'
import settings from './settings'
import page from './page'
import ssb from './ssb'
import skill from './skill'
import idea from './idea'

// Make vue.js use the vuex.js plugin. This also enables the possibility to inject the
// store into the components.
Vue.use(Vuex)

export default (callback) => {
  const persistence = new Persistence()

  const store = new Vuex.Store({
    plugins: [createPersistedState({
      // Those are the store modules that are persisted in localstorage.
      paths: ['settings']
    })],

    strict: process.env.NODE_ENV !== 'production', // prevent state changes outside of mutations

    state: {
      err: null
    },

    modules: {
      settings: settings(),
      ssb: ssb({ persistence }),
      page: page({ i18n, document }),
      skill: skill({ persistence }),
      idea: idea({ persistence })
    },

    mutations: {
      error (state, err) {
        state.err = err
      }
    }
  })

  // wait for sbot to be initialized to avoid race conditions
  persistence.connect(store)
    .then(() => callback(store))
    .catch((err) => {
      store.commit('error', err)
      callback(store)
    })
}
