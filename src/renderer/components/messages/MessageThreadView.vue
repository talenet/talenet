<template>
  <div>
    <t-message-thread-header
      :ownIdentity="ownIdentity"
      :otherIdentity="otherIdentity">
    </t-message-thread-header>

    <div v-if="messages.length > 0" class="row">
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
        'ownIdentityKey': 'identity/subscribe',
        'otherIdentityKey': 'identity/subscribe'
      })
    ],

    props: {
      ownIdentityKey: {
        type: String,
        required: true
      },

      otherIdentityKey: {
        type: String,
        required: true
      },

      messages: {
        type: Array,
        required: true
      }
    },

    computed: {
      ...mapGetters({
        'ownIdentity': 'identity/own',
        'getIdentity': 'identity/get'
      }),

      otherIdentity () {
        return this.getIdentity(this.otherIdentityKey)
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
