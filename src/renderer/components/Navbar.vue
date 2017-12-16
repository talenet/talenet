<template>
  <b-navbar :fixed="position" :class="classes" toggleable="sm" type="dark" variant="dark">
    <b-nav-toggle target="t-navbar-top-collapse"></b-nav-toggle>

    <b-collapse is-nav id="t-navbar-top-collapse">
      <b-navbar-nav class="container d-flex d-flex-row">
        <slot name="item"></slot>
        <div class="t-navbar-center">
          <slot name="center"></slot>
        </div>
      </b-navbar-nav>
    </b-collapse>
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

  .t-navbar {
    height: $navbar-content-height;

    &.t-navbar-top {
      border-bottom: $navbar-border-width solid $navbar-border-color;
    }

    &.t-navbar-bottom {
      border-top: $navbar-border-width solid $navbar-border-color;
    }

    .navbar-nav {
      padding: 0;
      border-right: $navbar-border-width solid $navbar-border-color;
    }

    .nav-item, .form-inline {
      flex-grow: 1;
      border-left: $navbar-border-width solid $navbar-border-color;
      max-width: 25%;
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
