<template>
  <t-navbar position="top">
    <b-nav-item slot="item" to="/ideas/matches">{{$t('navbar.matchingIdeas')}}</b-nav-item>
    <b-nav-item slot="item" to="/ideas/create">{{$t('navbar.createIdea')}}</b-nav-item>
    <b-nav-item slot="item" to="/skills">{{$t('navbar.skilliverse')}}</b-nav-item>
    <b-nav-form slot="item" @submit="$event.preventDefault()">
      <b-form-input type="text" :placeholder="$t('navbar.search')"></b-form-input>
    </b-nav-form>

    <t-hexagon-image
      slot="center"
      @click="goToHomePage()">
    </t-hexagon-image>
  </t-navbar>
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
