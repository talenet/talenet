<template>
  <div>
    <div class="row">
      <div class="t-center-col">
        <t-introduction-box messagesKey="idea.create.introduction"></t-introduction-box>
      </div>
    </div>

    <b-form @submit="$event.preventDefault()">
      <fieldset :disabled="saving">
        <div class="row">
          <div class="t-center-col">
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
          <div class="t-center-col">
            <t-markdown-input-group
              v-model="description"
              :rows="10"
              name="description"
              :label="$t('idea.create.description.label')"
              :placeholder="$t('idea.create.description.placeholder')"
              :description="$t('idea.create.description.description')"
              :markdown-label="$t('idea.create.description.markdownLabel')"
            ></t-markdown-input-group>
          </div>
        </div>

        <div class="row">
          <div class="t-center-col">
            <t-skill-selector
              @select="addSkill($event)"
              :label="$t('idea.create.selectSkill.label')"
              :placeholder="$t('idea.create.selectSkill.placeholder')"
              :description="$t('idea.create.selectSkill.description')"
              :selectedSkillKeys="skillKeys"
            ></t-skill-selector>

            <div class="t-create-idea-form-current-skills-label">
              {{$t('idea.create.selectedSkills.label')}}
            </div>

            <div v-if="skillKeys.length" class="t-create-idea-form-current-skills">
              <t-skill-badge
                v-for="skillKey in skillKeys"
                :key="skillKey"
                :skill-key="skillKey"
                action="remove"
                @click="removeSkill(skillKey)"
              >
              </t-skill-badge>
            </div>
            <div v-else class="t-create-idea-form-current-skills-no-skills">
              <small class="text-muted">{{$t('idea.create.selectedSkills.noSkills')}}</small>
            </div>
          </div>
        </div>

        <div class="row">
          <div class="t-center-col">
            <t-action-panel>
              <b-button slot="left" @click="createIdea" variant="primary">
                {{ $t('idea.create.save.button') }}
              </b-button>
              <b-button slot="right" @click="cancel" variant="outline-primary">
                {{ $t('idea.create.cancel.button') }}
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

  import SubscriptionMixin from '../../mixins/Subscription'
  import { registerConstraints, resetValidation } from '../../util/validation.js'
  import { mapGetters } from 'vuex'

  export default {
    mixins: [
      SubscriptionMixin({
        'skillKeys': 'skill/subscribe'
      })
    ],

    data () {
      return {
        title: '',
        description: '',
        saving: false,
        skillKeys: []
      }
    },

    created () {
      registerConstraints(this, this.constraints())
    },

    methods: {
      ...mapGetters({
        constraints: 'idea/constraints'
      }),

      addSkill (key) {
        if (!this.skillKeys.includes(key)) {
          this.skillKeys.push(key)
        }
      },

      removeSkill (key) {
        this.skillKeys = this.skillKeys.filter(k => k !== key)
      },

      clearForm () {
        this.title = ''
        this.description = ''
        this.skillKeys = []

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
            new IdeaPersistenceData(null, data, this.skillKeys, [])
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

<style lang="scss" scoped>
  @import "../../variables";

  .t-create-idea-form-current-skills-label,
  .t-create-idea-form-current-skills,
  .t-create-idea-form-current-skills-no-skills {
    margin: {
      left: $idea-create-form-offset-x;
      right: $idea-create-form-offset-x;
    }
  }

  .t-create-idea-form-current-skills-label {
    margin: {
      top: $idea-create-form-offset-y;
    }
  }

  .t-create-idea-form-current-skills {
    margin: {
      bottom: $idea-create-form-offset-y;
    }
  }

  .t-create-idea-form-current-skills-no-skills {
    margin: {
      bottom: $idea-create-form-offset-y;
    }
  }
</style>
