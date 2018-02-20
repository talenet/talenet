/**
 * Mixin for forwarding events.
 *
 * Usage:
 *
 * <code>
 *     ...
 *
 *     <input ref="input1Ref">
 *
 *     ...
 *
 *     <input ref="input2Ref">
 *
 *     ...
 *
 *     mixins: [
 *         ...
 *         ForwardEventsMixin({
 *             'input1Ref': ['input', 'focus', 'blur'],
 *             'input2Ref': ['click', 'change']
 *         }),
 *         ...
 *     ],
 *     ...
 * </code>
 */
export default function (forwards) {
  return {
    mounted () {
      for (const ref of Object.keys(forwards)) {
        const component = this.$refs[ref]
        if (!component) {
          console.error('Could not forward events for "' + ref + '" as reference could not be resolved.')
          continue
        }

        const $el = component.$el || component

        for (const eventName of forwards[ref]) {
          $el.addEventListener(eventName, event => this.$emit(eventName, event))
        }
      }
    }
  }
}
