<template>
  <div class="home">
    <h1>{{ $t('home.welcome') }}</h1>

    <p>{{ userState }}</p>

    <button v-if="loggedOut" @click="login" class="login">Login</button>
  </div>
</template>

<script>
  import {mapGetters} from 'vuex'

  export default {
    name: 'home',
    computed: {
      ...mapGetters({
        loggedOut: 'loggedOut'
      }),
      userState () {
        return this.$store.state.loggedIn ? 'You are logged in.' : 'You are logged out.'
      }
    },
    methods: {
      login () {
        this.$store.commit('login')
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
