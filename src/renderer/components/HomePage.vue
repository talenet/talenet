<template>
  <t-center-on-page v-if="mode === 'loading'">
    <t-loading-animation size="xl"></t-loading-animation>
  </t-center-on-page>

  <t-center-on-page v-else-if="mode === 'invite'">
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
  </t-center-on-page>

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

      <div class="t-about-logos-container">
        <div class="t-about-logos">
          <a href="https://prototypefund.de/en/" target="_blank">
            <img class="t-prototype-fund-logo" src="../static/img/PrototypeFund-P-Logo.svg"/>
          </a>
          <a href="https://www.bmbf.de/en/index.html" target="_blank">
            <img class="t-bmbf-logo" src="../static/img/BMBF_gefoerdert_2017_en.jpg"/>
          </a>
        </div>
      </div>
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

  div .t-about-text {
    padding: {
      top: $home-about-text-padding-top;
      bottom: $home-about-text-padding-bottom;
    }
  }

  .t-about-logos-container {
    text-align: center;
    width: 100%;
    margin-top: 50px;

    .t-about-logos {
      display: inline-block;
      padding: 10px;
      background-color: white;

      .t-prototype-fund-logo, .t-bmbf-logo {
        height: 150px;
      }

      .t-prototype-fund-logo {
        margin: {
          left: 50px;
          right: 50px;
        }
      }
    }
  }
</style>
