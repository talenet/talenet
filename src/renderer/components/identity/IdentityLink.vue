<template>
  <span class="t-identity-link" @click="goToIdentityPage()">
    {{identity | tFormatIdentityName(identityKey)}}
  </span>
</template>

<script>
  import Identity from '../../models/Identity'

  export default {
    props: {
      identity: {
        type: Identity
      },

      identityKey: {
        type: String
      }
    },

    methods: {
      goToIdentityPage () {
        if (!this.identity) {
          return
        }

        this.$router.push({
          name: 'identityDetails',
          params: {
            identityKey: this.identity.key()
          }
        })
      }
    }
  }
</script>

<style lang="scss" scoped>
  @import "../../variables";

  .t-identity-link {
    color: $link-color;
    cursor: pointer;

    &:hover {
      text-decoration: underline;
    }
  }
</style>
