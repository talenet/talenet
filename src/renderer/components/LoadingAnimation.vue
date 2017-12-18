<template>
  <div :class="classes">
    <t-loading-animation-item :item="1" class="t-loading-animation-item"></t-loading-animation-item>
    <t-loading-animation-item :item="2" class="t-loading-animation-item"></t-loading-animation-item>
    <t-loading-animation-item :item="3" class="t-loading-animation-item"></t-loading-animation-item>
  </div>
</template>

<script>
  import LoadingAnimationItem from './LoadingAnimationItem.vue'

  export default {
    components: {
      't-loading-animation-item': LoadingAnimationItem
    },

    props: {
      size: {
        type: String,
        default: 'md'
      }
    },

    computed: {
      classes () {
        return ['t-loading-animation', 't-loading-animation-' + this.size]
      }
    }
  }
</script>

<style lang="scss" scoped>
  @import "../variables";

  .t-loading-animation {
    text-align: center;
    width: 100%;
  }

  @each $size-name, $size in $loading-animation-sizes {
    .t-loading-animation-#{$size-name} {
      margin-top: -$size / 2;

      .t-loading-animation-item {
        width: $size;
      }
    }
  }
</style>
