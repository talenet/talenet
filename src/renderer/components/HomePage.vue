<template>
  <div v-if="mode === 'loading'" class="t-center-vertical">
    <t-loading-animation></t-loading-animation>
  </div>

  <div v-else-if="mode === 'invite'" class="t-center-vertical">
    <div class="container">
      <div class="row">
        <div class="t-center-col">
          <t-text-box>
            {{$t('home.invite.text')}}
          </t-text-box>
        </div>
      </div>

      <div class="row">
        <div class="t-center-col">
          <t-invite-accept-form
            :join-pub-button-text="$t('home.invite.form.joinPub.button')"
            @join="showAbout()"
            :cancel-button-text="$t('home.invite.form.cancel.button')"
            @cancel="showAbout()"
          ></t-invite-accept-form>
        </div>
      </div>
    </div>
  </div>

  <div v-else class="container">
    <div class="row">
      <t-text-box class="t-center-col t-about-text">
        <div>
          <p>{{ $t('home.about.welcome') }}</p>
        </div>
        <div>
          <p v-for="paragraph in $t('home.about.text')" :key="paragraph">
            {{paragraph}}
          </p>
        </div>

        <t-button-panel>
          <b-button slot="left" variant="primary" @click="editIdentity()">{{$t('home.about.editIdentity.button')}}</b-button>
          <a slot="right" href="https://blog.t4l3.net" target="_blank">{{$t('home.about.goToBlog.button')}}</a>
        </t-button-panel>
      </t-text-box>
    </div>
  </div>
</template>

<script>
  export default {
    data () {
      return {
        'mode': 'loading'
      }
    },

    mounted () {
      // TODO: Decide on mode
      this.mode = 'invite'
    },

    computed: {},

    methods: {
      showAbout () {
        this.mode = 'about'
      },

      editIdentity () {
        this.$router.push({
          name: 'identityEdit'
        })
      }
    }
  }
</script>

<style lang="scss" scoped>
  @import "../variables";

  div.t-about-text {
    padding: {
      top: $home-about-text-padding-top;
      bottom: $home-about-text-padding-bottom;
    }
  }
</style>
