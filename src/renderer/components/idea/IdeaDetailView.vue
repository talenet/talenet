<template>
  <div v-if="mode === 'view'">
    <t-center-on-page v-if="!idea || loading">
      <t-loading-animation size="xl"></t-loading-animation>
    </t-center-on-page>

    <t-center-on-page v-if="!loading && !exists">
      <t-text-box>{{$t('idea.error.notFound')}}</t-text-box>
    </t-center-on-page>

    <div v-if="idea && !loading && exists" class="t-idea-details">
      <div class="row">
        <div class="t-wide-col">
          <t-introduction-box messagesKey="idea.view.introduction"></t-introduction-box>
        </div>
      </div>

      <div class="row">
        <div class="t-wide-col t-wide-right-above">
          <t-action-panel>
            <b-button
              slot="left"
              v-if="!idea.isAssociated(ownIdentityKey)"
              variant="primary"
              @click="associateWith">
              {{$t('idea.view.associateWith.button')}}
            </b-button>
            <b-button
              v-if="idea.isAssociated(ownIdentityKey) && idea.hasHat(ownIdentityKey)"
              slot="left"
              variant="primary"
              @click="editIdea">
              {{$t('idea.view.edit.button')}}
            </b-button>
            <b-button
              slot="left"
              v-if="idea.isAssociated(ownIdentityKey) && idea.hasHat(ownIdentityKey)"
              variant="outline-primary"
              @click="discardHat">
              {{$t('idea.view.discardHat.button')}}
            </b-button>
            <b-button
              slot="left"
              v-if="idea.isAssociated(ownIdentityKey) && !idea.isHatTaken()"
              variant="primary"
              @click="takeHat">
              {{$t('idea.view.takeHat.button')}}
            </b-button>
            <b-button
              slot="left"
              v-if="idea.isAssociated(ownIdentityKey) && !idea.hasHat(ownIdentityKey)"
              variant="outline-primary"
              @click="disassociateFrom">
              {{$t('idea.view.disassociateFrom.button')}}
            </b-button>

            <b-button
              slot="right"
              variant="outline-primary"
              @click="copyIdea()">
              {{$t('idea.view.copy.button')}}
            </b-button>
          </t-action-panel>
        </div>

        <div class="t-wide-col t-wide-left-below">
          <t-text-box class="clearfix">
            <h1>{{idea.title()}}</h1>

            <t-markdown-text :text="idea.description()"></t-markdown-text>

            <span class="t-idea-details-created">
              {{$t('idea.view.created')}} {{idea.creationTimestamp() | t-format-timestamp}}
            </span>
          </t-text-box>
        </div>
      </div>

      <div class="row">
        <div class="t-wide-col">
          <b-card no-body class="t-idea-details-commitment-box">
            <b-tabs card @input="updateCommitmentCards()">
              <b-tab :title="$t('idea.view.commitment.skills.tab')" active>
                <t-skill-badge
                  v-for="skillKey in skillKeys"
                  :key="skillKey"
                  :skill-key="skillKey"
                ></t-skill-badge>
              </b-tab>

              <b-tab :title="$t('idea.view.commitment.commitments.tab')">
                <t-idea-commitment-card
                  v-for="hatKey in hats"
                  ref="commitmentCard"
                  :key="hatKey"
                  :identityKey="hatKey"
                  :hasHat="true">
                </t-idea-commitment-card>

                <small class="text-muted">{{$t('idea.view.commitment.description')}}</small>
              </b-tab>
            </b-tabs>
          </b-card>
        </div>
      </div>

      <div class="row">
        <div class="t-wide-col">
          <t-idea-comments :idea="idea"></t-idea-comments>
        </div>
      </div>
    </div>
  </div>
  <div v-else><!-- mode === 'edit' -->
    <t-idea-edit-form
      :idea="idea"
      @save="ideaSaved"
      @cancel="editCanceled"
    ></t-idea-edit-form>
  </div>
</template>

<script>
  import SubscriptionMixin from '../../mixins/Subscription'
  import { mapGetters } from 'vuex'

  export default {
    mixins: [
      SubscriptionMixin({
        'ideaKey': 'idea/subscribe',
        'skillKeys': 'skill/subscribe',
        '!': 'identity/subscribeOwnIdentityKey'
      })
    ],

    props: [
      'ideaKey'
    ],

    data () {
      return {
        mode: 'view',
        loading: false,
        exists: true
      }
    },

    methods: {
      updateCommitmentCards () {
        // Makes sure the hexagon images are being rendered correctly
        const commitmentCards = this.$refs.commitmentCard || []
        for (const commitmentCard of commitmentCards) {
          if (commitmentCard) {
            commitmentCard.update()
          }
        }
      },

      editIdea () {
        this.mode = 'edit'
      },

      ideaSaved () {
        this.mode = 'view'
        // TODO: Feedback
      },

      editCanceled () {
        this.mode = 'view'
      },

      _updateIdeaState (action) {
        this.loading = true

        this.$store.dispatch('idea/' + action, this.ideaKey)
          .catch((err) => {
            if (err) {
              console.error(err)
            }
          })
          .finally(() => {
            this.loading = false
          })
      },

      takeHat () {
        this._updateIdeaState('takeHat')
      },

      discardHat () {
        this._updateIdeaState('discardHat')
      },

      associateWith () {
        this._updateIdeaState('associateWith')
      },

      disassociateFrom () {
        this._updateIdeaState('disassociateFrom')
      },

      copyIdea () {
        this.loading = true

        this.$store.dispatch('idea/copy', this.ideaKey)
          .then(ideaKey => {
            this.loading = false

            if (ideaKey) {
              // TODO: Feedback
              this.$router.push({
                name: 'idea',
                params: { ideaKey }
              })
            }
          })
          .catch(err => {
            if (err) {
              console.error(err)
            }
            this.loading = false
          })
      }
    },

    computed: {
      ...mapGetters({
        ownIdentityKey: 'identity/ownIdentityKey',
        skill: 'skill/get'
      }),

      idea () {
        return this.$store.getters['idea/get'](this.ideaKey)
      },

      hats () {
        return this.idea.hats()
      },

      skillKeys () {
        const idea = this.$store.getters['idea/get'](this.ideaKey)
        return idea ? idea.skills() : []
      }
    }
  }
</script>

<style lang="scss">
  @import "../../variables";

  // wrapping everything as scoping in this case for some reason prevents any style from having any effect
  .t-idea-details {
    .t-idea-details-created {
      font-size: $idea-details-timestamp-font-size;
      line-height: $idea-details-timestamp-font-size;
      color: $idea-details-timestamp-color;
      font-style: italic;
      float: right;
    }

    .t-idea-details-commitment-box {
      margin: {
        top: $idea-details-offset-y;
        bottom: $idea-details-offset-y;
      }
      border: $idea-commitment-box-border;

      .card-header {
        padding: 0;
      }

      .card-header-tabs {
        margin: 0;
        outline: none;

        .nav-item {
          width: 50%;

          .nav-link {
            border: none;
            color: $idea-commitment-box-tab-color;
            background-color: $idea-commitment-box-tab-bg;

            &.active {
              color: $idea-commitment-box-active-tab-color;
              background-color: $idea-commitment-box-active-tab-bg;
            }
          }
        }

        &, .nav-item .nav-link {
          border-bottom: $idea-commitment-box-border;
        }
      }
    }
  }
</style>
