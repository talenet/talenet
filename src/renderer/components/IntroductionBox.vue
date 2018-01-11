<template>
  <div v-if="visible" class="t-introduction-box clearfix">
    <template v-if="$slots.default">
      <slot></slot>
    </template>
    <template v-else>
      <p>{{$t(messagesKey + '.text')}}</p>
      <p><em>{{$t(messagesKey + '.callToAction')}}</em></p>
    </template>

    <b-button variant="primary" size="sm" class="float-right" @click="close()">{{$t('introduction.box.close.button')}}</b-button>
  </div>
</template>

<script>
  export default {
    props: {
      'messagesKey': {
        type: String,
        required: true
      }
    },

    computed: {
      visible () {
        return !this.$store.getters['settings/isIntroductionRead'](this.messagesKey)
      }
    },

    methods: {
      close () {
        this.$store.dispatch('settings/markIntroductionAsRead', this.messagesKey)
      }
    }
  }
</script>

<style lang="scss" scoped>
  @import "../variables";

  .t-introduction-box {
    position: relative;
    border: $introduction-box-border;

    margin: {
      top: $introduction-box-margin-top;
      bottom: $introduction-box-margin-bottom;
    }
    padding: {
      top: $introduction-box-padding-top;
      bottom: $introduction-box-padding-bottom;
      left: $introduction-box-padding-left;
      right: $introduction-box-padding-right;
    }

    background-color: $introduction-box-bg;
  }
</style>
