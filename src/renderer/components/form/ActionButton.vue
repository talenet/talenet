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

      dispatch (action) {
        this.start()
        return this.$store.dispatch(action)
          .then(() => {
            this.finish()
          })
          .catch(() => {
            this.fail()
          })
      },

      setState (state, delay) {
        if (this.timeout) {
          clearTimeout(this.timeout)
          this.timeout = null
        }
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
        this.setState('initial')
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
  }
</style>
