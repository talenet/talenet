<template>
  <div class="t-center-on-page">
    <div class="t-center-vertical">
      <slot></slot>
    </div>
  </div>
</template>

<script>
  export default {}
</script>

<style lang="scss" scoped>
  .t-center-on-page {
    position: fixed;
    top: 0;
    bottom: 0;
    left: 0;
    right: 0;

    .t-center-vertical {
      overflow-x: hidden;
      overflow-y: auto;
      padding: {
        top: 3rem;
        bottom: 3rem;
      }
      .container {
        margin: auto;
      }
    }
  }
</style>
