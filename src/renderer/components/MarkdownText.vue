<template>
  <span v-html="renderedText" :class="classes"></span>
</template>

<script>
  import renderMarkdown from '../util/markdown'

  export default {
    props: {
      'text': {
        type: String,
        required: false
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

    overflow-x: hidden;
    word-wrap: break-word;

    h1 {
      font-size: $markdown-h1-font-size;
    }

    h2 {
      font-size: $markdown-h2-font-size;
    }

    h3 {
      font-size: $markdown-h3-font-size;
    }

    h4 {
      font-size: $markdown-h4-font-size;
    }

    h5 {
      font-size: $markdown-h5-font-size;
    }

    h6 {
      font-size: $markdown-h6-font-size;
    }

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
