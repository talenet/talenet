import ssbClient from 'ssb-client'
import pull from 'pull-stream'
import FileReaderStream from 'pull-file-reader'
import AbortableStream from 'pull-abortable'
import Promise from 'bluebird'
import _ from 'lodash'

import Skill from '../models/Skill'
import Idea from '../models/Idea'
import Identity from '../models/Identity'

const PROTOCOL_VERSION = 1

const TALENET_TYPE_PREFIX = 'talenet-'

const SKILL_TYPE_PREFIX = TALENET_TYPE_PREFIX + 'skill-'
const TYPE_SKILL_CREATE = SKILL_TYPE_PREFIX + 'create'

const IDEA_TYPE_PREFIX = TALENET_TYPE_PREFIX + 'idea-'
const TYPE_IDEA_CREATE = IDEA_TYPE_PREFIX + 'create'
const TYPE_IDEA_UPDATE = IDEA_TYPE_PREFIX + 'update'
const TYPE_IDEA_SKILL_ASSIGNMENT = IDEA_TYPE_PREFIX + 'skill_assignment'
const TYPE_IDEA_HAT = IDEA_TYPE_PREFIX + 'hat'
const TYPE_IDEA_ASSOCIATION = IDEA_TYPE_PREFIX + 'association'
const TYPE_IDEA_COMMENT = IDEA_TYPE_PREFIX + 'comment'
const TYPE_IDEA_COMMENT_REPLY = IDEA_TYPE_PREFIX + 'comment_reply'

const IDENTITY_TYPE_PREFIX = TALENET_TYPE_PREFIX + 'identity-'
const TYPE_IDENTITY_SET_NAME = 'about' // predefined by ssb, thus no prefix
const TYPE_IDENTITY_SET_IMAGE = TYPE_IDENTITY_SET_NAME // predefined by ssb, thus no prefix
const TYPE_IDENTITY_SKILL_ASSIGNMENT = IDENTITY_TYPE_PREFIX + 'skill_assignment'

/**
 * Adapter for querying, creating and storing TALEnet data from / to SSB.
 */
export default class SSBAdapter {
  _ideaSubscriptions = {}

  _ideaMatches = []
  _ideaMatchesSubscriptions = []

  _ownIdeas = []
  _ownIdeasSubscriptions = []

  _skillSubscriptions = {}

  _aboutObservable = {}

  _ownIdentityKeySubscriptions = []
  _identitySubscriptions = {}

  constructor () {
    this._sbot = null
    this._store = null
  }

  connect (store) {
    this._store = store

    return new Promise((resolve, reject) => {
      // TODO: use config from loady
      ssbClient((err, sbot) => {
        if (err) {
          return reject(err)
        }
        this._sbot = sbot

        store.commit('ssb/connected')
        sbot.on('closed', () => {
          store.commit('ssb/disconnect')
        })

        this._pullMessages()
        resolve(this._registerAboutApi())
      })
    })
  }

  _registerAboutApi () {
    return new Promise((resolve, reject) => {
      const aboutApi = this._sbot.about
      if (!aboutApi) {
        reject(new Error('TALEnet needs the ssb-about plugin'))
      }

      if (!this._sbot.talequery) {
        reject(new Error('TALEnet needs the ssb-talequery plugin. If you want to use your own \'sbot server\' please use \'sbot plugins.install ssb-talequery\' to install it.'))
      }

      pull(
        aboutApi.stream({ live: true }),
        pull.drain((msg) => {
          aboutApi.get((err, aboutObservable) => {
            if (err) {
              // TODO: How can we handle this?
              console.error(err)
              return
            }

            this._aboutObservable = aboutObservable

            for (const authorIdentityKey in msg) {
              if (msg.hasOwnProperty(authorIdentityKey)) {
                this._propagateIdentityUpdate(authorIdentityKey)
              }
            }
          })
        })
      )

      resolve()
    })
  }

  _pullMessages () {
    /* cryptix: i think we should filter this to our types only
     * there is lot's of noise (like post and vote messages) that we don't handle either way
     */
    pull(
      this._sbot.createLogStream({ live: true }),
      pull.drain((msg) => this._handleMessage(msg))
    )
  }

  static _getMessageType (msg) {
    const value = msg.value
    if (!value) {
      return null
    }

    const content = value.content
    if (!content) {
      return null
    }

    const type = content.type
    if (typeof type !== 'string') {
      return null
    }

    return type
  }

  _handleMessage (msg) {
    const type = SSBAdapter._getMessageType(msg)
    if (!type) {
      return
    }

    if (type.startsWith(IDEA_TYPE_PREFIX)) {
      return this._handleIdeaMessage(msg, type)
    }

    if (type.startsWith(IDENTITY_TYPE_PREFIX)) {
      return this._handleIdentityMessage(msg, type)
    }
  }

  _handleIdentityMessage (msg, type) {
    switch (type) {
      case TYPE_IDENTITY_SKILL_ASSIGNMENT:
        this._handleIdentitySkillAssignment(msg)
        break

      default:
        console.error('Unexpected message type for identities:', type)
    }
  }

  _handleIdentitySkillAssignment (msg) {
    const identityKey = msg.value.author
    const currentIdentity = this._getIdentityFromStore(identityKey)
    const updatedIdentity = currentIdentity.withSsbSkillAssignment(msg)
    this._propagateUpdatesForIdentitySubscriptions(updatedIdentity)
  }

  _handleSkillMessage (msg, type) {
    switch (type) {
      case TYPE_SKILL_CREATE:
        this._handleSkillCreation(msg.key, msg.value)
        break

      default:
        console.error('Unexpected message type for skills:', type)
    }
  }

  _handleSkillCreation (skillKey, value) {
    const subscriptions = this._skillSubscriptions[skillKey]
    if (subscriptions) {
      const skill = Skill.fromSsbValue(skillKey, value)
      for (const subscription of subscriptions) {
        subscription.propagateUpdate(skill)
      }
    }
  }

  _getIdeaFromStore (key) {
    return this._store.getters['idea/get'](key) || new Idea({ key })
  }

  _subscriptionsForIdea (key) {
    return this._ideaSubscriptions[key] || []
  }

  _hasIdeaSubscription (key) {
    return !_.isEmpty(this._subscriptionsForIdea(key))
  }

  _propagateUpdatesForIdeaSubscriptions (idea) {
    for (const subscription of this._subscriptionsForIdea(idea.key())) {
      subscription.propagateUpdate(idea)
    }
  }

  _propagateUpdatesForIdentitySubscriptions (identity) {
    for (const subscription of this._identitySubscriptions[identity.key()] || []) {
      subscription.propagateUpdate(identity)
    }
  }

  _handleIdeaMessage (msg, type) {
    const key = type === TYPE_IDEA_CREATE ? msg.key : msg.value.content.ideaKey

    let idea = this._getIdeaFromStore(key)

    switch (type) {
      case TYPE_IDEA_CREATE:
        this._handleIdeaCreation(idea, msg.value)
        break

      case TYPE_IDEA_UPDATE:
        idea = idea.withSsbUpdate(msg)
        break

      case TYPE_IDEA_SKILL_ASSIGNMENT:
        idea = idea.withSsbSkillAssignment(msg)
        break

      case TYPE_IDEA_HAT:
        idea = idea.withSsbHatUpdate(msg)
        break

      case TYPE_IDEA_ASSOCIATION:
        idea = idea.withSsbIdeaAssociation(msg)
        this._updateOwnIdeas(idea)
        break

      case TYPE_IDEA_COMMENT:
        idea = idea.withSsbIdeaComment(msg)
        break

      case TYPE_IDEA_COMMENT_REPLY:
        idea = idea.withSsbIdeaCommentReply(msg)
        break

      default:
        console.error('Unexpected message type for idea update:', type)
    }

    if (this._hasIdeaSubscription(key)) {
      this._propagateUpdatesForIdeaSubscriptions(idea)
    }
  }

  _handleIdeaCreation (idea, value) {
    const updatedIdea = idea.withCreationTimestamp(value.timestamp)

    const key = idea.key()
    if (!this._ideaMatches.includes(key)) {
      this._ideaMatches.push(key)

      for (const subscription of this._ideaMatchesSubscriptions) {
        subscription.propagateUpdate([...this._ideaMatches])
      }
    }

    return updatedIdea
  }

  ideaExists (ideaKey) {
    return new Promise((resolve) => {
      this._sbot.get(ideaKey, (err, value) => {
        if (err) {
          console.error(err)
          return resolve({ ideaKey, exists: false })
        }

        const exists = value && value.content && value.content.type === TYPE_IDEA_CREATE

        if (exists) {
          const idea = this._handleIdeaCreation(this._getIdeaFromStore(ideaKey), value)
          this._propagateUpdatesForIdeaSubscriptions(idea)
        }

        resolve({ ideaKey, exists })
      })
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
            this._sbot.talequery.read({
              query: [{ $filter: { value: { content: { ideaKey } } } }],
              live: false
            }),
            pull.collect((err, msgs) => {
              if (err) {
                return reject(err)
              }

              for (const msg of msgs) {
                this._handleMessage(msg)
              }

              resolve(result)
            })
          )
        })
      })
  }

  _publish (type, payload) {
    return new Promise((resolve, reject) => {
      let msg = {
        ...payload,
        type,
        version: PROTOCOL_VERSION
      }
      this._sbot.publish(msg, (err, publishedMsg) => {
        if (err) {
          return reject(err)
        }

        resolve(publishedMsg)
      })
    })
  }

  publishPost (msg) {
    return this._publish('post', { text: msg })
  }

  _writeIdeaData (ideaPersistenceData) {
    const ideaKey = ideaPersistenceData.ideaKey()
    const promises = []

    const ssbUpdate = ideaPersistenceData.asSsbUpdate()
    if (ssbUpdate) {
      promises.push(this._publish(TYPE_IDEA_UPDATE, ssbUpdate))
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

  createIdea (ideaPersistenceData) {
    return this._publish(TYPE_IDEA_CREATE, {})
      .then((msg) => {
        return this.associateWithIdea(msg.key)
      }).then((ideaKey) => {
        return this.takeHat(ideaKey)
      }).then((ideaKey) => {
        return this._writeIdeaData(ideaPersistenceData.withKey(ideaKey))
      })
  }

  updateIdea (ideaPersistenceData) {
    return this._writeIdeaData(ideaPersistenceData)
  }

  _updateIdeaSkillAssignment (ideaKey, skillKey, action) {
    return this._publish(TYPE_IDEA_SKILL_ASSIGNMENT, {
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

  _updateHat (ideaKey, action) {
    return this._publish(TYPE_IDEA_HAT, {
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

  _updateIdeaAssociation (ideaKey, action) {
    return this._publish(TYPE_IDEA_ASSOCIATION, {
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

  postIdeaComment (ideaComment) {
    return this._publish(TYPE_IDEA_COMMENT, ideaComment.asSsbComment())
      .then((msg) => msg.key)
  }

  replyToIdeaComment (ideaCommentReply) {
    return this._publish(TYPE_IDEA_COMMENT_REPLY, ideaCommentReply.asSsbCommentReply())
      .then((msg) => msg.key)
  }

  createSkill (skill) {
    return this._publish(TYPE_SKILL_CREATE, skill.asSsbSkill())
      .then((msg) => msg.key)
  }

  static _normalizeTerm (term) {
    return term ? term.trim().toLowerCase() : ''
  }

  searchSkills (term) {
    return new Promise((resolve, reject, onCancel) => {
      const abortableStream = AbortableStream()
      onCancel(() => abortableStream.abort())

      const normalizedTerm = SSBAdapter._normalizeTerm(term)
      pull(
        this._sbot.query.read({
          query: [{ $filter: { value: { content: { type: TYPE_SKILL_CREATE } } } }],
          live: false
        }),
        abortableStream,
        pull.filter((msg) => {
          if (!msg.value) {
            return false
          }
          const name = msg.value.content.name
          return SSBAdapter._normalizeTerm(name).indexOf(normalizedTerm) >= 0
        }),
        pull.collect((err, msgs) => {
          if (err) {
            return reject(err)
          }

          for (const msg of msgs) {
            const type = SSBAdapter._getMessageType(msg)
            if (!type) {
              continue
            }
            this._handleSkillMessage(msg, type)
          }

          resolve(msgs.map((msg) => msg.key))
        })
      )
    })
  }

  _subscribe (subscriptions, onUpdate, keys) {
    const subscription = {
      promise: new Promise((resolve, reject, onCancel) => {
        onCancel(() => this._unsubscribe(subscriptions, subscription, keys))
      }),
      propagateUpdate: onUpdate
    }

    if (keys) {
      for (const key of keys) {
        const subscriptionsForKey = subscriptions[key] || []
        subscriptionsForKey.push(subscription)
        subscriptions[key] = subscriptionsForKey
      }
    } else {
      subscriptions.push(subscription)
    }

    return subscription.promise
  }

  _unsubscribe (subscriptions, subscription, keys) {
    if (keys) {
      for (const key of keys) {
        const subscriptionsForKey = subscriptions[key]
        if (subscriptionsForKey) {
          _.remove(subscriptionsForKey, (s) => s === subscription)
          if (_.isEmpty(subscriptionsForKey)) {
            delete subscriptions[key]
          }
        }
      }
    } else {
      _.remove(subscriptions, (s) => s === subscription)
    }
  }

  subscribeIdeas (onUpdate, ideaKeys) {
    const subscription = this._subscribe(this._ideaSubscriptions, onUpdate, ideaKeys)
    for (const key of ideaKeys) {
      this._loadIdea(key)
    }
    return subscription
  }

  subscribeIdeaMatches (onUpdate) {
    const subscription = this._subscribe(this._ideaMatchesSubscriptions, onUpdate)
    onUpdate([...this._ideaMatches])
    return subscription
  }

  _loadSkill (skillKey) {
    return new Promise((resolve, reject) => {
      this._sbot.get(skillKey, (err, value) => {
        if (err) {
          return reject(err)
        }

        const exists = value && value.content && value.content.type === TYPE_SKILL_CREATE
        if (exists) {
          this._handleSkillCreation(skillKey, value)
        }
      })
    })
  }

  subscribeSkills (onUpdate, skillKeys) {
    const subscription = this._subscribe(this._skillSubscriptions, onUpdate, skillKeys)
    for (const key of skillKeys) {
      this._loadSkill(key)
    }
    return subscription
  }

  _loadIdentitySkillAssociations (identityKeys) {
    return new Promise((resolve, reject) => {
      pull(
        this._sbot.query.read({
          query: [{ $filter: { value: { content: { type: TYPE_IDENTITY_SKILL_ASSIGNMENT } } } }],
          live: false
        }),
        pull.drain(msg => {
          if (identityKeys.includes(msg.value.author)) {
            this._handleIdentitySkillAssignment(msg)
          }
        }, () => {
          resolve()
        })
      )
    })
  }

  subscribeOwnIdentityKey (onUpdate) {
    const subscription = this._subscribe(this._ownIdentityKeySubscriptions, onUpdate)

    // cheating for now as we currently do not support switching identities
    onUpdate(this._sbot.id)

    return subscription
  }

  subscribeIdentities (onUpdate, identityKeys) {
    const subscription = this._subscribe(this._identitySubscriptions, onUpdate, identityKeys)
    for (const key of identityKeys) {
      this._propagateIdentityUpdate(key)
    }
    this._loadIdentitySkillAssociations(identityKeys)
    return subscription
  }

  _propagateIdentityUpdate (identityKey) {
    const subscriptions = this._identitySubscriptions[identityKey] || []
    if (_.isEmpty(subscriptions)) {
      return
    }

    const aboutFromIdentity = this._aboutObservable[identityKey]
    if (!aboutFromIdentity) {
      return
    }

    const currentIdentity = this._getIdentityFromStore(identityKey)
    const updatedIdentity = currentIdentity.withSsbAbout(identityKey, aboutFromIdentity)

    this._propagateUpdatesForIdentitySubscriptions(updatedIdentity)
  }

  _getIdentityFromStore (identityKey) {
    return this._store.getters['identity/get'](identityKey) || new Identity({ key: identityKey })
  }

  setIdentityName (identityKey, name) {
    return this._publish(TYPE_IDENTITY_SET_NAME, {
      about: identityKey,
      name: name
    }).then(() => identityKey)
  }

  _storeFile (file) {
    return new Promise((resolve, reject) => {
      pull(
        FileReaderStream(file),
        this._sbot.blobs.add((err, key) => {
          if (err) {
            return reject(err)
          }

          resolve(key)
        })
      )
    })
  }

  setIdentityImage (identityKey, imageFile) {
    return this._storeFile(imageFile)
      .then((imageKey) => {
        return this._publish(TYPE_IDENTITY_SET_IMAGE, {
          about: identityKey,
          image: {
            link: imageKey,
            size: imageFile.size,
            type: imageFile.type
          }
        }).then(() => identityKey)
      })
  }

  subscribeOwnIdeas (onUpdate) {
    const subscription = this._subscribe(this._ownIdeasSubscriptions, onUpdate)
    onUpdate([...this._ownIdeas])
    return subscription
  }

  _updateOwnIdeas (idea) {
    const key = idea.key()
    const associated = idea.isAssociated(this._sbot.id)
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

  _updateIdentitySkillAssignment (skillKey, action) {
    return this._publish(TYPE_IDENTITY_SKILL_ASSIGNMENT, {
      skillKey,
      action
    }).then(() => {
      return skillKey
    })
  }

  assignSkillToIdentity (skillKey) {
    return this._updateIdentitySkillAssignment(skillKey, Identity.SSB_ACTION_ASSIGN_SKILL)
  }

  unassignSkillFromIdentity (skillKey) {
    return this._updateIdentitySkillAssignment(skillKey, Identity.SSB_ACTION_UNASSIGN_SKILL)
  }
}
