<template>
  <span v-html="renderedText" class="t-markdown-text"></span>
</template>

<script>
  import renderMarkdown from '../util/markdown'

  export default {
    props: [
      'text'
    ],

    computed: {
      renderedText () {
        return renderMarkdown(this.text)
      }
    }
  }
</script>

<style lang="scss" scoped>
  @import "../variables";

  .t-markdown-text {
    font-family: $font-family-markdown;
    font-size: $font-size-markdown;

  }
</style>
