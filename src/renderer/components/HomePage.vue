<template>
  <transition name="fade" mode="out-in">
    <t-center-on-page v-if="mode === 'loading'">
      <t-loading-animation size="xl"></t-loading-animation>
    </t-center-on-page>

    <t-center-on-page v-else-if="mode === 'introduction'">
      <div class="container">
        <div class="row">
          <div class="t-center-col">
            <t-introduction-box
              messages-key="home.introduction">
              <h2 class="t-introduction-box-headline">{{$t('home.introduction.headline')}}</h2>
              <p>{{$t('home.introduction.text')}}</p>
              <p><em>{{$t('home.introduction.callToAction')}}</em></p>
            </t-introduction-box>
          </div>
        </div>

        <div class="row">
          <div class="t-center-col">
            <t-text-box>
              <h1 class="t-textbox-title">{{$t('introduction.conditions.headline')}}</h1>
              <div v-for="(paragraph, index) in $t('introduction.conditions.paragraphs')" :key="index">
                <p>{{ paragraph }}</p></li>
            </div>
            </t-text-box>

            <t-button-panel>
              <span slot="right">{{$t('introduction.conditions.buttonsentence')}}</span>
              <b-button slot="right" variant="primary" @click="showInvite()">{{$t('introduction.conditions.button')}}
              </b-button>
            </t-button-panel>
          </div>
        </div>
      </div>
    </t-center-on-page>

    <t-center-on-page v-else-if="mode === 'invite'">
      <div class="container">
        <div class="row">
          <div class="t-center-col">
            <t-text-box>
              <h1 class="t-textbox-title">{{$t('home.invite.headline')}}</h1>
              <p v-for="(paragraph, index) in $t('home.invite.text')" :key="index">
                {{ paragraph }}
              </p>

              <p class="text-center">
                <t-action-button ref="getInvite" variant="primary" size="lg" @click="getInvite">
                  {{ $t('home.invite.inviteLink') }}
                </t-action-button>
              </p>
            </t-text-box>
          </div>
        </div>

        <div class="row">
          <div class="t-center-col">
            <t-invite-accept-form
              ref="inviteForm"
              :join-pub-button-text="$t('home.invite.form.joinPub.button')"
              @join="showAbout()"
              :cancel-button-text="$t('home.invite.form.cancel.button')"
              @cancel="showAbout()"
            ></t-invite-accept-form>
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
              <h1 class="t-textbox-title">{{$t('home.about.headline')}}</h1>
              <p v-for="(paragraph, index) in $t('home.about.text')" :key="paragraph">
                <i18n :path="'home.about.text[' + index + ']'" tag="p">
                  <h2 place="subheadline1">
                    {{ $t('home.about.subheadline1') }}
                  </h2>
                  <h2 place="subheadline2">
                    {{ $t('home.about.subheadline2') }}
                  </h2>
                  <h2 place="subheadline3">
                    {{ $t('home.about.subheadline3') }}
                  </h2>
                  <a
                    place="ssbLink"
                    href="https://www.scuttlebutt.nz/"
                    target="_blank"
                  >{{ $t('home.about.ssbLink') }}</a>
                  <a
                    place="downloadKeyPairLink"
                    href="javascript:"
                    @click="downloadKeyPair()"
                  >{{ $t('home.about.downloadKeyPairLink') }}</a>
                  <a
                    place="conceptsLink"
                    href="https://t4l3.net/concept/"
                    target="_blank"
                  >{{ $t('home.about.conceptsLink') }}</a>
                  <span place="devLinks">
                  <nobr v-for="identityKey in devIdentityKeys" :key="identityKey">
                    <t-identity-link
                      :identity="getIdentity(identityKey)"
                      :identityKey="identityKey">
                    </t-identity-link>,
                  </nobr>
                  </span>
                  <t-identity-link
                    place="lastDevLink"
                    :identity="getIdentity(lastDevIdentityKey)"
                    :identityKey="lastDevIdentityKey">
                  </t-identity-link>
                </i18n>
              </p>
            </div>

            <t-button-panel>
              <b-button slot="left" variant="primary" @click="editIdentity()">{{$t('home.about.editIdentity.button')}}
              </b-button>
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
  </transition>
</template>

<script>
  import SubscriptionMixin from '../mixins/Subscription'
  import { mapGetters, mapActions } from 'vuex'

  const DEV_IDENTITY_KEYS = [
    '@J31cBBwVK+4i9/L37VO5PGGHnIpPnfoJRdjv+NlQeu0=.ed25519',
    '@p13zSAiOpguI9nsawkGijsnMfWmFd5rlUNpzekEE+vI=.ed25519',
    '@3a/8VgfLqnmmqO3mf0al1piEbKqvg1LqRoNd2pcsLLo=.ed25519',
    '@xCWXNsIf59keld9ssTWpAGhMIanqKx5VmubWcZITkkQ=.ed25519',
    '@NXNrTfdIIQpdG9CAXPKaEoB7c4IFgaGzpNy9le+1VZw=.ed25519'
  ]

  export default {
    mixins: [
      SubscriptionMixin({
        devIdentityKeys: 'identity/subscribe',
        lastDevIdentityKey: 'identity/subscribe'
      })
    ],

    data () {
      return {
        mode: 'loading'
      }
    },

    mounted () {
      if (this.isLandingPageInviteDone) {
        this.mode = 'about'
      } else {
        this.hideNavbars()
        this.mode = 'introduction'
      }
    },

    destroyed () {
      this.showNavbars()
    },

    computed: {
      ...mapGetters({
        isLandingPageInviteDone: 'settings/isLandingPageInviteDone',
        getIdentity: 'identity/get'
      }),

      devIdentityKeys () {
        return DEV_IDENTITY_KEYS.slice(0, DEV_IDENTITY_KEYS.length - 1)
      },

      lastDevIdentityKey () {
        return DEV_IDENTITY_KEYS[DEV_IDENTITY_KEYS.length - 1]
      }
    },

    methods: {
      ...mapActions({
        hideNavbars: 'page/hideNavbar',
        showNavbars: 'page/showNavbar'
      }),

      showInvite () {
        this.hideNavbars()
        this.mode = 'invite'
      },

      showAbout () {
        this.showNavbars()
        this.$store.dispatch('settings/markLandingPageInviteAsDone')
          .then(() => {
            this.mode = 'feedback'
            return null
          })
      },

      editIdentity () {
        this.$router.push({
          name: 'identityEdit'
        })
      },

      getInvite () {
        window.open('https://t4l3.net/invitation/', '_blank')
        // this.$refs.inviteForm.disable()
        // this.$refs.getInvite.dispatch('ssb/getInviteFromPub')
        //   .then(invite => {
        //     this.$refs.inviteForm.setInviteCode(invite)
        //   })
        //   .catch(err => {
        //     if (err) {
        //       console.error(err)
        //     }
        //   })
        //   .finally(() => {
        //     this.$refs.inviteForm.enable()
        //   })
      },

      downloadKeyPair () {
        this.$store.dispatch('identity/downloadKeyPair')
          .catch(err => {
            if (err) {
              console.error(err)
            }
          })
      }
    }
  }
</script>

<style lang="scss" scoped>
  @import "../variables";

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
