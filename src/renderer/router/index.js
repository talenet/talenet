import Vue from 'vue'
import Router from 'vue-router'
import HomePage from '../components/HomePage.vue'
import SSBDemo from '../components/SSBDemo.vue'

Vue.use(Router)

export default new Router({
  mode: 'hash', // As Electron uses file:// in production we cannot use 'history' there.
  routes: [
    {
      path: '/',
      name: 'home',
      component: HomePage,
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
    }
  ]
})
