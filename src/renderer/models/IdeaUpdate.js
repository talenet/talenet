import { filterFields } from '../util/objects'
import { addGetters } from '../util/immutableBean'

const FIELDS = ['ideaKey', 'title', 'description']

/**
 * Immutable class holding data for an idea.
 */
export default class IdeaUpdate {
  constructor (data) {
    this._data = filterFields(data, FIELDS)
    addGetters(this, this._data, FIELDS)
  }

  asSsbUpdate () {
    // If schema diverges we need to explicitly convert here. For now we just copy the data.
    return {
      ...this._data
    }
  }
}
