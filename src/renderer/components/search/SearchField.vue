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

        if (!error) {
          return false
        }

        const baseKey = 'search.error.'
        const messageKey = baseKey + error.type

        if (error.value !== undefined) {
          return $t(messageKey, [error.value])
        } else {
          return $t(messageKey)
        }
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

        switch (result.type) {
          case 'idea':
            return this.goTo('idea', { ideaKey: result.key })

          case 'identity':
            return this.goTo('identityDetails', { identityKey: result.key })

          case 'privateMessage':
            return this.goTo('messageThread', { threadKey: result.key })
        }

        console.warn('Invalid state. Search result not handled:', result)
      },

      handleErrorResult (result) {
        this.error = result
      },

      goTo (name, params) {
        this.$router.push({
          name,
          params
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
