import Vue from 'vue'
import Router from 'vue-router'
import Home from '../components/Home.vue'
import CatCodes from '../components/CatCodes.vue'
import SSBDemo from '../components/SSBDemo.vue'

Vue.use(Router)

export default new Router({
  mode: 'hash', // As Electron uses file:// in production we cannot use 'history' there.
  routes: [
    {
      path: '/',
      component: Home,
      meta: {
        title: 'home.title'
      }
    },
    {
      path: '/ssbdemo',
      component: SSBDemo,
      meta: {
        title: 'ssb.title'
      }
    },
    {
      path: '/catcodes',
      component: CatCodes
    }
  ]
})
