import Promise from 'bluebird'
import _ from 'lodash'
import AbortableStream from 'pull-abortable'
import { Graph } from 'graphlib'

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

  static SKILL_GRAPH_OPTS = {
    directed: false,
    compound: false,
    multigraph: false
  }
  _skillGraph = new Graph(SkillAdapter.SKILL_GRAPH_OPTS)

  _skillByKey = {}
  _skillByName = {}

  _similaritiesSubscriptions = []

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
    this._skillGraph.node(skill.key(), skill)
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
    this._propagateSimilaritiesUpdate()
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

  _ensureSkillExistsInGraph (skillKey) {
    if (!this._skillGraph.hasNode(skillKey)) {
      this._skillGraph.setNode(skillKey)
    }
  }

  _updateSimilarity (skillKey1, skillKey2, callback) {
    this._ensureSkillExistsInGraph(skillKey1)
    this._ensureSkillExistsInGraph(skillKey2)

    const similarities = this._skillGraph.edge(skillKey1, skillKey2) || {}
    callback(similarities)
    this._skillGraph.setEdge(skillKey1, skillKey2, similarities)
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

    this._updateSimilarity(skillKey1, skillKey2, similarities => {
      const authorVote = similarities[author]

      if (!authorVote || authorVote.timestamp < timestamp) {
        similarities[author] = {
          timestamp,
          vote: similarity
        }
      }
    })

    this._propagateSimilaritiesUpdate()
  }

  _propagateSimilaritiesUpdate = _.throttle(() => {
    SSBAdapter.propagateUpdate(this._similaritiesSubscriptions, SkillAdapter.toVotesGraph(this._skillGraph))
  }, 100)

  static sumUpVotes (votes) {
    return Object.values(votes).reduce((v, { vote }) => v + vote, 0)
  }

  static toVotesGraph (skillGraph) {
    const voteGraph = skillGraph.filterNodes(() => true) // copy skill graph

    for (const edge of voteGraph.edges()) {
      const votes = SkillAdapter.sumUpVotes(voteGraph.edge(edge))
      if (votes <= 0) {
        voteGraph.removeEdge(edge)
      } else {
        voteGraph.setEdge(edge, votes)
      }
    }

    return voteGraph
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
