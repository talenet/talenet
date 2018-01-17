<template>
  <b-alert
    v-if="post"
    class="t-pub-info-post"
    :show="true"
    dismissible
    @dismissed="dismiss()">

    <strong>{{post.timestamp() | tFormatTimestamp}}</strong>

    <t-markdown-text :text="post.text()"></t-markdown-text>
  </b-alert>
</template>

<script>
  import SubscriptionMixin from '../mixins/Subscription'
  import { mapGetters } from 'vuex'

  export default {
    mixins: [
      SubscriptionMixin({
        '!': 'ssb/subscribeLatestPubPost'
      })
    ],

    computed: {
      ...mapGetters({
        latestPubPost: 'ssb/latestPubPost',
        ignorePubPostsUntil: 'settings/ignorePubPostsUntil'
      }),

      post () {
        const post = this.latestPubPost
        const ignorePubPostsUntil = this.ignorePubPostsUntil

        return post && post.timestamp() > ignorePubPostsUntil ? post : null
      }
    },

    methods: {
      dismiss () {
        this.$store.dispatch('settings/ignorePubPostsUntil', this.post.timestamp())
      }
    }
  }
</script>

<style lang="scss">
  @import "../variables";

  .t-pub-info-post {
    position: absolute;
    z-index: $pub-post-z-index;
    top: $pub-post-offset-top;
    left: 0;
    right: 0;

    max-height: 50%;
    overflow: hidden;

    color: $pub-post-color;
    background-color: $pub-post-bg;
    border: none;

    .t-markdown-text {
      display: block;

      margin-top: $pub-post-text-offset-top;
      margin-bottom: 0;

      font-family: $pub-post-font-family;

      & > *:last-child {
        margin-bottom: 0;
      }
    }

    .close {
      color: $pub-post-color;
      text-shadow: none;
      outline: none;

      &:hover {
        opacity: 1;
      }
    }
  }
</style>
