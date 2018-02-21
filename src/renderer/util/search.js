/**
 * Util for handling searches / search results.
 */

/**
 * Generate the error message for the specified search error object.
 * Return false if no error occurred.
 */
export function toErrorMessage ($t, error) {
  if (!error) {
    return false
  }

  const baseKey = 'search.error.'
  const messageKey = baseKey + error.type

  if (error.value !== undefined) {
    return $t(messageKey, [error.value])
  } else {
    return $t(messageKey)
  }
}

/**
 * Navigates to the found search result.
 *
 * @return true if navigation was initiated, otherwise false.
 */
export function navigateToSearchResult ($router, result) {
  switch (result.type) {
    case 'idea':
      return goTo($router, 'idea', { ideaKey: result.key })

    case 'identity':
      return goTo($router, 'identityDetails', { identityKey: result.key })

    case 'privateMessage':
      return goTo($router, 'messageThread', { threadKey: result.key })
  }

  console.warn('Invalid state. Search result not handled:', result)
  return false
}

function goTo ($router, name, params) {
  $router.push({
    name,
    params
  })

  return true
}
