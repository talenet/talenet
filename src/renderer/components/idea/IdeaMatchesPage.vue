<template>
  <div class="row">
    <div class="col-md-6">
      <h1>{{$t('idea.matches.title')}}</h1>

      <t-idea-list :ideaKeys="ideaKeys"></t-idea-list>
    </div>
  </div>
</template>

<script>
  import SubscriptionMixin from '../../mixins/Subscription'
  import { mapGetters } from 'vuex'

  export default {
    mixins: [
      SubscriptionMixin({
        '!': 'idea/subscribeMatches',
        'ideaKeys': 'idea/subscribe'
      })
    ],

    computed: {
      ...mapGetters({
        matches: 'idea/matches'
      }),

      ideaKeys () {
        const keys = Object.keys(this.matches)
        keys.sort((key1, key2) => {
          const match1 = this.matches[key1]
          const match2 = this.matches[key2]

          const countDiff = match1.matchingSkillsCount - match2.matchingSkillsCount
          if (countDiff !== 0) {
            return countDiff
          }
          return match1.creationTimestamp - match2.creationTimestamp
        })
        return keys
      }
    }
  }
</script>
