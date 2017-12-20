<template>
  <div class="t-markdown-input-group" v-model="value">
    <b-form-group
      :feedback="validationFeedback"
      :state="validationState"
    >
      <b-card no-body>
        <b-tabs card @input="updateMarkdownHeight()">
          <b-tab :title="label" active>
            <b-form-textarea
              ref="textarea"
              :value="value"
              :rows="rows"
              @input="$emit('input', $event)"
              @change="$emit('change', $event)"
              @blur="$emit('blur', $event)"
              :placeholder="placeholder"
              :state="validationState"
            ></b-form-textarea>

            <i18n :path="'markdown.description'" tag="small" class="text-muted t-markdown-input-group-description">
              <a place="markdownLink" href="http://commonmark.org/help/" target="_blank">{{ $t('markdown.link') }}</a>
            </i18n>
          </b-tab>
          <b-tab :title="markdownLabel">
            <t-text-box :style="'margin: 0; min-height: ' + markdownHeight + 'px;'">
              <t-markdown-text :text="value"></t-markdown-text>
            </t-text-box>

            <i18n :path="'markdown.description'" tag="small" class="text-muted t-markdown-input-group-description">
              <a place="markdownLink" href="http://commonmark.org/help/" target="_blank">{{ $t('markdown.link') }}</a>
            </i18n>
          </b-tab>
        </b-tabs>
      </b-card>
      <small v-show="$parent.errors.has(name)" class="t-markdown-input-group-error">
        {{ $parent.errors.first(name) }}
      </small>
    </b-form-group>
  </div>
</template>

<script>
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
        markdownHeight: 0
      }
    },

    mounted () {
      this.updateMarkdownHeight()
    },

    methods: {
      handleInput (event) {
        this.$emit('input', event)
        this.updateMarkdownHeight()
      },
      updateMarkdownHeight () {
        this.markdownHeight = this.$refs.textarea.$el.getBoundingClientRect().height
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
  }
</style>
