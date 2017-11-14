/**
 * Util for creating immutable data beans.
 */

/**
 * Adds getters on the given object for the specified fields. Each getter will return the corresponding
 * field of the data object. E.g.:
 *
 * <code>
 *     const FIELDS = ['title', 'value']
 *
 *     class Bean {
 *         constructor () {
 *             this._data = {
 *                 title: 'TITLE',
 *                 value: 'VALUE'
 *             }
 *             addGetters(this, this._data, FIELDS)
 *         }
 *     }
 *
 *     let b = new Bean()
 *     console.log(b.title()) // => 'TITLE'
 * </code>
 */
export function addGetters (obj, data, fields) {
  for (let field of fields) {
    obj[field] = () => data[field]
  }
}
