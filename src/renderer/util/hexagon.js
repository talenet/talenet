/**
 * Util for calculating hexagons.
 */

const ANGLE_60 = 2 * Math.PI / 6
const SIN_ANGLE_60 = Math.sin(ANGLE_60)

/**
 * Calculates the height of the hexagon from the given radius.
 */
export function calcHexagonHeight (r) {
  return 2 * r * SIN_ANGLE_60
}

/**
 * Calculates the n-th corner point of the hexagon centered around x, y
 * with a radius of r.
 */
export function calcHexagonPoint (x, y, r, n) {
  const angle = n * ANGLE_60

  const cos = Math.cos(angle)
  const sin = Math.sin(angle)

  const px = r * cos
  const py = r * sin

  return {
    x: x + px,
    y: y + py
  }
}
