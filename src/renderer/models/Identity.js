import { filterFields } from '../util/objects'
import { addGetters } from '../util/immutableBean'

const FIELDS = ['key', 'name', 'description', 'imageKey']
const ABOUT_PROPERTIES = {
  name: 'name',
  description: 'description',
  image: 'imageKey'
}

/**
 * Immutable class holding data for an identity.
 */
export default class Identity {
  constructor (data) {
    this._data = filterFields(data, FIELDS)
    addGetters(this, this._data, FIELDS)
  }

  static fromSsbAbout (key, aboutFromIdentity) {
    const data = {
      key
    }

    for (const propertiy in ABOUT_PROPERTIES) {
      if (!ABOUT_PROPERTIES.hasOwnProperty(propertiy)) {
        continue
      }

      const propertyData = aboutFromIdentity[propertiy]
      if (!propertyData) {
        continue
      }

      // We only use data for this identity.
      const valueArray = propertyData[key]
      if (!valueArray) {
        continue
      }

      data[ABOUT_PROPERTIES[propertiy]] = valueArray[0]
    }

    if (!data.name) {
      data.name = key.substr(0, 6) + '...'
    }

    if (!data.imageKey) {
      data.imageKey = '&owujXOFvfirC5Kootc7T6uiyclwaME6+lZMqEtV30iw=.sha256'
    }

    return new Identity(data)
  }
}
