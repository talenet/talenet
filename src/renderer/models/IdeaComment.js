import { filterFields } from '../util/objects'
import { addGetters } from '../util/immutableBean'

const FIELDS = ['key', 'ideaKey', 'text']

/**
 * Immutable class holding data for an idea comment.
 */
export default class IdeaComment {
  constructor (data = {}) {
    this._data = filterFields(data, FIELDS)
    addGetters(this, this._data, FIELDS)
  }

  withKey (key) {
    return new IdeaComment({
      ...this._data,
      key
    })
  }

  asSsbComment () {
    return {
      ideaKey: this._data.ideaKey,
      text: this._data.text
    }
  }
}
