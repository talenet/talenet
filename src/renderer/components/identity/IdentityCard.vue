<template>
  <b-card @click="goToIdentityPage()" v-if="identity">
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
    },

    methods: {
      goToIdentityPage () {
        this.$router.push({
          name: 'identityDetails',
          params: {
            identityKey: this.identity.key()
          }
        })
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

<style lang="scss" scoped>
  .card {
    cursor: pointer;
  }
</style>
