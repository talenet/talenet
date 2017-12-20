<template>
  <b-navbar :fixed="position" :class="classes" toggleable="sm" type="dark" variant="dark">
    <b-nav-toggle :target="'t-navbar-' + position + '-collapse'"></b-nav-toggle>
    <b-collapse is-nav :id="'t-navbar-' + position + '-collapse'">
      <b-navbar-nav class="container d-flex d-flex-row">
        <slot name="item"></slot>
      </b-navbar-nav>
    </b-collapse>
    <div class="t-navbar-center">
      <slot name="center"></slot>
    </div>
  </b-navbar>
</template>

<script>
  export default {
    props: {
      position: {
        type: String,
        required: true
      }
    },

    computed: {
      classes () {
        return ['t-navbar', 't-navbar-' + this.position]
      }
    }
  }
</script>

<style lang="scss">
  // Not scoped to allow styling slots.
  @import "../variables";
  @import "../mixins";

  .t-navbar {
    height: $navbar-content-height;

    &.t-navbar-top, &.t-navbar-top .navbar-nav {
      border-bottom: $navbar-border-width solid $navbar-border-color;
    }

    &.t-navbar-bottom {
      border-top: $navbar-border-width solid $navbar-border-color;
    }

    .navbar-toggler {
      outline: none;
    }

    .navbar-nav {
      padding: 0;
      border-right: $navbar-border-width solid $navbar-border-color;
    }

    .nav-item, .form-inline {
      flex-grow: 1;
      border: none;
      height: $navbar-content-height;
      max-height: $navbar-content-height;
      padding: 0;

      a {
        text-align: center;
        padding: 0;
        margin: 0;
        border: none;
        height: $navbar-content-height;
        line-height: $navbar-content-height;
      }
    }

    .navbar-nav {
      border: $navbar-border-width solid $navbar-border-color;
      background-color: $navbar-bg;
    }

    &.t-navbar-top .navbar-nav {
      padding-top: $navbar-center-size * 0.4;
    }

    &.t-navbar-bottom .navbar-nav {
      padding-bottom: $navbar-center-size * 0.4;
    }

    @include media-breakpoint-up(sm) {
      .navbar-nav {
        padding-top: 0;
        padding-bottom: 0;
      }

      .nav-item, .form-inline {
        max-width: 25%;
        border-left: $navbar-border-width solid $navbar-border-color;
        border-top: none;
        border-bottom: none;
      }
    }

    .nav-item {
      .active {
        background-color: $navbar-active-bg;
      }
    }

    .form-inline {
      input {
        margin: 0;

        box-sizing: border-box;

        width: 100%;

        border: none;
        border-radius: 0;

        box-shadow: none;
      }
    }

    .t-navbar-center {
      position: absolute;
      left: 50%;
      margin-left: -$navbar-center-size / 2;

      width: $navbar-center-size;
      height: $navbar-center-size;

      & > * {
        width: $navbar-center-size;
      }
    }

    &.t-navbar-top .t-navbar-center {
      bottom: 0;
      margin-bottom: -$navbar-center-size / 2;
    }

    &.t-navbar-bottom .t-navbar-center {
      top: 0;
      margin-top: -$navbar-center-size / 2;
    }
  }
</style>
