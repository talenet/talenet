import Promise from 'bluebird'
import _ from 'lodash'
import AbortableStream from 'pull-abortable'
import { Graph } from 'graphlib'

import SSBAdapter from './SSBAdapter'
import Skill from '../models/Skill'

export default class SkillAdapter {
  static MAX_TYPE_AHEAD_SKILL_DISTANCE = 3.5 // distance between two skills is: 1 + 1 / votes

  static SKILL_TYPE_PREFIX = SSBAdapter.TALENET_TYPE_PREFIX + 'skill-'
  static TYPE_SKILL_CREATE = SkillAdapter.SKILL_TYPE_PREFIX + 'create'
  static TYPE_SKILL_SIMILARITY = SkillAdapter.SKILL_TYPE_PREFIX + 'similarity'

  static SKILLS_ARE_SIMILAR = 1
  static SKILLS_ARE_NOT_SIMILAR = 0

  _skillSubscriptions = {}
  _allSkillsSubscriptions = {}

  static SKILL_GRAPH_OPTS = {
    directed: false,
    compound: false,
    multigraph: false
  }
  _skillGraph = new Graph(SkillAdapter.SKILL_GRAPH_OPTS)

  _skillByKey = {}
  _skillByName = {}

  _similaritiesSubscriptions = {}

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
    if (_.isString(name)) {
      return this._skillByName[SkillAdapter._normalizeSkillName(name)]
    }
    return null
  }

  _setSkill (skill) {
    this._skillGraph.node(skill.key(), skill)
    for (const key of skill.keys()) {
      this._skillByKey[key] = skill
    }
    const name = SkillAdapter._normalizeSkillName(skill.name())
    if (_.isString(name) && !_.isEmpty(name)) {
      this._skillByName[name] = skill
    }
  }

  subscribeSkills (subscriptionId, onUpdate, skillKeys) {
    const subscription = this._ssbAdapter.subscribe(subscriptionId, this._skillSubscriptions, skillKeys, onUpdate)
    for (const skill of this._findSkillsByKeys(skillKeys)) {
      onUpdate(skill)
    }
    return subscription
  }

  subscribeAllSkills (subscriptionId, onUpdate) {
    const subscription = this._ssbAdapter.subscribe(subscriptionId, this._allSkillsSubscriptions, null, onUpdate)
    for (const skill of Object.values(this._skillByName)) {
      onUpdate(skill)
    }
    return subscription
  }

  subscribeSimilarities (subscriptionId, onUpdate) {
    const subscription = this._ssbAdapter.subscribe(subscriptionId, this._similaritiesSubscriptions, null, onUpdate)
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
    SSBAdapter.propagateUpdate(
      this._similaritiesSubscriptions,
      SkillAdapter.toVotesGraph(this._skillGraph, this._ssbAdapter.ownId())
    )
  }, 100)

  static sumUpVotes (votes) {
    return Object.values(votes).reduce((v, { vote }) => v + vote, 0)
  }

  static toVotesGraph (skillGraph, ownIdentityKey) {
    const voteGraph = skillGraph.filterNodes(() => true) // copy skill graph

    for (const edge of voteGraph.edges()) {
      const votesByAuthor = voteGraph.edge(edge)
      const votes = SkillAdapter.sumUpVotes(votesByAuthor)
      if (votes <= 0) {
        voteGraph.removeEdge(edge)
      } else {
        voteGraph.setEdge(edge, {
          distance: SkillAdapter.votesToDistance(votes),
          votes,
          ownVote: votesByAuthor[ownIdentityKey]
        })
      }
    }

    return voteGraph
  }

  _propagateSkillUpdate (skill) {
    SSBAdapter.propagateUpdate(this._skillSubscriptions, skill, ...skill.keys())
    SSBAdapter.propagateUpdate(this._allSkillsSubscriptions, skill)
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

      const skillKeys = []
      for (const match of matchingNames) {
        const skill = this._findSkillByName(match)
        if (skill) {
          skillKeys.push(skill.key())
        }
      }

      const skillKeysWithDistance = SkillAdapter.findSkillsWithinDistance(
        this._skillGraph,
        skillKeys,
        SkillAdapter.MAX_TYPE_AHEAD_SKILL_DISTANCE
      )
      // add names for sorting
      _.each(skillKeysWithDistance, s => {
        const skill = this._skillByKey[s.key]
        if (skill) {
          s.name = skill.name().toLowerCase()
        }
      })

      resolve(
        _.sortBy(
          skillKeysWithDistance.filter(s => s.name),
          ['distance', 'name']
        ).map(s => s.key)
      )
    })
  }

  /**
   * DISCLAIMER: This algorithm assumes that for any two skills A and B the distance is always >= 1.
   */
  static findSkillsWithinDistance (skillGraph, skillKeys, maxDistance) {
    const visited = new Set(skillKeys)

    const foundSkills = {}
    for (const key of skillKeys) {
      foundSkills[key] = 0 // the given keys are within distance 0 of themselves
    }

    let startKeys = skillKeys
    while (!_.isEmpty(startKeys)) {
      const nextKeys = []

      for (const sourceKey of startKeys) {
        const edges = skillGraph.nodeEdges(sourceKey)

        for (const edge of edges || []) {
          const targetField = sourceKey === edge.v ? 'w' : 'v' // nodes at edges may occur in any order
          const targetKey = edge[targetField]

          const sourceDistance = foundSkills[sourceKey]
          const votes = SkillAdapter.sumUpVotes(skillGraph.edge(edge))
          const targetDistance = sourceDistance + SkillAdapter.votesToDistance(votes)

          if (targetDistance > maxDistance) {
            continue
          }

          const currentTargetDistance = foundSkills[targetKey]
          if (!_.isNumber(currentTargetDistance) || targetDistance < currentTargetDistance) {
            foundSkills[targetKey] = targetDistance
          }

          if (!visited.has(targetKey)) {
            visited.add(targetKey)
            nextKeys.push(targetKey)
          }
        }
      }

      startKeys = nextKeys
    }

    return Object.entries(foundSkills).map(([key, distance]) => {
      return { key, distance }
    })
  }

  static votesToDistance (votes) {
    return 1 + 1 / votes
  }
}
