<template>
  <div class="t-input-group">
    <b-form-group
      :label="label"
      :description="description"
      :feedback="validationFeedback"
      :state="validationState"
    >
      <b-form-input
        :value="value"
        :type="type"
        @input="$emit('input', $event)"
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
  }
</style>
