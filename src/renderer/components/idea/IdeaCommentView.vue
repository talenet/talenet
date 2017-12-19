<template>
  <div>
    <t-idea-comment-card
      class="t-idea-comment-view-comment"
      type="comment"
      :comment="comment">
    </t-idea-comment-card>

    <t-idea-comment-card
      v-for="reply in idea.repliesForComment(comment.key())"
      class="t-idea-comment-view-reply"
      :key="reply.key()"
      type="reply"
      :comment="reply">
    </t-idea-comment-card>

    <t-reply-to-idea-comment-form
      class="t-idea-comment-view-reply-form"
      v-if="idea.isAssociated(ownIdentityKey)"
      :ideaKey="idea.key()"
      :commentKey="comment.key()"
    ></t-reply-to-idea-comment-form>
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
      'idea',
      'comment'
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

  .t-idea-comment-view-comment {
    border-bottom: $idea-comment-border-bottom;
  }

  .t-idea-comment-view-reply,
  .t-idea-comment-view-reply-form {
    margin-left: $idea-comment-reply-offset;
  }
</style>
