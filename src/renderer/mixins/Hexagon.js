import Vue from 'vue'
import { calcHexagonHeight, calcHexagonPoint } from '../util/hexagon'

export default {
  data () {
    return {
      radius: 0
    }
  },

  mounted () {
    this.updateRadius()
    window.removeEventListener('resize', this.updateRadius)
    window.addEventListener('resize', this.updateRadius)
  },

  destroyed () {
    window.removeEventListener('resize', this.updateRadius)
  },

  methods: {
    update () {
      Vue.nextTick().then(this.updateRadius.bind(this))
    },

    updateRadius () {
      this.radius = this.$el.getBoundingClientRect().width / 2
      return this.radius
    },

    calcPoints (skip = [], radius = null) {
      const ps = []

      const cx = this.radius
      const cy = calcHexagonHeight(this.radius) / 2

      let r = this.radius
      if (radius) {
        r = radius
      }

      for (let n = 0; n < 6; n += 1) {
        if (!skip.includes(n)) {
          ps.push(calcHexagonPoint(cx, cy, r - 1, n))
        }
      }

      return ps
    },

    calcPolygon (skip = [], radius = null) {
      return this.toPolygon(this.calcPoints(skip, radius))
    },

    toPolygon (points) {
      return points.map(({ x, y }) => x + ',' + y).join(' ')
    },

    calcPath (skip = [], radius = null) {
      return this.toPath(this.calcPoints(skip, radius))
    },

    toPath (points) {
      return 'M ' + points.map(({ x, y }) => x + ',' + y).join(' ')
    }
  },

  computed: {
    width () {
      return 2 * this.radius
    },

    height () {
      return calcHexagonHeight(this.radius)
    },

    points () {
      return this.calcPolygon()
    }
  }
}
