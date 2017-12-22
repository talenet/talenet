<template>
  <b-form @submit="$event.preventDefault()">
    <fieldset :disabled="saving">
      <t-textarea-group
        v-model="text"
        :rows="3"
        name="text"
        :label="$t('idea.comments.post.text.label')"
        :placeholder="$t('idea.comments.post.text.placeholder')"
      ></t-textarea-group>

      <i18n :path="'markdown.description'" tag="small" class="t-post-idea-comment-form-description text-muted">
        <a place="markdownLink" href="http://commonmark.org/help/" target="_blank">{{ $t('markdown.link') }}</a>
      </i18n>

      <t-button-panel>
        <t-action-button
          slot="left"
          ref="post"
          @click="post"
          variant="primary">
          {{ $t('idea.comments.post.postComment.button') }}
        </t-action-button>
      </t-button-panel>
    </fieldset>
  </b-form>
</template>

<script>
  import IdeaComment from '../../models/IdeaComment'
  import { registerConstraints, resetValidation } from '../../util/validation.js'
  import { mapGetters } from 'vuex'

  export default {
    props: [
      'ideaKey'
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
        constraints: 'idea/commentConstraints'
      }),

      clearForm () {
        this.text = ''
        resetValidation(this)
        this.$refs.post.reset()
      },

      post () {
        this.$refs.post.start()
        this.saving = true

        let data = {
          text: this.text
        }
        this.$validator.validateAll(data).then(valid => {
          if (!valid) {
            this.$refs.post.fail()
            return null
          }

          let ideaComment = new IdeaComment({
            ideaKey: this.ideaKey,
            ...data
          })

          return this.$store.dispatch(
            'idea/postComment',
            ideaComment
          )
        }).then((commentKey) => {
          this.saving = false

          if (commentKey) {
            this.clearForm()
            this.$refs.post.finish()
          }

          return null
        }).catch((err) => {
          if (err) {
            console.error(err)
          }
          this.$refs.post.fail()
          this.saving = false
        })
      }
    }
  }
</script>

<style lang="scss" scoped>
  @import "../../variables";

  .t-post-idea-comment-form-description {
    display: block;
    margin: {
      top: -$idea-comment-form-offset-y / 2;
      bottom: $idea-comment-form-offset-y;
      left: $idea-comment-form-offset-x;
      right: $idea-comment-form-offset-x;
    }
  }
</style>
