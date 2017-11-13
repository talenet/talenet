<template>
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
      :placeholder="placeholder"
      :state="validationState"
    ></b-form-textarea>
  </b-form-group>
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
