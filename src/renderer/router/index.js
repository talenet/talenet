import Vue from 'vue'
import Router from './HistoryAwareRouter'
import HomePage from '../components/HomePage.vue'
import IdentityPage from '../components/identity/IdentityPage.vue'
import IdentityEditPage from '../components/identity/IdentityEditPage.vue'
import MessagesOverviewPage from '../components/messages/MessagesOverviewPage.vue'
import MessageStartThreadPage from '../components/messages/MessageStartThreadPage.vue'
import MessageThreadPage from '../components/messages/MessageThreadPage.vue'
import DefineSkillsPage from '../components/skills/DefineSkillsPage.vue'
import SkilliversePage from '../components/skills/SkilliversePage.vue'
import OwnIdeaPage from '../components/idea/OwnIdeaPage.vue'
import MatchingIdeaPage from '../components/idea/MatchingIdeaPage.vue'
import NewIdeaPage from '../components/idea/NewIdeaPage.vue'
import CopiedIdeaPage from '../components/idea/CopiedIdeaPage.vue'
import IdeaPage from '../components/idea/IdeaPage.vue'
import IdeaMatchesPage from '../components/idea/IdeaMatchesPage.vue'
import CreateIdeaPage from '../components/idea/CreateIdeaPage.vue'
import AssociatedIdeasPage from '../components/idea/AssociatedIdeasPage.vue'
import SettingsPage from '../components/SettingsPage.vue'

import { toSearchResultRoute } from '../util/search'

Vue.use(Router)

export default function ({ store }) {
  console.log('new Router')
  return new Router({
    mode: 'hash', // As Electron uses file:// in production we cannot use 'history' there.
    routes: [
      {
        path: '/',
        name: 'home',
        component: HomePage,
        meta: {
          title: 'home.page.title'
        }
      },
      {
        path: '/identity/edit',
        name: 'identityEdit',
        component: IdentityEditPage,
        meta: {
          title: 'identity.edit.page.title'
        }
      },
      {
        path: '/identity/:identityKey',
        name: 'identityDetails',
        component: IdentityPage,
        meta: {
          title: 'identity.details.page.title'
        }
      },
      {
        path: '/messages/start-thread/:identityKey',
        name: 'messageStartThread',
        component: MessageStartThreadPage,
        meta: {
          title: 'messages.startThread.page.title'
        }
      },
      {
        path: '/messages/:threadKey',
        name: 'messageThread',
        component: MessageThreadPage,
        meta: {
          title: 'messages.thread.page.title'
        }
      },
      {
        path: '/messages',
        name: 'messages',
        component: MessagesOverviewPage,
        meta: {
          title: 'messages.overview.page.title'
        }
      },
      {
        path: '/skills/all',
        name: 'skilliverse',
        component: SkilliversePage,
        meta: {
          title: 'skill.skilliverse.page.title'
        }
      },
      {
        path: '/skills/define',
        name: 'defineSkills',
        component: DefineSkillsPage,
        meta: {
          title: 'identity.defineSkills.page.title'
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
        path: '/ideas/my/:ideaKey',
        name: 'ownIdea',
        component: OwnIdeaPage,
        meta: {
          title: 'idea.page.title'
        }
      },
      {
        path: '/ideas/match/:ideaKey',
        name: 'matchingIdea',
        component: MatchingIdeaPage,
        meta: {
          title: 'idea.page.title'
        }
      },
      {
        path: '/ideas/new/:ideaKey',
        name: 'newIdea',
        component: NewIdeaPage,
        meta: {
          title: 'idea.page.title'
        }
      },
      {
        path: '/ideas/copied/:ideaKey',
        name: 'copiedIdea',
        component: CopiedIdeaPage,
        meta: {
          title: 'idea.page.title'
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
        path: '/search/:term',
        name: 'search',
        beforeEnter (to, from, next) {
          // TODO: Move to own search subrouter?
          const term = to.params.term

          const abort = error => {
            if (error) {
              store.commit('page/error', error)
            }

            if (from.name) {
              next(false)
            } else {
              next('/')
            }
          }

          // TODO: Display activity
          store.dispatch('ssb/waitForInitialization')
            .then(() => store.dispatch('search/find', term))
            .then(result => {
              const route = toSearchResultRoute(result)
              if (route) {
                return next(route)
              }

              abort()
            })
            .catch(err => {
              if (err) {
                console.error(err)
              }

              abort(err)
            })
        },
        meta: {
          title: 'search.page.title'
        }
      },
      {
        path: '/settings',
        name: 'settings',
        component: SettingsPage,
        meta: {
          title: 'settings.page.title'
        }
      },
      {
        // Fallback route
        path: '*',
        redirect: '/'
      }
    ]
  })
}
