<template>
  <b-card :title="$t('idea.create.label')">
    <b-form>
      <fieldset :disabled="saving">
        <div class="row">
          <div class="col-md-6">
            <t-input-group
              v-model="title"
              name="title"
              :label="$t('idea.create.title.label')"
              :placeholder="$t('idea.create.title.placeholder')"
              :description="$t('idea.create.title.description')"
            ></t-input-group>
          </div>
        </div>

        <div class="row">
          <div class="col-md-6">
            <t-textarea-group
              v-model="description"
              :rows="10"
              name="description"
              :label="$t('idea.create.description.label')"
              :placeholder="$t('idea.create.description.placeholder')"
              :description="$t('idea.create.description.description')"
            ></t-textarea-group>
          </div>
          <div class="col-md-6">
            <b-card>
              <t-markdown-text :text="description"></t-markdown-text>
            </b-card>
          </div>
        </div>

        <b-button @click="createIdea" variant="primary">{{ $t('idea.create.save.button') }}</b-button>
        <b-button @click="cancel" variant="secondary">{{ $t('idea.create.cancel.button') }}</b-button>
      </fieldset>
    </b-form>
  </b-card>
</template>

<script>
  import IdeaPersistenceData from '../../models/IdeaPersistenceData'
  import { registerConstraints, resetValidation } from '../../util/validation.js'
  import { mapGetters } from 'vuex'

  export default {
    data () {
      return {
        title: '',
        description: '',
        saving: false
      }
    },

    created () {
      registerConstraints(this, this.constraints())
    },

    methods: {
      ...mapGetters({
        constraints: 'idea/constraints'
      }),

      clearForm () {
        this.title = ''
        this.description = ''

        resetValidation(this)
      },

      createIdea () {
        this.saving = true

        let data = {
          title: this.title,
          description: this.description
        }
        this.$validator.validateAll(data).then(valid => {
          if (!valid) {
            return null
          }

          return this.$store.dispatch(
            'idea/create',
            new IdeaPersistenceData(null, data, [], [])
          )
        }).then((ideaKey) => {
          this.saving = false

          if (ideaKey) {
            this.clearForm()
            this.$router.push({
              name: 'idea',
              params: { ideaKey }
            })
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
