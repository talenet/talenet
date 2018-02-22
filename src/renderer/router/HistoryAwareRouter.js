import _ from 'lodash'
import VueRouter from 'vue-router'
import Vue from 'vue'

/**
 * Router implementation tracking history to seamlessly allow forward / back navigation.
 */
export default class HistoryAwareRouter extends VueRouter {
  _possibleSteps = {
    back: 0,
    forward: 0
  }

  // tracking the current action to distinguish manual link clicks from programmatic navigation
  _currentAction = 'loading'

  constructor (opts) {
    super(opts)

    Vue.util.defineReactive(this, '_possibleSteps', this._possibleSteps)

    this.onReady(() => {
      this._currentAction = null
    })

    this.afterEach(() => {
      if (!this._currentAction) {
        // We are navigating via a link click, therefore we need update possible steps
        this._possibleSteps.back += 1
        this._possibleSteps.forward = 0
      }
      this._currentAction = null
    })
  }

  isHistoryNavigationPossible (direction) {
    const history = this._possibleSteps[direction]
    return _.isNumber(history) && history > 0
  }

  push (location, onComplete, onAbort) {
    this._possibleSteps.back += 1
    this._possibleSteps.forward = 0

    this._currentAction = 'push'
    return super.push.apply(this, arguments)
  }

  replace (location, onComplete, onAbort) {
    // replacing the current route, so the possible number of back steps is staying unchanged
    this._possibleSteps.forward = 0

    this._currentAction = 'replace'
    return super.replace.apply(this, arguments)
  }

  go (n) {
    if (!_.isNumber(n)) {
      console.error('$router.go() being called with invalid argument: ', n)
    }

    if (n === 0) {
      // we stay on the current page
      return
    }

    const direction = n < 0 ? 'back' : 'forward'

    const absSteps = Math.abs(n)
    const possibleSteps = this._possibleSteps[direction]

    const absStepsToGo = Math.min(absSteps, possibleSteps)
    const stepsToGo = Math.sign(n) * absStepsToGo

    this._possibleSteps.back += stepsToGo
    this._possibleSteps.forward -= stepsToGo

    this._currentAction = 'go'
    super.go(stepsToGo)
  }

  back () {
    return this.go(-1)
  }

  forward () {
    return this.go(1)
  }
}
