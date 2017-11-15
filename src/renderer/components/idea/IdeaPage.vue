<template>
  <t-idea-detail-view :ideaKey="$route.params.ideaKey"></t-idea-detail-view>
</template>

<script>
  import IdeaDetailView from './IdeaDetailView.vue'

  export default {
    components: {
      't-idea-detail-view': IdeaDetailView
    }
  }
</script>
