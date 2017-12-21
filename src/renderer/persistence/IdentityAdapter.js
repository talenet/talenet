import Promise from 'bluebird'
import pull from 'pull-stream'
import { saveAs } from 'file-saver'

import SSBAdapter from './SSBAdapter'
import Identity from '../models/Identity'
import SkillAdapter from './SkillAdapter'

const KEY_FILE_HEADER = `# this is your SECRET name.
# this name gives you magical powers.
# with it you can mark your messages so that your friends can verify
# that they really did come from you.
#
# if any one learns this name, they can use it to destroy your identity
# NEVER show this to anyone!!!

`
const KEY_FILE_FOOTER = `

# WARNING! It's vital that you DO NOT edit OR share your secret name
# instead, share your public name
# your public name: `

/**
 * Persistence adapter for loading and publishing identity related data.
 */
export default class IdentityAdapter {
  static IDENTITY_TYPE_PREFIX = SSBAdapter.TALENET_TYPE_PREFIX + 'identity-'
  static TYPE_IDENTITY_UPDATE_DETAILS = 'about' // predefined by ssb, thus no prefix
  static TYPE_IDENTITY_SET_IMAGE = IdentityAdapter.TYPE_IDENTITY_UPDATE_DETAILS // predefined by ssb, thus no prefix
  static TYPE_IDENTITY_SKILL_ASSIGNMENT = IdentityAdapter.IDENTITY_TYPE_PREFIX + 'skill_assignment'
  static TYPE_IDENTITY_BLOCK = 'contact' // predefined by ssb, thus no prefix

  _ownIdentityKeySubscriptions = []
  _identitySubscriptions = {}

  _identityByKey = {}

  constructor ({ ssbAdapter }) {
    this._ssbAdapter = ssbAdapter

    ssbAdapter.registerMessageHandlers({
      [IdentityAdapter.TYPE_IDENTITY_SKILL_ASSIGNMENT]: this._handleIdentitySkillAssignment.bind(this)
    })
  }

  connect () {
    return new Promise((resolve, reject) => {
      this._pullIdentities()
      resolve()
    })
  }

  _getIdentity (key) {
    return this._identityByKey[key] || new Identity({ key })
  }

  _setIdentity (identity) {
    this._identityByKey[identity.key()] = identity
  }

  _pullIdentities () {
    pull(
      this._ssbAdapter.streamAbouts(),
      pull.drain(about => {
        const key = about.author
        const currentIdentity = this._getIdentity(key)
        const updatedIdentity = currentIdentity.withSsbAbout(about.about)
        this._setIdentity(updatedIdentity)

        this._propagateIdentityUpdate(updatedIdentity)
      })
    )
  }

  subscribeOwnIdentityKey (onUpdate) {
    const subscription = this._ssbAdapter.subscribe(this._ownIdentityKeySubscriptions, null, onUpdate)

    // cheating for now as we currently do not support switching identities
    onUpdate(this.ownIdentityKey())

    return subscription
  }

  subscribeIdentities (onUpdate, identityKeys) {
    const subscription = this._ssbAdapter.subscribe(this._identitySubscriptions, identityKeys, onUpdate)

    for (const key of identityKeys) {
      this._propagateIdentityUpdate(this._getIdentity(key))
    }
    this._loadIdentitySkillAssociations(identityKeys)
    return subscription
  }

  _propagateIdentityUpdate (identity) {
    SSBAdapter.propagateUpdate(
      this._identitySubscriptions[identity.key()],
      identity
    )
  }

  _loadIdentitySkillAssociations (identityKeys) {
    return new Promise((resolve, reject) => {
      pull(
        this._ssbAdapter.streamByType(SkillAdapter.TYPE_IDENTITY_SKILL_ASSIGNMENT),
        pull.drain(msg => {
          if (identityKeys.includes(msg.value.author)) {
            this._handleIdentitySkillAssignment(msg)
          }
        }, () => {
          // TODO: Load skills?
          resolve()
        })
      )
    })
  }

  _updateIdentitySkillAssignment (skillKey, action) {
    return this._ssbAdapter.publish(IdentityAdapter.TYPE_IDENTITY_SKILL_ASSIGNMENT, {
      skillKey,
      action
    }).then(() => {
      return skillKey
    })
  }

  updateIdentityDetails (details) {
    const identityKey = details.identityKey
    const data = {
      about: identityKey,
      description: details.description
    }
    if (details.name) {
      data.name = details.name
    }
    return this._ssbAdapter.publish(IdentityAdapter.TYPE_IDENTITY_UPDATE_DETAILS, data).then(() => identityKey)
  }

  setIdentityImage (identityKey, imageFile) {
    return this._ssbAdapter.storeFile(imageFile)
      .then((imageKey) => {
        return this._ssbAdapter.publish(IdentityAdapter.TYPE_IDENTITY_SET_IMAGE, {
          about: identityKey,
          image: {
            link: imageKey,
            size: imageFile.size,
            type: imageFile.type
          }
        }).then(() => identityKey)
      })
  }

  assignSkillToIdentity (skillKey) {
    return this._updateIdentitySkillAssignment(skillKey, Identity.SSB_ACTION_ASSIGN_SKILL)
  }

  unassignSkillFromIdentity (skillKey) {
    return this._updateIdentitySkillAssignment(skillKey, Identity.SSB_ACTION_UNASSIGN_SKILL)
  }

  _handleIdentitySkillAssignment (msg) {
    const identityKey = msg.value.author

    const currentIdentity = this._getIdentity(identityKey)
    const updatedIdentity = currentIdentity.withSsbSkillAssignment(msg)

    this._setIdentity(updatedIdentity)

    this._propagateIdentityUpdate(updatedIdentity)
  }

  blockIdentity (identityKey) {
    if (identityKey === this.ownIdentityKey()) {
      return Promise.reject(new Error('Trying to block own identity: ', identityKey))
    }

    return this._ssbAdapter.publish(IdentityAdapter.TYPE_IDENTITY_BLOCK, {
      contact: identityKey,
      blocking: true
    }).then(() => {
      return identityKey
    })
  }

  ownIdentityKey () {
    return this._ssbAdapter.ownId()
  }

  downloadKeyPair () {
    return new Promise((resolve, reject) => {
      const secretKeys = this._ssbAdapter.secretKeys()
      const blob = new Blob(
        [
          KEY_FILE_HEADER,
          JSON.stringify(secretKeys, null, '  '),
          KEY_FILE_FOOTER,
          secretKeys.id
        ],
        { type: 'text/plain;charset=utf-8' }
      )
      saveAs(blob, 'talenet-keypair.secret')

      resolve()
    })
  }
}
