<template>
  <div class="t-message-thread-header">
    <div class="container">
      <div class="row">
        <div class="offset-1 col-5">
          <svg class="t-message-thread-header-cap-left">
            <polygon class="t-message-thread-header-cap-bg" points="15,0 0.5,25 15,50"></polygon>
            <path class="t-message-thread-header-cap-border" d="M15,0 L0.5,25 L15,50"></path>
          </svg>

          <div class="t-message-thread-header-other-identity d-flex flex-row align-items-center">
            <t-identity-image :identity="otherIdentity"></t-identity-image>
            <t-identity-link :identity="otherIdentity"></t-identity-link>
          </div>

          <svg class="t-message-thread-header-middle-left">
            <polygon class="t-message-thread-header-middle-bg" points="0,50 29,0 0,0"></polygon>
            <path class="t-message-thread-header-middle-border" d="M0,50 L29,0"></path>
          </svg>
        </div>
        <div class="col-5">
          <svg class="t-message-thread-header-cap-right">
            <polygon class="t-message-thread-header-cap-bg" points="0,0 14.5,25 0,50"></polygon>
            <path class="t-message-thread-header-cap-border" d="M0,0 L14.5,25 L0,50"></path>
          </svg>

          <div class="t-message-thread-header-own-identity d-flex flex-row align-items-center">
            <t-identity-image :identity="ownIdentity"></t-identity-image>
            <t-identity-link :identity="ownIdentity"></t-identity-link>
          </div>

          <svg class="t-message-thread-header-middle-right">
            <polygon class="t-message-thread-header-middle-bg" points="99,50 70,0 99,0"></polygon>
            <path class="t-message-thread-header-middle-border" d="M99,50 L70,0"></path>
          </svg>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  // import Identity from '../../models/Identity'

  export default {
    props: {
      ownIdentity: {
        required: true
        // type: Identity
      },

      otherIdentity: {
        required: true
        // type: Identity
      }
    }
  }
</script>

<style lang="scss" scoped>
  @import "../../variables";
  @import "../../functions";

  $header-height: 50px;
  $cap-height: $header-height;
  $cap-width: 15px;

  $middle-offset: 70px;

  .t-message-thread-header {
    position: fixed;
    z-index: $zindex-fixed - 1;

    top: $navbar-height - 1px;
    left: 0;
    right: 0;

    height: $header-height;

    .t-identity-image {
      z-index: 1;
      display: inline-block;
      width: 48px;
    }

    .t-identity-link {
      margin: 0 10px;
    }

    .t-message-thread-header-own-identity,
    .t-message-thread-header-other-identity {
      overflow: hidden;
      text-overflow: ellipsis;
      white-space: nowrap;

      height: $header-height;

      background-color: $tale-dark-grey;
      border: {
        top: 1px solid $tale-blue;
        bottom: 1px solid $tale-blue;
      }

      .t-identity-image:hover + .t-identity-link {
        text-decoration: underline;
      }
    }

    .t-message-thread-header-own-identity {
      justify-content: flex-end;
      margin-right: -$cap-width + 4px;

      .t-identity-image {
        order: 1;
      }
    }
    .t-message-thread-header-other-identity {
      justify-content: flex-start;
      margin-left: -$cap-width + 4px;
    }

    .t-message-thread-header-cap-left,
    .t-message-thread-header-cap-right {
      position: absolute;
      top: 0;

      width: $cap-width;
      height: $cap-height;

      background-color: $tale-grey;

      .t-message-thread-header-cap-bg {
        fill: $tale-dark-grey;
      }
      .t-message-thread-header-cap-border {
        stroke: $tale-blue;
        fill: none;
      }
    }

    .t-message-thread-header-cap-left {
      left: 0;
    }
    .t-message-thread-header-cap-right {
      right: 0;
    }

    .t-message-thread-header-middle-left,
    .t-message-thread-header-middle-right {
      position: absolute;
      top: 0;

      width: 2 * $cap-width + $middle-offset - 1;
      height: $cap-height;

      background-color: $tale-grey;

      .t-message-thread-header-middle-bg {
        fill: $tale-dark-grey;
      }
      .t-message-thread-header-middle-border {
        stroke: $tale-blue;
        fill: none;
      }
    }

    .t-message-thread-header-middle-left {
      right: 0;
    }
    .t-message-thread-header-middle-right {
      left: 0;
    }
  }
</style>
