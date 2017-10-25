<template>
  <b-card :title="$t('idea.create.label')">
    <b-form>
      <b-alert variant="danger" show>TODO: VALIDATION!</b-alert>

      <b-form-group :label="$t('idea.create.title.label')" :description="$t('idea.create.title.description')">
        <b-form-input v-model="title" :placeholder="$t('idea.create.title.placeholder')"></b-form-input>
      </b-form-group>
      <b-form-group :label="$t('idea.create.description.label')"
                    :description="$t('idea.create.description.description')">
        <b-form-textarea v-model="description" :rows="10"
                         :placeholder="$t('idea.create.description.placeholder')"></b-form-textarea>
      </b-form-group>

      <b-button @click="createIdea" variant="primary">{{ $t('idea.create.save.button') }}</b-button>
      <b-button @click="cancel" variant="secondary">{{ $t('idea.create.cancel.button') }}</b-button>
    </b-form>
  </b-card>
</template>

<script>
  export default {
    data () {
      return {
        title: '',
        description: ''
      }
    },
    methods: {
      createIdea () {
        this.$store.dispatch(
          'idea/create',
          {
            title: this.title,
            description: this.description
          }
        ).then((createdIdea) => {
          // TODO: Clear form and navigate to idea.
          console.log('done creating idea:', createdIdea)
        })
      },

      cancel () {
        // TODO: Clear and leave form.
      }
    }
  }
</script>

<style scoped lang="scss">
</style>
