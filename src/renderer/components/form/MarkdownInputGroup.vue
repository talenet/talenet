<template>
  <div class="row t-markdown-input-group" v-model="value">
    <div class="t-wide-col">
      <b-form-group
        :feedback="validationFeedback"
        :state="validationState"
      >
        <b-card no-body>
          <b-tabs ref="tabs" card @input="updateMarkdownHeight()">
            <b-tab :title="label" active>
              <b-form-textarea
                ref="textarea"
                :value="value"
                :rows="rows"
                @input="handleInput($event)"
                @change="$emit('change', $event)"
                @blur="$emit('blur', $event)"
                :placeholder="placeholder"
                :state="validationState"
              ></b-form-textarea>

              <i18n :path="'markdown.description'" tag="small" class="text-muted t-markdown-input-group-description">
                <a place="markdownLink" href="http://commonmark.org/help/" target="_blank">{{ $t('markdown.link') }}</a>
              </i18n>
            </b-tab>
            <b-tab :title="markdownTabTitle" :disabled="disableMarkdownTab">
              <t-text-box :style="'margin: 0; min-height: ' + markdownHeight + 'px;'">
                <t-markdown-text :text="value"></t-markdown-text>
              </t-text-box>

              <i18n :path="'markdown.description'" tag="small" class="text-muted t-markdown-input-group-description">
                <a place="markdownLink" href="http://commonmark.org/help/" target="_blank">{{ $t('markdown.link') }}</a>
              </i18n>
            </b-tab>
          </b-tabs>
        </b-card>
      </b-form-group>
    </div>
    <div class="t-wide-col t-wide-only">
      <t-text-box :style="'height: ' + markdownHeight + 'px;'" class="t-markdown-input-group-preview-right">
        <t-markdown-text :text="value"></t-markdown-text>
      </t-text-box>
    </div>
  </div>
</template>

<script>
  import Vue from 'vue'
  import FormGroupValidationMixin from '../../mixins/FormGroupValidation'

  /**
   * Form group holding an textarea and displaying corresponding validation errors.
   */
  export default {
    mixins: [
      FormGroupValidationMixin
    ],

    props: {
      'value': {
        type: String,
        required: false
      },
      'rows': {
        type: Number,
        default: 10
      },
      'label': {
        type: String,
        required: true
      },
      'placeholder': {
        type: String,
        required: false
      },
      'markdownLabel': {
        type: String,
        required: true
      }
    },

    data () {
      return {
        markdownHeight: 0,
        disableMarkdownTab: true
      }
    },

    mounted () {
      this.update()
      window.removeEventListener('resize', this.update)
      window.addEventListener('resize', this.update)
    },

    destroyed () {
      window.removeEventListener('resize', this.update)
    },

    computed: {
      markdownTabTitle () {
        return this.markdownLabel + (this.disableMarkdownTab ? ' > ' : '')
      }
    },

    methods: {
      handleInput (event) {
        this.$emit('input', event)
        this.updateMarkdownHeight()
      },

      update () {
        this.updateTabs()
        this.updateMarkdownHeight()
      },

      updateTabs () {
        this.disableMarkdownTab = window.innerWidth >= 992
        if (this.disableMarkdownTab && this.$refs.tabs.currentTab === 1) {
          this.$refs.tabs.setTab(0)
        }
      },

      updateMarkdownHeight () {
        Vue.nextTick(() => {
          this.markdownHeight = this.$refs.textarea.$el.getBoundingClientRect().height
        })
      }
    }
  }
</script>

<style lang="scss">
  @import "../../mixins";
  @import "../../variables";

  // wrapping everything as scoping in this case for some reason prevents any style from having any effect
  .t-markdown-input-group {
    .card-header, .card-body {
      padding: 0;
    }

    .card-header-tabs {
      margin: 0;
      outline: none;

      .nav-item {
        width: 50%;

        .nav-link {
          border: none;
          color: $markdown-input-group-tab-color;
          background-color: $markdown-input-group-tab-bg;

          white-space: nowrap;

          padding: {
            top: $markdown-input-group-tab-padding-y;
            bottom: $markdown-input-group-tab-padding-y;
            left: $markdown-input-group-tab-padding-x;
            right: $markdown-input-group-tab-padding-x;
          }

          &.active {
            color: $markdown-input-group-active-tab-color;
            background-color: $markdown-input-group-active-tab-bg;
          }
        }
      }

      &, .nav-item .nav-link {
        border-bottom: $form-input-border-top;
      }
    }

    .card {
      border: $markdown-input-group-border;
    }

    .is-valid {
      .card, .card-header-tabs, .t-text-box, .nav-item .nav-link {
        border-color: $form-feedback-valid-color;
      }
    }

    .is-invalid {
      .card, .card-header-tabs, .t-text-box, .nav-item .nav-link {
        border-color: $form-feedback-invalid-color;
      }
    }

    .invalid-feedback {
      margin: {
        left: $form-input-text-offset;
        right: $form-input-text-offset;
      }
    }

    .t-markdown-input-group-error {
      color: $form-feedback-invalid-color;
      margin: {
        left: $markdown-input-group-offset-x;
        right: $markdown-input-group-offset-x;
      }
    }

    .t-markdown-input-group-description {
      display: block;
      margin: {
        top: $markdown-input-group-description-margin-y;
        bottom: $markdown-input-group-description-margin-y;
        left: $markdown-input-group-offset-x;
        right: $markdown-input-group-offset-x;
      }
    }

    textarea {
      border: {
        top: none;
        bottom: $form-input-border-bottom;
        left: none;
        right: none;
      }

      overflow-y: hidden
    }

    .t-markdown-text {
      display: block;
    }

    .t-text-box {
      border: {
        top: none;
        bottom: $form-input-border-bottom;
        left: none;
        right: none;
      }
    }

    textarea, .t-markdown-text {
      padding: {
        left: $markdown-input-group-offset-x;
        right: $markdown-input-group-offset-x;
        top: $markdown-input-group-offset-y;
        bottom: $markdown-input-group-offset-y;
      }
    }

    .t-text-box.t-markdown-input-group-preview-right {
      overflow-y: auto;
      border: none;
      margin: {
        top: $markdown-input-group-margin-top-preview-right;
      }
    }
  }
</style>
