<template>
  <div>
    <div>
      <div class="row">
        <div class="t-center-col">
          <t-introduction-box messagesKey="idea.matches.introduction"></t-introduction-box>
        </div>
      </div>
    </div>

    <div class="row">
      <div class="t-center-col">
        <t-idea-list
          v-if="ideaKeys.length > 0 || timedOut"
          :ideaKeys="ideaKeys"
          :no-ideas-text="$t('idea.matches.noIdeas')"
          timestamp="created"
          route="matchingIdea">
        </t-idea-list>

        <t-loading-animation v-else :inline="true" size="lg"></t-loading-animation>
      </div>
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

    data () {
      return {
        timedOut: false
      }
    },

    mounted () {
      setTimeout(() => {
        this.timedOut = true
      }, 10000)
    },

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
