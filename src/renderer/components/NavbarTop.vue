<template>
  <div>
    <t-navbar position="top">
      <b-nav-item slot="item" to="/ideas/matches">{{$t('navbar.matchingIdeas')}}</b-nav-item>
      <b-nav-item slot="item" to="/ideas/create">{{$t('navbar.createIdea')}}</b-nav-item>
      <b-nav-item slot="item" to="/skills/all">{{$t('navbar.skilliverse')}}</b-nav-item>
      <b-nav-form slot="item" @submit="$event.preventDefault()">
        <b-form-input id="search" type="text" :placeholder="$t('navbar.search')"></b-form-input>
      </b-nav-form>

      <t-connection-activity-indicator
        slot="center"
        @click="goToHomePage()">
      </t-connection-activity-indicator>
    </t-navbar>

    <b-tooltip :show.sync="showTooltip" target="search" placement="bottom">
      <span class="t-navbar-search-tooltip">{{$t('navbar.searchUnderConstruction.tooltip')}}</span>
    </b-tooltip>
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

    data () {
      return {
        showTooltip: false
      }
    },

    computed: {
      ...mapGetters({
        // ssbConnected: 'ssb/connected',
        ownIdentityKey: 'identity/ownIdentityKey',
        ownIdentity: 'identity/own'
      })
    },

    methods: {
      // reconnect () {
      //   this.$store.dispatch('ssb/connect')
      // },

      goToHomePage () {
        this.$router.push({
          name: 'home'
        })
      }
    }
  }
</script>

<style lang="scss" scoped>
  @import "../variables";

  .t-navbar-search-tooltip {
    font-size: $font-size-base;
  }
</style>
