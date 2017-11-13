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

      // for some reason there is a fields object in the fields object and we need to use the inner one
      let field = this.$parent.fields[this.name]
      let valid = this.$parent.errors.has(this.name) ? 'invalid' : 'valid'

      // only if the field has been changed we set a validation state
      return field.dirty ? valid : null
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
      if (!this.$parent.fields[this.name]) {
        throw new Error('There is no validation configured for field "' + this.name + '".')
      }
    }
  }
}
