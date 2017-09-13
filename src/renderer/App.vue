<template>
  <div id="app">
    <h1>"Menu"</h1>
    <ul>
      <li><router-link to="/">Home</router-link></li>
      <li><router-link to="/catcodes">cats</router-link></li>
      <!-- <li><router-link to="/ssb">SSB Demo</router-link></li> -->
    </ul>
    <router-view></router-view>
  </div>
</template>

<script>
export default {
  name: 'app'
}
</script>

<style>
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  color: #2c3e50;
  margin-top: 60px;
}
</style>
