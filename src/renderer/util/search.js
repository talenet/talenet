/**
 * Util for handling searches / search results.
 */

/**
 * Determines a target route for the given search result.
 *
 * @return false if no route could be determined.
 */
export function toSearchResultRoute (result) {
  switch (result.type) {
    case 'idea':
      return {
        name: 'idea',
        params: {
          ideaKey: result.key
        }
      }

    case 'identity':
      return {
        name: 'identityDetails',
        params: {
          identityKey: result.key
        }
      }

    case 'privateMessage':
      return {
        name: 'messageThread',
        params: {
          threadKey: result.key
        }
      }
  }

  console.warn('Invalid state. Search result not handled:', result)
  return false
}
