import Vue from 'vue'
import Vuex from 'vuex'

import Persistence from '../persistence/SSBAdapter'

import i18n from '../i18n'
import page from './page'
import ssb from './ssb'
import idea from './idea'

// Make vue.js use the vuex.js plugin. This also enables the possibility to inject the
// store into the components.
Vue.use(Vuex)

let persistence = new Persistence()

let store = new Vuex.Store({
  strict: process.env.NODE_ENV !== 'production', // prevent state changes outside of mutations

  state: {
    err: null
  },

  modules: {
    ssb: ssb({ persistence }),
    page: page({ i18n, document }),
    idea: idea({ persistence })
  },

  mutations: {
    error (state, err) {
      state.err = err
    }
  }
})

persistence.connect(store)

export default store
