import { filterFields } from '../util/objects'
import { addGetters } from '../util/immutableBean'

const FIELDS = ['key', 'ideaKey', 'commentKey', 'authorIdentityKey', 'text', 'timestamp']

/**
 * Immutable class holding data for a reply to an idea comment.
 */
export default class IdeaCommentReply {
  constructor (data = {}) {
    this._data = filterFields(data, FIELDS)
    addGetters(this, this._data, FIELDS)
  }

  static fromSsb (msg) {
    const content = msg.value.content
    return new IdeaCommentReply({
      key: msg.key,
      ideaKey: content.ideaKey,
      commentKey: content.commentKey,
      authorIdentityKey: msg.value.author,
      text: content.text,
      timestamp: msg.timestamp
    })
  }

  withKey (key) {
    return new IdeaCommentReply({
      ...this._data,
      key
    })
  }

  asSsbCommentReply () {
    return {
      ideaKey: this._data.ideaKey,
      commentKey: this._data.commentKey,
      text: this._data.text
    }
  }
}
