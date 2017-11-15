<template>
  <span v-html="renderedText"></span>
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
