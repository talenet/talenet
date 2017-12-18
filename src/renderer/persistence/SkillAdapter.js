import Promise from 'bluebird'
import _ from 'lodash'
import AbortableStream from 'pull-abortable'

import SSBAdapter from './SSBAdapter'
import Skill from '../models/Skill'

export default class SkillAdapter {
  static SKILL_TYPE_PREFIX = SSBAdapter.TALENET_TYPE_PREFIX + 'skill-'
  static TYPE_SKILL_CREATE = SkillAdapter.SKILL_TYPE_PREFIX + 'create'

  _skillSubscriptions = {}
  _skillByKey = {}
  _skillByName = {}

  constructor ({ ssbAdapter }) {
    this._ssbAdapter = ssbAdapter

    ssbAdapter.registerMessageHandlers({
      [SkillAdapter.TYPE_SKILL_CREATE]: this._handleSkillCreate.bind(this)
    })
  }

  connect () {
    // Nothing to see here, move along...!
    return Promise.resolve()
  }

  _findSkillByKey (key) {
    return this._skillByKey[key]
  }

  _findSkillsByKeys (keys) {
    const skills = []
    for (const key of keys) {
      const skill = this._findSkillByKey(key)
      if (skill) {
        skills.push(skill)
      }
    }
    return skills
  }

  static _normalizeSkillName (name) {
    if (_.isString(name)) {
      return _.trim(name).toLowerCase()
    }
    return name
  }

  _findSkillByName (name) {
    return this._skillByName[SkillAdapter._normalizeSkillName(name)]
  }

  _setSkill (skill) {
    for (const key of skill.keys()) {
      this._skillByKey[key] = skill
    }
    this._skillByName[SkillAdapter._normalizeSkillName(skill.name())] = skill
  }

  subscribeSkills (onUpdate, skillKeys) {
    const subscription = this._ssbAdapter.subscribe(this._skillSubscriptions, skillKeys, onUpdate)
    for (const skill of this._findSkillsByKeys(skillKeys)) {
      onUpdate(skill)
    }
    return subscription
  }

  createSkill (skill) {
    const existingSkill = this._findSkillByName(skill.name())
    if (existingSkill) {
      return Promise.resolve(existingSkill.key())
    }

    return this._ssbAdapter.publish(SkillAdapter.TYPE_SKILL_CREATE, skill.asSsbSkill())
      .then((msg) => msg.key)
  }

  _handleSkillCreate (msg) {
    const key = msg.key
    const name = msg.value.content.name

    const existingSkill = this._findSkillByName(name)

    let skill
    if (existingSkill) {
      skill = existingSkill.withKey(key)
    } else {
      skill = Skill.fromSsbValue(key, msg.value)
    }

    this._setSkill(skill)
    this._propagateSkillUpdate(skill)
  }

  _propagateSkillUpdate (skill) {
    const subscriptions = []
    for (const key of skill.keys()) {
      const skillSubscriptions = this._skillSubscriptions[key]
      if (skillSubscriptions) {
        subscriptions.push(...skillSubscriptions)
      }
    }
    SSBAdapter.propagateUpdate(subscriptions, skill)
  }

  searchSkills (term) {
    return new Promise((resolve, reject, onCancel) => {
      const abortableStream = AbortableStream()
      onCancel(() => abortableStream.abort())

      const normalizedTerm = SkillAdapter._normalizeSkillName(term)
      const matchingNames = []
      for (const name of Object.keys(this._skillByName)) {
        const normalizedName = SkillAdapter._normalizeSkillName(name)
        if (normalizedName.includes(normalizedTerm)) {
          matchingNames.push(normalizedName)
        }
      }

      matchingNames.sort()
      const skillKeys = []
      for (const match of matchingNames) {
        const skill = this._findSkillByName(match)
        if (skill) {
          skillKeys.push(skill.key())
        }
      }

      resolve(skillKeys)
    })
  }
}
