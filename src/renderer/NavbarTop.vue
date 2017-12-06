<template>
  <b-navbar fixed="top" toggleable="sm" type="dark" variant="dark">
    <b-nav-toggle target="t-navbar-top-collapse"></b-nav-toggle>

    <b-collapse is-nav id="t-navbar-top-collapse" class="justify-content-center">
      <b-navbar-nav>
        <b-nav-item to="/ideas/matches">{{$t('navbar.matchingIdeas')}}</b-nav-item>
        <b-nav-item to="/ideas/create">{{$t('navbar.createIdea')}}</b-nav-item>
        <b-nav-item to="/skills">{{$t('navbar.skilliverse')}}</b-nav-item>
        <b-nav v-if="ssbConnected">
          <b-nav-item disabled>{{ ssbAbouts(ssbShort,'name') }}</b-nav-item>
        </b-nav>
        <b-nav v-if="!ssbConnected">
          <b-button class="mx-2 my-2 my-sm-0" @click="reconnect" variant="success">Reconnect</b-button>
        </b-nav>
        <b-nav-form>
          <b-form-input size="sm" class="mr-sm-2" type="text" :placeholder="$t('navbar.search')"></b-form-input>
        </b-nav-form>
      </b-navbar-nav>
    </b-collapse>
  </b-navbar>
</template>

<script>
  import { mapGetters } from 'vuex'

  export default {
    computed: {
      ...mapGetters({
        ssbConnected: 'ssb/connected',
        ssbShort: 'ssb/whoami',
        ssbAbouts: 'ssb/abouts'
      })
    },

    methods: {
      reconnect () {
        // this.$store.dispatch('ssb/connect')
      }
    }
  }
</script>

<style lang="scss" scoped>
  @import "variables";

  .navbar {
    border-bottom: $navbar-border-width solid $navbar-border-color;
  }
</style>
