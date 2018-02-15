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

    computed: {
      ...mapGetters({
        'ownIdentityKey': 'identity/ownIdentityKey',
        'ownIdentity': 'identity/own',
        'getIdentity': 'identity/get'
      }),

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
