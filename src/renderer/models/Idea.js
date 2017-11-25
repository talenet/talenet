import { filterFields } from '../util/objects'
import { addGetters } from '../util/immutableBean'
import IdeaUpdate from './IdeaUpdate'
import IdeaComment from './IdeaComment'
import IdeaCommentReply from './IdeaCommentReply'

const FIELDS = ['key', 'title', 'description', 'creationTimestamp']

const PROPERTY_HAT = 'hat'
const ACTION_TAKE_HAT = 'take'

const PROPERTY_ASSOCIATED = 'associated'
const ACTION_ASSOCIATE_WITH_IDEA = 'associate'

/**
 * Immutable class holding data for an idea.
 */
export default class Idea {
  constructor (data = {}, timestamps = {}, identityStates = {}, comments = [], repliesByComment = {}) {
    this._data = filterFields(data, FIELDS)
    this._timestamps = { ...timestamps }

    addGetters(this, this._data, FIELDS)

    this._identityStates = { ...identityStates }
    this._comments = [...comments]
    this._repliesByComment = {...repliesByComment}
  }

  static _identityStateHasProperty (identityState, property) {
    const propertyState = identityState[property]
    return propertyState && propertyState.hasProperty
  }

  _identityHasProperty (identityKey, property) {
    const identityState = this._identityStates[identityKey]
    if (!identityState) {
      return false
    }

    return Idea._identityStateHasProperty(identityState, property)
  }

  _identitiesWithProperty (property) {
    const keys = Object.keys(this._identityStates)
    return keys.filter((identityKey) => this._identityHasProperty(identityKey, property))
  }

  /**
   * Checks if the hat has been taken by the specified identity.
   */
  hasHat (identityKey) {
    // if identity is not associated with idea, we pretend they don't wear the hat
    if (!this.isAssociated(identityKey)) {
      return false
    }
    return this._identityHasProperty(identityKey, PROPERTY_HAT)
  }

  /**
   * The hat is considered to be taken if at least one identity is known to have taken it.
   */
  isHatTaken () {
    return this.hats().length > 0
  }

  /**
   * Identity keys of identities having taken the hat of the idea.
   */
  hats () {
    // if identity is not associated with idea, we pretend they don't wear the hat
    return this._identitiesWithProperty(PROPERTY_HAT).filter((identityKey) => this.isAssociated(identityKey))
  }

  /**
   * Checks if the specified identity is associated with the idea.
   */
  isAssociated (identityKey) {
    return this._identityHasProperty(identityKey, PROPERTY_ASSOCIATED)
  }

  /**
   * Identity keys of identities being associated with the idea.
   */
  associations () {
    return this._identitiesWithProperty(PROPERTY_ASSOCIATED)
  }

  /**
   * Comments at the idea in chronological order.
   */
  comments () {
    return [...this._comments]
  }

  /**
   * Replies to the specified comment at the idea in chronological order.
   */
  repliesForComment (commentKey) {
    const replies = this._repliesByComment[commentKey] || []
    return [...replies]
  }

  _withData (field, value) {
    const data = { ...this._data }
    data[field] = value
    return new Idea(
      data,
      this._timestamps,
      this._identityStates,
      this._comments,
      this._repliesByComment
    )
  }

  withKey (key) {
    return this._withData('key', key)
  }

  withCreationTimestamp (timestamp) {
    return this._withData('creationTimestamp', timestamp)
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
        newData[field] = this._data[field]
        newTimestamps[field] = this._timestamps[field]
      }
    }

    return new Idea(
      newData,
      newTimestamps,
      this._identityStates,
      this._comments,
      this._repliesByComment
    )
  }

  _withSsbIdentityStateUpdate (msg, property, propertySetAction) {
    const timestamp = msg.timestamp
    const identityKey = msg.value.author
    const action = msg.value.content.action
    const wantsProperty = action === propertySetAction

    let identityState = { ...this._identityStates[identityKey] }

    if (identityState.timestamp) {
      if (timestamp > identityState.timestamp) {
        identityState[property] = {
          timestamp,
          hasProperty: wantsProperty
        }
      }
    } else {
      identityState[property] = {
        timestamp,
        hasProperty: wantsProperty
      }
    }

    const newIdentityStates = { ...this._identityStates }
    newIdentityStates[identityKey] = identityState

    return new Idea(
      this._data,
      this._timestamps,
      newIdentityStates,
      this._comments,
      this._repliesByComment
    )
  }

  /**
   * Merge the idea with an hat update from SSB. This tracks for the hat state of each identity
   * a timestamp, so that the hat state will only be overwritten by an update with a newer timestamp.
   */
  withSsbHatUpdate (msg) {
    return this._withSsbIdentityStateUpdate(msg, PROPERTY_HAT, ACTION_TAKE_HAT)
  }

  /**
   * Merge the idea with an association update from SSB. This tracks for the association state of each identity
   * a timestamp, so that the association state will only be overwritten by an update with a newer timestamp.
   */
  withSsbIdeaAssociation (msg) {
    return this._withSsbIdentityStateUpdate(msg, PROPERTY_ASSOCIATED, ACTION_ASSOCIATE_WITH_IDEA)
  }

  /**
   * Merge the idea with an idea comment from SSB.
   */
  withSsbIdeaComment (msg) {
    return this.withIdeaComment(IdeaComment.fromSsb(msg))
  }

  /**
   * Merge the idea with an idea comment.
   */
  withIdeaComment (comment) {
    const key = comment.key()
    let comments
    // detect duplicates
    if (this._comments.some((existingComment) => existingComment.key() === key)) {
      comments = this._comments
    } else {
      comments = [...this._comments, comment]
      comments.sort((comment1, comment2) => comment1.timestamp() - comment2.timestamp())
    }
    return new Idea(
      this._data,
      this._timestamps,
      this._identityStates,
      comments,
      this._repliesByComment
    )
  }

  /**
   * Merge the idea with a reply to an idea comment from SSB.
   */
  withSsbIdeaCommentReply (msg) {
    return this.withIdeaCommentReply(IdeaCommentReply.fromSsb(msg))
  }

  /**
   * Merge the idea with a reply to an idea comment.
   */
  withIdeaCommentReply (commentReply) {
    const key = commentReply.key()
    const commentKey = commentReply.commentKey()
    const existingReplies = this._repliesByComment[commentKey] || []

    let repliesByComment
    // detect duplicate
    if (existingReplies.some((existingReply) => existingReply.key() === key)) {
      repliesByComment = this._repliesByComment
    } else {
      let newReplies = [...existingReplies, commentReply]
      newReplies.sort((reply1, reply2) => reply1.timestamp() - reply2.timestamp())
      repliesByComment = { ...this._repliesByComment }
      repliesByComment[commentKey] = newReplies
    }

    return new Idea(
      this._data,
      this._timestamps,
      this._identityStates,
      this._comments,
      repliesByComment
    )
  }

  asUpdate () {
    return new IdeaUpdate({
      ...this._data,
      ideaKey: this._data.key
    })
  }
}
