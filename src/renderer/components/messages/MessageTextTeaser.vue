<template>
  <div class="t-message-text-teaser">
    <svg class="t-message-text-teaser-right">
      <polygon class="t-message-text-teaser-side-bg" points="0,0 12,20.5 0,41"></polygon>
      <path class="t-message-text-teaser-side-border" d="M0,0 L12,20.5 L0,41"></path>
    </svg>

    <div class="t-message-text-teaser-content-container">
      <t-markdown-text :text="text" :text-only="true"></t-markdown-text>
    </div>
  </div>
</template>

<script>
  export default {
    props: {
      text: {
        type: String,
        required: true
      }
    }
  }
</script>

<style lang="scss" scoped>
  @import "../../variables";

  $width: 70%;

  .t-message-text-teaser {
    pointer-events: none;
    user-select: none;

    overflow: hidden;

    height: (100 / 3) * 1%;
    width: 100%;

    .t-message-text-teaser-content-container {
      position: absolute;
      top: 0;
      bottom: 0;
      left: -1px;
      right: 100% - $width;

      padding-left: 110px;

      white-space: nowrap;
      overflow: hidden;
      text-overflow: ellipsis;
      line-height: 2;

      background-color: $tale-dark-grey;
      border: {
        top: 1px solid $tale-blue;
        bottom: 1px solid $tale-blue;
      }
    }

    .t-message-text-teaser-right {
      position: absolute;
      left: $width;
      top: 50%;
      margin-top: -1 / 2 * 41px;

      height: 41px;
      width: 13px;
    }

    .t-message-text-teaser-side-bg {
      fill: $tale-dark-grey;
    }

    .t-message-text-teaser-side-border {
      stroke: $tale-blue;
      fill: none;
    }
  }
</style>
