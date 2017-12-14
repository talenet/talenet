<template>
  <div>
    <h1>{{$t('idea.associated.title')}}</h1>

    <t-idea-list :ideaKeys="sortedKeys"></t-idea-list>
  </div>
</template>

<script>
  import SubscriptionMixin from '../../mixins/Subscription'
  import { mapGetters } from 'vuex'

  export default {
    mixins: [
      SubscriptionMixin({
        '!': ['identity/subscribeOwnIdentityKey', 'idea/subscribeOwnIdeas'],
        'ownIdeas': 'idea/subscribe'
      })
    ],

    computed: {
      ...mapGetters({
        ownIdentityKey: 'identity/ownIdentityKey',
        ownIdeas: 'idea/ownIdeas',
        idea: 'idea/get'
      }),

      sortedKeys () {
        const keys = [...this.ownIdeas]
        keys.sort((key1, key2) => {
          const idea1 = this.idea(key1)
          const idea2 = this.idea(key2)

          if (!idea1) {
            return -1
          }
          if (!idea2) {
            return 1
          }

          const hasHat1 = idea1.hasHat(this.ownIdentityKey)
          const hasHat2 = idea2.hasHat(this.ownIdentityKey)

          if (hasHat1 !== hasHat2) {
            if (hasHat1) {
              return -1
            } else {
              return 1
            }
          }

          // Later updates come first
          return idea2.lastUpdate() - idea1.lastUpdate()
        })
        return keys
      }
    }
  }
</script>
