<template>
  <b-card class="t-dev-panel">
    <h4 @click="togglePanel">{{title}}</h4>

    <div v-if="expanded" class="d-flex flex-column">
      <b-button
        variant="outline-danger"
        size="sm"
        @click="toggleDevLocale()">
        {{$t('dev.toggleLocale')}} ({{locale}})
      </b-button>

      <!-- TODO: don't display button when running with --use-global-ssb -->
      <b-button
        variant="outline-danger"
        size="sm"
        @click="toggleSkilliverseDebug()">
        {{$t('dev.skilliverse.debug')}}
      </b-button>

      <b-button
        variant="outline-danger"
        size="sm"
        @click="showElectronDevTools()">
        {{$t('dev.showElectronDevTools')}}
      </b-button>
    </div>
  </b-card>
</template>

<script>
  import { mapGetters, mapActions } from 'vuex'

  export default {
    data () {
      return {
        expanded: true
      }
    },

    computed: {
      ...mapGetters({
        locale: 'page/locale'
      }),

      title () {
        return this.$t('dev.panel.heading') + ' ' + (this.expanded ? '▼' : '▲')
      }
    },

    methods: {
      togglePanel () {
        this.expanded = !this.expanded
      },

      ...mapActions({
        showElectronDevTools: 'development/showElectronDevTools',
        toggleSkilliverseDebug: 'development/toggleSkilliverseDebug'
      }),

      toggleDevLocale () {
        let newLocale
        if (this.locale.startsWith('dev-')) {
          newLocale = this.locale.slice(4)
        } else {
          newLocale = 'dev-' + this.locale
        }

        this.$store.dispatch('page/setLocale', newLocale)
      }
    }
  }
</script>

<style lang="scss" scoped>
  @import "../variables";

  .t-dev-panel {
    position: fixed;
    top: $dev-panel-position-top;
    left: $dev-panel-position-left;

    // Above other fixed objects.
    z-index: $zindex-fixed + 1;

    border: $dev-panel-border;

    button {
      margin-top: $dev-panel-button-gap;
    }

    h4 {
      cursor: pointer;
      font-size: $dev-panel-title-font-size;
    }
  }
</style>
