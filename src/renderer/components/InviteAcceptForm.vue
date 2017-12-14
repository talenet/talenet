<template>
  <b-form @submit="$event.preventDefault()">
    <t-input-group
      name="inviteCode"
      v-model="inviteCode"
      :label="$t('invite.code.label')"
      :description="$t('invite.code.description')"
      :placeholder="$t('invite.code.placeholder')"
    ></t-input-group>

    <b-button variant="success" @click="acceptInvite()">{{$t('invite.accept.button')}}</b-button>
    <b-button variant="secondary" @click="cancel()">{{$t('invite.cancel.button')}}</b-button>
  </b-form>
</template>

<script>
  import { registerConstraints, resetValidation } from '../util/validation.js'
  import { mapGetters } from 'vuex'

  export default {
    created () {
      registerConstraints(this, this.constraints)
    },

    data () {
      return {
        inviteCode: ''
      }
    },

    computed: {
      ...mapGetters({
        'constraints': 'ssb/inviteConstraints'
      })
    },

    methods: {
      clear () {
        this.inviteCode = ''
        resetValidation(this)
      },

      acceptInvite () {
        const data = {
          inviteCode: this.inviteCode
        }
        Promise.resolve(this.$validator.validateAll(data)).then(valid => {
          if (!valid) {
            return null
          }

          return this.$store.dispatch(
            'ssb/acceptInvite',
            this.inviteCode
          )
        }).then(result => {
          if (result.success) {
            // TODO: Feedback
            this.clear()
          } else {
            this.$validator.errors.add({
              field: 'inviteCode',
              msg: this.$t('invite.error.notAccepted')
            })
          }
        }).catch((err) => {
          console.error(err)
        })
      },

      cancel () {
        this.clear()
      }
    }
  }
</script>
