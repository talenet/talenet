<template>
  <div>
    <b-button
      variant="success"
      @click="resetIntroductions()">
      {{$t('settings.introductions.reset.button')}}
    </b-button>
    <b-button
      v-if="!isDevMode"
      variant="warn"
      @click="setDevMode(true)">
      {{$t('settings.devMode.enable.button')}}
    </b-button>
    <b-button
      v-if="isDevMode"
      variant="warn"
      @click="setDevMode(false)">
      {{$t('settings.devMode.disable.button')}}
    </b-button>
  </div>
</template>

<script>
  import { mapActions, mapGetters } from 'vuex'

  export default {
    computed: {
      ...mapGetters({
        'isDevMode': 'settings/isDevMode'
      })
    },

    methods: {
      ...mapActions({
        'resetIntroductions': 'settings/resetIntroductions',
        'setDevMode': 'settings/setDevMode'
      })
    }
  }
</script>
