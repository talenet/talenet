import Vue from 'vue'
import App from './App.vue'
import BootstrapVue from 'bootstrap-vue'
import VeeValidate from 'vee-validate'
import router from './router'
import withStore from './store'
import i18n from './i18n'
import GlobalComponents from './components/global'
import GlobalFilters from './filters/global'
import applyConfig from './configuration'

if (!process.env.IS_WEB) {
  Vue.use(require('vue-electron'))
}

applyConfig()

Vue.config.productionTip = false

Vue.use(VeeValidate)
Vue.use(BootstrapVue)

GlobalComponents.register()
GlobalFilters.register()

// defer app initialization until store, sbot, etc. are initialized
withStore((store) => {
  /* eslint-disable no-new */
  new Vue({
    el: '#app',
    router: router({ store }),
    store,
    i18n,
    template: '<App/>',
    components: {
      App
    }
  })
})
