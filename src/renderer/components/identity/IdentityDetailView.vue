<template>
  <div v-if="identity" class="row">
    <div class="t-center-col">
      <t-introduction-box messagesKey="identity.edit.introduction"></t-introduction-box>
    </div>

    <div class="t-center-col">
      <t-action-panel v-if="isOwnIdentity">
        <b-button slot="left" variant="primary" @click="editIdentity()">
          {{$t('identity.details.editIdentity.button')}}
        </b-button>
        <b-button slot="right" variant="outline-primary" @click="defineSkills()">
          {{$t('identity.details.defineSkills.button')}}
        </b-button>
      </t-action-panel>
    </div>

    <div class="t-center-col t-identity-details-top">
      <span class="t-identity-details-name">{{identity.name()}}</span>
    </div>

    <div class="t-center-col">
      <t-text-box class="t-identity-details-box clearfix">
        <t-hexagon-image class="t-identity-details-image" :href="imageUrl(identity.imageKey())"></t-hexagon-image>

        {{identity.description()}}
      </t-text-box>
    </div>

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

    <div class="t-center-col" v-if="isOwnIdentity">
      <t-identity-key-pair-download></t-identity-key-pair-download>
    </div>

    <div class="t-center-col">
      <t-action-panel :text="$t('identity.details.block.text')"
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
        ownIdentityKey: 'identity/ownIdentityKey',
        imageUrl: 'ssb/blobUrl'
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

  .t-identity-details-top {
    margin-top: $identity-details-offset-y;
  }

  .t-identity-details-bottom {
    margin-bottom: $identity-details-offset-y;
  }

  .t-identity-details-name, .t-identity-details-skills {
    margin: {
      left: $identity-details-text-offset;
      right: $identity-details-text-offset;
    }
  }

  .t-identity-details-image {
    float: left;
    width: $identity-details-image-size;
    height: $identity-details-image-size;
    margin-right: $identity-details-image-margin-right;
  }
</style>
