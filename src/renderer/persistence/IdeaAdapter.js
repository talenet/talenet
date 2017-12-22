import Promise from 'bluebird'
import pull from 'pull-stream'
import AbortableStream from 'pull-abortable'
import _ from 'lodash'
import mapSeries from 'async/mapSeries'

import SSBAdapter from './SSBAdapter'
import Idea from '../models/Idea'

export default class IdeaAdapter {
  static IDEA_TYPE_PREFIX = SSBAdapter.TALENET_TYPE_PREFIX + 'idea-'
  static TYPE_IDEA_CREATE = IdeaAdapter.IDEA_TYPE_PREFIX + 'create'
  static TYPE_IDEA_UPDATE = IdeaAdapter.IDEA_TYPE_PREFIX + 'update'
  static TYPE_IDEA_SKILL_ASSIGNMENT = IdeaAdapter.IDEA_TYPE_PREFIX + 'skill_assignment'
  static TYPE_IDEA_HAT = IdeaAdapter.IDEA_TYPE_PREFIX + 'hat'
  static TYPE_IDEA_ASSOCIATION = IdeaAdapter.IDEA_TYPE_PREFIX + 'association'
  static TYPE_IDEA_COMMENT = IdeaAdapter.IDEA_TYPE_PREFIX + 'comment'
  static TYPE_IDEA_COMMENT_REPLY = IdeaAdapter.IDEA_TYPE_PREFIX + 'comment_reply'

  _latestIdeaUpdateByKey = {}
  _ideaByKey = {}

  _ideaSubscriptions = {}

  _ownIdeas = []
  _ownIdeasSubscriptions = []

  _ideaMatchesSubscriptions = []
  _runningIdeaMatchesUpdate = null

  constructor ({ ssbAdapter, identityAdapter }) {
    this._ssbAdapter = ssbAdapter
    this._identityAdapter = identityAdapter

    ssbAdapter.registerMessageHandlers({
      [IdeaAdapter.TYPE_IDEA_CREATE]: this._handleIdeaCreation.bind(this),
      [IdeaAdapter.TYPE_IDEA_UPDATE]: this._handleIdeaUpdate.bind(this),
      [IdeaAdapter.TYPE_IDEA_SKILL_ASSIGNMENT]: this._handleSkillAssignment.bind(this),
      [IdeaAdapter.TYPE_IDEA_HAT]: this._handleHat.bind(this),
      [IdeaAdapter.TYPE_IDEA_ASSOCIATION]: this._handleAssociation.bind(this),
      [IdeaAdapter.TYPE_IDEA_COMMENT]: this._handleComment.bind(this),
      [IdeaAdapter.TYPE_IDEA_COMMENT_REPLY]: this._handleCommentReply.bind(this)
    })
  }

  connect () {
    return Promise.resolve()
  }

  subscribeIdeas (onUpdate, ideaKeys) {
    const subscription = this._ssbAdapter.subscribe(this._ideaSubscriptions, ideaKeys, onUpdate)
    for (const key of ideaKeys) {
      this._loadIdea(key)
    }
    return subscription
  }

  _propagateIdeaUpdate (idea) {
    SSBAdapter.propagateUpdate(
      this._ideaSubscriptions[idea.key()],
      idea
    )
  }

  subscribeOwnIdeas (onUpdate) {
    const subscription = this._ssbAdapter.subscribe(this._ownIdeasSubscriptions, null, onUpdate)
    onUpdate([...this._ownIdeas])
    return subscription
  }

  _updateOwnIdeas (idea) {
    const key = idea.key()
    const associated = idea.isAssociated(this._identityAdapter.ownIdentityKey())
    const currentlyOwnIdea = this._ownIdeas.includes(key)

    let updated = false

    if (associated && !currentlyOwnIdea) {
      this._ownIdeas.push(key)
      updated = true
    } else if (!associated && currentlyOwnIdea) {
      this._ownIdeas = this._ownIdeas.filter(k => k !== key)
      updated = true
    }

    if (updated) {
      for (const subscription of this._ownIdeasSubscriptions) {
        subscription.propagateUpdate([...this._ownIdeas])
      }
    }
  }

  subscribeIdeaMatches (onUpdate) {
    const ownIdentitySubscription = this._identityAdapter.subscribeIdentities(
      this._updateMatches.bind(this),
      [this._identityAdapter.ownIdentityKey()]
    )
    return this._ssbAdapter.subscribe(
      this._ideaMatchesSubscriptions,
      null,
      onUpdate,
      () => ownIdentitySubscription.cancel()
    )
  }

  _hasSubscriptionForIdea (key) {
    return !_.isEmpty(this._ideaSubscriptions[key] || [])
  }

  _writeIdeaData (ideaPersistenceData) {
    const ideaKey = ideaPersistenceData.ideaKey()
    const promises = []

    const ssbUpdate = ideaPersistenceData.asSsbUpdate()
    if (ssbUpdate) {
      promises.push(this._ssbAdapter.publish(IdeaAdapter.TYPE_IDEA_UPDATE, ssbUpdate))
    }

    for (const skillKey of ideaPersistenceData.skillAssignments()) {
      promises.push(this.assignSkillToIdea(ideaKey, skillKey))
    }

    for (const skillKey of ideaPersistenceData.skillUnassignments()) {
      promises.push(this.unassignSkillFromIdea(ideaKey, skillKey))
    }

    return Promise.all(promises)
      .then(() => {
        return ideaKey
      })
  }

  _getIdea (key) {
    return this._ideaByKey[key] || new Idea({ key })
  }

  _setIdea (idea) {
    this._ideaByKey[idea.key()] = idea
  }

  createIdea (ideaPersistenceData) {
    return this._ssbAdapter.publish(IdeaAdapter.TYPE_IDEA_CREATE, {})
      .then((msg) => {
        return this.associateWithIdea(msg.key)
      }).then((ideaKey) => {
        return this.takeHat(ideaKey)
      }).then((ideaKey) => {
        return this._writeIdeaData(ideaPersistenceData.withKey(ideaKey))
      })
  }

  _doHandleMessage (msg, updateIdea, force = false) {
    const type = SSBAdapter.getMessageType(msg)
    const key = type === IdeaAdapter.TYPE_IDEA_CREATE ? msg.key : msg.value.content.ideaKey

    if (!force && !this._hasSubscriptionForIdea(key)) {
      return
    }

    const timestamp = msg.value.timestamp
    const currentLatestTimestamp = this._latestIdeaUpdateByKey[key] || 0
    if (timestamp > currentLatestTimestamp) {
      this._latestIdeaUpdateByKey[key] = timestamp
    }

    const currentIdea = this._getIdea(key)
    const updatedIdea = updateIdea(currentIdea).withLastUpdate(this._latestIdeaUpdateByKey[key] || 0)

    this._setIdea(updatedIdea)

    this._propagateIdeaUpdate(updatedIdea)

    return updatedIdea
  }

  _handleIdeaCreation (msg) {
    this._doHandleMessage(
      msg,
      idea => idea.withCreationTimestamp(msg.value.timestamp)
    )
  }

  copyIdea (ideaKey) {
    return this._loadIdea(ideaKey)
      .then(result => {
        if (!result.exists) {
          return Promise.reject(new Error('Cannot find idea to copy: ' + ideaKey))
        }
        const idea = this._getIdea(ideaKey)
        return this.createIdea(idea.asCopyPersistanceData())
      })
  }

  updateIdea (ideaPersistenceData) {
    return this._writeIdeaData(ideaPersistenceData)
  }

  _handleIdeaUpdate (msg) {
    this._doHandleMessage(
      msg,
      idea => idea.withSsbUpdate(msg)
    )
  }

  _updateIdeaSkillAssignment (ideaKey, skillKey, action) {
    return this._ssbAdapter.publish(IdeaAdapter.TYPE_IDEA_SKILL_ASSIGNMENT, {
      ideaKey,
      skillKey,
      action
    }).then(() => {
      return skillKey
    })
  }

  assignSkillToIdea (ideaKey, skillKey) {
    return this._updateIdeaSkillAssignment(ideaKey, skillKey, Idea.SSB_ACTION_ASSIGN_SKILL)
  }

  unassignSkillFromIdea (ideaKey, skillKey) {
    return this._updateIdeaSkillAssignment(ideaKey, skillKey, Idea.SSB_ACTION_UNASSIGN_SKILL)
  }

  _handleSkillAssignment (msg) {
    this._doHandleMessage(
      msg,
      idea => idea.withSsbSkillAssignment(msg)
    )
    // TODO: Update matches
  }

  _updateHat (ideaKey, action) {
    return this._ssbAdapter.publish(IdeaAdapter.TYPE_IDEA_HAT, {
      ideaKey,
      action
    }).then(() => {
      return ideaKey
    })
  }

  takeHat (ideaKey) {
    return this._updateHat(ideaKey, Idea.SSB_ACTION_TAKE_HAT)
  }

  discardHat (ideaKey) {
    return this._updateHat(ideaKey, Idea.SSB_ACTION_DISCARD_HAT)
  }

  _handleHat (msg) {
    this._doHandleMessage(
      msg,
      idea => idea.withSsbHatUpdate(msg)
    )
  }

  _updateIdeaAssociation (ideaKey, action) {
    return this._ssbAdapter.publish(IdeaAdapter.TYPE_IDEA_ASSOCIATION, {
      ideaKey,
      action
    }).then(() => {
      return ideaKey
    })
  }

  associateWithIdea (ideaKey) {
    return this._updateIdeaAssociation(ideaKey, Idea.SSB_ACTION_ASSOCIATE_WITH_IDEA)
  }

  disassociateFromIdea (ideaKey) {
    return this._updateIdeaAssociation(ideaKey, Idea.SSB_ACTION_DISASSOCIATE_FROM_IDEA)
  }

  _handleAssociation (msg) {
    const updatedIdea = this._doHandleMessage(
      msg,
      idea => idea.withSsbIdeaAssociation(msg),
      true // force
    )
    this._updateOwnIdeas(updatedIdea)
  }

  postIdeaComment (ideaComment) {
    return this._ssbAdapter.publish(IdeaAdapter.TYPE_IDEA_COMMENT, ideaComment.asSsbComment())
      .then((msg) => msg.key)
  }

  _handleComment (msg) {
    this._doHandleMessage(
      msg,
      idea => idea.withSsbIdeaComment(msg)
    )
  }

  replyToIdeaComment (ideaCommentReply) {
    return this._ssbAdapter.publish(IdeaAdapter.TYPE_IDEA_COMMENT_REPLY, ideaCommentReply.asSsbCommentReply())
      .then((msg) => msg.key)
  }

  _handleCommentReply (msg) {
    this._doHandleMessage(
      msg,
      idea => idea.withSsbIdeaCommentReply(msg)
    )
  }

  ideaExists (ideaKey) {
    return this._ssbAdapter.getValueByKey(ideaKey)
      .then(value => {
        const exists = value && value.content && value.content.type === IdeaAdapter.TYPE_IDEA_CREATE

        if (exists) {
          this._handleIdeaCreation({
            key: ideaKey,
            value
          })
        }

        return ({ ideaKey, exists })
      })
      .catch(err => {
        if (err) {
          console.error(err)
        }

        return Promise.resolve({ ideaKey, exists: false })
      })
  }

  _loadIdea (ideaKey) {
    return this.ideaExists(ideaKey)
      .then((result) => {
        if (!result.exists) {
          return result
        }

        return new Promise((resolve, reject) => {
          pull(
            this._ssbAdapter.streamByIdea(ideaKey),
            pull.collect((err, msgs) => {
              if (err) {
                return reject(err)
              }

              for (const msg of msgs) {
                this._ssbAdapter.handleMessage(msg)
              }

              resolve(result)
            })
          )
        })
      })
  }

  _updateMatches (ownIdentity) {
    if (this._runningIdeaMatchesUpdate) {
      this._runningIdeaMatchesUpdate.cancel()
      this._runningIdeaMatchesUpdate = null
    }

    if (_.isEmpty(this._ideaMatchesSubscriptions)) {
      return
    }

    this._runningIdeaMatchesUpdate = this._findIdeaKeysForSkills(ownIdentity.skills())
      .then(skillsByIdea => {
        if (_.isEmpty(skillsByIdea)) {
          return
        }

        const ideaKeys = Object.keys(skillsByIdea)

        return this._getCreationTimestampByIdea(ideaKeys)
          .then(timestampByIdea => {
            const matches = {}
            for (const ideaKey of ideaKeys) {
              matches[ideaKey] = {
                matchingSkillsCount: _.size(skillsByIdea[ideaKey]),
                creationTimestamp: timestampByIdea[ideaKey]
              }
            }

            for (const subscription of this._ideaMatchesSubscriptions) {
              subscription.propagateUpdate(matches)
            }

            return null
          })
      })
      .catch(err => {
        if (err) {
          console.error(err)
        }
      })
  }

  _findIdeaKeysForSkills (skillKeys) {
    return new Promise((resolve, reject, onCancel) => {
      const abortableStream = AbortableStream()
      onCancel(() => abortableStream.abort())

      pull(
        this._ssbAdapter.streamByType(IdeaAdapter.TYPE_IDEA_SKILL_ASSIGNMENT, false),
        abortableStream,
        pull.collect((err, msgs) => {
          if (err) {
            return reject(err)
          }

          const ideas = {}
          for (const msg of msgs) {
            const skillKey = msg.value.content.skillKey
            if (!skillKeys.includes(skillKey)) {
              continue
            }

            const ideaKey = msg.value.content.ideaKey
            const idea = ideas[ideaKey] || new Idea({ key: ideaKey })
            ideas[ideaKey] = idea.withSsbSkillAssignment(msg)
          }

          const skillsByIdea = {}
          for (const idea of Object.values(ideas)) {
            const ideaSkills = idea.skills()
            if (_.isEmpty(ideaSkills)) {
              continue
            }

            const ideaKey = idea.key()
            skillsByIdea[ideaKey] = ideaSkills
          }

          resolve(skillsByIdea)
        })
      )
    })
  }

  _getCreationTimestampByIdea (ideaKeys) {
    return new Promise((resolve) => {
      mapSeries(
        ideaKeys,
        (ideaKey, callback) => this._ssbAdapter.getValueByKey(ideaKey)
          .then(value => {
            value.key = ideaKey
            callback(null, value)

            return null
          })
          .catch(err => callback(err)),
        (errs, values) => {
          if (errs) {
            for (const err of errs) {
              console.error(err)
            }
          }

          const timestampByIdea = {}
          for (const value of values || []) {
            timestampByIdea[value.key] = value.timestamp
          }

          resolve(timestampByIdea)
        }
      )
    })
  }
}
