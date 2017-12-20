<template>
  <div id="app">
    <t-navbar-top></t-navbar-top>

    <!-- error modal -->
    <b-container>
      <b-modal v-model="showError"
               title="Error Occured"
               header-bg-variant="danger"
      >

        <h4>{{ getError.message }}</h4>
        <pre>{{ getError.stack }}</pre>
        <footer slot="modal-footer" class="w-100">
          <small class="float-left">TODO: report error button</small>
          <b-btn size="sm" class="float-right" variant="default" @click="acceptError">OK</b-btn>
        </footer>
      </b-modal>
    </b-container>

    <b-container>
      <router-view></router-view>
    </b-container>

    <t-navbar-bottom></t-navbar-bottom>
  </div>
</template>

<script>
  import NavbarTop from './components/NavbarTop.vue'
  import NavbarBottom from './components/NavbarBottom.vue'
  import { updateTitleFromRoute, scrollToContent } from './util/page'

  /**
   * This component holds the whole app.
   */
  export default {
    components: {
      't-navbar-top': NavbarTop,
      't-navbar-bottom': NavbarBottom
    },

    created () {
      updateTitleFromRoute(this.$route, this.$store)
    },

    computed: {
      showError: {
        get () {
          return this.$store.state.err != null
        },

        set () {
        } // ignored
      },

      getError () {
        if (this.$store.state.err == null) {
          return new Error('should not show up')
        }
        // console.error(this.$store.state.err)
        return this.$store.state.err
      }
    },

    methods: {
      acceptError () {
        this.$store.commit('error', null)
      }
    },

    watch: {
      '$route' (route) {
        updateTitleFromRoute(route, this.$store)
        scrollToContent(route)
      }
    }
  }
</script>

<style lang="scss">
  // App SCSS intialization block.
  @import "variables";
  @import "mixins";
  @import "fonts";
  @import "../../node_modules/bootstrap/scss/bootstrap";
  @import "global-fixes";

  // Page styling
  body {
    padding: {
      top: $body-padding-top;
      bottom: $body-padding-bottom;
    }
  }

  // Global styling
  button, .btn {
    @include cut-corners($button-corner-cut-size)
  }

  // Break points
  .t-center-col,
  .t-wide-col {
    @extend .offset-#{$center-column-breakpoint}-2, .col-#{$center-column-breakpoint}-8;
  }

  .t-wide-col {
    @extend .offset-#{$wide-column-breakpoint}-0, .col-#{$wide-column-breakpoint}-6;
  }

  @include media-breakpoint-down($below-wide-column-breakpoint) {
    .t-wide-only {
      display: none;
    }
  }

  .t-wide-left-above {
    @extend .order-#{$wide-column-breakpoint}-1, .order-#{$center-column-breakpoint}-1;
  }

  .t-wide-left-below {
    @extend .order-#{$wide-column-breakpoint}-1, .order-#{$center-column-breakpoint}-2;
  }

  .t-wide-right-above {
    @extend .order-#{$wide-column-breakpoint}-2, .order-#{$center-column-breakpoint}-1;
  }

  .t-wide-right-below {
    @extend .order-#{$wide-column-breakpoint}-2, .order-#{$center-column-breakpoint}-2;
  }

  .t-center-vertical {
    @extend .d-flex, .flex-row, .align-items-center;
    height: 100%;
  }
</style>
