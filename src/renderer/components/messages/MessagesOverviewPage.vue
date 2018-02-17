<template>
  <div class="row">
    <div class="t-center-col">
      <t-message-thread-card v-for="msg in messages" :message="msg" :key="msg.key">
      </t-message-thread-card>
    </div>
  </div>
</template>

<script>
  import SubscriptionMixin from '../../mixins/Subscription'
  import { mapGetters } from 'vuex'

  export default {
    mixins: [
      SubscriptionMixin({
        '!': [
          'privateMessages/subscribeOverview'
        ]
      })
    ],

    computed: {
      ...mapGetters({
        'messages': 'privateMessages/all'
      })
    }
  }
</script>
