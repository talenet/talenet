<template>
  <svg
    :width="width"
    :height="height"
    @click="$emit('click', $event)"
    class="t-hexagon-button">
    <polygon class="t-hexagon-button-bg" :points="points"></polygon>
    <polygon class="t-hexagon-button-border" :points="points"></polygon>

    <text :x="width / 2" :y="height / 2" v-if="$slots.default">
      <slot></slot>
    </text>
    <clipPath v-if="icon" :id="clipPathId">
      <polygon :points="points"></polygon>
    </clipPath>
    <image
      v-if="icon"
      :width="width"
      :height="height"
      preserveAspectRatio="xMidYMid slice"
      :clip-path="'url(#' + clipPathId + ')'"
      :xlink:href="'static/img/' + icon + '-icon.svg'">
    </image>
  </svg>
</template>

<script>
  import HexagonMixin from '../../mixins/Hexagon'

  export default {
    mixins: [HexagonMixin],

    props: {
      icon: {
        type: String,
        required: false
      }
    },

    computed: {
      clipPathId () {
        // Needs to be globally unique, otherwise the clip path of a different hexagon might be used.
        return 'hexagon-clip-' + this._uid
      }
    }
  }
</script>

<style lang="scss" scoped>
  @import "../../variables";

  .t-hexagon-button {
    cursor: pointer;
    user-select: none;

    width: $hexagon-button-size;

    text {
      text-anchor: middle;
      alignment-baseline: central;
      font-size: $hexagon-button-font-size;
      fill: $hexagon-button-text-color;
    }

    .t-hexagon-button-bg {
      fill: $hexagon-button-bg;
    }

    .t-hexagon-button-border {
      fill: none;
      stroke: $hexagon-button-border-color;
      stroke-width: $hexagon-button-border-width;
    }
  }
</style>
