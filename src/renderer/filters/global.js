import Vue from 'vue'

/**
 * Definition of globally available filters. Only list filters that are reusable.
 */
export default {
  register () {
    Vue.filter('t-format-timestamp', timestamp => {
      if (!timestamp) {
        return
      }
      // TODO: Nicer formatting
      return new Date(timestamp).toLocaleString('de-DE')
    })
  }
}
