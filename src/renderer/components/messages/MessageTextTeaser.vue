<template>
  <div :class="classes">
    <svg v-if="align === 'right'" class="t-message-text-teaser-left">
      <polygon class="t-message-text-teaser-side-bg" points="13,0 1,20.5 13,41"></polygon>
      <path class="t-message-text-teaser-side-border" d="M13,0 L1,20.5 L13,41"></path>
    </svg>

    <svg v-if="align === 'left'" class="t-message-text-teaser-right">
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
      },

      align: {
        type: String,
        default: 'left'
      }
    },

    computed: {
      classes () {
        return {
          't-message-text-teaser': true,
          ['t-message-text-teaser-' + this.align]: true
        }
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

    .t-message-text-teaser-content-container {
      position: absolute;
      top: 0;
      bottom: 0;

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

    &.t-message-text-teaser-left .t-message-text-teaser-content-container {
      left: -1px;
      right: 100% - $width;

      padding-left: 110px;
      padding-right: 3px;
    }
    &.t-message-text-teaser-right .t-message-text-teaser-content-container {
      right: -1px;
      left: 100% - $width;

      padding-right: 110px;
      padding-left: 3px;
    }

    .t-message-text-teaser-left,
    .t-message-text-teaser-right {
      position: absolute;
      top: 50%;
      margin-top: -1 / 2 * 41px;

      height: 41px;
      width: 13px;
    }

    .t-message-text-teaser-left {
      right: $width;
    }
    .t-message-text-teaser-right {
      left: $width;
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
