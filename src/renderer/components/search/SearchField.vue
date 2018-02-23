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
  import { toSearchResultRoute } from '../../util/search'
  import SearchError from '../../models/SearchError'
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
        const $t = this.$t
        const error = this.error

        if (error) {
          if (error.render) {
            return error.render($t)
          } else {
            return new SearchError(error).render($t)
          }
        }

        return false
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
            this.term = ''
            const route = toSearchResultRoute(result)
            if (route) {
              this.$router.push(route)
            }
          })
          .catch(err => {
            if (err) {
              console.error(err)
            }

            this.error = err
          })
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
