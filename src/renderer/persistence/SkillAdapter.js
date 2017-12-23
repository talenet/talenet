import Promise from 'bluebird'
import _ from 'lodash'
import AbortableStream from 'pull-abortable'

import SSBAdapter from './SSBAdapter'
import Skill from '../models/Skill'

export default class SkillAdapter {
  static SKILL_TYPE_PREFIX = SSBAdapter.TALENET_TYPE_PREFIX + 'skill-'
  static TYPE_SKILL_CREATE = SkillAdapter.SKILL_TYPE_PREFIX + 'create'
  static TYPE_SKILL_SIMILARITY = SkillAdapter.SKILL_TYPE_PREFIX + 'similarity'

  static SKILLS_ARE_SIMILAR = 1
  static SKILLS_ARE_NOT_SIMILAR = 0

  _skillSubscriptions = {}
  _allSkillsSubscriptions = []
  _skillByKey = {}
  _skillByName = {}

  _similaritiesSubscriptions = []
  _similarities = {}

  constructor ({ ssbAdapter }) {
    this._ssbAdapter = ssbAdapter

    ssbAdapter.registerMessageHandlers({
      [SkillAdapter.TYPE_SKILL_CREATE]: this._handleSkillCreate.bind(this),
      [SkillAdapter.TYPE_SKILL_SIMILARITY]: this._handleSkillSimilarity.bind(this)
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

  subscribeAllSkills (onUpdate) {
    const subscription = this._ssbAdapter.subscribe(this._allSkillsSubscriptions, null, onUpdate)
    for (const skill of Object.values(this._skillByName)) {
      onUpdate(skill)
    }
    return subscription
  }

  subscribeSimilarities (onUpdate) {
    const subscription = this._ssbAdapter.subscribe(this._similaritiesSubscriptions, null, onUpdate)
    onUpdate(this._similarityVotes())
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

  voteSkillsAsSimilar (skillKey1, skillKey2) {
    return this._voteSkillSimilarity(skillKey1, skillKey2, SkillAdapter.SKILLS_ARE_SIMILAR)
  }

  voteSkillsAsNotSimilar (skillKey1, skillKey2) {
    return this._voteSkillSimilarity(skillKey1, skillKey2, SkillAdapter.SKILLS_ARE_NOT_SIMILAR)
  }

  _voteSkillSimilarity (skillKey1, skillKey2, similarity) {
    return this._ssbAdapter.publish(SkillAdapter.TYPE_SKILL_SIMILARITY, {
      skillKey1,
      skillKey2,
      similarity
    })
  }

  _handleSkillSimilarity (msg) {
    const value = msg.value

    const author = value.author
    const timestamp = value.timestamp
    let { skillKey1, skillKey2, similarity } = value.content

    if (similarity !== 0 && similarity !== 1) {
      return
    }

    if (!_.isString(skillKey1) || !_.isString(skillKey2) || skillKey1 === skillKey2) {
      return
    }

    if (skillKey2 > skillKey1) {
      const temp = skillKey1
      skillKey1 = skillKey2
      skillKey2 = temp
    }

    const similarities = this._similarities[skillKey1] || {}
    const votes = similarities[skillKey2] || {}
    const authorVote = votes[author]

    if (!authorVote || authorVote.timestamp < timestamp) {
      votes[author] = {
        timestamp,
        vote: similarity
      }
    } else {
      return
    }

    similarities[skillKey2] = votes
    this._similarities[skillKey1] = similarities

    SSBAdapter.propagateUpdate(this._similaritiesSubscriptions, this._similarityVotes())
  }

  _similarityVotes () {
    const similarityVotes = {}
    for (const skillKey1 of Object.keys(this._similarities)) {
      const skill1Similarities = this._similarities[skillKey1]

      const skill1Votes = {}
      for (const skillKey2 of Object.keys(skill1Similarities)) {
        const pairVotes = Object.values(skill1Similarities[skillKey2]).reduce((v, { vote }) => v + vote, 0)
        if (pairVotes > 0) {
          skill1Votes[skillKey2] = pairVotes
        }
      }

      if (!_.isEmpty(skill1Votes)) {
        similarityVotes[skillKey1] = skill1Votes
      }
    }

    return similarityVotes
  }

  _propagateSkillUpdate (skill) {
    const subscriptions = []
    for (const key of skill.keys()) {
      const skillSubscriptions = this._skillSubscriptions[key]
      if (skillSubscriptions) {
        subscriptions.push(...skillSubscriptions)
      }
    }
    subscriptions.push(...this._allSkillsSubscriptions)
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
