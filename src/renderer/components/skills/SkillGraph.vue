<template>
  <div class="t-skill-graph">
    <canvas
      :width="width * clickResoultionRatio"
      :height="height * clickResoultionRatio"
      ref="clickMap"
      :style="clickMapCanvasStyle">
    </canvas>
    <canvas :width="width" :height="height" ref="canvas"></canvas>

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

      <t-hexagon-button class="t-skill-graph-zoom-button" @click="resumeSimulation()">R</t-hexagon-button>
      <t-hexagon-button class="t-skill-graph-zoom-button" @click="zoomBy(1)">+</t-hexagon-button>
      <t-hexagon-button class="t-skill-graph-zoom-button" @click="zoomBy(-1)">-</t-hexagon-button>
    </div>

    <t-skill-similarity-editor ref="similarityEditor" :skills="skills"></t-skill-similarity-editor>
  </div>
</template>

<script>
  import _ from 'lodash'
  import { mapGetters } from 'vuex'
  import {
    event,
    forceCenter,
    forceLink,
    forceManyBody,
    forceSimulation,
    forceX,
    forceY,
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
  const MIN_SKILL_CLICK_RADIUS = 15

  const SKILL_HUD_BUTTONS = 2

  const SKILL_HUD_BUTTON_SELECT_LEFT = 0
  const SKILL_HUD_BUTTON_SELECT_RIGHT = 1

  let nextClickColor = 1

  function genClickColor () {
    const r = (nextClickColor & 0x0000ff) >> 0
    const g = (nextClickColor & 0x00ff00) >> 8
    const b = (nextClickColor & 0xff0000) >> 16

    nextClickColor += 1

    return `rgb(${r},${g},${b})`
  }

  export default {
    props: {
      skills: {
        required: true,
        type: Object
      },

      similarities: {
        required: true,
        type: Object
      }
    },

    data () {
      return {
        $canvas: null,
        ctx: null,
        clickCtx: null,
        clickResoultionRatio: 0.2,
        simulation: null,
        zoomBehavior: null,
        zoomTransform: zoomIdentity,
        zoomLevel: 1,

        hovering: {},
        focusedSkillNode: null,

        width: 0,
        height: 0,

        skillHudButtonClickColors: [],
        nodesById: {}
      }
    },

    mounted () {
      this.initClickColors()

      const canvas = this.$refs.canvas
      this.ctx = canvas.getContext('2d')
      this.$canvas = select(canvas)

      this.clickCtx = this.$refs.clickMap.getContext('2d')

      this.zoomTransform = zoomIdentity

      this.cleanUpSimulation()
      this.simulation =
        forceSimulation()
          .force('charge', forceManyBody().strength(-50))
          .force('link', this.linkForce())
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
            this.simulation.force('link', this.linkForce())
            this.updateLinks()
          })
      this.$canvas.call(this.zoomBehavior)

      this.$canvas.on('click', this.onClick)
      this.$canvas.on('mousemove', this.onMouseMove)

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
      },

      hovering () {
        this.draw()
      }
    },

    computed: {
      ...mapGetters({
        'debugging': 'development/skilliverseDebug'
      }),

      clickAreas () {
        const clickAreas = {}

        const nodes = this.nodes
        const nodesById = this.nodesById
        for (const node of nodes) {
          clickAreas[node.clickColor] = {
            click: function () {
              this.focusSkill(nodesById[node.id])
            }.bind(this),
            hover: {
              skill: node.id
            }
          }
        }

        const skillHudButtonClickColors = this.skillHudButtonClickColors
        for (let button = 0; button < SKILL_HUD_BUTTONS; button++) {
          clickAreas[skillHudButtonClickColors[button]] = {
            click: function () {
              this.performSkillHudAction(button)
            }.bind(this),
            hover: {
              skillHudButton: button
            }
          }
        }

        return clickAreas
      },

      nodes () {
        return Object.values(this.skills).map(skill => {
          return {
            id: skill.key(),
            text: skill.name(),
            clickColor: genClickColor()
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
      },

      clickMapCanvasStyle () {
        const scale = 1 / this.clickResoultionRatio
        return {
          transformOrigin: 'top left',
          transform: `scale(${scale}, ${scale})`,
          visibility: this.debugging ? '' : 'hidden'
        }
      }
    },

    methods: {
      linkForce () {
        return forceLink()
          .id(d => d.id)
          .distance(20)
          .strength(() => 1 / Math.pow(this.zoomTransform.k, 2))
      },

      initClickColors () {
        const colors = []
        for (let button = 0; button < SKILL_HUD_BUTTONS; button++) {
          colors.push(genClickColor())
        }
        this.skillHudButtonClickColors = colors
      },

      resumeSimulation () {
        this.simulation.alpha(1)
        this.simulation.restart()
      },

      cleanUpSimulation () {
        if (this.simulation) {
          this.simulation.stop()
          this.simulation = null
        }
      },

      updateNodes () {
        if (this.simulation) {
          this.simulation.nodes(this.nodes)

          const nodesById = {}
          for (const node of this.simulation.nodes()) {
            nodesById[node.id] = node
          }
          this.nodesById = nodesById
          this.resumeSimulation()
        }
      },

      updateLinks () {
        if (this.simulation) {
          this.simulation.force('link').links(this.links)
          this.resumeSimulation()
        }
      },

      updateSize () {
        const boundingClientRect = this.$el.getBoundingClientRect()

        this.width = boundingClientRect.width
        this.height = boundingClientRect.height

        if (!this.width || !this.height) {
          return
        }

        const cx = this.width / 2
        const cy = this.height / 2
        this.simulation
          .force('center', forceCenter(cx, cy))
          .force('x', forceX(cx))
          .force('y', forceY(cy))

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
        const clickArea = this.getHoveredClickArea(mouse(this.$refs.canvas))

        if (clickArea && clickArea.click) {
          clickArea.click()
        } else {
          this.focusedSkillNode = null
        }
      },

      onMouseMove () {
        const clickArea = this.getHoveredClickArea(mouse(this.$refs.canvas))

        let hovering = {}
        if (clickArea && clickArea.hover) {
          hovering = clickArea.hover
        }

        if (!_.isEqual(this.hovering, hovering)) {
          this.hovering = hovering
        }
      },

      toClickCoordinates ({ x, y }) {
        const scale = this.clickResoultionRatio
        return {
          x: Math.round(scale * x),
          y: Math.round(scale * y)
        }
      },

      getHoveredClickArea ([x, y]) {
        const c = this.toClickCoordinates({ x, y })
        const [r, g, b, a] = this.clickCtx.getImageData(c.x, c.y, 1, 1).data
        if (a !== 255) {
          // alpha channel indicates the area is clickable at all
          return
        }

        const clickColor = `rgb(${r},${g},${b})`
        return this.clickAreas[clickColor]
      },

      focusSkill (skill) {
        this.focusedSkillNode = skill
        this.zoomTo(Math.max(4, this.zoomTransform.k), skill)
      },

      performSkillHudAction (button) {
        switch (button) {
          case SKILL_HUD_BUTTON_SELECT_LEFT:
            this.$refs.similarityEditor.setLeftSkill(this.focusedSkillNode.id)
            break

          case SKILL_HUD_BUTTON_SELECT_RIGHT:
            this.$refs.similarityEditor.setRightSkill(this.focusedSkillNode.id)
            break

          default:
            console.error('Unknown skill HUD button:', button)
        }
      },

      draw () {
        this.ctx.clearRect(0, 0, this.width, this.height)

        this.clickCtx.clearRect(0, 0, this.clickResoultionRatio * this.width, this.clickResoultionRatio * this.height)

        const links = this.simulation.force('link').links()
        for (const link of links) {
          this.drawLink(link)
        }

        // Collect focused and hovered skill to draw those last (on top of others)
        let focused = null
        let hovered = null

        const nodes = this.simulation.nodes()
        for (const node of nodes) {
          if (this.isSkillFocused(node)) {
            focused = node
          } else if (this.isSkillHovered(node)) {
            hovered = node
          } else {
            this.drawSkill(node)
          }
        }

        if (focused) {
          this.drawSkill(focused)
        }

        if (hovered) {
          this.drawSkill(hovered)
        }

        if (this.focusedSkillNode) {
          this.drawSkillHud(this.focusedSkillNode)
        }
      },

      isSkillFocused (node) {
        return this.focusedSkillNode && node.id === this.focusedSkillNode.id
      },

      isSkillHovered (node) {
        return node.id === this.hovering.skill
      },

      drawSkill (node) {
        const { x, y } = this.applyZoomTransform(node)
        const r = this.applyZoomScale(SKILL_RADIUS)
        const focused = this.isSkillFocused(node)
        const hovered = this.isSkillHovered(node)

        const clickRadius = Math.max(
          this.applyZoomScale(SKILL_RADIUS + 1),
          MIN_SKILL_CLICK_RADIUS
        )

        this.clickCtx.fillStyle = node.clickColor
        this.clickCtx.beginPath()
        this.clickCtx.arc(
          this.clickResoultionRatio * x,
          this.clickResoultionRatio * y,
          this.clickResoultionRatio * clickRadius,
          0,
          2 * Math.PI,
          true
        )
        this.clickCtx.fill()
        this.clickCtx.closePath()

        if (hovered) {
          this.ctx.shadowColor = TALE_GREEN
          this.ctx.shadowBlur = 20
        }

        if (this.zoomTransform.k >= 2) {
          const borderScale = Math.min(this.zoomTransform.k - 2, 1)
          const w = this.applyZoomScale(0.5)

          this.ctx.lineWidth = w * borderScale
          this.ctx.fillStyle = TALE_DARK_GREY
          this.ctx.strokeStyle = focused ? TALE_GREEN : TALE_DARK_BLUE

          this.ctx.beginPath()
          this.ctx.arc(x, y, borderScale * r, 0, 2 * Math.PI, true)
          this.ctx.fill()
          this.ctx.stroke()
          this.ctx.closePath()
        }

        if (this.zoomTransform.k < 4) {
          const dotScale = Math.min(4 - this.zoomTransform.k, 1)

          this.ctx.fillStyle = focused ? TALE_GREEN : TALE_WHITE

          this.ctx.beginPath()
          this.ctx.arc(x, y, dotScale * r * 0.2, 0, 2 * Math.PI, true)
          this.ctx.fill()
          this.ctx.closePath()
        }

        if (this.zoomTransform.k >= 3) {
          const textScale = Math.min(this.zoomTransform.k - 3, 1)

          const tx = x
          const ty = y + r + textScale * this.applyZoomScale(7)
          const th = this.applyZoomScale(5) * textScale
          const tw = this.ctx.measureText(node.text).width

          this.clickCtx.fillStyle = node.clickColor
          const tcx = this.clickResoultionRatio * (tx - 1.2 * tw / 2)
          const tcy = this.clickResoultionRatio * (ty - th)
          const tcw = this.clickResoultionRatio * (1.2 * tw)
          const tch = this.clickResoultionRatio * (1.5 * th)
          this.clickCtx.fillRect(tcx, tcy, tcw, tch)

          this.clickCtx.fillRect(
            this.clickResoultionRatio * (x - clickRadius),
            this.clickResoultionRatio * y,
            this.clickResoultionRatio * 2 * clickRadius,
            this.clickResoultionRatio * (ty - y + th / 3)
          )

          this.ctx.font = th + 'px OpenSansRegular'
          this.ctx.fillStyle = focused ? TALE_GREEN : TALE_DARK_BLUE
          this.ctx.textAlign = 'center'
          this.ctx.fillText(node.text, tx, ty)
        }

        if (hovered) {
          this.ctx.shadowColor = null
          this.ctx.shadowBlur = null
        }
      },

      drawLink (link) {
        const source = this.applyZoomTransform(link.source)
        const target = this.applyZoomTransform(link.target)

        const hoveringSkill = this.isSkillHovered(link.source) || this.isSkillHovered(link.target)

        if (hoveringSkill) {
          this.ctx.shadowColor = TALE_GREEN
          this.ctx.shadowBlur = 20
        }

        this.ctx.strokeStyle = TALE_DARK_BLUE

        this.ctx.lineWidth = 1 + Math.log(this.applyZoomScale(1))
        this.ctx.globalAlpha = Math.max(1 / this.zoomTransform.k, 0.4)

        this.ctx.beginPath()
        this.ctx.moveTo(source.x, source.y)
        this.ctx.lineTo(target.x, target.y)
        this.ctx.stroke()
        this.ctx.closePath()

        if (hoveringSkill) {
          this.ctx.shadowColor = null
          this.ctx.shadowBlur = null
        }

        this.ctx.globalAlpha = 1
      },

      drawSkillHud (node) {
        this.drawSkillHudButton(node, SKILL_HUD_BUTTON_SELECT_LEFT)
        this.drawSkillHudButton(node, SKILL_HUD_BUTTON_SELECT_RIGHT)
      },

      drawSkillHudButton (node, button) {
        const sPos = this.applyZoomTransform(node)
        const sx = sPos.x
        const sy = sPos.y
        const sr = this.applyZoomScale(SKILL_RADIUS)

        const angle = Math.PI * ((1 + button) / (SKILL_HUD_BUTTONS + 1))
        const offset = 2 * sr

        const bx = sx - offset * Math.cos(angle)
        const by = sy - offset * Math.sin(angle)
        const br = sr * 2 / 3

        const hovered = button === this.hovering.skillHudButton

        this.clickCtx.fillStyle = this.skillHudButtonClickColors[button]
        this.clickCtx.beginPath()
        this.clickCtx.arc(
          this.clickResoultionRatio * bx,
          this.clickResoultionRatio * by,
          this.clickResoultionRatio * (br + 4),
          0,
          2 * Math.PI,
          true
        )
        this.clickCtx.fill()
        this.clickCtx.closePath()

        this.ctx.lineWidth = 2
        this.ctx.fillStyle = TALE_DARK_GREY
        this.ctx.strokeStyle = TALE_GREEN

        if (hovered) {
          this.ctx.shadowColor = TALE_GREEN
          this.ctx.shadowBlur = 20
        }

        this.ctx.beginPath()
        this.ctx.arc(bx, by, br, 0, 2 * Math.PI, true)
        this.ctx.fill()
        this.ctx.stroke()
        this.ctx.closePath()

        if (hovered) {
          this.ctx.shadowColor = null
          this.ctx.shadowBlur = null
        }
      }
    }
  }
</script>

<style lang="scss">
  @import "../../variables";

  .t-skill-graph {
    width: 100%;
    height: 100%;

    canvas {
      position: absolute;
      left: 0;
      right: 0;
      top: 0;
      bottom: 0;
    }

    canvas {
      image-rendering: optimizeSpeed; // Older versions of FF
      image-rendering: -moz-crisp-edges; // FF 6.0+
      image-rendering: -webkit-optimize-contrast; // Webkit // (Safari now, Chrome soon)
      image-rendering: -o-crisp-edges; // OS X & Windows Opera (12.02+)
      image-rendering: optimize-contrast; // Possible future browsers.
      -ms-interpolation-mode: nearest-neighbor; // IE
    }

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
