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

    <b-button
      v-if="isDevMode"
      class="t-toggle-dev-locale"
      variant="outline-danger"
      size="sm"
      @click="toggleDevLocale()">
      {{$t('navbar.dev.toggleLocale')}} ({{locale}})
    </b-button>
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
        imageUrl: 'ssb/blobUrl',
        isDevMode: 'settings/isDevMode',
        locale: 'page/locale'
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
      },

      toggleDevLocale () {
        let newLocale
        if (this.locale.startsWith('dev-')) {
          newLocale = this.locale.slice(4)
        } else {
          newLocale = 'dev-' + this.locale
        }

        this.$store.dispatch('page/setLocale', newLocale)
      }
    }
  }
</script>

<style lang="scss" scoped>
  @import "../variables";

  .t-toggle-dev-locale {
    position: fixed;
    bottom: $navbar-content-height + 10px;
    right: 10px;

    z-index: $zindex-fixed + 1;
  }
</style>
