<template>
  <b-form>
    <fieldset :disabled="saving">
      <t-input-group
        v-model="name"
        name="name"
        :label="$t('skill.create.name.label')"
        :placeholder="$t('skill.create.name.placeholder')"
        :description="$t('skill.create.name.description')"
      ></t-input-group>

      <b-button @click="createSkill" variant="primary">{{ $t('skill.create.save.button') }}</b-button>
      <b-button @click="cancel" variant="secondary">{{ $t('skill.create.cancel.button') }}</b-button>
    </fieldset>
  </b-form>
</template>

<script>
  import Skill from '../../models/Skill'
  import { registerConstraints, resetValidation } from '../../util/validation.js'
  import { mapGetters } from 'vuex'

  export default {
    data () {
      return {
        name: '',
        saving: false
      }
    },

    created () {
      registerConstraints(this, this.constraints())
    },
    methods: {
      ...mapGetters({
        constraints: 'skill/constraints'
      }),

      clearForm () {
        this.name = ''
        resetValidation(this)
      },

      createSkill () {
        let data = {
          name: this.name
        }

        this.$validator.validateAll(data).then(valid => {
          if (!valid) {
            return null
          }

          let skill = new Skill(data)

          return this.$store.dispatch(
            'skill/create',
            skill
          )
        }).then((skillKey) => {
          this.saving = false

          if (skillKey) {
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
