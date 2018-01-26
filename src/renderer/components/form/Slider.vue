<template>
  <div :class="classes">
    <vue-slider
      :value="value"
      :min="min"
      :max="max"
      :interval="step"
      :direction="orientation"
      :tooltip="false"
      :dot-size="null"
      height="100%"
      width="0%"
      @input="onInput($event)">
    </vue-slider>
  </div>
</template>

<script>
  import vueSlider from 'vue-slider-component'

  export default {
    components: {
      vueSlider
    },

    props: {
      orientation: {
        type: String,
        default: 'horizontal' // TODO: Render horizontal slider nicely
      },

      min: {
        type: Number,
        required: true
      },

      max: {
        type: Number,
        required: true
      },

      step: {
        type: Number,
        required: true
      },

      value: {
        type: Number,
        required: false
      }
    },

    computed: {
      classes () {
        return [
          't-slider',
          't-slider-' + this.orientation
        ]
      }
    },

    methods: {
      onInput (event) {
        // The event seems to be emitted too often, so only let it pass if value has changed.
        if (event !== this.value) {
          // As the event is not compatible with v-model we re-code it.
          this.$emit('input', {
            target: {
              value: event
            }
          })
        }
      }
    }
  }
</script>

<style lang="scss">
  @import "../../variables";

  .t-slider {
    &.t-slider-vertical {
      height: $slider-vertical-height;
    }

    .vue-slider {
      border-radius: 0;
      background-color: transparent;
      border: {
        top: $slider-border;
        left: $slider-border;
        bottom: $slider-border;
        right: none;
      }
      width: $slider-vertical-width;
    }

    .vue-slider-process {
      display: none;
    }

    .vue-slider-dot {
      height: 0;
      width: 0;

      // TODO: Replace unicode triangle with SVG and replace magic values with nice positioning.
      margin-left: -0.85 * $slider-dot-size;
      margin-bottom: 0.825 * $slider-dot-size;

      background-color: transparent;
      border: none;

      &::after {
        content: "►";
        color: $slider-dot-color;
        font-size: $slider-dot-size;
      }
    }
  }
</style>
