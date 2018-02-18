/**
 * Store module for performing searches.
 */
export default function ({ searchAdapter }) {
  return {
    namespaced: true,

    state () {
      return {}
    },

    actions: {
      find (context, term) {
        return searchAdapter.find(term)
      }
    }
  }
}
