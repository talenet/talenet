/**
 * Util for store related helper functions.
 */
import _ from 'lodash'
import Promise from 'bluebird'

/**
 * Helper function to subscribe for multiple keys at the persistence layer.
 *
 * @param context Context object of the store action.
 * @param keys Single key or array of keys to subscribe for.
 * @param mutationName Name of the store mutation to call for every updated entity.
 * @param subscribeFunction Function to call on persistence layer to subscribe for.
 *
 * @return Promise to cancel the subscription (just call <code>cancel()</code>).
 */
export function subscribeKeys (context, keys, mutationName, subscribeFunction) {
  let keysToSubscribeFor = keys
  if (!_.isArray(keysToSubscribeFor)) {
    keysToSubscribeFor = [keysToSubscribeFor]
  }
  // Ignore null-ish keys.
  keysToSubscribeFor = keysToSubscribeFor.filter((key) => !!key)

  if (_.isEmpty(keysToSubscribeFor)) {
    return new Promise(() => {})
  }

  return subscribeFunction((entity) => {
    context.commit(mutationName, entity)
  }, keysToSubscribeFor)
}
