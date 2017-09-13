import Vue from 'vue'
import Router from 'vue-router'
import Home from '@/components/Home'
import CatCodes from '@/components/CatCodes'

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
