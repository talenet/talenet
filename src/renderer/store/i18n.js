/**
 * Store module for I18N.
 */
export default (app) => ({
  namespaced: true,

  mutations: {
    setLocale (state, locale) {
      app.$i18n.locale = locale
    }
  },

  actions: {
    setLocale ({ commit }, locale) {
      commit('setLocale', locale)
    }
  }
})
