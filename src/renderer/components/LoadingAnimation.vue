<template>
  <transition appear name="fade" mode="out-in">
    <div :class="classes">
      <t-loading-animation-item
        v-for="item in items"
        :key="item"
        :item="item"
        class="t-loading-animation-item">
      </t-loading-animation-item>
    </div>
  </transition>
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
      },
      items: {
        type: Number,
        default: 3
      },
      inline: {
        type: Boolean,
        default: false
      }
    },

    computed: {
      classes () {
        const classes = ['t-loading-animation', 't-loading-animation-' + this.size]
        if (this.inline) {
          classes.push('t-loading-animation-inline')
        }
        return classes
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
        height: $size;
      }
    }
  }

  .t-loading-animation-inline {
    margin-top: 0;
  }
</style>
