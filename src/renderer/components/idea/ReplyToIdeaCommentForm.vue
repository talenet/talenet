<template>
  <b-form @submit="$event.preventDefault()">
    <fieldset :disabled="saving">
      <t-textarea-group
        v-model="text"
        :rows="5"
        name="text"
        :label="$t('idea.comments.reply.text.label')"
        :placeholder="$t('idea.comments.reply.text.placeholder')"
        :description="$t('idea.comments.reply.text.description')"
      ></t-textarea-group>

      <b-button @click="reply" variant="primary">{{ $t('idea.comments.reply.postReply.button') }}</b-button>
      <b-button @click="cancel" variant="secondary">{{ $t('idea.comments.reply.cancel.button') }}</b-button>
    </fieldset>
  </b-form>
</template>

<script>
  import IdeaCommentReply from '../../models/IdeaCommentReply'
  import { registerConstraints, resetValidation } from '../../util/validation.js'
  import { mapGetters } from 'vuex'

  export default {
    props: [
      'ideaKey',
      'commentKey'
    ],

    data () {
      return {
        text: '',
        saving: false
      }
    },

    created () {
      registerConstraints(this, this.constraints())
    },

    methods: {
      ...mapGetters({
        constraints: 'idea/commentReplyConstraints'
      }),

      clearForm () {
        this.text = ''
        resetValidation(this)
      },

      reply () {
        this.saving = true

        let data = {
          text: this.text
        }
        this.$validator.validateAll(data).then(valid => {
          if (!valid) {
            return null
          }

          let ideaCommentReply = new IdeaCommentReply({
            ideaKey: this.ideaKey,
            commentKey: this.commentKey,
            ...data
          })

          return this.$store.dispatch(
            'idea/replyToComment',
            ideaCommentReply
          )
        }).then((replyKey) => {
          this.saving = false

          if (replyKey) {
            this.clearForm()
          }
        }).catch((err) => {
          if (err) {
            console.error(err)
          }
          this.saving = false
        })
      },

      cancel () {
        this.clearForm()
      }
    }
  }
</script>
