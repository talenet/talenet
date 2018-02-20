<template>
  <div class="t-message-thread-reply-form row">
    <div class="col-md-7 offset-md-3">
      <b-form @submit="$event.preventDefault()">
        <fieldset :disabled="publishing">
          <t-textarea-group
            v-model="text"
            :rows="3"
            name="text"
            :label="$t('messages.replyToThread.text.label')"
            :placeholder="$t('messages.replyToThread.text.placeholder')"
          ></t-textarea-group>

          <i18n
            :path="'markdown.description'"
            tag="small"
            class="t-message-thread-reply-form-text-description text-muted">
            <a place="markdownLink" href="http://commonmark.org/help/" target="_blank">{{ $t('markdown.link') }}</a>
          </i18n>

          <t-button-panel>
            <t-action-button
              slot="left"
              ref="publish"
              @click="replyToThread"
              variant="primary">
              {{ $t('messages.replyToThread.publish.button') }}
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
      threadKey: {
        type: String,
        required: true
      },

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
        'publishing': false,
        'text': ''
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

      replyToThread () {
        this.publishing = true

        const data = {
          text: this.text
        }
        this.$refs.publish.execute(
          this.$validator.validateAll(data).then(valid => {
            if (!valid) {
              this.$refs.publish.fail()
              return null
            }

            return this.$store.dispatch(
              'privateMessages/publishReply',
              {
                type: 'post',
                root: this.threadKey,
                branch: this.threadKey, // TODO: should be last replied-to msg
                recps: [this.ownIdentityKey, this.otherIdentityKey],
                text: data.text
              }
            )
          })
        ).then((threadKey) => {
          if (threadKey) {
            this.clearForm()
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

  .t-message-thread-reply-form-text-description {
    display: block;
    margin: {
      top: -$message-thread-form-offset-y / 2;
      bottom: $message-thread-form-offset-y;
      left: $message-thread-form-offset-x;
      right: $message-thread-form-offset-x;
    }
  }
</style>
