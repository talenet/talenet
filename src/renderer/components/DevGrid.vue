<template>
  <div class="t-dev-grid" v-if="showGrid">
    <b-container>
      <b-row>
        <b-col>
          <div class="t-dev-grid-col"></div>
        </b-col>
        <b-col>
          <div class="t-dev-grid-col"></div>
        </b-col>
        <b-col>
          <div class="t-dev-grid-col"></div>
        </b-col>
        <b-col>
          <div class="t-dev-grid-col"></div>
        </b-col>
        <b-col>
          <div class="t-dev-grid-col"></div>
        </b-col>
        <b-col>
          <div class="t-dev-grid-col"></div>
        </b-col>
        <b-col>
          <div class="t-dev-grid-col"></div>
        </b-col>
        <b-col>
          <div class="t-dev-grid-col"></div>
        </b-col>
        <b-col>
          <div class="t-dev-grid-col"></div>
        </b-col>
        <b-col>
          <div class="t-dev-grid-col"></div>
        </b-col>
        <b-col>
          <div class="t-dev-grid-col"></div>
        </b-col>
        <b-col>
          <div class="t-dev-grid-col"></div>
        </b-col>
      </b-row>
    </b-container>
  </div>
</template>

<script>
  import { mapGetters } from 'vuex'

  export default {
    computed: {
      ...mapGetters({
        'showGrid': 'development/showGrid'
      })
    }
  }
</script>

<style lang="scss" scoped>
  @import "../variables";

  .t-dev-grid {
    pointer-events: none;
    opacity: 0.5;
    z-index: $zindex-tooltip + 1;

    position: absolute;
    top: 0;
    bottom: 0;
    left: 0;
    right: 0;

    * {
      height: 100%;
    }

    .col {
      border: 1px solid $tale-yellow;
    }

    .t-dev-grid-col {
      border: 1px solid $tale-green;
    }
  }
</style>
