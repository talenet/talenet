import { filterFields } from '../util/objects'
import { addGetters } from '../util/immutableBean'
import IdeaUpdate from './IdeaUpdate'

const FIELDS = ['key', 'title', 'description']

/**
 * Immutable class holding data for an idea.
 */
export default class Idea {
  constructor (data, optTimestamps, optHatStates) {
    this._ideaData = filterFields(data || {}, FIELDS)
    this._timestamps = optTimestamps || {}

    addGetters(this, this._ideaData, FIELDS)

    this._hatStates = optHatStates || {}
  }

  hasHat (identityKey) {
    const hatState = this._hatStates[identityKey]
    if (!hatState) {
      return false
    }

    return hatState.hasHat
  }

  /**
   * The hat is considered to be taken if at least one identity is known to have taken it.
   */
  isHatTaken () {
    for (const identityKey in this._hatStates) {
      if (this._hatStates.hasOwnProperty(identityKey)) {
        const hatState = this._hatStates[identityKey]
        if (hatState.hasHat) {
          return true
        }
      }
    }

    return false
  }

  /**
   * Identity keys of identities having taken the hat of the idea.
   */
  hats () {
    const keys = Object.keys(this._hatStates)
    return keys.filter((key) => this._hatStates.hasOwnProperty(key) && this._hatStates[key].hasHat)
  }

  withKey (key) {
    return new Idea({
      ...this._ideaData,
      key
    })
  }

  /**
   * Merge the idea with an update from SSB. This tracks for each field a timestamp
   * so that each field will only be overwritten by an update for a field with a newer timestamp.
   */
  withSsbUpdate (msg) {
    const timestamp = msg.timestamp
    const content = msg.value.content

    const newData = {}
    const newTimestamps = {}

    for (const field of FIELDS) {
      if (content.hasOwnProperty(field) &&
        (!this._timestamps.hasOwnProperty(field) || this._timestamps[field] < timestamp)) {
        newData[field] = content[field]
        newTimestamps[field] = timestamp
      } else {
        newData[field] = this._ideaData[field]
        newTimestamps[field] = this._timestamps[field]
      }
    }

    return new Idea(newData, newTimestamps, this._hatStates)
  }

  withSsbHatUpdate (msg) {
    const timestamp = msg.timestamp
    const identityKey = msg.value.author
    const action = msg.value.content.action
    const wantsHat = action === 'take'

    const currentHatState = this._hatStates[identityKey]

    let newHatState
    if (currentHatState) {
      if (timestamp > currentHatState.timestamp) {
        newHatState = {
          timestamp,
          hasHat: wantsHat
        }
      } else {
        // copy for sake of immutability
        newHatState = { ...currentHatState }
      }
    } else {
      newHatState = {
        timestamp,
        hasHat: wantsHat
      }
    }

    const newHatStates = {
      ...this._hatStates
    }
    newHatStates[identityKey] = newHatState

    return new Idea(this._ideaData, this._timestamps, newHatStates)
  }

  asUpdate () {
    return new IdeaUpdate({
      ...this._ideaData,
      ideaKey: this._ideaData.key
    })
  }
}
