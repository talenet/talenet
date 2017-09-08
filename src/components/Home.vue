<template>
  <div class="home">
    <h1>{{ msg }}</h1>

    <p>{{ userState }}</p>

    <button v-if="loggedOut" @click="login" class="login">Login</button>
  </div>
</template>

<script>
export default {
  name: 'home',
  data () {
    return {
      msg: 'Welcome to TALEnet, the intergalactic skill & idea sharing community.'
    }
  },
  computed: {
    loggedOut () {
      return !this.$store.state.loggedIn
    },

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
<style scoped>
h1 {
  font-weight: normal;
}
</style>
