<template>
  <div v-if="ownIdentity">
    <t-hexagon-image :radius="50" :href="imageUrl(ownIdentity.imageKey())"></t-hexagon-image>
    <span>{{ownIdentity.name()}}</span>
  </div>
  <t-loading-animation v-else></t-loading-animation>
</template>

<script>
  import SubscriptionMixin from '../../mixins/Subscription'
  import { mapGetters } from 'vuex'

  export default {
    mixins: [
      SubscriptionMixin({
        '!': 'identity/subscribeOwnIdentityKey',
        'ownIdentityKey': 'identity/subscribe'
      })
    ],

    computed: {
      ...mapGetters({
        ownIdentity: 'identity/own',
        ownIdentityKey: 'identity/ownIdentityKey',
        imageUrl: 'ssb/blobUrl'
      })
    }
  }
</script>
