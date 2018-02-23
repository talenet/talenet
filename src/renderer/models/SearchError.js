import TaleError from './TaleError'

const MESSAGE_BASE_KEY = 'search.error.'
const ERROR_TYPE_BY_NAME = {
  NotFoundError: 'not-found'
}

/**
 * Error from performing a search.
 */
export default class SearchError extends TaleError {
  constructor (error) {
    let type
    if (error.type) {
      type = error.type
    }

    if (!type && error.name) {
      type = ERROR_TYPE_BY_NAME[error.name]
    }

    if (!type) {
      type = 'generic'
    }

    super(
      MESSAGE_BASE_KEY + type,
      error.value || [],
      error instanceof Error ? error : null
    )

    return this
  }
}
