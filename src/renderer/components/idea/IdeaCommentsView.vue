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
    </b-card>
  </b-card>
</template>

<script>
  import { mapGetters } from 'vuex'

  export default {
    props: [
      'idea'
    ],

    computed: {
      ...mapGetters({
        ownIdentityKey: 'ssb/whoami' // TODO: Refactor ssb module?
      })
    }
  }
</script>
