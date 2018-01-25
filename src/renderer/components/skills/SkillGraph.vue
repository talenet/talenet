<template>
  <div class="t-skill-graph">
    <div class="t-skill-graph-zoom-panel">
      <b-button @click="zoomBy(1)">+</b-button>
      <b-button @click="zoomBy(-1)">-</b-button>

      <b-button @click="zoomTo(1)">1</b-button>
      <b-button @click="zoomTo(2)">2</b-button>
      <b-button @click="zoomTo(3)">3</b-button>
      <b-button @click="zoomTo(4)">4</b-button>
      <b-button @click="zoomTo(5)">5</b-button>
      <b-button @click="zoomTo(6)">6</b-button>
      <b-button @click="zoomTo(7)">7</b-button>
      <b-button @click="zoomTo(8)">8</b-button>
    </div>
    <canvas :width="width" :height="height" ref="canvas"></canvas>
  </div>
</template>

<script>
  import {
    event,
    forceCenter,
    forceLink,
    forceManyBody,
    forceSimulation,
    interpolate,
    select,
    transition,
    zoom,
    zoomIdentity
  } from 'd3'

  // TODO: Find a better place to define colors in JS code.
  /* eslint-disable no-unused-vars */
  const TALE_BLACK = '#000000'
  const TALE_DARK_GREY = '#1e1e1e'
  const TALE_GREY = '#373636'
  const TALE_LIGHT_GREY = '#d5d3d3'
  const TALE_WHITE = '#ffffff'
  const TALE_BLUE = '#c1ffff'
  const TALE_DARK_BLUE = '#4ea2c2'
  const TALE_YELLOW = '#f2ff4d'
  const TALE_GREEN = '#42f480'
  const TALE_RED = '#ff0047'
  /* eslint-enable no-unused-vars */

  export default {
    props: {
      skills: {
        required: true,
        type: Array
      },

      similarities: {
        required: true,
        type: Object
      }
    },

    data () {
      return {
        ctx: null,
        simulation: null,
        zoomBehavior: null,
        zoomTransform: zoomIdentity,

        width: 0,
        height: 0
      }
    },

    mounted () {
      const canvas = this.$refs.canvas
      this.ctx = canvas.getContext('2d')
      this.zoomTransform = zoomIdentity

      this.cleanUpSimulation()
      this.simulation =
        forceSimulation()
          .force('charge', forceManyBody().strength(-10))
          .force('link', forceLink().id(d => d.id).distance(20).strength(link => 1.1 - 1 / link.votes))
          .on('tick', this.draw)
          .stop() // we start after having a non-zero canvas size in updateSize()

      this.updateNodes()
      this.updateLinks()

      this.updateSize()
      this.zoomBehavior =
        zoom()
          .scaleExtent([1, 8])
          .on('zoom', this.onZoom)
      select(canvas).call(this.zoomBehavior)

      window.removeEventListener('resize', this.updateSize)
      window.addEventListener('resize', this.updateSize)
    },

    destroyed () {
      this.zoomBehavior = null
      this.cleanUpSimulation()
      window.removeEventListener('resize', this.updateSize)
      this.ctx = null
    },

    watch: {
      nodes () {
        this.updateNodes()
      },

      links () {
        this.updateLinks()
      }
    },

    computed: {
      nodes () {
        return this.skills.map(skill => {
          return {
            id: skill.key()
          }
        })
      },

      links () {
        const links = []
        const similarities = this.similarities

        for (const skillKey1 of Object.keys(similarities)) {
          const skillSimilarities = similarities[skillKey1]
          for (const skillKey2 of Object.keys(skillSimilarities)) {
            const votes = skillSimilarities[skillKey2] || 0
            if (votes > 0) {
              links.push({
                source: skillKey1,
                target: skillKey2,
                votes: votes
              })
            }
          }
        }

        return links
      }
    },

    methods: {
      cleanUpSimulation () {
        if (this.simulation) {
          this.simulation.stop()
          this.simulation = null
        }
      },

      updateNodes () {
        if (this.simulation) {
          this.simulation.nodes(this.nodes)
        }
      },

      updateLinks () {
        if (this.simulation) {
          this.simulation.force('link').links(this.links)
        }
      },

      updateSize () {
        const boundingClientRect = this.$el.getBoundingClientRect()

        this.width = boundingClientRect.width
        this.height = boundingClientRect.height

        if (!this.width || !this.height) {
          return
        }

        this.simulation.force('center', forceCenter(this.width / 2, this.height / 2))
        this.simulation.restart()
      },

      zoomBy (delta) {
        this.zoomTo(this.zoomTransform.k + delta)
      },

      zoomTo (scale) {
        transition().duration(350).tween('zoom', function () {
          const iScale = interpolate(this.zoomTransform.k, scale)
          return function (t) {
            this.zoomBehavior.scaleTo(select(this.$refs.canvas), iScale(t))
          }.bind(this)
        }.bind(this))
      },

      onZoom () {
        this.zoomTransform = event.transform
        this.draw()
      },

      applyZoomTransform (d) {
        const [x, y] = this.zoomTransform.apply([d.x, d.y])
        return {
          x,
          y
        }
      },

      applyZoomScale (n) {
        return this.zoomTransform.k * n
      },

      draw () {
        this.ctx.clearRect(0, 0, this.width, this.height)

        const links = this.simulation.force('link').links()
        for (const link of links) {
          this.drawLink(link)
        }

        const nodes = this.simulation.nodes()
        for (const node of nodes) {
          this.drawSkill(node)
        }
      },

      drawSkill (node) {
        const { x, y } = this.applyZoomTransform(node)
        const r = this.applyZoomScale(5)

        if (this.zoomTransform.k >= 3) {
          const frac = Math.min(this.zoomTransform.k - 3, 1)
          const w = this.applyZoomScale(1)

          this.ctx.lineWidth = w * frac
          this.ctx.fillStyle = TALE_DARK_GREY
          this.ctx.strokeStyle = TALE_GREY

          this.ctx.beginPath()
          this.ctx.arc(x, y, frac * r, 0, 2 * Math.PI, true)
          this.ctx.stroke()
          this.ctx.fill()
          this.ctx.closePath()
        }

        this.ctx.fillStyle = TALE_WHITE

        this.ctx.beginPath()
        this.ctx.arc(x, y, r * 0.2, 0, 2 * Math.PI, true)
        this.ctx.fill()
        this.ctx.closePath()
      },

      drawLink (link) {
        const source = this.applyZoomTransform(link.source)
        const target = this.applyZoomTransform(link.target)

        const w = this.applyZoomScale(1)

        this.ctx.lineWidth = w
        this.ctx.strokeStyle = TALE_DARK_BLUE

        this.ctx.beginPath()
        this.ctx.moveTo(source.x, source.y)
        this.ctx.lineTo(target.x, target.y)
        this.ctx.stroke()
        this.ctx.closePath()
      }
    }
  }
</script>

<style lang="scss" scoped>
  .t-skill-graph {
    width: 100%;
    height: 100%;

    .t-skill-graph-zoom-panel {
      // TODO: Extract variables as soon as zoom panel is nice.
      position: absolute;
      bottom: 1rem;
      right: 1rem;
    }
  }
</style>
