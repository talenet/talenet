<template>
  <div v-if="ownIdentityKey" class="t-identity-key-pair-download">
    <div class="t-identity-key-pair-download-heading">{{$t('identity.keyPair.download.heading')}}</div>

    <t-introduction-box messages-key="identity.keyPair.download.introduction"></t-introduction-box>

    <div class="t-identity-key-pair-download-pubkey-label">{{$t('identity.keyPair.download.pubkey.label')}}</div>
    <div class="t-identity-key-pair-download-pubkey">{{ownIdentityKey}}</div>

    <t-button-panel>
      <b-button slot="left" variant="primary" @click="download">{{$t('identity.keyPair.download.button')}}</b-button>
    </t-button-panel>
  </div>

  <div v-else>
    <t-loading-animation size="md"></t-loading-animation>
  </div>
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
        ownIdentityKey: 'identity/ownIdentityKey'
      })
    },

    methods: {
      download () {
        this.$store.dispatch('identity/downloadKeyPair')
          .catch(err => {
            if (err) {
              console.error(err)
            }
          })
      }
    }
  }
</script>

<style lang="scss" scoped>
  @import "../../variables";

  .t-identity-key-pair-download {
    .t-identity-key-pair-download-heading,
    .t-identity-key-pair-download-pubkey-label,
    .t-identity-key-pair-download-pubkey {
      margin: {
        top: $identity-key-pair-download-margin-y;
        bottom: $identity-key-pair-download-margin-y;
        left: $identity-key-pair-download-margin-x;
        right: $identity-key-pair-download-margin-x;
      }
    }

    .t-identity-key-pair-download-pubkey {
      font-family: $identity-key-pair-download-pubkey-font-family;
      font-size: $identity-key-pair-download-pubkey-font-size;
      word-break: break-all;
    }
  }
</style>
