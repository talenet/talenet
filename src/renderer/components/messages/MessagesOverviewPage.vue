<template>
  <div class="row">
    <div class="t-center-col">
      <t-message-thread-card
        :ownIdentity="ownIdentity"
        :otherIdentity="ownIdentity"
        :text="txt">
      </t-message-thread-card>
      <t-message-thread-card
        :ownIdentity="ownIdentity"
        :otherIdentity="ownIdentity"
        :text="txt">
      </t-message-thread-card>
      <t-message-thread-card
        :ownIdentity="ownIdentity"
        :otherIdentity="ownIdentity"
        :text="txt">
      </t-message-thread-card>
      <t-message-thread-card
        :ownIdentity="ownIdentity"
        :otherIdentity="ownIdentity"
        :text="txt">
      </t-message-thread-card>
      <t-message-thread-card
        :ownIdentity="ownIdentity"
        :otherIdentity="ownIdentity"
        :text="txt">
      </t-message-thread-card>
      <t-message-thread-card
        :ownIdentity="ownIdentity"
        :otherIdentity="ownIdentity"
        :text="txt">
      </t-message-thread-card>
      <t-message-thread-card
        :ownIdentity="ownIdentity"
        :otherIdentity="ownIdentity"
        :text="txt">
      </t-message-thread-card>
      <t-message-thread-card
        :ownIdentity="ownIdentity"
        :otherIdentity="ownIdentity"
        :text="txt">
      </t-message-thread-card>
      <t-message-thread-card
        :ownIdentity="ownIdentity"
        :otherIdentity="ownIdentity"
        :text="txt">
      </t-message-thread-card>
      <t-message-thread-card
        :ownIdentity="ownIdentity"
        :otherIdentity="ownIdentity"
        :text="txt">
      </t-message-thread-card>
      <t-message-thread-card
        :ownIdentity="ownIdentity"
        :otherIdentity="ownIdentity"
        :text="txt">
      </t-message-thread-card>
      <t-message-thread-card
        :ownIdentity="ownIdentity"
        :otherIdentity="ownIdentity"
        :text="txt">
      </t-message-thread-card>

      <b-form-textarea v-model="txt"></b-form-textarea>
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
    },

    data () {
      return {
        txt: ''
      }
    }
  }
</script>
