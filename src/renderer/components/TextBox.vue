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
  @import "../mixins";

  .t-text-box {
    overflow-y: hidden;
    word-wrap: break-word;

    p {
      @include body-copy-styling;
    }
    .t-textbox-title {
      margin-bottom: 2rem;
    }

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
    .t-introduction-box-headline{
      text-indent: none;
    }
  }
</style>
