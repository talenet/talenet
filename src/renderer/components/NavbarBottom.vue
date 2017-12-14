<template>
  <b-navbar fixed="bottom" toggleable="sm" type="dark" variant="dark">
    <b-nav-toggle target="t-navbar-bottom-collapse"></b-nav-toggle>

    <b-collapse is-nav id="t-navbar-bottom-collapse" class="justify-content-center">
      <b-navbar-nav>
        <b-nav-item to="/ideas/associated">{{$t('navbar.associatedIdeas')}}</b-nav-item>
        <b-nav-item to="/messages">{{$t('navbar.messages')}}</b-nav-item>
        <div v-if="ownIdentity" class="t-identity-image-container">
          <t-hexagon-image
            class="t-identity-image"
            @click="goToIdentityPage()"
            :href="imageUrl(ownIdentity.imageKey())">
          </t-hexagon-image>
        </div>
        <b-nav-item to="/skills/define">{{$t('navbar.defineSkills')}}</b-nav-item>
        <b-nav-item to="/settings">{{$t('navbar.settings')}}</b-nav-item>

        <b-button
          v-if="isDevMode"
          variant="danger"
          @click="toggleDevLocale()">
          {{$t('navbar.dev.toggleLocale')}} ({{locale}})
        </b-button>
      </b-navbar-nav>
    </b-collapse>
  </b-navbar>
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
          name: 'identityEdit'
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

  .navbar {
    border-top: $navbar-border-width solid $navbar-border-color;
  }

  .t-identity-image-container {
    position: absolute;
    top: 0;
    left: 50%;
    margin-left: -$navbar-identity-image-size / 2;
    margin-top: -$navbar-identity-image-size / 2;

    .t-identity-image {
      width: $navbar-identity-image-size;
    }
  }
</style>
