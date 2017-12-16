<template>
  <div class="t-loading-animation-item">
    <div class="t-loading-animation-item-svgs">
      <svg :class="classes" v-for="ps in points" :key="ps" :width="width" :height="height">
        <polygon class="t-loading-animation-item-polygon" :points="ps"></polygon>
      </svg>
    </div>
  </div>
</template>

<script>
  import HexagonMixin from '../mixins/Hexagon'

  const SKIPPED_POINTS_PER_FRAME = [
    [0, 3],
    [3],
    [],
    [0]
  ]

  export default {
    mixins: [HexagonMixin],

    props: {
      item: {
        type: Number,
        required: true
      }
    },

    computed: {
      points () {
        const points = []
        for (const skip of SKIPPED_POINTS_PER_FRAME) {
          points.push(this.calcPoints(skip))
        }
        return points
      },

      classes () {
        return ['t-loading-animation-item-' + this.item]
      }
    }
  }
</script>

<style lang="scss" scoped>
  @import "../variables";

  @keyframes loading-animation-keyframes {
    0% {
      opacity: 0.0;
    }
    24.9999% {
      opacity: 0.0;
    }
    25% {
      opacity: 1.0;
    }
    49.999% {
      opacity: 1.0;
    }
    50% {
      opacity: 0.0;
    }
    100% {
      opacity: 0.0;
    }
  }

  .t-loading-animation-item {
    display: inline-block;
  }

  .t-loading-animation-item-svgs {
    position: relative;

    svg {
      position: absolute;
      top: 0;
      left: 0;
    }

    @for $i from 1 through 4 {
      @for $j from 1 through 4 {
        .t-loading-animation-item-#{$i}:nth-child(#{$j}) {
          @if ($i == 1 and $j == 2) or ($i > 1 and $j == 1) {
            opacity: 1.0;
          }
          @else {
            opacity: 0.0;
          }
          animation-name: loading-animation-keyframes;
          animation-duration: $loading-animation-duration;
          animation-iteration-count: infinite;
          animation-delay: (($i - 1) / 5 + ($j - 1) - 2) * $loading-animation-duration / 4;
        }
      }
    }

    .t-loading-animation-item-polygon {
      fill: $loading-animation-color;
    }
  }
</style>
