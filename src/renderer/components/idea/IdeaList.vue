<template>
  <ul class="list-unstyled">
    <li v-for="idea in ideas" :key="idea.key()">
      <b-card :title="idea.title()">
        <span>
          {{idea.description()}}
        </span>
      </b-card>
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
