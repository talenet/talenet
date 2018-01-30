<template>
  <div class="t-skill-graph">
    <div class="t-skill-graph-zoom-panel d-flex flex-column align-items-center">
      <t-slider
        class="t-skill-graph-zoom-slider"
        orientation="vertical"
        :min="1"
        :max="8"
        :step="0.1"
        :value="zoomLevel"
        @input="zoomTo($event.target.value)">
      </t-slider>

      <t-hexagon-button class="t-skill-graph-zoom-button" @click="zoomBy(1)">+</t-hexagon-button>
      <t-hexagon-button class="t-skill-graph-zoom-button" @click="zoomBy(-1)">-</t-hexagon-button>
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
    mouse,
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

  const SKILL_RADIUS = 5
  const MIN_SKILL_CLICK_RADIUS = 10

  function distance (p1, p2) {
    return Math.sqrt(
      Math.pow(p1.x - p2.x, 2) + Math.pow(p1.y - p2.y, 2)
    )
  }

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
        canvas: null,
        $canvas: null,
        ctx: null,
        simulation: null,
        zoomBehavior: null,
        zoomTransform: zoomIdentity,
        zoomLevel: 1,

        selectedSkill: null,

        width: 0,
        height: 0
      }
    },

    mounted () {
      this.canvas = this.$refs.canvas
      this.ctx = this.canvas.getContext('2d')
      this.$canvas = select(this.canvas)

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
          .on('end', () => {
            this.zoomLevel = this.zoomTransform.k
          })
      this.$canvas.call(this.zoomBehavior)

      this.$canvas.on('click', this.onClick)

      window.removeEventListener('resize', this.updateSize)
      window.addEventListener('resize', this.updateSize)
    },

    destroyed () {
      this.zoomBehavior = null
      this.cleanUpSimulation()
      window.removeEventListener('resize', this.updateSize)
      this.$canvas = null
      this.ctx = null
      this.canvas = null
    },

    watch: {
      nodes () {
        this.updateNodes()
      },

      links () {
        this.updateLinks()
      },

      selectedSkill () {
        this.draw()
      }
    },

    computed: {
      nodes () {
        return this.skills.map(skill => {
          return {
            id: skill.key(),
            text: skill.name()
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

      zoomTo (scale, p = null) {
        const duration = (2 + Math.abs(scale - this.zoomTransform.k)) * 200
        transition().duration(duration).tween('zoom', function () {
          const iScale = interpolate(this.zoomTransform.k, scale)

          let iTranslate = null
          if (p) {
            const p0 = this.zoomCenterPoint()
            const p1 = p

            iTranslate = {
              x: interpolate(p0.x, p1.x),
              y: interpolate(p0.y, p1.y)
            }
          }

          return function (t) {
            this.zoomBehavior.scaleTo(this.$canvas, iScale(t))

            if (iTranslate) {
              const pt = {
                x: iTranslate.x(t),
                y: iTranslate.y(t)
              }
              this.zoomBehavior.translateTo(this.$canvas, pt.x, pt.y)
            }
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

      zoomCenterPoint () {
        const [x, y] = this.zoomTransform.invert([this.width / 2, this.height / 2])
        return { x, y }
      },

      onClick () {
        const [x, y] = mouse(this.canvas)
        const p = { x, y }
        const maxSkillDistance = Math.max(
          this.applyZoomScale(SKILL_RADIUS + 1),
          MIN_SKILL_CLICK_RADIUS
        )

        const skills =
          this.simulation
            .nodes()
            .filter(node => distance(p, this.applyZoomTransform(node)) <= maxSkillDistance)
        if (skills.length === 0) {
          return
        }

        // TODO: Decide if we want to take nearest skill instead of first.
        const skill = skills[0]
        this.selectedSkill = skill.id

        this.zoomTo(Math.max(4, this.zoomTransform.k), skill)
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
        const r = this.applyZoomScale(SKILL_RADIUS)
        const selected = node.id === this.selectedSkill

        if (this.zoomTransform.k >= 2) {
          const borderScale = Math.min(this.zoomTransform.k - 2, 1)
          const w = this.applyZoomScale(1)

          this.ctx.lineWidth = w * borderScale
          this.ctx.fillStyle = TALE_DARK_GREY
          this.ctx.strokeStyle = selected ? TALE_GREEN : TALE_DARK_BLUE

          this.ctx.beginPath()
          this.ctx.arc(x, y, borderScale * r, 0, 2 * Math.PI, true)
          this.ctx.stroke()
          this.ctx.fill()
          this.ctx.closePath()
        }

        if (this.zoomTransform.k < 4) {
          const dotScale = Math.min(4 - this.zoomTransform.k, 1)

          this.ctx.fillStyle = selected ? TALE_GREEN : TALE_WHITE

          this.ctx.beginPath()
          this.ctx.arc(x, y, dotScale * r * 0.2, 0, 2 * Math.PI, true)
          this.ctx.fill()
          this.ctx.closePath()
        }

        if (this.zoomTransform.k >= 3) {
          const textScale = Math.min(this.zoomTransform.k - 3, 1)

          this.ctx.font = this.applyZoomScale(5) * textScale + 'px OpenSansRegular'
          this.ctx.fillStyle = selected ? TALE_GREEN : TALE_DARK_BLUE
          this.ctx.textAlign = 'center'
          this.ctx.fillText(node.text, x, y + r + textScale * this.applyZoomScale(7))
        }
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

    .t-skill-graph-zoom-slider {
      margin-bottom: 3rem;
    }

    .t-skill-graph-zoom-button {
      margin-top: -1px;
    }
  }
</style>
