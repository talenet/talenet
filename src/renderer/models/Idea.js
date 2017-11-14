import { filterFields } from '../util/objects'
import { addGetters } from '../util/immutableBean'
import IdeaUpdate from './IdeaUpdate'

const FIELDS = ['key', 'title', 'description']

/**
 * Immutable class holding data for an idea.
 */
export default class Idea {
  constructor (data) {
    this._data = filterFields(data || {}, FIELDS)
    addGetters(this, this._data, FIELDS)
  }

  withKey (key) {
    return new Idea({
      ...this._data,
      key
    })
  }

  withSsbUpdate (msg) {
    return new Idea({
      ...this._data,
      ...msg.value.content
    })
  }

  asUpdate () {
    return new IdeaUpdate({
      ...this._data,
      ideaKey: this._data.key
    })
  }
}
