<template>
  <b-form @submit="$event.preventDefault()">
    <t-input-group
      name="inviteCode"
      v-model="inviteCode"
      :label="$t('invite.code.label')"
      :description="$t('invite.code.description')"
      :placeholder="$t('invite.code.placeholder')"
    ></t-input-group>

    <t-button-panel>
      <b-button slot="left" variant="primary" @click="acceptInvite()">{{joinPubButtonText}}</b-button>
      <b-button slot="right" variant="outline-primary" @click="cancel()">{{cancelButtonText}}</b-button>
    </t-button-panel>
  </b-form>
</template>

<script>
  import { registerConstraints, resetValidation } from '../util/validation.js'
  import { mapGetters } from 'vuex'

  export default {
    created () {
      registerConstraints(this, this.constraints)
    },

    props: {
      joinPubButtonText: {
        type: String,
        required: true
      },
      cancelButtonText: {
        type: String,
        required: true
      }
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
          if (!result) {
            return
          }
          if (result.success) {
            // TODO: Feedback
            this.clear()
            this.$emit('join')
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
        this.$emit('cancel')
      }
    }
  }
</script>
