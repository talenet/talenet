<template>
  <svg :width="width" :height="height" @click="$emit('click', $event)" :class="classes">
    <polygon class="t-hexagon-image-bg" :points="points"></polygon>
    <clipPath :id="clipPathId">
      <polygon :points="points"></polygon>
    </clipPath>
    <image :clip-path="'url(#' + clipPathId + ')'" :xlink:href="href"></image>
    <polygon class="t-hexagon-image-border" :points="points"></polygon>
  </svg>
</template>

<script>
  function point (cx, cy, r, n) {
    const angle = 2 * Math.PI * n / 6

    const cos = Math.cos(angle)
    const sin = Math.sin(angle)

    const px = r * cos
    const py = r * sin

    return {
      x: cx + px,
      y: cy + py
    }
  }

  export default {
    props: [
      'radius',
      'href'
    ],

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
      },

      width () {
        return 2 * this.radius
      },

      height () {
        return 2 * this.radius
      },

      points () {
        const ps = []

        const cx = this.radius
        const cy = this.radius

        for (let n = 0; n < 6; n += 1) {
          ps.push(point(cx, cy, this.radius - 1, n))
        }

        return ps.map(({ x, y }) => x + ',' + y).join(' ')
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

  image {
    width: 100%;
  }
</style>
