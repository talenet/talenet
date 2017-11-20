/**
 * Mixin for validation in form-group components. The name props is used to specify th
 */
export default {
  props: [
    'name'
  ],

  computed: {
    validationFeedback () {
      this._checkInitialization()
      return this.$parent.errors.first(this.name)
    },

    validationState () {
      this._checkInitialization()

      let field = this.$parent.fields[this.name]
      let valid = this.$parent.$validator.errors.has(this.name) ? 'invalid' : 'valid'

      // only if the field has been changed or validated we set a validation state
      return field.validated || field.dirty ? valid : null
    }
  },

  methods: {
    _checkInitialization () {
      if (process.env.NODE_ENV === 'production') {
        return
      }
      if (!this.name) {
        throw new Error('No name specified for form component.')
      }
      if (!this.$parent.$validator.fields.find(this.name)) {
        throw new Error('There is no validation configured for field "' + this.name + '".')
      }
    }
  }
}
