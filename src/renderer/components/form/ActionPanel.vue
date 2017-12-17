<template>
  <div class="t-action-panel clearfix">
    <div class="t-action-panel-left float-left">
      <slot name="left"></slot>
    </div>
    <div class="t-action-panel-right float-right">
      <slot name="right"></slot>
    </div>
  </div>
</template>

<script>
  export default {}
</script>

<style lang="scss" scoped>
  @import "../../variables";

  .t-action-panel {
    border: $action-panel-border;

    margin: {
      top: $action-panel-margin-top;
      bottom: $action-panel-margin-bottom;
    }

    padding: {
      top: $action-panel-padding-top;
      bottom: $action-panel-padding-bottom;
      left: $action-panel-padding-left;
      right: $action-panel-padding-right;
    }
  }
</style>
