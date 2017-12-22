<template>
  <t-center-on-page v-if="loading">
    <t-loading-animation size="xl"></t-loading-animation>
  </t-center-on-page>

  <t-center-on-page v-else-if="!loading && !exists">
    <t-text-box>{{$t('idea.error.notFound')}}</t-text-box>
  </t-center-on-page>

  <div v-else>
    <b-form @submit="$event.preventDefault()">
      <fieldset :disabled="loading">
        <div class="row">
          <div class="t-wide-col">
            <t-input-group
              v-model="title"
              name="title"
              :maxLength="constraints.title.max"
              :label="$t('idea.edit.title.label')"
              :placeholder="$t('idea.edit.title.placeholder')"
              :description="$t('idea.edit.title.description')"
            ></t-input-group>
          </div>
        </div>

        <t-markdown-input-group
          v-model="description"
          :rows="10"
          name="description"
          :label="$t('idea.edit.description.label')"
          :markdown-label="$t('idea.edit.description.markdownLabel')"
          :placeholder="$t('idea.edit.description.placeholder')"
        ></t-markdown-input-group>

        <div class="row">
          <div class="t-wide-col">
            <t-idea-skill-selector
              @add-skill="addSkill($event)"
              @remove-skill="removeSkill($event)"
              :skill-keys="skills"
            >
            </t-idea-skill-selector>
          </div>
        </div>

        <div class="row">
          <div class="t-wide-col">
            <t-action-panel>
              <t-action-button
                slot="left"
                ref="save"
                @click="save"
                variant="primary">
                {{ $t('idea.edit.save.button') }}
              </t-action-button>
              <b-button
                slot="right"
                @click="cancel"
                variant="outline-primary">
                {{ $t('idea.edit.cancel.button') }}
              </b-button>
            </t-action-panel>
          </div>
        </div>
      </fieldset>
    </b-form>
  </div>
</template>

<script>
  import IdeaPersistenceData from '../../models/IdeaPersistenceData'
  import { registerConstraints, resetValidation } from '../../util/validation.js'
  import { mapGetters } from 'vuex'
  import Promise from 'bluebird'

  export default {
    props: [
      'idea'
    ],

    data () {
      return {
        loading: false,
        saving: false,
        exists: true,

        title: '',
        description: '',

        currentSkills: [],
        skillsToAdd: [],
        skillsToRemove: []
      }
    },

    created () {
      registerConstraints(this, this.constraints)
    },

    mounted () {
      this.title = this.idea.title()
      this.description = this.idea.description()

      this.currentSkills = this.idea.skills()
    },

    computed: {
      ...mapGetters({
        constraints: 'idea/constraints',
        skill: 'skill/get'
      }),

      skills () {
        return [...this.currentSkills, ...this.skillsToAdd].filter(key => !this.skillsToRemove.includes(key))
      }
    },

    methods: {
      addSkill (key) {
        this.skillsToRemove = this.skillsToRemove.filter((skill) => skill !== key)
        if (!this.currentSkills.includes(key) && !this.skillsToAdd.includes(key)) {
          this.skillsToAdd.push(key)
        }
      },

      removeSkill (key) {
        this.skillsToAdd = this.skillsToAdd.filter((skill) => skill !== key)
        if (this.currentSkills.includes(key) && !this.skillsToRemove.includes(key)) {
          this.skillsToRemove.push(key)
        }
      },

      clearForm () {
        this.title = ''
        this.description = ''

        this.currentSkills = []
        this.skillsToAdd = []
        this.skillsToRemove = []

        resetValidation(this)
        this.$refs.save.reset()
      },

      save () {
        this.saving = true
        this.$refs.save.start()

        let data = {
          title: this.title,
          description: this.description
        }
        Promise.resolve(this.$validator.validateAll(data)).then(valid => {
          if (!valid) {
            this.$refs.save.fail()
            return null
          }

          return this.$store.dispatch(
            'idea/update',
            new IdeaPersistenceData(
              this.idea,
              data,
              this.skillsToAdd,
              this.skillsToRemove
            ))
        }).then((ideaKey) => {
          if (ideaKey) {
            this.clearForm()
            this.$refs.save.finish()
            this.$emit('save')
          }
        }).catch((err) => {
          if (err) {
            console.error(err)
          }
          this.$refs.save.fail()
        }).finally(() => {
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
