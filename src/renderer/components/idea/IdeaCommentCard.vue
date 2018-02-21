<template>
  <div class="t-idea-comment-card clearfix">
    <t-identity-image
      class="t-idea-comment-card-identity-image"
      :identity="identity">
    </t-identity-image>

    <div class="t-idea-comment-card-content">
      <t-identity-link
        class="t-idea-comment-card-identity-name"
      :identity="identity"
      :identity-key="identityKey">
      </t-identity-link>

      <t-markdown-text :text="comment.text()"></t-markdown-text>

      <small class="text-muted float-right">{{comment.timestamp() | tFormatTimestamp}}</small>
    </div>
  </div>
</template>

<script>
  import SubscriptionMixin from '../../mixins/Subscription'

  export default {
    mixins: [
      SubscriptionMixin({
        'identityKey': 'identity/subscribe'
      })
    ],

    props: {
      comment: {
        required: true
      },

      type: {
        type: String,
        required: true
      }
    },

    computed: {
      identityKey () {
        return this.comment.authorIdentityKey()
      },

      identity () {
        return this.$store.getters['identity/get'](this.identityKey)
      }
    },

    methods: {
      goToIdentityPage () {
        this.$router.push({
          name: 'identityDetails',
          params: {
            identityKey: this.identityKey
          }
        })
      }
    }
  }
</script>

<style lang="scss" scoped>
  @import "../../variables";

  .t-idea-comment-card {
    position: relative;
    padding: $idea-comment-padding-y $idea-comment-padding-x;
  }

  .t-idea-comment-card-identity-image {
    float: left;
    width: $idea-comment-identity-image-size;
  }

  .t-idea-comment-card-content {
    overflow-y: hidden;
    word-wrap: break-word;

    margin-left: $idea-comment-identity-image-size;
    padding: {
      left: $idea-comment-padding-x;
      right: $idea-comment-padding-x;
    }
  }

  .t-idea-comment-card-identity-name {
    color: $idea-comment-identity-name-color;
    /*font-weight: bold;*/
  }
</style>
