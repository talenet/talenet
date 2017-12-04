<template>
  <t-loading-animation v-if="!idea"></t-loading-animation>
  <b-card v-else :title="idea.title()" @click="goToIdea">
    <t-markdown-text :text="idea.description()"></t-markdown-text>
  </b-card>
</template>

<script>
  export default {
    props: [
      'idea'
    ],

    methods: {
      goToIdea () {
        this.$router.push({
          name: 'idea',
          params: {
            ideaKey: this.idea.key()
          }
        })
      }
    }
  }
</script>

<style lang="scss" scoped>
  @import "../../variables";

  .card {
    cursor: pointer;

    margin: {
      top: $card-deck-margin;
      bottom: $card-deck-margin;
    }

    &:hover {
      background-color: darken($card-bg, 5%);
    }
  }
</style>
