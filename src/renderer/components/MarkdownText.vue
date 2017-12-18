<template>
  <span v-html="renderedText" :class="classes"></span>
</template>

<script>
  import renderMarkdown from '../util/markdown'

  export default {
    props: {
      'text': {
        type: String,
        required: true
      },
      'headingsSameSize': {
        type: Boolean,
        default: false
      }
    },

    computed: {
      renderedText () {
        return renderMarkdown(this.text)
      },

      classes () {
        const classes = ['t-markdown-text']
        if (this.headingsSameSize) {
          classes.push('t-markdown-text-headings-same-size')
        }
        return classes
      }
    }
  }
</script>

<style lang="scss">
  // Scoping doesn't seem to work here. Enabling it prevents restyling of h1, ..., h6 somehow.
  @import "../variables";

  .t-markdown-text {
    font-family: $font-family-markdown;
    font-size: $font-size-markdown;

    &.t-markdown-text-headings-same-size {
      @for $i from 1 through 6 {
        h#{$i} {
          font-size: $font-size-markdown;
          font-weight: bold;
        }
      }
    }
  }
</style>
