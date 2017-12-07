<template>
  <b-card>
    <t-post-idea-comment-form
      v-if="idea.isAssociated(ownIdentityKey)"
      :ideaKey="idea.key()"
    ></t-post-idea-comment-form>

    <b-card v-for="comment in idea.comments().reverse()" :key="comment.key()">
      <div>{{comment.timestamp()}}</div>
      <t-identity-card :identityKey="comment.authorIdentityKey()"></t-identity-card>
      <t-markdown-text :text="comment.text()"></t-markdown-text>

      <t-reply-to-idea-comment-form
        v-if="idea.isAssociated(ownIdentityKey)"
        :ideaKey="idea.key()"
        :commentKey="comment.key()"
      ></t-reply-to-idea-comment-form>

      <b-card v-for="reply in idea.repliesForComment(comment.key()).reverse()" :key="reply.key()">
        <div>{{reply.timestamp()}}</div>
        <t-identity-card :identityKey="reply.authorIdentityKey()"></t-identity-card>
        <t-markdown-text :text="reply.text()"></t-markdown-text>
      </b-card>
    </b-card>
  </b-card>
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
