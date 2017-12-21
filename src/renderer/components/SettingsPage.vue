<template>
  <div class="t-settings">
    <div class="row">
      <div class="t-center-col">
        <t-introduction-box messagesKey="settings.introduction"></t-introduction-box>
      </div>
    </div>

    <div class="row">
      <div class="t-center-col">
        <t-invite-accept-form
          :join-pub-button-text="$t('settings.invite.form.joinPub.button')"
          :cancel-button-text="$t('settings.invite.form.cancel.button')"></t-invite-accept-form>

        <t-action-panel :text="$t('settings.introductions.text')">
          <t-action-button
            slot="left"
            variant="primary"
            action="settings/resetIntroductions">
            {{$t('settings.introductions.reset.button')}}
          </t-action-button>
        </t-action-panel>
        <t-action-panel :text="$t('settings.landingPage.invite.text')">
          <t-action-button
            slot="left"
            variant="primary"
            action="settings/resetLandingPageInvite">
            {{$t('settings.landingPage.invite.reset.button')}}
          </t-action-button>
        </t-action-panel>
        <t-action-panel :text="$t('settings.devMode.text')">
          <b-button
            v-if="!isDevMode"
            slot="left"
            variant="outline-danger"
            @click="setDevMode(true)">
            {{$t('settings.devMode.enable.button')}}
          </b-button>
          <b-button
            v-if="isDevMode"
            slot="left"
            variant="outline-danger"
            @click="setDevMode(false)">
            {{$t('settings.devMode.disable.button')}}
          </b-button>
        </t-action-panel>
      </div>
    </div>

    <t-34c3-box></t-34c3-box>
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
        'setDevMode': 'settings/setDevMode'
      })
    }
  }
</script>

<style lang="scss" scoped>
  .t-settings {
    .t-action-panel {
      margin: {
        top: 3rem;
        bottom: 3rem;
      }
    }
  }
</style>
