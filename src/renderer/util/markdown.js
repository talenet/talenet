import marked from 'ssb-marked'
import highlight from 'highlight.js'
import ssbRef from 'ssb-ref'

class Renderer extends marked.Renderer {
  urltransform (url) {
    if (ssbRef.isFeedId(url)) {
      return '#/identity/' + encodeURIComponent(url)
    }

    if (ssbRef.isMsgId(url)) {
      return '#/search/' + encodeURIComponent(url)
    }

    if (ssbRef.isBlobId(url)) {
      // Linking to blobs is currently not supported.
      return false
    }

    try {
      if (decodeURIComponent(url).startsWith('@')) {
        // Don't link mentions until we can resolve those nicely.
        return false
      }
    } catch (err) {
      console.warn('Checking URL for @mention failed:', url, err)
    }

    // TODO: Handle invite URLs (.isInvite(), .isLegacyInvite(), .isMultiServerInvite())?
    // TODO: Maybe filter more protocols like file:// or only whitelist http and https.

    return super.urltransform(url)
  }
}

// Documentation taken from: https://www.npmjs.com/package/ssb-marked
marked.setOptions({
  renderer: new Renderer(),

  // Enable GitHub flavored markdown
  gfm: true,

  // Enable GFM tables. This option requires the gfm option to be true.
  tables: true,

  // Enable GFM line breaks. This option requires the gfm option to be true.
  breaks: false,

  // Conform to obscure parts of markdown.pl as much as possible.
  // Don't fix any of the original markdown bugs or poor behavior.
  pedantic: false,

  // Sanitize the output. Ignore any HTML that has been input.
  sanitize: true,

  // Use smarter list behavior than the original markdown.
  // May eventually be default with the old behavior moved into pedantic.
  smartLists: true,

  // Use "smart" typograhic punctuation for things like quotes and dashes.
  smartypants: false,

  // Emoji support. For details see: https://www.npmjs.com/package/ssb-marked
  emoji: false,

  highlight (code, lang) {
    try {
      if (highlight.getLanguage(lang)) {
        return highlight.highlight(lang, code).value
      } else {
        return highlight.highlightAuto(code).value
      }
    } catch (err) {
      console.warn(err)
      return code
    }
  }
})

/**
 * Renders Markdown in a hopefully secure way to HTML.
 */
export default (markdown) => {
  return markdown ? marked(markdown) : markdown
}
