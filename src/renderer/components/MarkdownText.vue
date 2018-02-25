<template>
  <span v-html="renderedText" :class="classes"></span>
</template>

<script>
  import renderMarkdown from '../util/markdown'

  export default {
    props: {
      text: {
        type: String,
        required: false
      },

      headingsSameSize: {
        type: Boolean,
        default: false
      },

      textOnly: {
        type: Boolean,
        default: false
      }
    },

    computed: {
      renderedText () {
        return renderMarkdown(this.text)
      },

      classes () {
        return {
          't-markdown-text': true,
          't-markdown-text-headings-same-size': this.headingsSameSize,
          't-markdown-text-text-only': this.textOnly
        }
      }
    }
  }
</script>

<style lang="scss">
  // Scoping doesn't seem to work here. Enabling it prevents restyling of h1, ..., h6 somehow.
  @import "../variables";
  @import "../mixins";

  .t-markdown-text {
    @include body-copy-styling;

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

    &.t-markdown-text-text-only {
      * {
        display: inline;
        vertical-align: bottom;

        overflow: hidden;
        text-overflow: ellipsis;
        text-align: left;
        text-decoration: none;

        font-size: $font-size-markdown;
        font-weight: initial;
        font-style: normal;

        line-height: 2;
        color: $tale-white;
        background-color: initial;
        border: none;

        list-style: none;
        padding: 0;
        margin: 0;
      }

      img, hr {
        display: none;
      }
    }

    pre {
      background-color: $markdown-code-bg;
    }

    code {
      background-color: $markdown-code-bg;
      color: $markdown-code-color;
    }

    ul, ol {
      // fixes weird floating around identity image on identity details
      display: inline-block;
    }
  }
</style>
