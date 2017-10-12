<template>
  <div class="home">
    <h1>{{ $t('home.welcome') }}</h1>

    <div v-if="ssbConnected">
      <h2>Your SSB ID:</h2>
      <pre>{{ whoami }}</pre>
    </div>

    <button v-if="!ssbConnected" @click="connect" class="login">Connect ScuttleBot</button>
  </div>
</template>

<script>
  import {mapGetters} from 'vuex'

  export default {
    name: 'home',
    computed: {
      ...mapGetters({
        ssbConnected: 'ssb/connected'
      }),
      whoami () {
        return this.$store.getters['ssb/whoami']
      }
    },
    methods: {
      connect () {
        this.$store.dispatch('ssb/connect')
      }
    }
  }
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped lang="scss">
  $fw: bold; // Simple example to demonstrate SCSS is working.

  .home {
    h1 {
      font-weight: $fw;
    }
  }
</style>
