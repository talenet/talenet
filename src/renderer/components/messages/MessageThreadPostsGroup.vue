<template>
  <div :class="classes">
    <div class="t-message-thread-posts-group-container">
      <transition-group name="fade-height" mode="out-in" tag="div">
        <div class="t-message-thread-posts-group-message" v-for="msg in messages" :key="msg.key">
          <div class="t-message-thread-posts-group-message-content">
            <span
              class="t-message-thread-posts-group-message-timestamp">{{msg.value.timestamp | tFormatTimestamp}}</span>
            <t-markdown-text :text="msg.value.content.text"></t-markdown-text>
          </div>
        </div>
      </transition-group>

      <svg v-if="isOwn" class="t-message-thread-posts-group-corner-left">
        <polygon class="t-message-thread-posts-group-corner-bg" points="0,0 13,24 13,0"></polygon>
        <path class="t-message-thread-posts-group-corner-border" d="M0,0 L13,24"></path>
      </svg>

      <svg v-if="!isOwn" class="t-message-thread-posts-group-corner-right">
        <polygon class="t-message-thread-posts-group-corner-bg" points="13,0 0,24 0,0"></polygon>
        <path class="t-message-thread-posts-group-corner-border" d="M13,0 L0,24"></path>
      </svg>
    </div>
  </div>
</template>

<script>
  import SubscriptionMixin from '../../mixins/Subscription'
  import { mapGetters } from 'vuex'

  export default {
    props: {
      messages: {
        required: true,
        type: Array
      }
    },

    mixins: [
      SubscriptionMixin({
        '!': ['identity/subscribeOwnIdentityKey']
      })
    ],

    computed: {
      ...mapGetters({
        'ownIdentityKey': 'identity/ownIdentityKey'
      }),

      isOwn () {
        return this.ownIdentityKey === this.messages[0].value.author
      },

      classes () {
        return {
          't-message-thread-posts-group': true,
          'col-md-7': true,
          'offset-md-3': this.isOwn,
          'offset-md-2': !this.isOwn
        }
      }
    }
  }
</script>

<style lang="scss" scoped>
  @import "../../variables";

  .t-message-thread-posts-group {
    .t-message-thread-posts-group-container {
      position: relative;

      background-color: $message-thread-group-bg;
      border: $message-thread-group-border-width solid $message-thread-group-border-color;

      margin-bottom: $message-thread-group-spacing;
      padding: 0;
    }

    .t-message-thread-posts-group-message {
      position: relative;
      overflow-y: hidden;

      border-bottom: $message-thread-group-border-width solid $message-thread-group-border-color;

      &:last-child {
        border: none;
      }
    }

    .t-message-thread-posts-group-message-content {
      margin: {
        top: $message-thread-group-padding-y;
        left: $message-thread-group-padding-x;
        right: $message-thread-group-padding-x;
        bottom: $message-thread-group-padding-bottom;
      }
      .t-markdown-text {
        font-family: "OpenSansRegular";
        font-size: $font-size-base;
        text-indent: 0;
      }
    }

    .t-message-thread-posts-group-corner-left,
    .t-message-thread-posts-group-corner-right {
      position: absolute;
      bottom: -$message-thread-group-border-width;

      width: 13px;
      height: 24px;
      background-color: $body-bg;

      .t-message-thread-posts-group-corner-bg {
        fill: $message-thread-group-bg;
      }

      .t-message-thread-posts-group-corner-border {
        stroke: $message-thread-group-border-color;
        stroke-width: $message-thread-group-border-width;
      }
    }

    .t-message-thread-posts-group-corner-left {
      left: -$message-thread-group-border-width;
    }

    .t-message-thread-posts-group-corner-right {
      right: -$message-thread-group-border-width;
    }

    .t-message-thread-posts-group-message-timestamp {
      position: absolute;
      bottom: $message-thread-group-padding-y;
      right: $message-thread-group-padding-x;
      color: $tale-dark-grey;
    }
  }
</style>
