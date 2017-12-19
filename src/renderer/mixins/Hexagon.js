import Vue from 'vue'

function point (cx, cy, r, n) {
  const angle = 2 * Math.PI * n / 6

  const cos = Math.cos(angle)
  const sin = Math.sin(angle)

  const px = r * cos
  const py = r * sin

  return {
    x: cx + px,
    y: cy + py
  }
}

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
    },

    calcPoints (skip = []) {
      const ps = []

      const cx = this.radius
      const cy = this.radius

      for (let n = 0; n < 6; n += 1) {
        if (!skip.includes(n)) {
          ps.push(point(cx, cy, this.radius - 1, n))
        }
      }

      return ps.map(({ x, y }) => x + ',' + y).join(' ')
    }
  },

  computed: {
    width () {
      return 2 * this.radius
    },

    height () {
      return 2 * this.radius
    },

    points () {
      return this.calcPoints()
    }
  }
}
