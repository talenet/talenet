<template>
  <div>
    <t-message-thread-header
      :ownIdentity="ownIdentity"
      :otherIdentity="ownIdentity">
    </t-message-thread-header>
  </div>
</template>

<script>
  import SubscriptionMixin from '../../mixins/Subscription'
  import { mapGetters } from 'vuex'

  export default {
    mixins: [
      SubscriptionMixin({
        '!': [
          'identity/subscribeOwnIdentityKey'
        ],
        'ownIdentityKey': 'identity/subscribe'
      })
    ],

    computed: {
      ...mapGetters({
        'ownIdentityKey': 'identity/ownIdentityKey',
        'ownIdentity': 'identity/own'
      })
    }
  }
</script>

<style lang="scss" scoped>

</style>
