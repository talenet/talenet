import Vue from 'vue'

/**
 * Definition of globally available filters. Only list filters that are reusable.
 */
export default {
  register () {
    Vue.filter('tFormatTimestamp', timestamp => {
      if (!timestamp) {
        return
      }
      // TODO: Nicer formatting
      return new Date(timestamp).toLocaleString('de-DE')
    })

    Vue.filter('tFormatIdentityName', (identity, identityKey) => {
      const IDENTITY_KEY_AS_NAME_LENGTH = 12

      if (!identity) {
        return identityKey ? identityKey.substr(0, IDENTITY_KEY_AS_NAME_LENGTH) : ''
      }
      return identity.name() || identity.key().substr(0, IDENTITY_KEY_AS_NAME_LENGTH)
    })
  }
}
