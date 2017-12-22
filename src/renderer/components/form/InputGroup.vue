<template>
  <div class="t-input-group" v-model="value">
    <b-form-group
      :label="label"
      :description="description"
      :feedback="validationFeedback"
      :state="validationState"
    >
      <b-form-input
        :maxLength="maxLength"
        :value="value"
        :type="type"
        @input="$emit('input', $event)"
        @change="$emit('change', $event)"
        @blur="$emit('blur', $event)"
        :placeholder="placeholder"
        :state="validationState"
      ></b-form-input>
    </b-form-group>
  </div>
</template>

<script>
  import FormGroupValidationMixin from '../../mixins/FormGroupValidation'

  /**
   * Form group holding an input field and displaying corresponding validation errors.
   */
  export default {
    mixins: [
      FormGroupValidationMixin
    ],

    props: [
      'value',
      'type',
      'maxLength',
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
  .t-input-group {
    .is-invalid label {
      color: $form-feedback-invalid-color;
    }

    input {
      padding-left: $form-input-text-offset;

      border: {
        top: $form-input-border-top;
        bottom: $form-input-border-bottom;
        left: $form-input-border-left;
        right: $form-input-border-right;
      }
    }

    legend, .invalid-feedback, .form-text {
      margin: {
        left: $form-input-text-offset;
        right: $form-input-text-offset;
      }
    }
  }
</style>
