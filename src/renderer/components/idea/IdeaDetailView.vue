<template>
  <div v-if="mode === 'view'">
    <t-center-on-page v-if="!idea || loading">
      <t-loading-animation size="xl"></t-loading-animation>
    </t-center-on-page>

    <t-center-on-page v-if="!loading && !exists">
      <t-text-box>{{$t('idea.error.notFound')}}</t-text-box>
    </t-center-on-page>

    <div v-if="idea && !loading && exists">
      <div class="row">
        <div class="t-center-col">
          <t-introduction-box messagesKey="idea.view.introduction"></t-introduction-box>
        </div>
      </div>

      <div class="row">
        <div class="t-center-col">
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
      </div>

      <div class="row">
        <div class="t-center-col">
          <t-text-box class="clearfix">
            <h1>{{idea.title()}}</h1>

            <t-markdown-text :text="idea.description()"></t-markdown-text>

            <span class="t-idea-details-created">
              {{$t('idea.view.created')}} {{idea.creationTimestamp() | t-format-timestamp }}
            </span>
          </t-text-box>
        </div>
      </div>

      <div class="row">
        <div class="t-center-col">
          <div>
            <t-skill-badge
              v-for="skillKey in skillKeys"
              :key="skillKey"
              :skill-key="skillKey"
            ></t-skill-badge>
          </div>

          <div>
            <strong>TODO: Label for hats</strong>

            <div class="row">
              <div class="col-md-6" v-for="hatKey in hats">
                <t-identity-card :identityKey="hatKey"></t-identity-card>
              </div>
            </div>
          </div>

          <div>
            <strong>TODO: Label for associated identities</strong>

            <div class="row">
              <div class="col-md-6" v-for="associatedKey in associations">
                <t-identity-card :identityKey="associatedKey"></t-identity-card>
              </div>
            </div>
          </div>

        </div>
      </div>

      <div class="row">
        <div class="t-center-col">
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
        return this.$store.getters['idea/get'](this.ideaKey).hats()
      },

      associations () {
        return this.$store.getters['idea/get'](this.ideaKey).associations()
      },

      skillKeys () {
        const idea = this.$store.getters['idea/get'](this.ideaKey)
        return idea ? idea.skills() : []
      }
    }
  }
</script>

<style lang="scss" scoped>
  @import "../../variables";

  .t-idea-details-created {
    font-size: $idea-details-timestamp-font-size;
    line-height: $idea-details-timestamp-font-size;
    color: $idea-details-timestamp-color;
    font-style: italic;
    float: right;
  }
</style>
