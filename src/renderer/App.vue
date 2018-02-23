<template>
  <div :class="classes" ref="scrollView" id="t-scroll-view">
    <template v-if="initialized">
      <transition name="fade" mode="out-in">
        <t-navbar-top v-if="showNavbar"></t-navbar-top>
      </transition>

      <t-pub-info-post></t-pub-info-post>

      <b-container class="t-app-content-container">
        <transition appear name="fade" mode="out-in">
          <router-view></router-view>
        </transition>
      </b-container>

      <t-dev-grid></t-dev-grid>

      <t-dev-panel v-if="isDevMode"></t-dev-panel>

      <transition name="fade" mode="out-in">
        <t-navbar-bottom v-if="showNavbar"></t-navbar-bottom>
      </transition>
    </template>
    <t-center-on-page v-else>
      <t-loading-animation size="xl"></t-loading-animation>
    </t-center-on-page>
    <!-- error modal -->
    <b-container>
      <b-modal v-model="showError" title="Error Occured" header-bg-variant="danger">
        <h4>{{ getError.message }}</h4>
        <pre>{{ getError.stack }}</pre>
        <footer slot="modal-footer" class="w-100">
          <small class="float-left">TODO: report error button</small>
          <b-btn size="sm" class="float-right" variant="default" @click="acceptError">OK</b-btn>
        </footer>
      </b-modal>
    </b-container>
  </div>
</template>

<script>
  import NavbarTop from './components/NavbarTop.vue'
  import NavbarBottom from './components/NavbarBottom.vue'
  import { updateTitleFromRoute, scrollToTop } from './util/page'
  import { mapGetters } from 'vuex'

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
      ...mapGetters({
        initialized: 'ssb/initialized',
        showNavbar: 'page/navbar',
        isDevMode: 'settings/isDevMode'
      }),

      classes () {
        const classes = ['t-app']
        if (!this.initialized || !this.showNavbar) {
          classes.push('t-app-no-nav')
        }
        return classes
      },

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
        scrollToTop(this.$refs.scrollView)
      }
    }
  }
</script>

<style lang="scss">
  // Thrid party
  @import "../../node_modules/highlight.js/styles/darcula.css";
  // Bootstrap
  @import "variables";
  @import "mixins";
  @import "fonts";
  @import "../../node_modules/bootstrap/scss/bootstrap";
  @import "global-fixes";

  // Page styling
  html, body {
    height: 100%;
  }

  .t-app {
    height: 100%;

    padding: {
      top: $app-padding-top;
      bottom: $app-padding-bottom;
    }

    overflow-y: scroll;

    &.t-app-no-nav {
      overflow-y: auto;
    }

    .fade-enter-active, .fade-leave-active {
      transition: opacity .3s ease-in-out;
    }

    .fade-enter, .fade-leave-to {
      opacity: 0;
    }

    .fade-height-enter-active, .fade-height-leave-active {
      transition: all .5s ease-in-out;
      max-height: 800px;
    }

    .fade-height-enter, .fade-height-leave-to {
      overflow: hidden !important;
      max-height: 0 !important;
      opacity: 0 !important;
      margin-top: 0 !important;
      margin-bottom: 0 !important;
    }

    .t-app-content-container {
      // Compensate for scrollbar to align container with the grid.
      padding-left: $grid-gutter-width / 2 + $scrollbar-size / 2;
      padding-right: $grid-gutter-width / 2 - $scrollbar-size / 2;
    }

    &::-webkit-scrollbar-track {
      border: {
        top: $navbar-border-width solid $navbar-border-color;
        bottom: $navbar-border-width solid $navbar-border-color;
      }
    }

    &::-webkit-scrollbar-track {
      margin-top: $app-scrollbar-offset-top;
      margin-bottom: $app-scrollbar-offset-bottom;
    }
  }

  // Global styling
  button, .btn {
    @include cut-corners($button-corner-cut-size)
  }

  // General scrollbars
  ::-webkit-scrollbar {
    width: $scrollbar-size;
    height: $scrollbar-size;
  }

  ::-webkit-scrollbar-track {
    -webkit-box-shadow: $scrollbar-track-box-shadow;
  }

  ::-webkit-scrollbar-thumb {
    -webkit-box-shadow: $scrollbar-thumb-box-shadow;
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
