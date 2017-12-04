<template>
  <div>
    <h1>TODO: Matches</h1>

    <t-idea-list :ideaKeys="matches"></t-idea-list>
  </div>
</template>

<script>
  import SubscriptionMixin from '../../mixins/Subscription'
  import { mapGetters } from 'vuex'

  export default {
    mixins: [
      SubscriptionMixin
    ],

    methods: {
      subscriptions () {
        return {
          '!': 'idea/subscribeMatches',
          'matches': 'idea/subscribe'
        }
      }
    },

    computed: {
      ...mapGetters({
        matches: 'idea/matches'
      })
    }
  }
</script>
