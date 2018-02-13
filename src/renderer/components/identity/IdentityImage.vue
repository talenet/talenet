<template>
  <t-hexagon-image
    class="t-identity-image"
    ref="image"
    @click="goToIdentityPage()"
    :href="identityImageUrl">
  </t-hexagon-image>
</template>

<script>
  import Identity from '../../models/Identity'
  import { mapGetters } from 'vuex'

  export default {
    props: {
      identity: {
        type: Identity
      }
    },

    computed: {
      ...mapGetters({
        imageUrl: 'ssb/blobUrl'
      }),

      identityImageUrl () {
        const identity = this.identity
        const getImageUrl = this.imageUrl

        if (!identity) {
          return getImageUrl('&owujXOFvfirC5Kootc7T6uiyclwaME6+lZMqEtV30iw=.sha256')
        }

        return getImageUrl(identity.imageKey())
      }
    },

    methods: {
      update () {
        this.$refs.image.update()
      },

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
