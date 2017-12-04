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

        <t-skill-selector @select="addSkill($event)"></t-skill-selector>

        <div>
          <b-badge
            variant="success"
            v-for="skillKey in skills" :key="skillKey"
            @click="removeSkill(skillKey)"
          >
            <span v-if="skill(skillKey)">{{skill(skillKey).name()}} [-]</span>
            <t-loading-animation v-else></t-loading-animation>
          </b-badge>
        </div>

        <b-button @click="save" variant="primary">{{ $t('idea.edit.save.button') }}</b-button>
        <b-button @click="cancel" variant="secondary">{{ $t('idea.edit.cancel.button') }}</b-button>
      </fieldset>
    </b-form>
  </b-card>
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
      },

      save () {
        this.saving = true

        let data = {
          title: this.title,
          description: this.description
        }
        Promise.resolve(this.$validator.validateAll(data)).then(valid => {
          if (!valid) {
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
            this.$emit('save')
          }
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
        this.$emit('cancel')
      }
    }
  }
</script>
