<template>
  <transition appear name="fade" mode="out-in">
    <div v-if="ownIdentityKey && otherIdentityKeys.length > 0 && messages.length > 0">
      <div class="row">
        <div class="t-center-col">
          <t-introduction-box messages-key="messages.introduction"></t-introduction-box>
        </div>
      </div>

      <t-message-thread-view
        :threadKey="threadKey"
        :messages="messages"
        :ownIdentityKey="ownIdentityKey"
        :otherIdentityKeys="otherIdentityKeys">
      </t-message-thread-view>

      <t-message-thread-reply-form
        :threadKey="threadKey"
        :ownIdentityKey="ownIdentityKey"
        :otherIdentityKeys="otherIdentityKeys">
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
        if (typeof messages === 'undefined') {
          console.error('messages should not be undefined!')
          return []
        }

        return _.sortBy(messages, msg => msg.value.timestamp)
      },

      otherIdentityKeys () { // only once on mutation?!
        const authors = new Set()
        const me = this.ownIdentityKey
        for (const msg of this.messages) {
          if (msg.value.author !== me) {
            authors.add(msg.value.author)
          }
          for (const recipient of msg.value.content.recps) {
            if (recipient !== me) {
              authors.add(recipient)
            }
          }
        }
        return Array.from(authors)
      }
    }
  }
</script>
