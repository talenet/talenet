<template>
  <div id="app">
    <b-navbar toggleable="md" type="dark" variant="dark">
      <b-navbar-brand to="/">TALEnet</b-navbar-brand>

      <b-nav-toggle target="nav_collapse"></b-nav-toggle>

      <b-collapse is-nav id="nav_collapse">
        <b-nav is-nav-bar>
          <b-nav-item to="/">Home</b-nav-item>
          <b-nav-item to="/ssbdemo">SSB Demo</b-nav-item>
          <b-nav-item to="/catcodes">Cats</b-nav-item>
        </b-nav>

        <b-nav is-nav-bar class="ml-auto">
          <!-- TODO: ssb heartbeat? -->
          <b-nav v-if="ssbConnected">
           <b-nav-item disabled>Connected as {{ ssbShort }}</b-nav-item>
          </b-nav>
          <b-nav v-if="!ssbConnected">
           <b-button class="mx-2 my-2 my-sm-0" @click="reconnect" variant="success">Reconnect</b-button>
          </b-nav>
        </b-nav>
      </b-collapse>
    </b-navbar>

    <b-container>
      <router-view></router-view>
    </b-container>
  </div>
</template>

<script>
  import { updateTitleFromRoute } from './util/page'
  import {mapGetters} from 'vuex'

  /**
   * This componet holds the whole app.
   */
  export default {
    name: 'app',

    created () {
      updateTitleFromRoute(this.$route, this.$store)
      this.$store.dispatch('ssb/connect')
    },

    computed: {
      ...mapGetters({
        ssbConnected: 'ssb/connected'
        // ssbShort: 'ssb/whoami'
      }),
      ssbShort () {
        return this.$store.state.ssb.id.slice(0, 10) + '...'
      }
    },

    methods: {
      reconnect () {
        this.$store.dispatch('ssb/connect')
      }
    },

    watch: {
      '$route' (route) {
        updateTitleFromRoute(route, this.$store)
      }
    }
  }
</script>

<style lang="scss">
  // App SCSS intialization block.
  @import "variables";
  @import "../../node_modules/bootstrap/scss/bootstrap";
  @import "global-fixes";
</style>

<style scoped lang="scss">
  // Component specific styling.
</style>
