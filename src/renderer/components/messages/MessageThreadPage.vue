<template>
  <div>
    <t-message-thread-header
      :ownIdentity="ownIdentity"
      :otherIdentity="ownIdentity">
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
        'ownIdentityKey': 'identity/subscribe'
      })
    ],

    data () {
      return {
        messages: [
          {
            key: '1',
            author: 'alice',
            text: 'ohai',
            timestamp: 1518700446
          },
          {
            key: '2',
            author: 'alice',
            text: 'i can has test?',
            timestamp: 1518700447
          },
          {
            key: '3',
            author: 'bob',
            text: 'ohai alice',
            timestamp: 1518700448
          },
          {
            key: '4',
            author: 'alice',
            text: '# this\n## is\n### markdown',
            timestamp: 1518700449
          }
        ]
      }
    },

    computed: {
      ...mapGetters({
        'ownIdentityKey': 'identity/ownIdentityKey',
        'ownIdentity': 'identity/own'
      }),

      groups () {
        const groups = []

        let group = null
        let author = null
        for (const post of this.messages) {
          if (post.author !== author) {
            if (group) {
              groups.push(group)
            }

            author = post.author
            group = {
              author: author,
              key: post.key,
              messages: []
            }
          }

          group.messages.push(post)
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
