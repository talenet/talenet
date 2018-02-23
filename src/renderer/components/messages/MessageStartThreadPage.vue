<template>
  <transition appear name="fade" mode="out-in">
    <div v-if="ownIdentityKey && otherIdentityKey">
      <div class="row">
        <div class="t-center-col">
          <t-introduction-box messages-key="messages.introduction"></t-introduction-box>
        </div>
      </div>

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
  </transition>
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
