<template>
  <b-card>
    <t-hexagon-image :radius="25" href="http://csshexagon.com/img/meow.jpg"></t-hexagon-image>
    <span>{{abouts(identityKey, 'name')}}</span>
  </b-card>
</template>

<script>
  import { mapGetters } from 'vuex'

  export default {
    props: [
      'identityKey'
    ],

    computed: {
      ...mapGetters({
        abouts: 'ssb/abouts'
      })
    }
  }
</script>

<style lang="scss" scoped>
  .card-body {

  }
</style>
