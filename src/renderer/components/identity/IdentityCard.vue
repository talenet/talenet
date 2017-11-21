<template>
  <b-card>
    <t-hexagon-image :radius="25" href="http://csshexagon.com/img/meow.jpg"></t-hexagon-image>
    <span>{{identityKey}}</span>
  </b-card>
</template>

<script>
  export default {
    props: [
      'identityKey'
    ]
  }
</script>

<style lang="scss" scoped>
  .card-body {

  }
</style>
