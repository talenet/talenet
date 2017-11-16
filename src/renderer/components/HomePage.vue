<template>
  <div class="home">
    <h1>{{ $t('home.welcome') }}</h1>

    <t-create-idea-form></t-create-idea-form>

    <t-idea-list></t-idea-list>
  </div>
</template>

<script>
  export default {
    components: {}
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
