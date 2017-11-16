<template>
  <b-card :title="$t('idea.edit.label')">
    <b-form>
      <div v-if="loading">
        <t-loading-animation></t-loading-animation>
      </div>

      <div v-if="!loading && !exists">
        <h1>{{$t('idea.error.notFound')}}</h1>
      </div>

      <fieldset :disabled="loading">
        <div class="row">
          <div class="col-md-6">
            <t-input-group
              v-model="title"
              name="title"
              :label="$t('idea.edit.title.label')"
              :placeholder="$t('idea.edit.title.placeholder')"
              :description="$t('idea.edit.title.description')"
            ></t-input-group>
          </div>
        </div>

        <div class="row">
          <div class="col-md-6">
            <t-textarea-group
              v-model="description"
              :rows="10"
              name="description"
              :label="$t('idea.edit.description.label')"
              :placeholder="$t('idea.edit.description.placeholder')"
              :description="$t('idea.edit.description.description')"
            ></t-textarea-group>
          </div>
          <div class="col-md-6">
            <b-card>
              <t-markdown-text :text="description"></t-markdown-text>
            </b-card>
          </div>
        </div>

        <b-button @click="save" variant="primary">{{ $t('idea.edit.save.button') }}</b-button>
        <b-button @click="cancel" variant="secondary">{{ $t('idea.edit.cancel.button') }}</b-button>
      </fieldset>
    </b-form>
  </b-card>
</template>

<script>
  import IdeaUpdate from '../../models/IdeaUpdate'

  export default {
    props: [
      'ideaKey'
    ],

    data () {
      return {
        loading: true,
        saving: false,
        exists: false,

        title: '',
        description: ''
      }
    },

    created () {
      // TODO: Extract constraints
      this.$validator.attach('title', 'required')
      this.$validator.attach('description', 'required')

      this.loadIdea(this.ideaKey)
    },

    watch: {
      ideaKey (key) {
        this.loadIdea(key)
      }
    },

    methods: {
      clearForm () {
        this.title = ''
        this.description = ''

        this.errors.clear()
        //        this.fields.reset()
      },

      loadIdea (key) {
        this.loading = true
        this.exists = false
        this.clearForm()

        this.$store.dispatch('idea/load', key)
          .then((result) => {
            if (result.exists) {
              this.exists = true

              const idea = this.$store.getters['idea/get'](this.ideaKey)
              this.title = idea.title()
              this.description = idea.description()
            }

            this.loading = false
          })
          .catch((err) => {
            if (err) {
              console.error(err)
            }

            this.loading = false
          })
      },

      save () {
        this.saving = true

        let data = {
          title: this.title,
          description: this.description
        }
        this.$validator.validateAll(data).then(valid => {
          if (!valid) {
            return null
          }

          let ideaUpdate = new IdeaUpdate({
            ideaKey: this.ideaKey,
            ...data
          })

          return this.$store.dispatch(
            'idea/update',
            ideaUpdate
          )
        }).then((ideaKey) => {
          this.saving = false

          if (ideaKey) {
            this.clearForm()
            this.$emit('save')
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
        this.$emit('cancel')
      }
    }
  }
</script>
