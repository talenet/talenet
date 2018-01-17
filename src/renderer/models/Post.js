import { filterFields } from '../util/objects'
import { addGetters } from '../util/immutableBean'

const FIELDS = ['key', 'text', 'timestamp']

/**
 * Immutable class holding data for a pub.
 */
export default class Post {
  constructor (data = {}) {
    this._data = filterFields(data, FIELDS)
    addGetters(this, this._data, FIELDS)
  }

  static fromSsb (msg) {
    const value = msg.value

    return new Post({
      key: msg.key,
      text: value.content.text,
      timestamp: value.timestamp
    })
  }
}
