<template>
  <div class="t-connection-activity-indicator">
    <svg :width="width" :height="height" @click="$emit('click', $event)" :class="classes">
      <polygon class="t-connection-activity-indicator-bg" :points="points"></polygon>
      <polygon class="t-connection-activity-indicator-inner-border" :points="innerBorderPoints"></polygon>

      <polygon
        class="t-connection-activity-indicator-inner-bg"
        :points="innerBgPoints"
        v-if="ready || !connected">
      </polygon>

      <polygon class="t-connection-activity-indicator-border" :points="points"></polygon>
    </svg>
    <!-- todo: unterschiedliche animation fuer unterschiedliche zustaende -->
    <t-loading-animation
      class="t-connection-activity-indicator-downloading"
      size="sm"
      :items="1"
      v-if="downloading">
    </t-loading-animation>
    <t-loading-animation
      class="t-connection-activity-indicator-indexing"
      size="sm"
      :items="1"
      v-else-if="indexing">
    </t-loading-animation>
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

  .t-connection-activity-indicator-downloading,
  .t-connection-activity-indicator-indexing {
    position: absolute;
    top: 50%;
  }

</style>

<style lang="scss"> // unscoped style block to overwrite embedded loading animation
  @import "../variables";
  .t-connection-activity-indicator {
    .t-connection-activity-indicator-downloading .t-loading-animation-item-svgs .t-loading-animation-item-polygon {
      animation: t-animatron-downloading 5s infinite;

      @keyframes t-animatron-downloading {
        from  {
          fill:$tale-green;
          transform:rotate(+30deg);
          transform-origin:50%;
        }
        50%  {
          fill:$tale-red;
          transform:rotate(0deg);
          transform-origin:50%;
        }
        to {
          fill:$tale-green;
          transform:rotate(-30deg);
          transform-origin:50%;
        }
      }
    }

    .t-connection-activity-indicator-indexing .t-loading-animation-item-svgs .t-loading-animation-item-polygon {
      animation: t-animatron-indexing 2.5s infinite;

      @keyframes t-animatron-indexing {
        from  {
          fill:$tale-green;
          transform:rotate(-60deg);
          transform-origin:50%;
        }
        50%  {
          fill:$tale-red;
          transform:rotate(0deg);
          transform-origin:50%;
        }
        to {
          fill:$tale-green;
          transform:rotate(60deg);
          transform-origin:50%;
        }
      }
    }
  }
</style>
