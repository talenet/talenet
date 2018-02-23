import IdeaAdapter from './IdeaAdapter'
import SearchError from '../models/SearchError'

import Promise from 'bluebird'
import _ from 'lodash'

export default class SearchAdapter {
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

      if (this._ssbAdapter.isMessageKey(trimmedTerm)) {
        return resolve(
          this._ssbAdapter.getValueByKey(trimmedTerm)
            .then(value => this._handleFoundValue(trimmedTerm, value))
            .catch(err => {
              throw new SearchError(err)
            })
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
      return reject(new SearchError({
        type: 'invalid-query'
      }))
    })
  }

  _handleFoundValue (key, value) {
    const content = value.content
    if (!_.isObject(content)) {
      throw new SearchError({
        type: 'malformed-content'
      })
    }

    const type = content.type
    switch (type) {
      case IdeaAdapter.TYPE_IDEA_CREATE:
        return {
          type: 'idea',
          key
        }

      case 'post':
        if (value.private) {
          const root = content.root
          const threadKey = root || key
          return {
            type: 'privateMessage',
            key: threadKey
          }
        }
    }

    if (type.startsWith(IdeaAdapter.IDEA_TYPE_PREFIX)) {
      return {
        type: 'idea',
        key: content.ideaKey
      }
    }

    throw new SearchError({
      type: 'unsupported-type',
      value: type
    })
  }
}
