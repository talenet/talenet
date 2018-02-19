<template>
  <div class="t-message-start-thread-form row">
    <div class="col-md-7 offset-md-3">
      <b-form @submit="$event.preventDefault()">
        <fieldset :disabled="publishing">
          <t-textarea-group
            v-model="text"
            :rows="3"
            name="text"
            :label="$t('messages.startThread.text.label')"
            :placeholder="$t('messages.startThread.text.placeholder')"
          ></t-textarea-group>

          <i18n
            :path="'markdown.description'"
            tag="small"
            class="t-message-start-thread-form-text-description text-muted">
            <a place="markdownLink" href="http://commonmark.org/help/" target="_blank">{{ $t('markdown.link') }}</a>
          </i18n>

          <t-button-panel>
            <t-action-button
              slot="left"
              ref="publish"
              @click="startThread"
              variant="primary">
              {{ $t('messages.startThread.publish.button') }}
            </t-action-button>
          </t-button-panel>
        </fieldset>
      </b-form>
    </div>
  </div>
</template>

<script>
  import { registerConstraints, resetValidation } from '../../util/validation.js'
  import { mapGetters } from 'vuex'

  export default {
    props: {
      ownIdentityKey: {
        type: String,
        required: true
      },

      otherIdentityKey: {
        type: String,
        required: true
      }
    },

    data () {
      return {
        publishing: false,
        text: ''
      }
    },

    created () {
      registerConstraints(this, this.constraints)
    },

    computed: {
      ...mapGetters({
        constraints: 'privateMessages/constraints'
      })
    },

    methods: {
      clearForm () {
        this.text = ''
        resetValidation(this)
        this.$refs.publish.reset()
      },

      startThread () {
        this.publishing = true

        let data = {
          text: this.text
        }
        this.$refs.publish.execute(
          this.$validator.validateAll(data).then(valid => {
            if (!valid) {
              this.$refs.publish.fail()
              return null
            }

            return this.$store.dispatch(
              'privateMessages/startThread',
              {
                recipients: [
                  this.ownIdentityKey,
                  this.otherIdentityKey
                ],
                text: data.text
              }
            )
          })
        ).then((threadKey) => {
          if (threadKey) {
            this.clearForm()

            this.$router.replace({
              name: 'messageThread',
              params: {
                threadKey
              }
            })
          }

          return null
        }).catch((err) => {
          if (err) {
            console.error(err)
          }
        }).finally(() => {
          this.publishing = false
        })
      }
    }
  }
</script>

<style lang="scss" scoped>
  @import "../../variables";

  .t-message-start-thread-form-text-description {
    display: block;
    margin: {
      top: -$idea-comment-form-offset-y / 2;
      bottom: $idea-comment-form-offset-y;
      left: $idea-comment-form-offset-x;
      right: $idea-comment-form-offset-x;
    }
  }
</style>
