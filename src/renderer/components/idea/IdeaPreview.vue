<template>
  <t-loading-animation size="md" v-if="!idea"></t-loading-animation>

  <b-card v-else :title="idea.title()" @click="goToIdea">
    <b-badge
      v-if="idea.hasHat(ownIdentityKey)"
      variant="primary"
      class="t-idea-preview-hat">
      {{$t('idea.view.commitment.hat')}}
    </b-badge>

    <t-markdown-text
      :text="idea.description() || ''"
      :headings-same-size="true"
    ></t-markdown-text>

    <div class="t-idea-preview-markdown-overlay"></div>

    <span v-if="timestamp === 'updated'" class="t-idea-preview-last-update">
      {{$t('idea.preview.lastUpdate')}} {{idea.lastUpdate() | tFormatTimestamp }}
    </span>
    <span v-else-if="timestamp === 'created'" class="t-idea-preview-created">
      {{$t('idea.preview.created')}} {{idea.creationTimestamp() | tFormatTimestamp }}
    </span>
  </b-card>
</template>

<script>
  import SubscriptionMixin from '../../mixins/Subscription'
  import { mapGetters } from 'vuex'
  import Idea from '../../models/Idea'

  export default {
    mixins: [
      SubscriptionMixin({
        '!': 'identity/subscribeOwnIdentityKey'
      })
    ],

    props: {
      'idea': {
        type: Idea,
        required: false
      },
      'timestamp': {
        type: String,
        required: true
      },
      'route': {
        type: String,
        required: true
      }
    },

    computed: {
      ...mapGetters({
        ownIdentityKey: 'identity/ownIdentityKey'
      })
    },

    methods: {
      goToIdea () {
        this.$router.push({
          name: this.route,
          params: {
            ideaKey: this.idea.key()
          }
        })
      }
    }
  }
</script>

<style lang="scss" scoped>
  @import "../../variables";
  @import "../../mixins";

  .card {
    cursor: pointer;
    background-color: $idea-preview-bg;
    border: $idea-preview-border;
    margin: {
      top: $idea-preview-margin-y;
      bottom: $idea-preview-margin-y;
    }

    .t-idea-preview-markdown-overlay {
      position: absolute;
      left: 0;
      bottom: $idea-preview-markdown-overlay-bottom;
      height: $idea-preview-markdown-overlay-height;
      width: 100%;

      @include gradient-y(
        $start-color: rgba($idea-preview-bg, 0%),
        $end-color: rgba($idea-preview-bg, 100%),
        $start-percent: 0%,
        $end-percent: 80%
      );
    }

    &:hover {
      background-color: $idea-preview-hover-bg;

      .t-idea-preview-markdown-overlay {
        @include gradient-y(
          $start-color: rgba($idea-preview-hover-bg, 0%),
          $end-color: rgba($idea-preview-hover-bg, 100%),
          $start-percent: 0%,
          $end-percent: 80%
        );
      }
    }

    .card-body {
      padding: {
        top: $idea-preview-padding-y;
        bottom: $idea-preview-padding-y;
        left: $idea-preview-padding-x;
        right: $idea-preview-padding-x;
      }

      .t-idea-preview-hat {
        position: absolute;
        top: $idea-preview-padding-y;
        right: $idea-preview-padding-x;

        background: none;
        color: $idea-preview-hat-color;
        border: $idea-preview-hat-border;
      }

      .t-idea-preview-created,
      .t-idea-preview-last-update {
        position: relative;
        z-index: $idea-preview-timestamp-z-index;
        font-size: $idea-preview-timestamp-font-size;
        line-height: $idea-preview-timestamp-font-size;
        color: $idea-preview-timestamp-color;
        font-style: italic;
        float: right;
      }

      & > .t-markdown-text {
        pointer-events: none;
        user-select: none;
        display: block;
        height: $idea-preview-markdown-height;
        overflow: hidden;
      }

      .card-title {
        max-width: 85%;
        margin-bottom: $idea-preview-title-margin-bottom;
        font-size: $idea-preview-title-font-size;
        overflow: hidden;
        white-space: nowrap;
        text-overflow: ellipsis;
      }
    }
  }
</style>
