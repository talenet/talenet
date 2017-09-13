import Vue from 'vue'
import Vuex from 'vuex'

// Make vue.js use the vuex.js plugin. This also enables the possibility to inject the
// store into the components.
Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    loggedIn: false // simple example during setup phase ;-)
  },
  mutations: {
    login: state => { state.loggedIn = true }
  }
})
