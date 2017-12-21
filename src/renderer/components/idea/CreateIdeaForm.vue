<template>
  <div>
    <div class="row">
      <div class="t-wide-col">
        <t-introduction-box messagesKey="idea.create.introduction"></t-introduction-box>
      </div>
    </div>

    <b-form @submit="$event.preventDefault()">
      <fieldset :disabled="saving">
        <div class="row">
          <div class="t-wide-col">
            <t-input-group
              v-model="title"
              name="title"
              :label="$t('idea.create.title.label')"
              :placeholder="$t('idea.create.title.placeholder')"
              :description="$t('idea.create.title.description')"
            ></t-input-group>
          </div>
        </div>

        <t-markdown-input-group
          v-model="description"
          :rows="10"
          name="description"
          :label="$t('idea.create.description.label')"
          :placeholder="$t('idea.create.description.placeholder')"
          :markdown-label="$t('idea.create.description.markdownLabel')"
        ></t-markdown-input-group>

        <div class="row">
          <div class="t-wide-col">
            <t-idea-skill-selector
              @add-skill="addSkill($event)"
              @remove-skill="removeSkill($event)"
              :skill-keys="skillKeys"
            >
            </t-idea-skill-selector>
          </div>
        </div>

        <div class="row">
          <div class="t-wide-col">
            <t-action-panel>
              <t-action-button slot="left" ref="save" @click="createIdea" variant="primary">
                {{ $t('idea.create.save.button') }}
              </t-action-button>
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
        this.$refs.save.reset()
      },

      createIdea () {
        this.saving = true
        this.$refs.save.start()

        let data = {
          title: this.title,
          description: this.description
        }
        this.$validator.validateAll(data).then(valid => {
          if (!valid) {
            this.$refs.save.fail()
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
            this.$refs.save.finish()
            this.$router.push({
              name: 'idea',
              params: { ideaKey }
            })
          }
        }).catch((err) => {
          if (err) {
            console.error(err)
          }
          this.$refs.save.fail()
          this.saving = false
        })
      },

      cancel () {
        this.clearForm()
      }
    }
  }
</script>
