<template>
  <div v-if="identity">
    <div class="row">
      <div class="t-center-col">
        <t-introduction-box messagesKey="identity.edit.introduction"></t-introduction-box>
      </div>
    </div>

    <div class="row">
      <div class="t-center-col">
        <t-action-panel
          class="t-identity-details-actions"
          v-if="isOwnIdentity">
          <b-button slot="left" variant="primary" @click="editIdentity()">
            {{$t('identity.details.editIdentity.button')}}
          </b-button>
          <b-button slot="right" variant="outline-primary" @click="defineSkills()">
            {{$t('identity.details.defineSkills.button')}}
          </b-button>
        </t-action-panel>
      </div>

      <div class="t-center-col t-identity-details-top">
        <span class="t-identity-details-name">{{identity | tFormatIdentityName(identityKey)}}</span>

        <small class="text-muted t-identity-details-pubkey">{{identity.key()}}</small>

        <t-text-box class="t-identity-details-box clearfix">
          <t-identity-image class="t-identity-details-image" :identity="identity"></t-identity-image>

          <t-markdown-text :text="identity.description()"></t-markdown-text>
        </t-text-box>
      </div>
    </div>

    <div class="row">
      <div class="t-center-col t-identity-details-bottom">
        <div class="t-identity-details-skills">
          <t-skill-badge
            v-for="skillKey in skillKeys"
            :key="skillKey"
            :skillKey="skillKey"
          >
          </t-skill-badge>
        </div>
      </div>
    </div>

    <div class="row" v-if="isOwnIdentity">
      <div class="t-center-col" v-if="isOwnIdentity">
        <t-identity-key-pair-download></t-identity-key-pair-download>
      </div>
    </div>

    <div class="row">
      <div class="t-center-col">
        <t-action-panel
          :text="$t('identity.details.block.text')"
          v-if="ownIdentityKey && ownIdentityKey !== identity.key()">
          <b-button
            slot="left"
            variant="outline-danger"
            @click="block()">
            {{$t('identity.details.block.button')}}
          </b-button>
        </t-action-panel>
      </div>
    </div>
  </div>

  <t-center-on-page v-else>
    <t-loading-animation size="xl"></t-loading-animation>
  </t-center-on-page>
</template>

<script>
  import SubscriptionMixin from '../../mixins/Subscription'
  import { mapGetters } from 'vuex'

  export default {
    mixins: [
      SubscriptionMixin({
        '!': 'identity/subscribeOwnIdentityKey',
        'identityKey': 'identity/subscribe'
      })
    ],

    props: {
      identityKey: {
        type: String,
        required: true
      }
    },

    computed: {
      ...mapGetters({
        constraints: 'identity/constraints',
        ownIdentityKey: 'identity/ownIdentityKey'
      }),

      identity () {
        return this.$store.getters['identity/get'](this.identityKey)
      },

      skillKeys () {
        const identity = this.identity
        return identity ? identity.skills() : []
      },

      isOwnIdentity () {
        return this.ownIdentityKey && this.identity && this.ownIdentityKey === this.identity.key()
      }
    },

    methods: {
      editIdentity () {
        this.$router.push({
          name: 'identityEdit'
        })
      },

      defineSkills () {
        this.$router.push({
          name: 'defineSkills'
        })
      },

      block () {
        if (!confirm(this.$t('identity.details.block.confirmation'))) {
          return
        }
        this.$store.dispatch('identity/block', this.identityKey)
          .then(() => {
            window.location.reload()
            return null
          })
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
  @import "../../variables";
  @import "../../mixins";

  .t-identity-details-top {
    margin-top: $identity-details-offset-y;
  }

  .t-identity-details-bottom {
    margin-bottom: $identity-details-offset-y;
  }

  .t-identity-details-name, .t-identity-details-pubkey, .t-identity-details-skills {
    display: block;
    overflow-y: hidden;
    word-wrap: break-word;

    margin: {
      left: $identity-details-text-offset;
      right: $identity-details-text-offset;
    }
  }

  .t-identity-details-image {
    cursor: initial;
    pointer-events: none;
    float: left;
    width: $identity-details-image-size;
    height: $identity-details-image-size;
    margin-right: $identity-details-image-margin-right;
  }
</style>
