import _ from 'lodash'

/**
 * Mixin handling subscriptions for required data.
 *
 * The subscriptions are declared via the parameter to the mixin function.
 *
 * The keys of the object define a prop, computed value, etc. of the
 * component. For this a watcher will be installed to update subscriptions
 * on changes. The corresponding value will also be passed as a payload to
 * the specified store action(s) (see below).
 *
 * Array payloads will be treated as sets. Thus a change in sort-order will
 * not trigger a subscription update.
 *
 * If a key starts with a <code>'!'</code> no watcher will be installed and
 * no payload will be passed to the store action(s).
 *
 * The values of the object specify the store actions handling the
 * subscriptions. Those may be either single strings or arrays of strings for
 * multiple actions.
 *
 * <code>
 *     ...
 *     props: [
 *         ...
 *         'fooKey'
 *         ...
 *     ],
 *
 *     computed: {
 *         ...
 *         barKeys () { ... },
 *         ...
 *     },
 *
 *     mixins: [
 *         ...
 *         SubscriptionMixin({
 *             'fooKey': 'foo/subscribe',
 *             'barKeys': ['bar/subscribe1', 'bar/subscribe2'],
 *             '!withoutKey': 'baz/subscribe'
 *         }),
 *         ...
 *     ],
 *     ...
 * </code>
 */
export default function (subscriptions) {
  if (!_.isObject(subscriptions)) {
    throw new Error('Subscription mixin requires an subscriptions object as a parameter.')
  }

  function ignorePayload (name) {
    return name.startsWith('!')
  }

  function forEachSubscription (component, callback) {
    for (const name in subscriptions) {
      if (subscriptions.hasOwnProperty(name)) {
        callback(name)
      }
    }
  }

  function payloadChanged (component, name) {
    const previousPayload = component.subscriptionPayloads[name]
    const currentPayload = component[name]

    if (_.isEqual(previousPayload, currentPayload)) {
      return false
    }
    if (_.isArray(previousPayload) && _.isArray(currentPayload)) {
      if (previousPayload.length !== currentPayload.length) {
        return true
      }

      const payload1 = [...previousPayload]
      const payload2 = [...currentPayload]
      payload1.sort()
      payload2.sort()

      return !_.isEqual(payload1, payload2)
    }
    return true
  }

  function updatePayload (component, name) {
    const currentPayload = component[name]
    let payload
    if (_.isArray(currentPayload)) {
      payload = [...currentPayload]
    } else if (_.isObject(currentPayload)) {
      payload = { ...currentPayload }
    } else {
      payload = currentPayload
    }
    component.subscriptionPayloads[name] = payload
  }

  return {
    data () {
      return {
        registeredSubscriptions: {},
        subscriptionPayloads: {}
      }
    },

    created () {
      forEachSubscription(this, (name) => {
        if (!ignorePayload(name)) {
          this.$watch(name, () => {
            if (payloadChanged(this, name)) {
              this.subscribe(name)
            }
            updatePayload(this, name)
          })
        }
      })
    },

    mounted () {
      forEachSubscription(this, (name) => {
        this.subscribe(name)
      })
    },

    destroyed () {
      forEachSubscription(this, (name) => {
        this.unsubscribe(name)
      })
    },

    methods: {
      subscribe (name) {
        this.unsubscribe(name)

        let actions = subscriptions[name]
        if (!_.isArray(actions)) {
          actions = [actions]
        }
        this.registeredSubscriptions[name] = this.registeredSubscriptions[name] || []

        for (const action of actions) {
          this.registeredSubscriptions[name].push(
            ignorePayload(name)
              ? this.$store.dispatch(action)
              : this.$store.dispatch(action, this[name])
          )
        }
      },

      unsubscribe (name) {
        if (this.registeredSubscriptions[name]) {
          for (const subscription of this.registeredSubscriptions[name]) {
            subscription.cancel()
          }
          delete this.registeredSubscriptions[name]
        }
      }
    }
  }
}
