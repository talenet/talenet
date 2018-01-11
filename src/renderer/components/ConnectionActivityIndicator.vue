<template>
  <div class="t-connection-activity-indicator">
    <svg :width="width" :height="height" @click="$emit('click', $event)" :class="classes">
      <polygon class="t-connection-activity-indicator-bg" :points="points"></polygon>
      <polygon class="t-connection-activity-indicator-inner-border" :points="innerBorderPoints"></polygon>
      <polygon class="t-connection-activity-indicator-inner-bg" :points="innerBgPoints"></polygon>
      <polygon class="t-connection-activity-indicator-border" :points="points"></polygon>
    </svg>
  </div>
</template>

<script>
  import HexagonMixin from '../mixins/Hexagon'
  import { mapGetters } from 'vuex'

  export default {
    mixins: [HexagonMixin],

    computed: {
      ...mapGetters({
        'connected': 'ssb/connected',
        'activity': 'ssb/activity'
      }),

      classes () {
        const classes = []

        if (this.$listeners.click) {
          classes.push('t-connection-activity-indicator-clickable')
        }

        if (this.connected) {
          switch (this.activity) {
            case 'downloading':
              classes.push('t-connection-activity-indicator-downloading')
              break
            case 'indexing':
              classes.push('t-connection-activity-indicator-indexing')
              break
            case 'ready':
              classes.push('t-connection-activity-indicator-connected')
              break
          }
        } else {
          classes.push('t-connection-activity-indicator-disconnected')
        }

        return classes
      },

      innerBorderPoints () {
        return this.calcPoints([], this.radius * 0.4)
      },

      innerBgPoints () {
        return this.calcPoints([], this.radius * 0.3)
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
    stroke-width: 1px;
  }

  .t-connection-activity-indicator-inner-border {
    fill: none;
  }

  .t-connection-activity-indicator-connected {
    .t-connection-activity-indicator-inner-bg {
      fill: $connection-activity-indicator-connected-bg;
    }

    .t-connection-activity-indicator-inner-border {
      stroke: $connection-activity-indicator-connected-border-color;
      stroke-width: 1px;
    }

    .t-connection-activity-indicator-disconnected {
      .t-connection-activity-indicator-inner-bg {
        fill: $connection-activity-indicator-disconnected-bg;
      }

      .t-connection-activity-indicator-inner-border {
        stroke: $connection-activity-indicator-disconnected-border-color;
        stroke-width: 1px;
      }
    }
  }
</style>
