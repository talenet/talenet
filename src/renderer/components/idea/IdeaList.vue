<template>
  <ul class="list-unstyled">
    <li v-for="key in ideaKeys" :key="key">
      <t-idea-preview :idea="idea(key)"></t-idea-preview>
    </li>
  </ul>
</template>

<script>
  import { mapGetters } from 'vuex'

  export default {
    props: [
      'ideaKeys'
    ],

    computed: {
      ...mapGetters({
        idea: 'idea/get'
      })
    }
  }
</script>
