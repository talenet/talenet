<template>
  <b-form>
    <fieldset :disabled="saving">
      <t-textarea-group
        v-model="text"
        :rows="5"
        name="text"
        :label="$t('idea.comments.post.text.label')"
        :placeholder="$t('idea.comments.post.text.placeholder')"
        :description="$t('idea.comments.post.text.description')"
      ></t-textarea-group>

      <b-button @click="post" variant="primary">{{ $t('idea.comments.post.postComment.button') }}</b-button>
      <b-button @click="cancel" variant="secondary">{{ $t('idea.comments.post.cancel.button') }}</b-button>
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
      },

      post () {
        this.saving = true

        let data = {
          text: this.text
        }
        this.$validator.validateAll(data).then(valid => {
          if (!valid) {
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
