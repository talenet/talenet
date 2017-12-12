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
  static SSB_ACTION_ASSIGN_SKILL = 'assign'
  static SSB_ACTION_UNASSIGN_SKILL = 'unassign'

  constructor (
    data = {},
    skillStates = {}
  ) {
    if (!data.name) {
      data.name = data.key.substr(0, 6) + '...'
    }

    if (!data.imageKey) {
      data.imageKey = '&owujXOFvfirC5Kootc7T6uiyclwaME6+lZMqEtV30iw=.sha256'
    }

    this._data = filterFields(data, FIELDS)
    addGetters(this, this._data, FIELDS)

    this._skillStates = { ...skillStates }
  }

  /**
   * Keys of skills assigned to the identity.
   */
  skills () {
    return Object.keys(this._skillStates).filter((key) => {
      const state = this._skillStates[key]
      return state && state.assigned
    })
  }

  withSsbAbout (key, aboutFromIdentity) {
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

      if (propertiy === 'image') {
        data.imageKey = valueArray[0].link
      } else {
        data[ABOUT_PROPERTIES[propertiy]] = valueArray[0]
      }
    }

    return new Identity(data, this._skillStates)
  }

  /**
   * Merge the identity with a skill assignment update. This tracks for each skill key a timestamp, so that
   * an update is only applied if it is newer than the current state for the skill key.
   */
  withSsbSkillAssignment (msg) {
    const newSkillStates = { ...this._skillStates }

    const timestamp = msg.timestamp
    const skillKey = msg.value.content.skillKey
    const action = msg.value.content.action
    const assigned = action === Identity.SSB_ACTION_ASSIGN_SKILL

    const currentSkillState = newSkillStates[skillKey]
    let newSkillState
    if (currentSkillState && currentSkillState.timestamp > timestamp) {
      newSkillState = currentSkillState
    } else {
      newSkillState = {
        assigned,
        timestamp
      }
    }

    newSkillStates[skillKey] = newSkillState

    return new Identity(
      this._data,
      newSkillStates
    )
  }
}