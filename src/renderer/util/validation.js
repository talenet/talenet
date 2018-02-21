/**
 * Util for validating data.
 */

/**
 * Registers the given validation constraints for the given component.
 */
export function registerConstraints (component, constraints) {
  for (const name of Object.keys(constraints)) {
    component.$validator.attach({
      name,
      rules: constraints[name]
    })
  }
}

/**
 * Resets the validation state for the specified component.
 */
export function resetValidation (component) {
  component.errors.clear()
  component.$validator.reset()
}
