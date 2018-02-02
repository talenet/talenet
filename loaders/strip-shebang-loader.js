module.exports = function (source) {
  if (source.substring(0, 2) === '#!') {
    return source.slice(source.indexOf('\n'))
  }
  return source
}
