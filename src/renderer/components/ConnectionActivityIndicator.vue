<template>
  <div class="t-connection-activity-indicator">
    <svg :width="width" :height="height" @click="$emit('click', $event)" :class="classes">
      <polygon class="t-connection-activity-indicator-bg" :points="points"></polygon>
      <polygon
        v-if="ready || downloading || !connected"
        class="t-connection-activity-indicator-inner-border"
        :points="innerBorderPoints">
      </polygon>

      <line
        class="t-connection-activity-indicator-inner-border-animation-line"
        v-if="connected && indexing"
        v-for="line in innerBorderAnimationLines"
        :x1="line.x1"
        :y1="line.y1"
        :x2="line.x2"
        :y2="line.y2"
      >
      </line>

      <polygon
        class="t-connection-activity-indicator-inner-bg"
        :points="innerBgPoints">
      </polygon>

      <polygon class="t-connection-activity-indicator-border" :points="points"></polygon>
    </svg>
  </div>
</template>

<script>
  import HexagonMixin from '../mixins/Hexagon'
  import { mapGetters } from 'vuex'

  const LINE_SEGMENTS = 12

  function pointBetween (j, pa, pb) {
    return {
      x: ((LINE_SEGMENTS - j) * pa.x + j * pb.x) / LINE_SEGMENTS,
      y: ((LINE_SEGMENTS - j) * pa.y + j * pb.y) / LINE_SEGMENTS
    }
  }

  export default {
    mixins: [HexagonMixin],

    data () {
      return {
        innerBorderAnimationPos: 0
      }
    },

    computed: {
      ...mapGetters({
        'connected': 'ssb/connected',
        'activity': 'ssb/activity'
      }),

      downloading () {
        return this.activity === 'downloading'
      },

      indexing () {
        return this.activity === 'indexing'
      },

      ready () {
        return this.activity === 'ready'
      },

      classes () {
        const classes = []

        if (this.$listeners.click) {
          classes.push('t-connection-activity-indicator-clickable')
        }

        if (this.connected) {
          classes.push('t-connection-activity-indicator-connected')
        } else {
          classes.push('t-connection-activity-indicator-disconnected')
        }

        if (this.activity) {
          classes.push('t-connection-activity-indicator-' + this.activity)
        }

        return classes
      },

      innerBorderPoints () {
        return this.calcPolygon([], this.radius * 0.525)
      },

      innerBorderAnimationLines () {
        const hexPoints = this.calcPoints([], this.radius * 0.525)
        const lines = []

        for (let i = 0; i < 6; i++) {
          for (let j = 0; j < LINE_SEGMENTS; j++) {
            const pa = hexPoints[i]
            const pb = hexPoints[(i + 1) % 6]

            const p1 = pointBetween(j, pa, pb)
            const p2 = pointBetween(j + 1, pa, pb)

            lines.push({
              x1: p1.x,
              y1: p1.y,
              x2: p2.x,
              y2: p2.y
            })
          }
        }

        return lines
      },

      innerBgPoints () {
        return this.calcPolygon([], this.radius * 0.38)
      }
    }
  }
</script>

<style lang="scss" scoped>
  @import "../variables";

  .t-connection-activity-indicator {
    text-align: center;
  }

  .t-connection-activity-indicator-clickable {
    cursor: pointer;
  }

  .t-connection-activity-indicator-bg {
    fill: $connection-activity-indicator-bg;
  }

  .t-connection-activity-indicator-border {
    fill: none;
    stroke: $connection-activity-indicator-border-color;
    stroke-width: $connection-activity-indicator-border-width;
  }

  .t-connection-activity-indicator-inner-border,
  .t-connection-activity-indicator-inner-border-animation {
    fill: none;
  }

  .t-connection-activity-indicator-connected {
    .t-connection-activity-indicator-inner-bg {
      fill: $connection-activity-indicator-connected-bg;
    }

    .t-connection-activity-indicator-inner-border {
      stroke: $connection-activity-indicator-connected-border-color;
      stroke-width: $connection-activity-indicator-connected-border-width;
    }

    .t-connection-activity-indicator-inner-border-animation-line {
      stroke: $connection-activity-indicator-indexing-color;
      stroke-linecap: round;

      @keyframes t-connection-activity-indicator-inner-border-animation-keyframes {
        0% {
          opacity: 1.0;
          stroke-width: 2.5%;
        }
        100% {
          opacity: 0.1;
          stroke-width: 0.5%;
        }
      }

      $animation-steps: 2;
      @for $i from 0 through 6 * $animation-steps - 1 {
        &:nth-child(#{6 * $animation-steps}n + #{$i}) {
          animation-name: t-connection-activity-indicator-inner-border-animation-keyframes;
          animation-duration: $connection-activity-indicator-indexing-animation-duration;
          animation-iteration-count: infinite;
          animation-delay: $i * $connection-activity-indicator-indexing-animation-duration / (6 * $animation-steps)
             - $connection-activity-indicator-indexing-animation-duration;
        }
      }
    }

    &.t-connection-activity-indicator-downloading {
      .t-connection-activity-indicator-inner-bg {
        @keyframes t-connection-activity-indicator-inner-bg-downloading-keyframes {
          0% {
            opacity: 0.0;
            clip-path: polygon(
                0% 0%,
                0% 0%,
                0% 100%,
                0% 100%
            );
          }
          50% {
            opacity: 1.0;
            clip-path: polygon(
                0% 0%,
                100% 0%,
                100% 100%,
                0% 100%
            );
          }
          100% {
            opacity: 0.0;
            clip-path: polygon(
                100% 0%,
                100% 0%,
                100% 100%,
                100% 100%
            );
          }
        }

        fill: $connection-activity-indicator-downloading-color;

        animation-name: t-connection-activity-indicator-inner-bg-downloading-keyframes;
        animation-duration: $connection-activity-indicator-downloading-animation-duration;
        animation-iteration-count: infinite;
        animation-timing-function: linear;
      }
    }
  }

  .t-connection-activity-indicator-disconnected {
    .t-connection-activity-indicator-inner-bg {
      fill: $connection-activity-indicator-disconnected-bg;
    }

    .t-connection-activity-indicator-inner-border {
      stroke: $connection-activity-indicator-disconnected-border-color;
      stroke-width: $connection-activity-indicator-border-width;
    }
  }
</style>
