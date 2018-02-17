<template>
  <div class="row">
    <div class="col-md-7 offset-md-3">
      <b-form @submit="$event.preventDefault()">
        <fieldset :disabled="publishing">
          <b-form-textarea v-model="draftMsg"></b-form-textarea>
          <t-button-panel>
            <t-action-button
              v-if="showSend"
              slot="left"
              ref="sendReply"
              variant="primary"
              @click="sendReply()">
              {{ $t('messages.publish.button') }}
            </t-action-button>
          </t-button-panel>
        </fieldset>
      </b-form>
    </div>
  </div>
</template>

<script>
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
        'draftMsg': ''
      }
    },

    computed: {
      showSend () {
        return this.draftMsg.length !== 0
      }
    },

    methods: {
      sendReply () {
        this.publishing = true
        const data = {
          type: 'post',
          root: this.threadKey,
          branch: this.threadKey, // TODO: should be last replied-to msg
          recps: [this.ownIdentityKey, this.otherIdentityKey],
          text: this.draftMsg
        }
        this.$refs.sendReply.execute(
          this.$store.dispatch('privateMessages/publishReply', data)
        ).then((key) => {
          if (key) {
            this.draftMsg = ''
          }
          return null
        }).catch(console.error).finally(() => {
          this.publishing = false
        })
      }
    }
  }
</script>

<style lang="scss" scoped>

</style>
