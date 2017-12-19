<template>
  <div class="t-textarea-group" v-model="value">
    <b-form-group
      :label="label"
      :description="description"
      :feedback="validationFeedback"
      :state="validationState"
    >
      <b-form-textarea
        :value="value"
        :rows="rows"
        @input="$emit('input', $event)"
        @change="$emit('change', $event)"
        @blur="$emit('blur', $event)"
        :placeholder="placeholder"
        :state="validationState"
      ></b-form-textarea>
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

    props: [
      'value',
      'rows',
      'label',
      'placeholder',
      'description'
    ]
  }
</script>

<style lang="scss">
  @import "../../mixins";
  @import "../../variables";

  // wrapping everything as scoping in this case for some reason prevents any style from having any effect
  .t-textarea-group {
    .is-invalid label {
      color: $form-feedback-invalid-color;
    }

    legend, .form-text, .invalid-feedback {
      margin: {
        left: $form-input-text-offset;
        right: $form-input-text-offset;
      }
    }

    textarea {
      border: {
        top: $form-input-border-top;
        bottom: $form-input-border-bottom;
        left: $form-input-border-left;
        right: $form-input-border-right;
      }
    }
  }
</style>
