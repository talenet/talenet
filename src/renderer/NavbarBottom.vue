<template>
  <b-navbar fixed="bottom" toggleable="sm" type="dark" variant="dark">
    <b-nav-toggle target="t-navbar-bottom-collapse"></b-nav-toggle>

    <b-collapse is-nav id="t-navbar-bottom-collapse" class="justify-content-center">
      <b-nav is-nav-bar>
        <b-nav-item to="/ideas/associated">{{$t('navbar.associatedIdeas')}}</b-nav-item>
        <b-nav-item to="/messages">{{$t('navbar.messages')}}</b-nav-item>
        <div class="t-identity-image">
          <t-hexagon-image :radius="50" :href="imageUrl"></t-hexagon-image>
        </div>
        <b-nav-item to="/skills/define">{{$t('navbar.defineSkills')}}</b-nav-item>
        <b-nav-item to="/settings">{{$t('navbar.settings')}}</b-nav-item>
      </b-nav>
    </b-collapse>
  </b-navbar>
</template>

<script>
  export default {
    computed: {
      imageUrl () {
        let blob = this.$store.getters['ssb/abouts'](this.$store.state.ssb.id, 'image')
        return this.$store.getters['ssb/blobUrl'](blob)
      }
    }
  }
</script>

<style lang="scss" scoped>
  @import "variables";

  .navbar {
    border-top: $navbar-border-width solid $navbar-border-color;
  }

  .t-identity-image {
    // For now locally defined as we need to specify the radius also as a prop
    // of the component. How can we resolve this to only define it once?
    $identity-image-radius: 50px;

    position: absolute;
    top: 0;
    left: 50%;
    margin-left: -$identity-image-radius;
    margin-top: -$identity-image-radius;
  }
</style>
