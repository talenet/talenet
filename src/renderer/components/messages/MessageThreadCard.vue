<template>
  <div class="t-thread-card">
    <div class="t-thread-card-container">
      <div class="t-thread-card-content-container">
        <div class="t-thread-card-content" :style="`height: ${content.height}px;`">
          <t-message-text-teaser class="t-thread-card-teaser" :text="text"></t-message-text-teaser>

          <div class="t-thread-card-timestamp">
            {{new Date() | tFormatTimestamp }}
          </div>
        </div>
      </div>
      <svg class="t-thread-card-corner-top-left" :width="corner.width" :height="corner.height">
        <polygon
          class="t-thread-card-corner-bg"
          :points="`0,0 0,${corner.height} ${corner.width},0`">
        </polygon>
        <path
          class="t-thread-card-corner-border"
          :d="`M${corner.width},0 L0,${corner.height} Z`">
        </path>
      </svg>

      <svg class="t-thread-card-corner-bottom-right" :width="corner.width / 2" :height="corner.height / 2">
        <polygon
          class="t-thread-card-corner-bg"
          :points="`${corner.width / 2},0 ${corner.width / 2},${corner.height / 2} 0,${corner.height / 2}`">
        </polygon>
        <path
          class="t-thread-card-corner-border"
          :d="`M${corner.width / 2},0 L0,${corner.height / 2} Z`">
        </path>
      </svg>
    </div>

    <div class="t-thread-card-inner-click-container">
      <div class="t-thread-card-identity-container">
        <t-identity-image
          class="t-thread-card-other-identity-image"
          :identity="ownIdentity">
        </t-identity-image>

        <t-identity-link
          v-if="ownIdentity"
          class="t-thread-card-own-identity-name"
          :identity="ownIdentity">
        </t-identity-link>
      </div>

      <div class="t-thread-card-identity-container">
        <t-identity-image
          class="t-thread-card-own-identity-image"
          :identity="otherIdentity">
        </t-identity-image>

        <t-identity-link
          v-if="otherIdentity"
          class="t-thread-card-other-identity-name"
          :identity="otherIdentity">
        </t-identity-link>
      </div>
    </div>
  </div>
</template>

<script>
  // import Identity from '../../models/Identity'

  const SIN_60 = Math.sin(Math.PI / 3)

  export default {
    props: {
      ownIdentity: {
        required: true
        // type: Identity
      },

      otherIdentity: {
        required: true
        // type: Identity
      },

      text: {
        required: true,
        type: String
      }
    },

    data () {
      const r = 55
      const h = r * SIN_60
      const w = Math.sqrt(r * r - h * h)

      return {
        corner: {
          width: w,
          height: h
        },

        content: {
          height: 3 * 47 * SIN_60
        }
      }
    }
  }
</script>

<style lang="scss" scoped>
  @import "../../variables";
  @import "../../mixins";

  $padding-x: 7px;

  .t-thread-card {
    position: relative;

    .t-thread-card-container {
      position: relative;
      overflow: hidden;

      cursor: pointer;
      user-select: none;

      margin: {
        top: 1.5rem;
        bottom: 1.5rem;
      }

      background-color: $tale-grey;
      @include transition(background-color 0.2s ease-out);

      &:hover {
        background-color: darken($tale-grey, 5%);
      }
    }

    .t-thread-card-corner-top-left,
    .t-thread-card-corner-bottom-right {
      position: absolute;

      .t-thread-card-corner-bg {
        fill: $tale-grey;
      }

      .t-thread-card-corner-border {
        stroke: $tale-blue;
      }
    }

    .t-thread-card-corner-top-left {
      top: 0;
      left: 0;
    }

    .t-thread-card-corner-bottom-right {
      bottom: 0;
      right: 0;
    }

    $width: 94px;

    .t-thread-card-content-container {
      // background-color: $tale-dark-grey;
      border: 1px solid $tale-blue;

      padding: 5px $padding-x;
    }

    .t-thread-card-teaser {
      position: absolute;
      top: (100 / 3) * 1%;
      left: -$padding-x;
    }

    .t-thread-card-content {
      position: relative;
    }

    .t-thread-card-inner-click-container,
    .t-thread-card-identity-container {
      position: absolute;
      top: 0;
      bottom: 0;
      left: 0;
      right: 0;
    }

    .t-thread-card-inner-click-container {
      pointer-events: none;

      margin: 5px $padding-x;
    }

    .t-thread-card-other-identity-image,
    .t-thread-card-own-identity-image {
      position: absolute;
    }

    .t-thread-card-other-identity-image {
      top: 0;
      left: 0;
      width: $width;
    }

    .t-thread-card-own-identity-image {
      bottom: 0;
      right: 0;
      width: $width / 2 - 3px;
    }

    .t-thread-card-own-identity-name,
    .t-thread-card-other-identity-name,
    .t-thread-card-timestamp {
      position: absolute;
      margin: 3px 0;
    }

    .t-thread-card-own-identity-name {
      top: 0;
      left: 110px - $padding-x;
    }

    .t-thread-card-other-identity-name {
      bottom: 0;
      right: $width / 2 - 3px + 12px;
    }

    .t-thread-card-timestamp {
      top: 0;
      right: 8px;
      color: $tale-light-grey;
    }

    .t-identity-image,
    .t-identity-link {
      pointer-events: initial;
    }

    .t-identity-image:hover + .t-identity-link {
      text-decoration: underline;
    }
  }
</style>
