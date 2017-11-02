import Vue from 'vue'
import App from './App.vue'
import BootstrapVue from 'bootstrap-vue'
import VeeValidate from 'vee-validate'
import router from './router'
import store from './store'
import i18n from './i18n'
import GlobalComponents from './components/global'

if (!process.env.IS_WEB) {
  Vue.use(require('vue-electron'))
}
Vue.config.productionTip = false

Vue.use(VeeValidate)
Vue.use(BootstrapVue)

GlobalComponents.register()

/* eslint-disable no-new */
export const app = new Vue({
  el: '#app',
  router,
  store,
  i18n,
  template: '<App/>',
  components: {
    App
  }
})
