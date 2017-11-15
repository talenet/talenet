import { filterFields } from '../util/objects'
import { addGetters } from '../util/immutableBean'
import IdeaUpdate from './IdeaUpdate'

const FIELDS = ['key', 'title', 'description']

/**
 * Immutable class holding data for an idea.
 */
export default class Idea {
  constructor (data, optTimestamps) {
    this._data = filterFields(data || {}, FIELDS)
    this._timestamps = optTimestamps || {}

    addGetters(this, this._data, FIELDS)
  }

  withKey (key) {
    return new Idea({
      ...this._data,
      key
    })
  }

  /**
   * Merge the idea with an update from SSB. This tracks for each field a timestamp
   * so that each field will only be overwritten by an update for a field with a newer timestamp.
   */
  withSsbUpdate (msg) {
    const timestamp = msg.value.timestamp
    const content = msg.value.content

    const newData = {}
    const newTimestamps = {}

    for (const field of FIELDS) {
      if (content.hasOwnProperty(field) &&
        (!this._timestamps.hasOwnProperty(field) || this._timestamps[field] < timestamp)) {
        newData[field] = content[field]
        newTimestamps[field] = timestamp
      } else {
        newData[field] = this._data[field]
        newTimestamps[field] = this._timestamps[field]
      }
    }

    return new Idea(newData, newTimestamps)
  }

  asUpdate () {
    return new IdeaUpdate({
      ...this._data,
      ideaKey: this._data.key
    })
  }
}
