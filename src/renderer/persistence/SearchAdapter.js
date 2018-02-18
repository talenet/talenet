import IdeaAdapter from './IdeaAdapter'

import Promise from 'bluebird'
import _ from 'lodash'

export default class SkillAdapter {
  constructor ({ ssbAdapter }) {
    this._ssbAdapter = ssbAdapter
  }

  connect () {
    // Nothing to see here, move along...!
    return Promise.resolve()
  }

  find (term) {
    return new Promise((resolve, reject) => {
      const trimmedTerm = term.trim()
      console.log(trimmedTerm)

      if (this._ssbAdapter.isMessageKey(trimmedTerm)) {
        return resolve(
          this._ssbAdapter.getValueByKey(trimmedTerm)
            .then(value => this._handleFoundValue(trimmedTerm, value))
        )
      }

      if (this._ssbAdapter.isIdentityKey(trimmedTerm)) {
        return resolve({
          found: {
            type: 'identity',
            key: trimmedTerm
          }
        })
      }

      // Blobs and text search aren't supported yet.
      return resolve({
        error: {
          type: 'invalid-query'
        }
      })
    })
  }

  _handleFoundValue (key, value) {
    console.log(value)

    const content = value.content
    if (!_.isObject(content)) {
      return {
        error: {
          type: 'malformed-content'
        }
      }
    }

    const type = content.type
    switch (type) {
      case IdeaAdapter.TYPE_IDEA_CREATE:
        return {
          found: {
            type: 'idea',
            key
          }
        }

      case 'post':
        if (value.private) {
          const root = content.root
          const threadKey = root || key
          return {
            found: {
              type: 'privateMessage',
              key: threadKey
            }
          }
        }
    }

    if (type.startsWith(IdeaAdapter.IDEA_TYPE_PREFIX)) {
      return {
        found: {
          type: 'idea',
          key: content.ideaKey
        }
      }
    }

    return {
      error: {
        type: 'unsupported-type',
        value: type
      }
    }
  }
}
