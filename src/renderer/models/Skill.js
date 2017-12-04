import { filterFields } from '../util/objects'
import { addGetters } from '../util/immutableBean'

const FIELDS = ['key', 'name', 'timestamp']

/**
 * Immutable class holding data for a skill.
 */
export default class Skill {
  constructor (data = {}) {
    this._data = filterFields(data, FIELDS)
    addGetters(this, this._data, FIELDS)
  }

  static fromSsbValue (key, value) {
    const content = value.content
    return new Skill({
      key,
      name: content.name,
      timestamp: content.timestamp
    })
  }

  withKey (key) {
    return new Skill({
      ...this._data,
      key
    })
  }

  asSsbSkill () {
    return {
      name: this._data.name
    }
  }
}
