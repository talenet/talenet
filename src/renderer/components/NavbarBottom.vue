<template>
  <div>
    <t-navbar position="bottom">
      <b-nav-item slot="item" to="/ideas/associated">{{$t('navbar.associatedIdeas')}}</b-nav-item>
      <b-nav-item slot="item" to="/messages">{{$t('navbar.messages')}}</b-nav-item>
      <b-nav-item slot="item" to="/skills/define">{{$t('navbar.defineSkills')}}</b-nav-item>
      <b-nav-item slot="item" to="/settings">{{$t('navbar.settings')}}</b-nav-item>

      <t-hexagon-image
        slot="center"
        v-if="ownIdentity"
        @click="goToIdentityPage()"
        :href="imageUrl(ownIdentity.imageKey())">
      </t-hexagon-image>
    </t-navbar>
  </div>
</template>

<script>
  import SubscriptionMixin from '../mixins/Subscription'
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
    },

    methods: {
      goToIdentityPage () {
        this.$router.push({
          name: 'identityDetails',
          params: {
            identityKey: this.ownIdentityKey
          }
        })
      }
    }
  }
</script>
