<template>
  <div>
    <h1>{{$t('idea.associated.title')}}</h1>

    <b-alert variant="warning" show>TODO: Sort order</b-alert>

    <t-idea-list :ideaKeys="ownIdeas"></t-idea-list>
  </div>
</template>

<script>
  import SubscriptionMixin from '../../mixins/Subscription'
  import { mapGetters } from 'vuex'

  export default {
    mixins: [
      SubscriptionMixin({
        '!': 'idea/subscribeOwnIdeas',
        'ownIdeas': 'idea/subscribe'
      })
    ],

    computed: {
      ...mapGetters({
        ownIdeas: 'idea/ownIdeas'
      })
    }
  }
</script>
