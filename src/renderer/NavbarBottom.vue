<template>
  <b-navbar fixed="bottom" toggleable="sm" type="dark" variant="dark">
    <b-nav-toggle target="t-navbar-bottom-collapse"></b-nav-toggle>

    <b-collapse is-nav id="t-navbar-bottom-collapse" class="justify-content-center">
      <b-nav is-nav-bar>
        <b-nav-item to="/ideas/associated">{{$t('navbar.associatedIdeas')}}</b-nav-item>
        <b-nav-item to="/messages">{{$t('navbar.messages')}}</b-nav-item>
        <b-button class="mx-2 my-2 my-sm-0" variant="success">\o/<!-- identity --></b-button>
        <b-nav-item to="/skills/define">{{$t('navbar.defineSkills')}}</b-nav-item>
        <b-nav-item to="/settings">{{$t('navbar.settings')}}</b-nav-item>
      </b-nav>
    </b-collapse>
  </b-navbar>
</template>

<script>
  export default {}
</script>

<style lang="scss" scoped>
  @import "variables";

  .navbar {
    border-top: $navbar-border-width solid $navbar-border-color;
  }
</style>
