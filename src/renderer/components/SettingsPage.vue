<template>
  <b-button variant="success" @click="resetIntroductions()">{{$t('settings.introductions.reset.button')}}</b-button>
</template>

<script>
  import { mapActions } from 'vuex'

  export default {
    methods: {
      ...mapActions({
        'resetIntroductions': 'settings/resetIntroductions'
      })
    }
  }
</script>
