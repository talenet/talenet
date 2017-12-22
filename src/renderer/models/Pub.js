import { filterFields } from '../util/objects'
import { addGetters } from '../util/immutableBean'

const FIELDS = ['key', 'host', 'port', 'timestamp']

/**
 * Immutable class holding data for a pub.
 */
export default class Pub {
  constructor (data = {}) {
    this._data = filterFields(data, FIELDS)
    addGetters(this, this._data, FIELDS)
  }

  static fromSsb (address, timestamp) {
    return new Pub({
      ...address,
      timestamp
    })
  }
}
