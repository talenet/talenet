<template>
  <div>
    <t-message-thread-header
      :ownIdentity="ownIdentity"
      :otherIdentity="otherIdentity">
    </t-message-thread-header>

    <div class="row">
      <t-message-thread-posts-group
        v-for="group in groups"
        :key="group.key"
        :author="group.author"
        :messages="group.messages">
      </t-message-thread-posts-group>
    </div>

    <div class="row">
      <b-form @submit="$event.preventDefault()">
        <fieldset :disabled="publishing">
          <b-form-textarea v-model="draftMsg"></b-form-textarea>
          <t-button-panel>
            <t-action-button v-if="showSend"
              slot="left"
              ref="sendReply"
              variant="primary"
              @click="sendReply()">
              [F] send:reply
            </t-action-button>
          </t-button-panel>
        </fieldset>
      </b-form>
    </div>
  </div>
</template>

<script>
  import SubscriptionMixin from '../../mixins/Subscription'
  import { mapGetters } from 'vuex'

  export default {
    mixins: [
      SubscriptionMixin({
        '!': [
          'identity/subscribeOwnIdentityKey'
        ],
        'ownIdentityKey': 'identity/subscribe',
        'threadKey': 'privateMessages/subscribeByThread'
      })
    ],

    data () {
      return {
        'publishing': false,
        'draftMsg': ''
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
    },

    computed: {
      ...mapGetters({
        'ownIdentityKey': 'identity/ownIdentityKey',
        'ownIdentity': 'identity/own',
        'getIdentity': 'identity/get'
      }),

      showSend () {
        return this.draftMsg.length !== 0
      },

      otherIdentityKey () {
        let author = null
        const me = this.ownIdentityKey
        // only once on mutation?!
        for (const msg of this.messages) {
          if (msg.value.author !== me) {
            author = msg.value.author
            break
          }
        }
        return author
      },

      otherIdentity () {
        return this.getIdentity(this.otherIdentityKey)
      },

      messages () {
        const msgs = this.$store.getters['privateMessages/threadByKey'](this.threadKey)
        return msgs
      },

      threadKey () {
        return this.$route.params.threadKey
      },

      groups () {
        const groups = []
        let group = null
        let author = null
        for (const msg of this.messages) {
          if (msg.value.author !== author) {
            if (group) {
              groups.push(group)
            }
            author = msg.value.author
            group = {
              author: author,
              key: msg.key,
              messages: []
            }
          }
          group.messages.push(msg)
        }
        if (group) {
          groups.push(group)
        }
        return groups
      }
    }
  }
</script>

<style lang="scss" scoped>

</style>
