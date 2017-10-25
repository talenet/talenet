<template>
  <div class="home">
    <h1>{{ $t('home.welcome') }}</h1>

    <create-idea-form></create-idea-form>
  </div>
</template>

<script>
  import CreateIdeaForm from './idea/CreateIdeaForm.vue'

  export default {
    components: { CreateIdeaForm }
  }
</script>

<style scoped lang="scss">
  $fw: bold; // Simple example to demonstrate SCSS is working.

  .home {
    h1 {
      font-weight: $fw;
    }
  }
</style>
