import Vue from 'vue'
import Vuex from 'vuex'

import i18n from '../i18n'
import page from './page'
import ssb from './ssb'

// Make vue.js use the vuex.js plugin. This also enables the possibility to inject the
// store into the components.
Vue.use(Vuex)

export default new Vuex.Store({
  strict: process.env.NODE_ENV !== 'production', // prevent state changes outside of mutations

  modules: {
    ssb: ssb,
    page: page({ i18n, document })
  }
})
