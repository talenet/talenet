<template>
  <div :class="classes">
    <div class="t-message-thread-posts-group-message" v-for="message in messages" :key="message.key">
      <span>{{message.timestamp | tFormatTimestamp}}</span>
      <t-markdown-text :text="message.text"></t-markdown-text>
    </div>
  </div>
</template>

<script>
  export default {
    props: {
      author: {
        required: true,
        type: String
      },

      messages: {
        required: true,
        type: Array
      }
    },

    data () {
      return {
        ownIdentityKey: 'alice'
      }
    },

    computed: {
      isOwn () {
        return this.ownIdentityKey === this.author
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
      top: 1.5rem;
      bottom: 1.5rem;
    }

    .t-message-thread-posts-group-message {
      border-bottom: 1px solid $tale-black;
    }
  }
</style>
