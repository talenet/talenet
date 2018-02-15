<template>
  <b-button
    :variant="variant"
    :size="size"
    :disabled="pending"
    @click="handleClick($event)"
    :class="classes">
    <span class="t-action-button-text"><slot></slot></span>
    <t-loading-animation
      class="t-action-button-loading-animation"
      v-if="pending"
      size="sm"
      :items="1"
      :inline="true">
    </t-loading-animation>
  </b-button>
</template>

<script>
  import Promise from 'bluebird'
  import _ from 'lodash'

  const MIN_PENDING_TIME = 800
  const SUCCESS_TIME = 4000
  const ERROR_TIME = 1000

  export default {
    props: {
      variant: {
        type: String,
        default: 'primary'
      },
      size: {
        type: String,
        default: 'md'
      },
      action: {
        type: String,
        default: null
      }
    },

    data () {
      return {
        state: 'initial',
        stateSetAt: new Date().getTime(),
        timeout: null
      }
    },

    beforeDestroy () {
      this.resetTimeout()
    },

    computed: {
      classes () {
        return ['t-action-button', 't-action-button-' + this.state]
      },

      pending () {
        return this.state === 'pending'
      }
    },

    methods: {
      handleClick (event) {
        this.$emit('click', event)
        if (this.action) {
          this.dispatch(this.action)
        }
      },

      dispatch (action, payload) {
        return this.execute(this.$store.dispatch(action, payload))
      },

      execute (promise) {
        this.start()
        return Promise.resolve(promise)
          .then((result) => {
            return new Promise((resolve, reject) => {
              if (!this.pending) {
                // the state has been changed externally, don't interfere with that
                return resolve(result)
              }

              // make sure pending state is at least show MIN_PENDING_TIME milliseconds
              const now = new Date().getTime()
              const millisPassed = now - this.stateSetAt
              const remainingDelay = MIN_PENDING_TIME - millisPassed

              this.finish(remainingDelay, () => resolve(result))
            })
          })
          .catch(err => {
            this.fail()
            throw err // pass on through promise chain
          })
      },

      resetTimeout () {
        if (this.timeout) {
          clearTimeout(this.timeout)
          this.timeout = null
        }
      },

      setState (state, delay, callback) {
        this.resetTimeout()

        if (_.isFunction(delay)) {
          callback = delay
          delay = undefined
        }

        if (delay && delay > 0) {
          this.timeout = setTimeout(() => {
            this.setState(state, callback)
          }, delay)
        } else {
          this.state = state
          this.stateSetAt = new Date().getTime()
          if (_.isFunction(callback)) {
            callback()
          }
        }
      },

      start () {
        this.setState('pending')
      },

      finish (delay, callback) {
        this.setState('done', delay, () => {
          this.$el.blur()
          if (_.isFunction(callback)) {
            callback()
          }
          this.setState('initial', SUCCESS_TIME)
        })
      },

      fail () {
        this.$el.blur()
        this.setState('error')
        this.setState('initial', ERROR_TIME)
      },

      reset () {
        this.$el.blur()
        this.setState('initial')
      }
    }
  }
</script>

<style lang="scss" scoped>
  @import "../../variables";
  @import "../../mixins";

  .t-action-button {
    position: relative;

    &:disabled {
      opacity: 1;
    }

    &.t-action-button-done {
      @include button-variant($success, $success);
    }

    &.t-action-button-error {
      @include button-variant($danger, $danger);
    }

    &.t-action-button-pending {
      background-color: transparent;
      cursor: wait;

      .t-action-button-text {
        visibility: hidden;
      }
    }

    .t-action-button-loading-animation {
      position: absolute;
      bottom: -1px;
      left: 0;
    }
  }
</style>
