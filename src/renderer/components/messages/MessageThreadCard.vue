<template>
  <div :class="classes">
    <div class="t-thread-card-container" @click="goToThread()">
      <div class="t-thread-card-content-container">
        <div class="t-thread-card-content" :style="`height: ${content.height}px;`">
          <t-message-text-teaser
            class="t-thread-card-teaser"
            :text="message.value.content.text"
            :align="isOwnMessage ? 'right' : 'left'">
          </t-message-text-teaser>

          <div class="t-thread-card-timestamp">
            {{ message.value.timestamp | tFormatTimestamp }}
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
          class="t-thread-card-author-image"
          :identity="authorIdentity">
        </t-identity-image>

        <t-identity-link
          class="t-thread-card-author-name"
          :identity="authorIdentity">
        </t-identity-link>
      </div>

      <div class="t-thread-card-identity-container">
        <t-identity-image
          class="t-thread-card-recipient-image"
          :identity="recpIdentity">
        </t-identity-image>

        <t-identity-link
          class="t-thread-card-recipient-name"
          :identity="recpIdentity">
        </t-identity-link>
      </div>
    </div>
  </div>
</template>

<script>
  import SubscriptionMixin from '../../mixins/Subscription'
  import { mapGetters } from 'vuex'

  // import Post from '../../models/Post'

  const SIN_60 = Math.sin(Math.PI / 3)

  export default {
    mixins: [
      SubscriptionMixin({
        'authorKey': 'identity/subscribe',
        'recpKey': 'identity/subscribe'
      })
    ],

    computed: {
      ...mapGetters({
        'ownIdentityKey': 'identity/ownIdentityKey',
        'getIdentity': 'identity/get'
      }),

      // => Post model
      threadKey () {
        let tk = null
        if (this.message.value.content.root) {
          tk = this.message.value.content.root
        } else {
          tk = this.message.key
        }
        return tk
      },

      classes () {
        return {
          't-thread-card': true,
          't-thread-card-own-message': this.isOwnMessage
        }
      },

      isOwnMessage () {
        return this.authorKey === this.ownIdentityKey
      },

      authorKey () {
        return this.message.value.author
      },

      authorIdentity () {
        return this.getIdentity(this.authorKey)
      },

      recpKey () { // is it for me or not?
        // TOOD: want to display for me and this other 4 people
        const m = this.message
        const recps = m.value.content.recps || []
        const fromMe = this.isOwnMessage
        for (const r of recps) {
          // can be either {link: '@ed25519', name: '...'} or '@ed25519'
          const k = typeof r === 'string' ? r : r.link
          if (fromMe) {
            if (k !== this.ownIdentityKey) {
              return k
            }
          } else {
            if (k === this.ownIdentityKey) {
              return k
            }
          }
        }
        console.error('multiparty! recp == 0!! :(')
        return null // not for me?! should not be possible
      },

      recpIdentity () { // see above - is now always me but shouldnt if I send the message..!
        return this.getIdentity(this.recpKey)
      }
    },

    props: {
      message: {
        required: true,
        type: Object // better type: Post  // HOWTO Post.fromSSB(..) ?
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
    },

    methods: {
      goToThread () {
        this.$router.push({
          name: 'messageThread',
          params: {
            threadKey: this.threadKey
          }
        })
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
      right: -$padding-x;
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

    .t-thread-card-author-image,
    .t-thread-card-recipient-image {
      position: absolute;
    }

    .t-thread-card-author-image,
    &.t-thread-card-own-message .t-thread-card-recipient-image {
      top: 0;
      left: 0;
      right: initial;
      bottom: initial;
      width: $width;
    }

    .t-thread-card-recipient-image,
    &.t-thread-card-own-message .t-thread-card-author-image {
      top: initial;
      left: initial;
      bottom: 0;
      right: 0;
      width: $width / 2 - 3px;
    }

    .t-thread-card-recipient-name,
    .t-thread-card-author-name,
    .t-thread-card-timestamp {
      position: absolute;
      margin: 3px 0;
    }

    .t-thread-card-recipient-name,
    &.t-thread-card-own-message .t-thread-card-author-name {
      top: initial;
      left: initial;
      bottom: 0;
      right: $width / 2 - 3px + 12px;
    }

    .t-thread-card-author-name,
    &.t-thread-card-own-message .t-thread-card-recipient-name {
      top: 0;
      left: 110px - $padding-x;
      right: initial;
      bottom: initial;
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
