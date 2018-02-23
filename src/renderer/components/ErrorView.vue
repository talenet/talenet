<template>
  <transition name="fade" mode="out-in">
    <b-alert
      v-if="error"
      class="t-error-view"
      :show="true"
      variant="danger"
      dismissible
      @dismissed="dismiss()">

      <div class="t-error-view-message">
        {{message}}
      </div>

      <b-button
        class="t-error-view-show-details"
        variant="outline-primary"
        size="sm"
        @click="toggleDetails()">
        {{$t('error.details.button')}}
      </b-button>

      <div v-if="showDetails" class="t-error-view-details">
        <div>
          <p>{{timestamp | tFormatTimestamp}}</p>
        </div>

        <pre>{{stackTrace}}</pre>
      </div>
    </b-alert>
  </transition>
</template>

<script>
  import { mapGetters } from 'vuex'

  export default {
    data () {
      return {
        timestamp: new Date(),
        showDetails: false
      }
    },

    computed: {
      ...mapGetters({
        error: 'page/error'
      }),

      message () {
        const $t = this.$t
        const error = this.error

        if (error) {
          if (error.render) {
            return error.render($t)
          } else {
            return error.message
          }
        }

        return false
      },

      stackTrace () {
        const error = this.error
        if (error) {
          return error.stack
        }

        return ''
      }
    },

    watch: {
      error () {
        this.timestamp = new Date()
        this.showDetails = false
      }
    },

    methods: {
      toggleDetails () {
        this.showDetails = !this.showDetails
      },

      dismiss () {
        this.$store.commit('page/error', null)
      }
    }
  }
</script>

<style lang="scss">
  @import "../variables";

  .t-error-view {
    position: absolute;
    z-index: $error-view-z-index;
    top: $error-view-offset-top;
    left: 0;
    right: 0;

    max-height: 90%;
    overflow: auto;

    color: $error-view-content-color;
    background-color: $error-view-background-color;
    border: none;

    .t-error-view-message {
      margin-top: $error-view-message-offset-top;
    }

    .t-error-view-details {
      margin-top: $error-view-content-spacing;
    }

    .t-error-view-show-details {
      margin: $error-view-content-spacing 0;

      color: $error-view-content-color;
      border-color: $error-view-content-color;

      &:hover {
        background-color: $error-view-content-color;
        color: $error-view-background-color;
      }

      &:active {
        outline-color: $error-view-content-color;
      }
    }

    pre {
      white-space: pre-wrap;
      color: $error-view-content-color;
    }

    .close {
      color: $error-view-content-color;
      text-shadow: none;
      outline: none;

      &:hover {
        opacity: 1;
      }
    }
  }
</style>
