<template>
  <div class="t-idea-comment-card clearfix">
    <t-hexagon-image
      class="t-idea-comment-card-identity-image"
      :href="identityImageUrl">
    </t-hexagon-image>

    <div class="t-idea-comment-card-content">
      <div class="t-idea-comment-card-identity-name">
        {{identityName}}:
      </div>

      <t-markdown-text :text="comment.text()"></t-markdown-text>

      <small class="text-muted float-right">{{comment.timestamp() | t-format-timestamp}}</small>
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

      identity () {
        return this.$store.getters['identity/get'](this.comment.authorIdentityKey())
      },

      identityName () {
        const identity = this.identity
        const authorIdentityKey = this.comment.authorIdentityKey

        if (!identity) {
          return authorIdentityKey
        }

        return identity.name() || identity.key()
      },

      identityImageUrl () {
        const identity = this.identity
        const getImageUrl = this.imageUrl

        if (!identity) {
          return // TODO
        }

        return getImageUrl(identity.imageKey())
      }
    },

    methods: {
      goToIdentityPage () {
        this.$router.push({
          name: 'identityDetails',
          params: {
            identityKey: this.identity.key()
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
