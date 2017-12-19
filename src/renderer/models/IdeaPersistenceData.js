import _ from 'lodash'
import { filterFields } from '../util/objects'
import { addGetters } from '../util/immutableBean'

const FIELDS = ['title', 'description', 'originalIdeaKey']

/**
 * Class holding to be persisted data for an idea.
 */
export default class IdeaPersistenceData {
  constructor (idea, data, skillsToAdd = [], skillsToRemove = []) {
    this._idea = idea
    this._ideaKey = data.ideaKey ? data.ideaKey : (idea && idea.key())

    this._data = filterFields(data, FIELDS)
    addGetters(this, this._data, FIELDS)
    this._skillsToAdd = skillsToAdd
    this._skillsToRemove = skillsToRemove
  }

  withKey (ideaKey) {
    return new IdeaPersistenceData(
      this._idea,
      {
        ...this._data,
        ideaKey
      },
      this._skillsToAdd,
      this._skillsToRemove
    )
  }

  ideaKey () {
    return this._ideaKey
  }

  skillAssignments () {
    return this._skillsToAdd
  }

  skillUnassignments () {
    return this._skillsToRemove
  }

  asSsbUpdate () {
    const data = {}

    for (const field of FIELDS) {
      const value = this._data[field]

      // We only write changed fields into the update.
      if (field === 'originalIdeaKey' || !this._idea || value !== this._idea[field]()) {
        data[field] = value
      }
    }

    // Only write originalIdeaKey if it is set as we only want to include it in idea copies.
    if (!data.originalIdeaKey) {
      delete data.originalIdeaKey
    }

    if (_.isEmpty(data)) {
      // nothing to update
      return false
    }

    data.ideaKey = this.ideaKey()
    return data
  }
}
