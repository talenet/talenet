<template>
  <div v-if="visible" class="t-history-button">
    <t-hexagon-button
      @click="navigate()"
      :icon="'history-' + direction">
    </t-hexagon-button>
  </div>
</template>

<script>
  export default {
    props: {
      direction: {
        type: String,
        required: true
      }
    },

    computed: {
      visible () {
        return this.$router.isHistoryNavigationPossible(this.direction)
      }
    },

    methods: {
      navigate () {
        this.$router[this.direction]()
      }
    }
  }
</script>

<style lang="scss">
  @import "../variables";

  div.t-history-button {
    .t-hexagon-button {
      width: $history-button-size;
    }
  }
</style>
