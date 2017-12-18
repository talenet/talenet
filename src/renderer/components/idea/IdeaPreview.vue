<template>
  <t-loading-animation size="md" v-if="!idea"></t-loading-animation>

  <b-card v-else :title="idea.title()" @click="goToIdea">
    <t-markdown-text
      :text="idea.description() || ''"
      :headings-same-size="true"
    ></t-markdown-text>

    <div class="t-idea-preview-markdown-overlay"></div>

    <span class="t-idea-preview-last-update">
      {{$t('idea.preview.lastUpdate')}} {{idea.lastUpdate() | t-format-timestamp }}
    </span>
  </b-card>
</template>

<script>
  export default {
    props: [
      'idea'
    ],

    methods: {
      goToIdea () {
        this.$router.push({
          name: 'idea',
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

      .t-idea-preview-last-update {
        font-size: $idea-preview-last-update-font-size;
        line-height: $idea-preview-last-update-font-size;
        color: $idea-preview-last-update-color;
        font-style: italic;
        float: right;
      }

      & > .t-markdown-text {
        display: block;
        height: $idea-preview-markdown-height;
        overflow: hidden;
      }

      .card-title {
        margin-bottom: $idea-preview-title-margin-bottom;
        font-size: $idea-preview-title-font-size;
        overflow: hidden;
        white-space: nowrap;
        text-overflow: ellipsis;
      }
    }
  }
</style>
