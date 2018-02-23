<template>
  <t-center-on-page v-if="searching">
    <t-loading-animation size="xl"></t-loading-animation>
  </t-center-on-page>
</template>

<script>
  import { toSearchResultRoute, toErrorMessage } from '../../util/search'

  export default {
    data () {
      return {
        searching: true
      }
    },

    mounted () {
      this.$store.dispatch('search/find', this.$route.params.term)
        .then(result => {
          if (result.found) {
            const route = toSearchResultRoute(result.found)
            if (route) {
              return this.$router.replace(route)
            }
          }

          this.goBackWithError(result.error)
        })
        .catch(err => {
          if (err) {
            console.error(err)
          }

          this.goBackWithError(err)
        })
    },

    methods: {
      goBackWithError (error) {
        const message = toErrorMessage(this.$t, error)
        if (message) {
          this.$store.commit('error', { message })
        }

        if (this.$router.isHistoryNavigationPossible('back')) {
          this.$router.back()
        } else {
          this.$router.push({
            name: 'home'
          })
        }
      }
    }
  }
</script>

<style lang="scss" scoped>

</style>
