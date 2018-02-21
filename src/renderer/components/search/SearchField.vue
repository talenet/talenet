<template>
  <div :id="id" :class="classes">
    <input
      :id="inputId"
      type="text"
      ref="input"
      :placeholder="$t('navbar.search')"
      v-model="term"
      @focus="onFocus()"
      @keyup.enter="onEnter()">

    <b-tooltip
      :container="id"
      :target="inputId"
      :show="!!errorMessage"
      :triggers="[]"
      placement="bottom">
      {{errorMessage}}
    </b-tooltip>
  </div>
</template>

<script>
  import { toErrorMessage, navigateToSearchResult } from '../../util/search'
  import _ from 'lodash'

  export default {
    data () {
      return {
        term: '',
        error: null
      }
    },

    computed: {
      classes () {
        return {
          't-search-field': true,
          'has-error': !!this.error
        }
      },

      id () {
        return 't-search-field-' + this._uid
      },

      inputId () {
        return 't-search-field-input-' + this._uid
      },

      errorMessage () {
        return toErrorMessage(this.$t, this.error)
      }
    },

    methods: {
      onFocus () {
        this.error = null
      },

      onEnter () {
        this.$refs.input.blur()

        const term = this.term.trim()
        if (_.isEmpty(term)) {
          return
        }

        this.$store.dispatch('search/find', term)
          .then(result => {
            console.log(result)

            if (result.found) {
              return this.handleFoundResult(result.found)
            } else if (result.error) {
              return this.handleErrorResult(result.error)
            }
          })
          .catch(err => {
            if (err) {
              console.error(err)
            }
          })
      },

      handleFoundResult (result) {
        this.term = ''
        navigateToSearchResult(this.$router, result)
      },

      handleErrorResult (result) {
        this.error = result
      }
    }
  }
</script>

<style lang="scss">
  @import "../../variables";

  .t-search-field {
    height: 100%;
    width: 100%;

    input {
      background-color: $input-bg;
      color: $input-color;

      &, &:focus {
        outline: none;
      }
    }

    &.has-error input {
      color: $tale-red;
    }

    .tooltip {
      opacity: 1;

      .arrow::before {
        // bottom: 1px;
        border-bottom-color: $tale-red;
        // box-shadow: 0 0 1px $tale-red;
      }

      .tooltip-inner {
        color: $tale-red;
        background-color: $tale-dark-grey;
        border: 1px solid $tale-red;
      }
    }
  }
</style>
