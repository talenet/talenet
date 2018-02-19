<template>
  <div v-if="ownIdentityKey && otherIdentityKey">
    <t-message-thread-view
      :ownIdentityKey="ownIdentityKey"
      :otherIdentityKey="otherIdentityKey"
      :messages="[]">
    </t-message-thread-view>

    <t-message-thread-start-form
      :ownIdentityKey="ownIdentityKey"
      :otherIdentityKey="otherIdentityKey">
    </t-message-thread-start-form>
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
        '!': 'identity/subscribeOwnIdentityKey'
      })
    ],

    computed: {
      ...mapGetters({
        'ownIdentityKey': 'identity/ownIdentityKey'
      }),

      otherIdentityKey () {
        return this.$route.params.identityKey
      }
    }
  }
</script>
