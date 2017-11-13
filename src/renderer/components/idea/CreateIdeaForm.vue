<template>
  <b-card :title="$t('idea.create.label')">
    <b-form>
      <fieldset :disabled="saving">
        <t-input-group
          v-model="title"
          name="title"
          :label="$t('idea.create.title.label')"
          :placeholder="$t('idea.create.title.placeholder')"
          :description="$t('idea.create.title.description')"
        ></t-input-group>

        <t-textarea-group
          v-model="description"
          :rows="10"
          name="description"
          :label="$t('idea.create.description.label')"
          :placeholder="$t('idea.create.description.placeholder')"
          :description="$t('idea.create.description.description')"
        ></t-textarea-group>

        <b-button @click="createIdea" variant="primary">{{ $t('idea.create.save.button') }}</b-button>
        <b-button @click="cancel" variant="secondary">{{ $t('idea.create.cancel.button') }}</b-button>
      </fieldset>
    </b-form>
  </b-card>
</template>

<script>
  export default {
    data () {
      return {
        title: '',
        description: '',
        saving: false
      }
    },
    created () {
      this.$validator.attach('title', 'required')
      this.$validator.attach('description', 'required')
    },
    methods: {
      clearForm () {
        this.title = ''
        this.description = ''

        this.errors.clear()
        this.fields.reset()
      },

      createIdea () {
        this.saving = true

        let idea = {
          title: this.title,
          description: this.description
        }
        this.$validator.validateAll(idea).then(valid => {
          if (!valid) {
            return null
          }

          return this.$store.dispatch(
            'idea/create',
            idea
          )
        }).then((createdIdea) => {
          this.saving = false

          if (createdIdea) {
            // TODO: Navigate to idea.
            console.log('done creating idea:', createdIdea)
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

<style scoped lang="scss">
</style>
