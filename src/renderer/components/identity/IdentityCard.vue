<template>
  <b-card v-if="identity">
    <t-hexagon-image class="t-identity-card-image" :href="imageUrl(identity.imageKey())"></t-hexagon-image>
    <span>{{identity.name()}}</span>
  </b-card>
  <t-loading-animation v-else></t-loading-animation>
</template>

<script>
  import SubscriptionMixin from '../../mixins/Subscription'
  import { mapGetters } from 'vuex'

  export default {
    mixins: [
      SubscriptionMixin({
        'identityKey': 'identity/subscribe'
      })
    ],

    props: [
      'identityKey'
    ],

    computed: {
      ...mapGetters({
        imageUrl: 'ssb/blobUrl'
      }),

      identity () {
        return this.$store.getters['identity/get'](this.identityKey)
      }
    }
  }
</script>

<style lang="scss" scoped>
  @import "../../variables";

  .t-identity-card-image {
    width: $identity-card-image-size;
  }
</style>
