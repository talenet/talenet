<template>
  <b-form @submit="$event.preventDefault()" class="t-reply-to-idea-comment-form">
    <fieldset :disabled="saving">
      <t-textarea-group
        v-model="text"
        :rows="3"
        name="text"
        :label="$t('idea.comments.reply.text.label')"
        :placeholder="$t('idea.comments.reply.text.placeholder')"
      ></t-textarea-group>

      <i18n :path="'markdown.description'" tag="small" class="t-reply-to-idea-comment-form-description text-muted">
        <a place="markdownLink" href="http://commonmark.org/help/" target="_blank">{{ $t('markdown.link') }}</a>
      </i18n>

      <t-button-panel>
        <t-action-button
          slot="left"
          ref="reply"
          @click="reply"
          variant="primary">
          {{ $t('idea.comments.reply.postReply.button') }}
        </t-action-button>
      </t-button-panel>
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
        this.$refs.reply.reset()
      },

      reply () {
        this.saving = true

        let data = {
          text: this.text
        }
        this.$refs.reply.execute(
          this.$validator.validateAll(data).then(valid => {
            if (!valid) {
              this.$refs.reply.fail()
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
          })
        ).then((replyKey) => {
          if (replyKey) {
            this.clearForm()
          }

          return null
        }).catch((err) => {
          if (err) {
            console.error(err)
          }
        }).finally(() => {
          this.saving = false
        })
      },

      cancel () {
        this.clearForm()
      }
    }
  }
</script>

<style lang="scss" scoped>
  @import "../../variables";

  .t-reply-to-idea-comment-form button {
    margin-bottom: $idea-comment-reply-form-margin-bottom;
  }

  .t-reply-to-idea-comment-form-description {
    display: block;
    margin: {
      top: -$idea-comment-form-offset-y / 2;
      bottom: $idea-comment-form-offset-y;
      left: $idea-comment-form-offset-x;
      right: $idea-comment-form-offset-x;
    }
  }
</style>
