<template>
  <transition appear name="fade" mode="out-in">
    <div v-if="ownIdentityKey && otherIdentityKey && messages.length > 0">
      <div class="row">
        <div class="t-center-col">
          <t-introduction-box messages-key="messages.introduction"></t-introduction-box>
        </div>
      </div>

      <t-message-thread-view
        :threadKey="threadKey"
        :messages="messages"
        :ownIdentityKey="ownIdentityKey"
        :otherIdentityKey="otherIdentityKey">
      </t-message-thread-view>

      <t-message-thread-reply-form
        :threadKey="threadKey"
        :ownIdentityKey="ownIdentityKey"
        :otherIdentityKey="otherIdentityKey">
      </t-message-thread-reply-form>
    </div>

    <t-center-on-page v-else>
      <t-loading-animation size="lg"></t-loading-animation>
    </t-center-on-page>
  </transition>
</template>

<script>
  import SubscriptionMixin from '../../mixins/Subscription'
  import _ from 'lodash'
  import { mapGetters } from 'vuex'

  export default {
    mixins: [
      SubscriptionMixin({
        '!': 'identity/subscribeOwnIdentityKey',
        'threadKey': 'privateMessages/subscribeByThread'
      })
    ],

    computed: {
      ...mapGetters({
        'ownIdentityKey': 'identity/ownIdentityKey'
      }),

      threadKey () {
        return this.$route.params.threadKey
      },

      messages () {
        const messages = this.$store.getters['privateMessages/threadByKey'](this.threadKey)
        if (!messages) {
          return []
        }

        return _.sortBy(messages, msg => msg.value.timestamp)
      },

      otherIdentityKey () {
        const me = this.ownIdentityKey

        for (const msg of this.messages) {
          if (msg.value.author !== me) {
            return msg.value.author
          }
        }

        for (const msg of this.messages) {
          for (const recipient of msg.value.content.recps) {
            if (recipient !== me) {
              return recipient
            }
          }
        }

        // No one else but me found, so I'm talking to myself.
        return me
      }
    }
  }
</script>
