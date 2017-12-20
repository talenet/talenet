<template>
  <div class="t-button-panel clearfix">
    <div class="t-button-panel-left float-left">
      <slot name="left"></slot>
    </div>
    <div class="t-button-panel-right float-right">
      <slot name="right"></slot>
    </div>
  </div>
</template>

<script>
  export default {}
</script>

<style lang="scss" scoped>
  @import "../../variables";

  .t-button-panel {
    padding: {
      top: $button-panel-padding-top;
      bottom: $button-panel-padding-bottom;
      left: $button-panel-padding-left;
      right: $button-panel-padding-right;
    }

    .t-button-panel-left > * {
      margin-right: $button-panel-button-gap;
    }

    .t-button-panel-right > * {
      margin-left: $button-panel-button-gap;
    }

    a {
      display: inline-block;
      margin: {
        top: $input-btn-padding-y;
        bottom: $input-btn-padding-y;
      }
    }
  }
</style>
