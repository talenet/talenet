<template>
  <svg
    :width="width"
    :height="height"
    @click="$emit('click', $event)"
    class="t-hexagon-button">
    <polygon class="t-hexagon-button-bg" :points="points"></polygon>
    <polygon class="t-hexagon-button-border" :points="points"></polygon>

    <text :x="width / 2" :y="height / 2">
      <slot></slot>
    </text>
  </svg>
</template>

<script>
  import HexagonMixin from '../../mixins/Hexagon'

  export default {
    mixins: [HexagonMixin]
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
