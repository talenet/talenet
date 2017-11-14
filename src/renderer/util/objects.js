/**
 * Util for working with objects.
 */

/**
 * Returns a copy of the given object only containing the specified fields. Other fields are being omitted.
 * If a field does not exists for the object it will not exist for the copy.
 */
export function filterFields (obj, fields) {
  let newObj = {}
  for (let field of fields) {
    if (obj.hasOwnProperty(field)) {
      newObj[field] = obj[field]
    }
  }

  return newObj
}
