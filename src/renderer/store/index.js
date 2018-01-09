import Vue from 'vue'
import Vuex from 'vuex'
import createPersistedState from 'vuex-persistedstate'

import SSBAdapter from '../persistence/SSBAdapter'
import SkillAdapter from '../persistence/SkillAdapter'
import IdentityAdapter from '../persistence/IdentityAdapter'
import IdeaAdapter from '../persistence/IdeaAdapter'

import i18n from '../i18n'
import settings from './settings'
import development from './development'
import page from './page'
import ssb from './ssb'
import identity from './identity'
import skill from './skill'
import idea from './idea'

// Make vue.js use the vuex.js plugin. This also enables the possibility to inject the
// store into the components.
Vue.use(Vuex)

export default (callback) => {
  const ssbAdapter = new SSBAdapter()
  const skillAdapter = new SkillAdapter({ ssbAdapter })
  const identityAdapter = new IdentityAdapter({ ssbAdapter })
  const ideaAdapter = new IdeaAdapter({ ssbAdapter, identityAdapter })

  const store = new Vuex.Store({
    plugins: [createPersistedState({
      // Those are the store modules that are persisted in localstorage.
      paths: ['settings']
    })],

    strict: process.env.NODE_ENV !== 'production', // prevent state changes outside of mutations

    state: {
      err: null
    },

    modules: {
      settings: settings(),
      development: development(),
      ssb: ssb({ ssbAdapter }),
      identity: identity({ identityAdapter }),
      page: page({ i18n, document }),
      skill: skill({ skillAdapter }),
      idea: idea({ ideaAdapter })
    },

    mutations: {
      error (state, err) {
        state.err = err
      }
    }
  })

  // wait for sbot to be initialized to avoid race conditions
  ssbAdapter.connect(store)
    .then(() => skillAdapter.connect())
    .then(() => identityAdapter.connect())
    .then(() => ideaAdapter.connect())
    .catch(err => {
      store.commit('error', err)
    })

  callback(store)
}
