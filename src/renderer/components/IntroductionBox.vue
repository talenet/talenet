<template>
  <transition :name="transition" mode="in-out" @after-leave="afterLeave()">
    <div v-if="visible" :class="classes">
      <div class="t-introduction-box-content-container">
        <div class="t-introduction-box-content-row">
          <div class="t-introduction-box-content clearfix">
            <template v-if="$slots.default">
              <slot></slot>
            </template>
            <template v-else>
              <p>{{$t(messagesKey + '.text')}}</p>
              <p><em>{{$t(messagesKey + '.callToAction')}}</em></p>
            </template>

            <b-button variant="primary" size="sm" class="float-right" @click="close()">
              {{buttonText}}
            </b-button>
          </div>
        </div>
      </div>
    </div>
  </transition>
</template>

<script>
  export default {
    props: {
      messagesKey: {
        type: String,
        required: true
      },

      type: {
        type: String,
        default: 'box'
      }
    },

    computed: {
      transition () {
        return this.type === 'box' ? 'fade-height' : 'fade'
      },

      classes () {
        const isOverlay = this.type === 'overlay'
        return {
          't-introduction-box': true,
          'd-flex': isOverlay,
          'flex-row': isOverlay,
          'align-items-center': isOverlay,
          ['t-introduction-box-type-' + this.type]: true
        }
      },

      buttonText () {
        const overrideKey = this.messagesKey + '.button'
        return this.$te(overrideKey) ? this.$t(overrideKey) : this.$t('introduction.box.close.button')
      },

      visible () {
        return !this.$store.getters['settings/isIntroductionRead'](this.messagesKey)
      }
    },

    methods: {
      close () {
        this.$store.dispatch('settings/markIntroductionAsRead', this.messagesKey)
        this.closing = true
      },

      afterLeave () {
        if (this.closing) {
          this.$emit('close')
          this.closing = false
        }
      }
    }
  }
</script>

<style lang="scss" scoped>
  @import "../variables";
  @import "../mixins";

  .t-introduction-box {
    position: relative;
    overflow: hidden;

    border: $introduction-box-border;

    margin: {
      top: $introduction-box-margin-top;
      bottom: $introduction-box-margin-bottom;
    }

    background-color: $introduction-box-bg;

    .t-introduction-box-content-container {
      padding: {
        top: $introduction-box-padding-top;
        bottom: $introduction-box-padding-bottom;
        left: $introduction-box-padding-left;
        right: $introduction-box-padding-right;
      }
    }

    &.t-introduction-box-type-overlay {
      position: absolute;
      z-index: $zindex-sticky;

      top: 0;
      bottom: 0;
      left: 0;
      right: 0;

      margin: 0;
      padding: 0;

      background-color: rgba($tale-dark-grey, 0.8);

      border: none;

      .t-introduction-box-content-container {
        @include make-container();
        @include make-container-max-widths();
      }

      .t-introduction-box-content-row {
        @include make-row();
      }

      .t-introduction-box-content {
        @include make-col-offset(2);
        @include make-col(8);
      }
    }
  }
</style>
