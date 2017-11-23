/**
 * Util for validating data.
 */

/**
 * Registers the given validation constraints for the given component.
 */
export function registerConstraints (component, constraints) {
  for (const key in constraints) {
    if (constraints.hasOwnProperty(key)) {
      for (const constraint of constraints[key]) {
        component.$validator.attach(key, constraint)
      }
    }
  }
}

/**
 * Resets the validation state for the specified component.
 */
export function resetValidation (component) {
  component.errors.clear()
  component.$validator.reset()
}
