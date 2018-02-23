/**
 * Error class for tale:net errors.
 */
export default class TaleError extends Error {
  constructor (key, values, cause = null) {
    const message = `Error: ${key} ${values}`
    super(message)

    this._key = key
    this._values = values
    this._cause = cause

    this.render = $t => {
      return $t(this._key, this._values || [])
    }

    this.cause = () => this._cause
  }
}
