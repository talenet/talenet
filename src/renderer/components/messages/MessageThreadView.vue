<template>
  <div>
    <t-message-thread-header
      :ownIdentity="ownIdentity"
      :otherIdentity="otherIdentity">
    </t-message-thread-header>

    <transition appear name="fade" mode="out-in" @enter="scrollToNewest()">
      <transition-group
        v-if="messages.length > 0"
        class="row"
        tag="div"
        name="fade-height"
        mode="out-in">
        <t-message-thread-posts-group
          v-for="group in groups"
          :key="group.key"
          :author="group.author"
          :messages="group.messages">
        </t-message-thread-posts-group>
      </transition-group>
    </transition>
  </div>
</template>

<script>
  import SubscriptionMixin from '../../mixins/Subscription'
  import { scrollToBottom } from '../../util/page'
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

      otherIdentityKeys: {
        type: Array,
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

      otherIdentityKey () {
        if (this.otherIdentityKeys.length === 0) {
          console.error('need at least one otherIdentityKey')
          return
        }
        return this.otherIdentityKeys[0]
      },

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
    },

    methods: {
      scrollToNewest () {
        scrollToBottom(document.getElementById('t-scroll-view'))
      }
    }
  }
</script>

<style lang="scss" scoped>

</style>
