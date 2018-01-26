<template>
  <div class="t-history-button">
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

    methods: {
      navigate () {
        window.history[this.direction]()
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
