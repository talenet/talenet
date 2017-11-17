import Vue from 'vue'
import Router from 'vue-router'
import HomePage from '../components/HomePage.vue'
import IdeaPage from '../components/idea/IdeaPage.vue'
import IdeaMatchesPage from '../components/idea/IdeaMatchesPage.vue'
import CreateIdeaPage from '../components/idea/CreateIdeaPage.vue'
import AssociatedIdeasPage from '../components/idea/AssociatedIdeasPage.vue'
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
      path: '/ideas/matches',
      name: 'ideaMatches',
      component: IdeaMatchesPage,
      meta: {
        title: 'idea.matches.page.title'
      }
    },
    {
      path: '/ideas/associated',
      name: 'associatedIdeas',
      component: AssociatedIdeasPage,
      meta: {
        title: 'idea.associated.page.title'
      }
    },
    {
      path: '/ideas/create',
      name: 'ideaCreate',
      component: CreateIdeaPage,
      meta: {
        title: 'idea.create.page.title'
      }
    },
    {
      path: '/ideas/:ideaKey',
      name: 'idea',
      component: IdeaPage,
      meta: {
        title: 'idea.page.title'
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
