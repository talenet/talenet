<template>
  <div v-if="identity">
    <t-hexagon-image class="t-identity-details-image" :href="imageUrl(identity.imageKey())"></t-hexagon-image>

    <span>{{identity.name()}}</span>

    <div>
      <b-badge
        variant="primary"
        v-for="skillKey in skillKeys"
        :key="skillKey"
      >
        <span v-if="skill(skillKey)">{{skill(skillKey).name()}}</span>
        <t-loading-animation v-else></t-loading-animation>
      </b-badge>
    </div>

    <b-button v-if="ownIdentityKey && ownIdentityKey === identity.key()" variant="primary" @click="edit()">
      {{$t('identity.details.edit.button')}}
    </b-button>
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
        'identityKey': 'identity/subscribe',
        'skillKeys': 'skill/subscribe'
      })
    ],

    props: {
      identityKey: {
        type: String,
        required: true
      }
    },

    computed: {
      ...mapGetters({
        constraints: 'identity/constraints',
        ownIdentityKey: 'identity/ownIdentityKey',
        skill: 'skill/get',
        imageUrl: 'ssb/blobUrl'
      }),

      identity () {
        return this.$store.getters['identity/get'](this.identityKey)
      },

      skillKeys () {
        const identity = this.identity
        return identity ? identity.skills() : []
      }
    },

    methods: {
      edit () {
        this.$router.push({
          name: 'identityEdit'
        })
      }
    }
  }
</script>

<style lang="scss" scoped>
  @import "../../variables";

  .t-identity-details-image {
    width: $identity-details-image-size;
    height: $identity-details-image-size;
  }
</style>
