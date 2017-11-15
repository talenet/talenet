import marked from 'ssb-marked'

// Documentation taken from: https://www.npmjs.com/package/ssb-marked
marked.setOptions({
  renderer: new marked.Renderer(),

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
  emoji: false
})

/**
 * Renders Markdown in a hopefully secure way to HTML.
 */
export default (markdown) => {
  return marked(markdown)
}
