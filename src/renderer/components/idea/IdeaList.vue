<template>
  <ul class="list-unstyled">
    <li v-for="key in ideaKeys" :key="key">
      <t-idea-preview :idea="idea(key)" :timestamp="timestamp" :route="route"></t-idea-preview>
    </li>
  </ul>
</template>

<script>
  import { mapGetters } from 'vuex'

  export default {
    props: {
      'ideaKeys': {
        type: Array,
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
