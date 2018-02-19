<template>
  <div v-if="ownIdentityKey && otherIdentityKey && messages.length > 0">
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
</template>

<script>
  import SubscriptionMixin from '../../mixins/Subscription'
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
        return this.$store.getters['privateMessages/threadByKey'](this.threadKey) || []
      },

      otherIdentityKey () {
        let author = null
        const me = this.ownIdentityKey
        // only once on mutation?!
        for (const msg of this.messages) {
          if (msg.value.author !== me) {
            author = msg.value.author
            break
          }
        }
        return author
      }
    }
  }
</script>
