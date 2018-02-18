<template>
  <div :class="classes">
    <div class="t-message-thread-posts-group-message" v-for="msg in messages" :key="msg.key">
      <span>{{msg.value.timestamp | tFormatTimestamp}}</span>
      <t-markdown-text :text="msg.value.content.text"></t-markdown-text>
    </div>
  </div>
</template>

<script>
  import SubscriptionMixin from '../../mixins/Subscription'
  import { mapGetters } from 'vuex'

  export default {
    props: {
      messages: {
        required: true,
        type: Array
      }
    },

    mixins: [
      SubscriptionMixin({
        '!': [ 'identity/subscribeOwnIdentityKey' ]
      })
    ],

    computed: {
      ...mapGetters({
        'ownIdentityKey': 'identity/ownIdentityKey'
      }),

      isOwn () {
        return this.ownIdentityKey === this.messages[0].value.author
      },

      classes () {
        return {
          't-message-thread-posts-group': true,
          'col-md-7': true,
          'offset-md-3': this.isOwn,
          'offset-md-2': !this.isOwn
        }
      }
    }
  }
</script>

<style lang="scss" scoped>
  @import "../../variables";

  .t-message-thread-posts-group {
    background-color: $tale-dark-grey;

    margin: {
      bottom: 1.5rem;
    }

    .t-message-thread-posts-group-message {
      border-bottom: 1px solid $tale-black;
    }
  }
</style>
