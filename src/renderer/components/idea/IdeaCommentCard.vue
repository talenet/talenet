<template>
  <div class="t-idea-comment-card clearfix">
    <t-hexagon-image
      class="t-idea-comment-card-identity-image"
      @click="goToIdentityPage()"
      :href="identityImageUrl">
    </t-hexagon-image>

    <div class="t-idea-comment-card-content">
      <div class="t-idea-comment-card-identity-name" @click="goToIdentityPage()">
        {{identity | tFormatIdentityName(identityKey)}}:
      </div>

      <t-markdown-text :text="comment.text()"></t-markdown-text>

      <small class="text-muted float-right">{{comment.timestamp() | tFormatTimestamp}}</small>
    </div>
  </div>
</template>

<script>
  import SubscriptionMixin from '../../mixins/Subscription'
  import { mapGetters } from 'vuex'

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
      ...mapGetters({
        imageUrl: 'ssb/blobUrl'
      }),

      identityKey () {
        return this.comment.authorIdentityKey()
      },

      identity () {
        return this.$store.getters['identity/get'](this.identityKey)
      },

      identityImageUrl () {
        const identity = this.identity
        const getImageUrl = this.imageUrl

        if (!identity) {
          return getImageUrl('&owujXOFvfirC5Kootc7T6uiyclwaME6+lZMqEtV30iw=.sha256')
        }

        return getImageUrl(identity.imageKey())
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

  .t-idea-comment-card-identity-image,
  .t-idea-comment-card-identity-name {
    cursor: pointer;
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
