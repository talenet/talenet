import { filterFields } from '../util/objects'
import { addGetters } from '../util/immutableBean'
import _ from 'lodash'

const FIELDS = ['name']

/**
 * Immutable class holding data for a skill.
 */
export default class Skill {
  constructor (data = {}, keys = []) {
    if (_.isString(data.name)) {
      data.name = _.trim(data.name)
    }
    this._data = filterFields(data, FIELDS)
    addGetters(this, this._data, FIELDS)

    this._keys = [...keys]
  }

  static fromSsbValue (key, value) {
    const content = value.content
    return new Skill(
      {
        name: content.name
      },
      [key]
    )
  }

  key () {
    return this._keys[0] || null
  }

  keys () {
    return [...this._keys]
  }

  withKey (key) {
    const keys = [...this._keys]
    if (!keys.includes(key)) {
      keys.push(key)
    }

    return new Skill(
      {
        ...this._data
      },
      keys
    )
  }

  asSsbSkill () {
    return {
      name: this._data.name
    }
  }
}
