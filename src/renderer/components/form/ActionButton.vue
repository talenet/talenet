<template>
  <b-button :variant="variant" @click="handleClick($event)" :class="classes">
    <slot></slot>
  </b-button>
</template>

<script>
  export default {
    props: {
      variant: {
        type: String,
        default: 'primary'
      },
      action: {
        type: String,
        default: null
      }
    },

    data () {
      return {
        state: 'initial',
        timeout: null
      }
    },

    beforeDestroy () {
      this.resetTimeout()
    },

    computed: {
      classes () {
        return ['t-action-button', 't-action-button-' + this.state]
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
        this.start()
        return this.$store.dispatch(action, payload)
          .then((result) => {
            this.finish()
            return result
          })
          .catch(() => {
            this.fail()
          })
      },

      resetTimeout () {
        if (this.timeout) {
          clearTimeout(this.timeout)
          this.timeout = null
        }
      },

      setState (state, delay) {
        this.resetTimeout()

        if (delay) {
          this.timeout = setTimeout(() => {
            this.setState(state)
          }, delay)
        } else {
          this.state = state
        }
      },

      start () {
        this.setState('pending')
      },

      finish () {
        this.setState('done')
        this.setState('initial', 5000)
      },

      fail () {
        this.setState('error')
        this.setState('initial', 1000)
      },

      reset () {
        this.setState('initial')
      }
    }
  }
</script>

<style lang="scss" scoped>
  @import "../../variables";
  @import "../../mixins";

  .t-action-button {
    &.t-action-button-done {
      @include button-variant($success, $success)
    }

    &.t-action-button-error {
      @include button-variant($danger, $danger)
    }
  }
</style>
