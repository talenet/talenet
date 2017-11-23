<template>
  <b-card>
    <t-post-idea-comment-form
      v-if="idea.isAssociated(ownIdentityKey)"
      :ideaKey="idea.key()"
    ></t-post-idea-comment-form>
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
