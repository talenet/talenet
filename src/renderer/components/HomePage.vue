<template>
  <t-center-on-page v-if="mode === 'loading'">
    <t-loading-animation size="xl"></t-loading-animation>
  </t-center-on-page>

  <t-center-on-page v-else-if="mode === 'invite'">
    <div class="container">
      <div class="row">
        <div class="t-center-col">
          <t-text-box>
            <p v-for="(paragraph, index) in $t('home.invite.text')" :key="index">
              {{ paragraph }}
            </p>

            <iframe class="t-invite-iframe" src="https://pub.t4l3.net/invited" scrolling="no"></iframe>

            <p class="text-center">
              <strong>{{ $t('home.invite.copyInviteText') }}</strong>
            </p>
          </t-text-box>
        </div>
      </div>

      <div class="row">
        <div class="t-center-col">
          <t-invite-accept-form
            :join-pub-button-text="$t('home.invite.form.joinPub.button')"
            @join="showFeedback()"
            :cancel-button-text="$t('home.invite.form.cancel.button')"
            @cancel="showFeedback()"
          ></t-invite-accept-form>
        </div>
      </div>
    </div>
  </t-center-on-page>

  <t-center-on-page v-else-if="mode === 'feedback'">
    <div class="container">
      <div class="row">
        <div class="t-center-col">
          <t-introduction-box messages-key="home.feedback.introduction"></t-introduction-box>
        </div>
      </div>

      <t-alpha-contact-box type="text"></t-alpha-contact-box>

      <div class="row">
        <div class="t-center-col">
          <span class="t-home-feedback-next-text">{{ $t('home.feedback.next.text') }}</span>
          <t-button-panel>
            <b-button variant="primary" slot="right" @click="showAbout()">{{ $t('home.feedback.next.button') }}
            </b-button>
          </t-button-panel>
        </div>
      </div>
    </div>
  </t-center-on-page>

  <div v-else>
    <div class="row">
      <div class="t-center-col">
        <t-text-box class="t-about-text">
          <div>
            <p>{{ $t('home.about.welcome') }}</p>
          </div>
          <div>
            <p v-for="(paragraph, index) in $t('home.about.text')" :key="paragraph">
              <i18n :path="'home.about.text[' + index + ']'" tag="p">
                <a place="ssbLink" href="https://www.scuttlebutt.nz/" target="_blank">{{ $t('home.about.ssbLink') }}</a>
              </i18n>
            </p>
          </div>

          <t-button-panel>
            <b-button slot="left" variant="primary" @click="editIdentity()">{{$t('home.about.editIdentity.button')}}
            </b-button>
            <a slot="right" href="https://blog.t4l3.net" target="_blank">{{$t('home.about.goToBlog.button')}}</a>
          </t-button-panel>
        </t-text-box>
      </div>
    </div>

    <div class="row">
      <div class="t-about-logos-container">
        <div class="t-about-logos">
          <a href="https://ind.ie/ethical-design/" target="_blank">
            <img class="t-ethical-design-logo" src="../static/img/ethical-design-badge-small.svg"/>
          </a>
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
  import { mapGetters, mapActions } from 'vuex'

  export default {
    data () {
      return {
        'mode': 'loading'
      }
    },

    mounted () {
      if (this.isLandingPageInviteDone) {
        this.mode = 'about'
      } else {
        this.hideNavbars()
        this.mode = 'invite'
      }
    },

    destroyed () {
      this.showNavbars()
    },

    computed: {
      ...mapGetters({
        isLandingPageInviteDone: 'settings/isLandingPageInviteDone'
      })
    },

    methods: {
      ...mapActions({
        hideNavbars: 'page/hideNavbar',
        showNavbars: 'page/showNavbar'
      }),

      showFeedback () {
        this.$store.dispatch('settings/markLandingPageInviteAsDone')
          .then(() => {
            this.mode = 'feedback'
            return null
          })
      },

      showAbout () {
        this.showNavbars()
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

  .t-invite-iframe {
    display: block;
    overflow: hidden;
    width: 500px;
    height: 215px;
    border: none;
    margin: {
      left: auto;
      right: auto;
      top: 1rem;
      bottom: 1rem;
    }
  }

  .t-home-feedback-next-text {
    display: block;

    margin: {
      left: $home-feedback-text-offset-x;
      right: $home-feedback-text-offset-x;
      top: $home-feedback-text-offset-y;
      bottom: $home-feedback-text-offset-y;
    }
  }

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

      .t-prototype-fund-logo, .t-bmbf-logo, .t-ethical-design-logo {
        height: 150px;
      }

      .t-ethical-design-logo {
        margin-left: 20px;
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
