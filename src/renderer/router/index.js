import Vue from 'vue'
import Router from 'vue-router'
import Home from '@/components/Home.vue'
import CatCodes from '@/components/CatCodes.vue'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'Home',
      component: Home
    },
    {
      path: '/catcodes',
      name: 'Cat Codes',
      component: CatCodes
    }
  ]
})
