<template>
  <div class="t-text-box">
    <slot></slot>
  </div>
</template>

<script>
  export default {}
</script>

<style lang="scss" scoped>
  @import "../variables";

  .t-text-box {
    margin: {
      top: $text-box-margin-top;
      bottom: $text-box-margin-bottom;
    }
    padding: {
      top: $text-box-padding-top;
      bottom: $text-box-padding-bottom;
      left: $text-box-padding-left;
      right: $text-box-padding-right;
    }

    background-color: $text-box-bg;

    & > .t-button-panel {
      padding: {
        left: 0;
        right: 0;
      };
    }
  }
</style>
