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

  return {
    data () {
      return {
        registeredSubscriptions: {}
      }
    },

    created () {
      forEachSubscription(this, (name) => {
        if (!ignorePayload(name)) {
          this.$watch(name, () => {
            this.subscribe(name)
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
