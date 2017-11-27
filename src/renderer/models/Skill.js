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

  static fromSsb (msg) {
    const content = msg.value.content
    return new Skill({
      key: msg.key,
      name: content.name,
      timestamp: msg.timestamp
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
