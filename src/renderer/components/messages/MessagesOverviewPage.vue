<template>
  <div>
    <div class="row">
      <div class="t-center-col">
        <t-introduction-box messages-key="messages.introduction"></t-introduction-box>
      </div>
    </div>

    <div class="row">
      <div class="t-center-col">
        <t-message-thread-card v-for="msg in messages" :message="msg" :key="msg.key">
        </t-message-thread-card>
      </div>
    </div>
  </div>
</template>

<script>
  import SubscriptionMixin from '../../mixins/Subscription'
  import _ from 'lodash'

  export default {
    mixins: [
      SubscriptionMixin({
        '!': [
          'privateMessages/subscribeOverview'
        ]
      })
    ],

    computed: {
      messages () {
        const messages = this.$store.getters['privateMessages/all']
        if (!messages) {
          return []
        }

        return _.sortBy(messages, msg => -msg.value.timestamp)
      }
    }
  }
</script>
