<template>
  <div @click="goToIdentityPage()" v-if="identity" class="t-idea-commitment-card clearfix">
    <t-identity-image
      ref="image"
      class="t-idea-commitment-card-image"
      :identity="identity">
    </t-identity-image>
    <div class="t-idea-commitment-card-content">
      <div>
        <t-identity-link
          class="t-idea-commitment-card-name"
          :identity="identity"
          :identity-key="identityKey">
        </t-identity-link>
      </div>
      <b-badge
        v-if="hasHat"
        variant="primary"
        class="t-idea-commitment-card-hat">
        {{$t('idea.view.commitment.hat')}}
      </b-badge>
    </div>
  </div>
  <t-loading-animation v-else></t-loading-animation>
</template>

<script>
  import SubscriptionMixin from '../../mixins/Subscription'
  import { mapGetters } from 'vuex'

  export default {
    mixins: [
      SubscriptionMixin({
        'identityKey': 'identity/subscribe'
      })
    ],

    props: {
      'identityKey': {
        type: String,
        required: true
      },
      'hasHat': {
        type: Boolean,
        required: true
      }
    },

    computed: {
      ...mapGetters({
        imageUrl: 'ssb/blobUrl'
      }),

      identity () {
        return this.$store.getters['identity/get'](this.identityKey)
      }
    },

    methods: {
      update () {
        if (this.$refs.image) {
          this.$refs.image.update()
        }
      },

      goToIdentityPage () {
        this.$router.push({
          name: 'identityDetails',
          params: {
            identityKey: this.identityKey
          }
        })
      }
    }
  }
</script>

<style lang="scss" scoped>
  @import "../../variables";

  .t-idea-commitment-card {
    cursor: pointer;
  }

  .t-idea-commitment-card-image {
    width: $idea-commitment-card-image-size;
    float: left;
  }

  .t-idea-commitment-card-content {
    overflow-y: hidden;
    word-wrap: break-word;
    margin-left: $idea-commitment-card-content-offset;
  }

  .t-idea-commitment-card-hat {
    background: none;
    color: $idea-commitment-card-hat-color;
    border: $idea-commitment-card-hat-border;
  }
</style>
