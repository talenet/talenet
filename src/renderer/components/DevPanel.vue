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

      <div class="t-dev-panel-group d-flex flex-column">
        <!-- TODO: don't display button when running with --use-global-ssb -->
        <b-button
          variant="outline-danger"
          size="sm"
          @click="toggleSkilliverseDebug('showClickAreas')">
          {{$t('dev.skilliverse.debug.showClickAreas')}}
        </b-button>

        <b-button
          variant="outline-danger"
          size="sm"
          @click="toggleSkilliverseDebug('showResumeSimulationButton')">
          {{$t('dev.skilliverse.debug.showResumeSimulationButton')}}
        </b-button>

        <b-button
          variant="outline-danger"
          size="sm"
          @click="toggleSkilliverseDebug('showVotes')">
          {{$t('dev.skilliverse.debug.showVotes')}}
        </b-button>
      </div>

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
        expanded: false
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

<style lang="scss">
  @import "../variables";

  .t-dev-panel {
    position: fixed;
    top: $dev-panel-position-top;
    left: $dev-panel-position-left;

    // Above other fixed objects.
    z-index: $zindex-fixed + 1;

    user-select: none;

    border: $dev-panel-border;

    button {
      margin-top: $dev-panel-button-gap;
    }

    h4 {
      cursor: pointer;
      font-size: $dev-panel-title-font-size;
    }

    .t-dev-panel-group {
      margin: {
        top: $dev-panel-group-margin-y;
        bottom: $dev-panel-group-margin-y;
      }
    }
  }
</style>
