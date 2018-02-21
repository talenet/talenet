<template>
  <t-center-on-page v-if="searching">
    <t-loading-animation size="xl"></t-loading-animation>
  </t-center-on-page>
</template>

<script>
  import { navigateToSearchResult } from '../../util/search'

  export default {
    data () {
      return {
        searching: true
      }
    },

    mounted () {
      this.$store.dispatch('search/find', this.$route.params.term)
        .then(result => {
          if (result.found && navigateToSearchResult(this.$router, result.found)) {
            return
          }

          // TODO: Display error

          this.$router.push({
            name: 'home'
          })
        })
        .catch(err => {
          if (err) {
            console.error(err)
          }
          this.$router.push({
            name: 'home'
          })
        })
    }
  }
</script>

<style lang="scss" scoped>

</style>
