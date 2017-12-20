<template>
  <div v-if="idea.isAssociated(ownIdentityKey) || idea.comments().length">
    <span class="t-idea-comments-view-title">{{$t('idea.comments.title')}}</span>

    <t-post-idea-comment-form
      v-if="idea.isAssociated(ownIdentityKey)"
      :ideaKey="idea.key()"
    ></t-post-idea-comment-form>

    <div class="t-idea-comments-view-comment"
         v-for="comment in idea.comments().reverse()"
         :key="comment.key()">
      <t-idea-comment :idea="idea" :comment="comment"></t-idea-comment>
    </div>
  </div>
</template>

<script>
  import { mapGetters } from 'vuex'
  import SubscriptionMixin from '../../mixins/Subscription'

  export default {
    mixins: [
      SubscriptionMixin({
        '!': 'identity/subscribeOwnIdentityKey'
      })
    ],

    props: [
      'idea'
    ],

    computed: {
      ...mapGetters({
        ownIdentityKey: 'identity/ownIdentityKey'
      })
    }
  }
</script>

<style lang="scss" scoped>
  @import "../../variables";

  .t-idea-comments-view-comment {
    margin-top: $idea-comments-margin-top;
    background-color: $idea-comments-bg;
  }

  .t-idea-comments-view-title {
    margin: {
      left: $idea-comments-offset-x;
      right: $idea-comments-offset-x;
    }
  }
</style>
