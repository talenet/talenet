<template>
  <ul class="list-unstyled">
    <li v-for="idea in ideas" :key="idea.key()">
      <t-idea-preview :idea="idea"></t-idea-preview>
    </li>
  </ul>
</template>

<script>
  import { mapGetters } from 'vuex'

  export default {
    computed: {
      ...mapGetters({
        ideas: 'idea/all'
      })
    }
  }
</script>
