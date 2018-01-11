<template>
  <fieldset class="t-action-panel clearfix" :disabled="disabled">
    <div v-if="text" class="t-action-panel-text">{{text}}</div>
    <div class="t-action-panel-left float-left">
      <slot name="left"></slot>
    </div>
    <div class="t-action-panel-right float-right">
      <slot name="right"></slot>
    </div>
  </fieldset>
</template>

<script>
  export default {
    props: {
      text: {
        type: String,
        required: false
      },
      disabled: {
        type: Boolean,
        default: false
      }
    }
  }
</script>

<style lang="scss" scoped>
  @import "../../variables";

  .t-action-panel-text {
    margin-bottom: $action-panel-text-offset-y;
  }

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

    .t-action-panel-left > * {
      margin-right: $action-panel-button-gap;
    }

    .t-action-panel-right > * {
      margin-left: $action-panel-button-gap;
    }
  }
</style>
