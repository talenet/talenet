<template>
  <div class="home">
    <h1>{{ $t('home.welcome') }}</h1>

    <t-create-idea-form></t-create-idea-form>
  </div>
</template>

<script>
  import CreateIdeaForm from './idea/CreateIdeaForm.vue'

  export default {
    components: {
      't-create-idea-form': CreateIdeaForm
    }
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
