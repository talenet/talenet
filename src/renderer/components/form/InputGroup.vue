<template>
  <b-form-group
    :label="label"
    :description="description"
    :feedback="validationFeedback"
  >
    <b-form-input
      :value="value"
      :type="type"
      @input="$emit('input', $event)"
      :placeholder="placeholder"
      :state="validationState"
    ></b-form-input>
  </b-form-group>
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
