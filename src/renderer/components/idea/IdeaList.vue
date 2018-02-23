<template>
  <transition appear name="fade" mode="out-in">
    <ul v-if="ideaKeys && ideaKeys.length" class="list-unstyled">
      <li v-for="key in ideaKeys" :key="key">
        <t-idea-preview :idea="idea(key)" :timestamp="timestamp" :route="route"></t-idea-preview>
      </li>
    </ul>
    <span v-else class="t-idea-list-no-ideas text-muted">{{noIdeasText}}</span>
  </transition>
</template>

<script>
  import { mapGetters } from 'vuex'

  export default {
    props: {
      'ideaKeys': {
        type: Array,
        required: true
      },
      'noIdeasText': {
        type: String,
        required: true
      },
      'timestamp': {
        type: String,
        required: true
      },
      'route': {
        type: String,
        required: true
      }
    },

    computed: {
      ...mapGetters({
        idea: 'idea/get'
      })
    }
  }
</script>

<style lang="scss" scoped>
  @import "../../variables";

  .t-idea-list-no-ideas {
    display: block;

    margin: {
      left: $idea-list-text-margin-x;
      right: $idea-list-text-margin-x;
    };
  }
</style>
