import Promise from 'bluebird'

/**
 * Sets global configurations that don't fit somewhere else.
 */
export default () => {
  Promise.config({
    // Allow promises to be canceled
    cancellation: true
  })
}
