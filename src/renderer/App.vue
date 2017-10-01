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
          <b-nav-form>
            <b-button to="/register" class="mx-2 my-2 my-sm-0" variant="success">Register</b-button>
            <b-button to="/login" class="my-2 my-sm-0" variant="outline-secondary">Login</b-button>
          </b-nav-form>
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

  /**
   * This componet holds the whole app.
   */
  export default {
    name: 'app',

    created () {
      updateTitleFromRoute(this.$route, this.$store)
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
