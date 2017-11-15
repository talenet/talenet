import Vue from 'vue'
import App from './App.vue'
import BootstrapVue from 'bootstrap-vue'
import VeeValidate from 'vee-validate'
import router from './router'
import withStore from './store'
import i18n from './i18n'
import GlobalComponents from './components/global'

if (!process.env.IS_WEB) {
  Vue.use(require('vue-electron'))
}
Vue.config.productionTip = false

Vue.use(VeeValidate)
Vue.use(BootstrapVue)

GlobalComponents.register()

// defer app initialization until store, sbot, etc. are initialized
withStore((store) => {
  /* eslint-disable no-new */
  new Vue({
    el: '#app',
    router,
    store,
    i18n,
    template: '<App/>',
    components: {
      App
    }
  })
})
