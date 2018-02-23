<template>
  <div>
    <div class="row">
      <div class="t-center-col">
        <t-introduction-box messages-key="messages.introduction"></t-introduction-box>
      </div>
    </div>

    <div class="row">
      <div class="t-center-col">
        <transition appear name="fade" mode="out-in">
          <div v-if="messages.length > 0">
            <t-message-thread-card
              v-for="msg in messages" :message="msg"
              :key="msg.key">
            </t-message-thread-card>
          </div>

          <span v-else class="t-messages-overview-no-threads text-muted">
            {{$t('messages.overview.noThreads')}}
          </span>
        </transition>
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

<style lang="scss" scoped>
  @import "../../variables";

  .t-messages-overview-no-threads {
    display: block;

    margin: {
      left: $messages-overview-text-margin-x;
      right: $messages-overview-text-margin-x;
    }
  }
</style>
