import Vue from 'vue'
import Vuex from 'vuex'

// Make vue.js use the vuex.js plugin. This also enables the possibility to inject the
// store into the components.
Vue.use(Vuex)

export default new Vuex.Store({
  strict: process.env.NODE_ENV !== 'production', // prevent state changes outside of mutations
  state: {
    loggedIn: false // simple example during setup phase ;-)
  },
  getters: {
    loggedOut: state => !state.loggedIn
  },
  mutations: {
    login: state => {
      state.loggedIn = true
    }
  }
})
