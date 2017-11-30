<template>
  <b-card>
    <t-hexagon-image :radius="25" :href="imageUrl"></t-hexagon-image>
    <span>{{abouts(identityKey, 'name')}}</span>
  </b-card>
</template>

<script>
  import { mapGetters } from 'vuex'

  export default {
    props: [
      'identityKey'
    ],

    computed: {
      ...mapGetters({
        abouts: 'ssb/abouts'
      }),

      imageUrl () {
        let blob = this.$store.getters['ssb/abouts'](this.identityKey, 'image')
        return this.$store.getters['ssb/blobUrl'](blob)
      }
    }
  }
</script>

<style lang="scss" scoped>
  .card-body {

  }
</style>
