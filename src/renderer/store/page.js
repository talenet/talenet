import { renderTitle } from '../util/page'

/**
 * Store module holding general page state.
 */
export default function ({ i18n, document }) {
  return {
    namespaced: true,

    state () {
      return {
        title: 'page.default.title',
        navbar: true,
        error: null
      }
    },

    getters: {
      locale () {
        return i18n.locale
      },

      navbar (state) {
        return state.navbar
      },

      error (state) {
        return state.error
      }
    },

    mutations: {
      setLocale (state, locale) {
        i18n.locale = locale
        renderTitle(state.title, i18n, document)
      },

      setTitle (state, title) {
        state.title = title
        renderTitle(title, i18n, document)
      },

      hideNavbar (state) {
        state.navbar = false
      },

      showNavbar (state) {
        state.navbar = true
      },

      error (state, error) {
        state.error = error
      }
    },

    actions: {
      setLocale ({ commit }, locale) {
        commit('setLocale', locale)
      },

      setTitle ({ commit }, title) {
        commit('setTitle', title)
      },

      hideNavbar ({ commit }) {
        commit('hideNavbar')
      },

      showNavbar ({ commit }) {
        commit('showNavbar')
      }
    }
  }
}
