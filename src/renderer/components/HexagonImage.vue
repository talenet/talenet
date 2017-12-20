<template>
  <svg :width="width" :height="height" @click="$emit('click', $event)" :class="classes">
    <polygon class="t-hexagon-image-bg" :points="points"></polygon>
    <clipPath v-if="href" :id="clipPathId">
      <polygon :points="points"></polygon>
    </clipPath>
    <image
      v-if="href"
      :width="width"
      :height="height"
      preserveAspectRatio="xMidYMid slice"
      :clip-path="'url(#' + clipPathId + ')'"
      :xlink:href="href">
    </image>
    <polygon class="t-hexagon-image-border" :points="points"></polygon>
  </svg>
</template>

<script>
  import HexagonMixin from '../mixins/Hexagon'

  export default {
    mixins: [HexagonMixin],

    props: {
      'href': {
        type: String,
        required: false
      }
    },

    computed: {
      classes () {
        const classes = []
        if (this.$listeners.click) {
          classes.push('t-hexagon-image-clickable')
        }

        return classes
      },

      clipPathId () {
        // Needs to be globally unique, otherwise the clip path of a different hexagon might be used.
        return 'hexagon-clip-' + this._uid
      }
    }
  }
</script>

<style lang="scss" scoped>
  @import "../variables";

  .t-hexagon-image-clickable {
    cursor: pointer;
  }

  .t-hexagon-image-bg {
    fill: $hexagon-image-bg;
  }

  .t-hexagon-image-border {
    fill: none;
    stroke: $hexagon-image-border-color;
    stroke-width: 1px;
  }
</style>
