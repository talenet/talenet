<template>
  <b-form @submit="$event.preventDefault()">
    <fieldset :disabled="disabled || pending">
      <t-input-group
        name="inviteCode"
        v-model="inviteCode"
        :label="$t('invite.code.label')"
        :description="$t('invite.code.description')"
        :placeholder="$t('invite.code.placeholder')"
      ></t-input-group>

      <a
        v-if="showInviteLink"
        class="t-invite-accept-form-link"
        href="https://alles:allen@pub.t4l3.net/invited"
        target="_blank">
        {{ $t('invite.code.link') }}
      </a>

      <t-button-panel>
        <t-action-button
          slot="left"
          ref="accept"
          variant="primary"
          @click="acceptInvite()">
          {{joinPubButtonText}}
        </t-action-button>
        <b-button
          slot="right"
          variant="outline-primary"
          @click="cancel()">
          {{cancelButtonText}}
        </b-button>
      </t-button-panel>
    </fieldset>
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
      },
      showInviteLink: {
        type: Boolean,
        default: false
      }
    },

    data () {
      return {
        inviteCode: '',
        disabled: false,
        pending: false
      }
    },

    computed: {
      ...mapGetters({
        'constraints': 'ssb/inviteConstraints'
      })
    },

    methods: {
      enable () {
        this.disabled = false
      },

      disable () {
        this.disabled = true
      },

      setInviteCode (invite) {
        this.inviteCode = invite
      },

      clear () {
        this.inviteCode = ''
        resetValidation(this)
        this.$refs.accept.reset()
      },

      acceptInvite () {
        this.pending = true
        const data = {
          inviteCode: this.inviteCode
        }
        this.$refs.accept.execute(
          this.$validator.validateAll(data).then(valid => {
            if (!valid) {
              this.$refs.accept.fail()
              return null
            }

            return this.$store.dispatch(
              'ssb/acceptInvite',
              this.inviteCode
            )
          }).then(result => {
            if (!result) {
              return null
            }

            if (!result.success) {
              this.$refs.accept.fail()
              this.$validator.errors.add({
                field: 'inviteCode',
                msg: this.$t('invite.error.notAccepted')
              })
              return null
            }

            return result
          })
        ).then(result => {
          if (result && result.success) {
            this.clear()
            this.$emit('join')
          }
        }).catch((err) => {
          console.error(err)
        }).finally(() => {
          this.pending = false
        })
      },

      cancel () {
        this.clear()
        this.$emit('cancel')
      }
    }
  }
</script>

<style lang="scss" scoped>
  @import "../variables";

  .t-invite-accept-form-link {
    display: block;
    position: relative;
    margin: {
      top: -$invite-accept-form-link-offset-y;
      bottom: $invite-accept-form-link-offset-y;
      left: $invite-accept-form-link-offset-x;
      right: $invite-accept-form-link-offset-x;
    }
  }
</style>
