<template>
  <b-card v-if="visible">
    <p>{{$t(messagesKey + '.text')}}</p>
    <p><em>{{$t(messagesKey + '.callToAction')}}</em></p>

    <b-button variant="success" @click="close()">{{$t('introduction.box.close.button')}}</b-button>
  </b-card>
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
