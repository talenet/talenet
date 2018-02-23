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
        :min="toSliderLevel(minZoomLevel)"
        :max="toSliderLevel(maxZoomLevel)"
        :step="0.1"
        :value="toSliderLevel(zoomLevel)"
        @input="zoomTo(fromSliderLevel($event.target.value))">
      </t-slider>

      <t-hexagon-button
        v-if="debugging.showResumeSimulationButton"
        class="t-skill-graph-zoom-button"
        @click="resumeSimulation()">
        R
      </t-hexagon-button>
      <t-hexagon-button class="t-skill-graph-zoom-button" @click="zoomIn()">+</t-hexagon-button>
      <t-hexagon-button class="t-skill-graph-zoom-button" @click="zoomOut()">-</t-hexagon-button>
    </div>

    <t-skilliverse-skill-type-ahead
      v-if="!linkEditorDisabled && (!selectedSkillKeys.left || !selectedSkillKeys.right)"
      ref="skillTypeAhead"
      :skills="skills"
      :selectedSkills="selectedSkillsSet"
      :bottom="typeAheadBottom"
      @suggest="highlightSuggestedSkills($event)"
      @select="selectSkill($event)">
    </t-skilliverse-skill-type-ahead>
  </div>
</template>

<script>
  import _ from 'lodash'
  import { mapGetters } from 'vuex'
  import Vue from 'vue'
  import { Graph } from 'graphlib'
  import {
    easeQuadOut,
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
  import { calcHexagonPoint } from '../../util/hexagon'
  import Identity from '../../models/Identity'

  // TODO: Find a better place to define colors in JS code.
  /* eslint-disable no-unused-vars */
  const TALE_BLACK = '#000000'
  const TALE_VERY_DARK_GREY = '#1c1c1c'
  const TALE_DARK_GREY = '#1e1e1e'
  const TALE_GREY = '#373636'
  const TALE_LIGHT_GREY = '#d5d3d3'
  const TALE_WHITE = '#ffffff'
  const TALE_BLUE = '#c1ffff'

  const TALE_DARK_BLUE = '#4ea2c2'
  const TALE_DARK_BLUE_BG = '#285364'

  const TALE_YELLOW = '#f2ff4d'
  const TALE_YELLOW_BG = '#666b2c'

  const TALE_GREEN = '#42f480'
  const TALE_GREEN_BG = '#2a633e'

  const TALE_RED = '#ff0047'
  const TALE_RED_BG = '#6d142d'

  const TALE_PURPLE = '#c34eff'
  const TALE_PURPLE_BG = '#51226a'
  /* eslint-enable no-unused-vars */

  const DEBUG_COLOR = TALE_RED

  const SKILL_COLOR = TALE_DARK_BLUE
  const SKILL_BG_COLOR = TALE_DARK_GREY
  const SKILL_OVERVIEW_COLOR = TALE_WHITE
  const SKILL_HOVER_COLOR = TALE_BLUE

  const OWN_SKILL_COLOR = TALE_PURPLE
  const OWN_SKILL_BG_COLOR = TALE_PURPLE_BG

  const SKILL_FOCUS_COLOR = TALE_BLUE
  const SKILL_FOCUS_BG_COLOR = TALE_DARK_BLUE_BG
  const SKILL_SELECT_LEFT_COLOR = TALE_BLUE
  const SKILL_SELECT_LEFT_BG_COLOR = TALE_DARK_GREY
  const SKILL_SELECT_RIGHT_COLOR = SKILL_SELECT_LEFT_COLOR
  const SKILL_SELECT_RIGHT_BG_COLOR = SKILL_SELECT_LEFT_BG_COLOR

  const SKILL_SIMILARITY_COLOR = TALE_DARK_BLUE
  const SKILL_SIMILARITY_OWN_VOTE_COLOR = TALE_PURPLE

  const LINK_HOVER_COLOR = TALE_YELLOW

  const LINK_EDITOR_BG_COLOR = TALE_VERY_DARK_GREY
  const LINK_EDITOR_BORDER_COLOR = TALE_DARK_BLUE

  const INITIAL_ZOOM_LEVEL = 1

  const MIN_ZOOM_LEVEL = 1 / 4
  const MAX_ZOOM_LEVEL = 8

  const SKILL_DOT_MAX_ZOOMLEVEL = 4
  const SKILL_CIRCLE_MIN_ZOOMLEVEL = 2
  const SKILL_TEXT_MIN_ZOOMLEVEL = 2
  const SKILL_HUD_MIN_ZOOMLEVEL = 2

  const SKILL_RADIUS = 5
  const MIN_SKILL_CLICK_RADIUS = 15

  const LINK_EDITOR_BUTTONS = 3
  const LINK_EDITOR_SLOT_LEFT = 0
  const LINK_EDITOR_SLOT_RIGHT = 1
  const LINK_EDITOR_ACTION = 2

  const SKILL_HUD_BUTTONS = 3
  const SKILL_HUD_BUTTON_SELECT_LEFT = 0
  const SKILL_HUD_BUTTON_SELECT_RIGHT = 2

  const SKILL_HUD_BUTTON_HOVER_COLOR = TALE_DARK_BLUE
  const SKILL_HUD_BUTTON_COLORS = {
    [SKILL_HUD_BUTTON_SELECT_LEFT]: TALE_BLUE,
    [SKILL_HUD_BUTTON_SELECT_RIGHT]: TALE_BLUE
  }
  const SKILL_HUD_BUTTON_BG_COLORS = {
    [SKILL_HUD_BUTTON_SELECT_LEFT]: TALE_DARK_BLUE_BG,
    [SKILL_HUD_BUTTON_SELECT_RIGHT]: TALE_DARK_BLUE_BG
  }

  const DIRECTION_INDICATOR_LENGTH = 30
  const DIRECTION_INDICATOR_WIDTH = 20

  let nextClickColor = 0x123456

  function genClickColor () {
    const r = (nextClickColor & 0x0000ff) >> 0
    const g = (nextClickColor & 0x00ff00) >> 8
    const b = (nextClickColor & 0xff0000) >> 16

    // We cannot disable anti-aliasing on the click canvas, which may result in incorrect lookups.
    // As a workaround we use a larger increment to have more non-zero bits and more distance between colors.
    // This should reduce the probability of matches via anti-aliasing. We also use a prime number as the
    // increment to maximise the cycle until first repetition.
    nextClickColor = (nextClickColor + 104711) % Math.pow(255, 3)

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
        type: Graph
      },

      ownIdentity: {
        required: false,
        type: Identity
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
        minZoomLevel: MIN_ZOOM_LEVEL,
        maxZoomLevel: MAX_ZOOM_LEVEL,
        zoomLevel: INITIAL_ZOOM_LEVEL,
        zoomTarget: INITIAL_ZOOM_LEVEL,
        zoomingToInProgress: false, // not for native zooming via mouse / touch

        hovering: {},
        focusedSkillNode: null,

        suggestedSkillKeys: new Set(),
        skillKeyForCompletion: null,
        linkEditorDisabled: false,
        typeAheadBottom: 0,

        selectedSkillKeys: {
          left: null,
          right: null
        },

        width: 0,
        height: 0,

        linkEditorClickColors: [],
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
          .scaleExtent([MIN_ZOOM_LEVEL, MAX_ZOOM_LEVEL])
          .clickDistance(5)
          .on('zoom', this.onZoom)
          .on('end', this.onZoomEnd)
      this.$canvas.call(this.zoomBehavior)

      this.$canvas.on('click', this.onClick)
      this.$canvas.on('mousemove', this.onMouseMove)
      this.$canvas.on('mouseout', this.onMouseOut)

      window.removeEventListener('resize', this.updateSize)
      window.addEventListener('resize', this.updateSize)
    },

    destroyed () {
      this.zoomBehavior = null
      this.cleanUpSimulation()
      window.removeEventListener('resize', this.updateSize)

      this.$canvas.remove()
      this.ctx = null
      this.clickCtx = null
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
      },

      'debugging.showVotes' () {
        this.draw()
      }
    },

    computed: {
      ...mapGetters({
        'debugging': 'development/skilliverseDebug'
      }),

      selectedSkillsSet () {
        const skills = new Set([])

        if (this.selectedSkillKeys.left) {
          skills.add(this.selectedSkillKeys.left)
        }
        if (this.selectedSkillKeys.right) {
          skills.add(this.selectedSkillKeys.right)
        }

        return skills
      },

      clickAreas () {
        const clickAreas = {}

        const nodes = this.nodes
        const nodesById = this.nodesById
        for (const node of nodes) {
          const key = node.id
          clickAreas[node.clickColor] = {
            click: function () {
              if (this.suggestedSkillKeys.has(key)) {
                this.selectSkill(key)
                this.focusedSkillNode = null
              } else {
                this.focusSkill(nodesById[key])
              }
            }.bind(this),
            hover: {
              skill: key
            }
          }
          clickAreas[node.clickGoToColor] = {
            click: function () {
              this.zoomToSkill(nodesById[key])
            }.bind(this),
            hover: {
              skill: key
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

        const linkEditorClickColors = this.linkEditorClickColors
        for (let button = 0; button < LINK_EDITOR_BUTTONS; button++) {
          clickAreas[linkEditorClickColors[button]] = {
            click: function () {
              this.performLinkEditorAction(button)
            }.bind(this),
            hover: {
              linkEditor: button
            }
          }
        }

        for (const link of this.links) {
          clickAreas[link.clickColor] = {
            click: function () {
              this.selectSkill(link.source.id, 'left')
              this.selectSkill(link.target.id, 'right')
              this.focusedSkillNode = null
              this.zoomToLink(link)
            }.bind(this),
            hover: {
              link: {
                id: link.id,
                source: link.source,
                target: link.target
              }
            }
          }
        }

        return clickAreas
      },

      nodes () {
        const ownSkills = new Set(this.ownIdentity && this.ownIdentity.skills())
        return Object.values(this.skills).map(skill => {
          const key = skill.key()
          return {
            id: key,
            text: skill.name(),
            clickColor: genClickColor(),
            clickGoToColor: genClickColor(),
            ownSkill: ownSkills.has(key)
          }
        })
      },

      links () {
        const ids = new Set(this.nodes.map(node => node.id))
        const links = []
        const similarities = this.similarities

        for (const edge of similarities.edges()) {
          if (!ids.has(edge.v) || !ids.has(edge.w)) {
            continue
          }

          const { distance, votes, ownVote } = similarities.edge(edge)
          links.push({
            id: `${edge.v}:${edge.w}`,
            source: edge.v,
            target: edge.w,
            clickColor: genClickColor(),
            distance,
            votes,
            ownVote: ownVote && ownVote.vote
          })
        }

        return links
      },

      clickMapCanvasStyle () {
        const scale = 1 / this.clickResoultionRatio
        return {
          transformOrigin: 'top left',
          transform: `scale(${scale}, ${scale})`,
          visibility: this.debugging.showClickAreas ? '' : 'hidden'
        }
      },

      selectedOwnVote () {
        const nodesById = this.nodesById
        const leftNode = this.selectedSkillKeys.left && nodesById[this.selectedSkillKeys.left]
        const rightNode = this.selectedSkillKeys.right && nodesById[this.selectedSkillKeys.right]
        const similarities = this.similarities

        const bothSelected = leftNode && rightNode
        if (!bothSelected) {
          return false
        }

        const edge = similarities.edge({ v: leftNode.id, w: rightNode.id })
        if (!edge) {
          return false
        }

        const ownVote = edge.ownVote
        return ownVote && ownVote.vote
      }
    },

    methods: {
      linkForce () {
        return forceLink()
          .id(d => d.id)
          .distance(20)
          .strength(() => 1 / Math.pow(Math.max(1, this.zoomTransform.k), 2))
      },

      genClickColors (n) {
        const colors = []
        for (let i = 0; i < n; i++) {
          colors.push(genClickColor())
        }

        return colors
      },

      initClickColors () {
        this.skillHudButtonClickColors = this.genClickColors(SKILL_HUD_BUTTONS)
        this.linkEditorClickColors = this.genClickColors(LINK_EDITOR_BUTTONS)
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

      toSliderLevel (zoomLevel) {
        if (zoomLevel >= 1) {
          return zoomLevel - 1
        }

        return 1 - 1 / zoomLevel
      },

      fromSliderLevel (sliderLevel) {
        if (sliderLevel >= 0) {
          return sliderLevel + 1
        }

        return 1 / (1 - sliderLevel)
      },

      zoomIn () {
        if (this.zoomTarget >= 1) {
          this.zoomTo(this.zoomTarget + 1)
        } else if (this.zoomTarget <= 0.5) {
          this.zoomTo(this.zoomTarget * 2)
        } else {
          this.zoomTo(2 - Math.log2(1 / this.zoomTarget))
        }
      },

      zoomOut () {
        if (this.zoomTarget >= 2) {
          this.zoomTo(this.zoomTarget - 1)
        } else {
          if (this.zoomTarget <= 1) {
            this.zoomTo(this.zoomTarget / 2)
          } else {
            this.zoomTo(1 / Math.pow(2, 2 - this.zoomTarget))
          }
        }
      },

      zoomTo (scale, p = null) {
        this.zoomingToInProgress = true
        this.zoomTarget = Math.min(MAX_ZOOM_LEVEL, Math.max(MIN_ZOOM_LEVEL, scale))
        this.zoomLevel = this.zoomTarget
        const duration = (2 + Math.abs(this.zoomTarget - this.zoomTransform.k)) * 200
        transition().duration(duration).ease(easeQuadOut).tween('zoom', function () {
          const iScale = interpolate(this.zoomTransform.k, this.zoomTarget)

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
        }.bind(this)).on('end', () => {
          this.zoomingToInProgress = false
          this.onZoomEnd()
        })
      },

      onZoom () {
        this.zoomTransform = event.transform
        this.draw()
      },

      onZoomEnd () {
        this.simulation.force('link', this.linkForce())
        this.updateLinks()

        if (!this.zoomingToInProgress) {
          this.zoomLevel = this.zoomTransform.k
          this.zoomTarget = this.zoomLevel
        }
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
        const clickArea = this.getHoveredClickArea()

        if (clickArea && clickArea.click) {
          clickArea.click()
        } else {
          this.focusedSkillNode = null
        }
      },

      onMouseMove () {
        const clickArea = this.getHoveredClickArea()

        let hovering = {}
        if (clickArea && clickArea.hover) {
          hovering = clickArea.hover
        }

        if (!_.isEqual(this.hovering, hovering)) {
          this.hovering = hovering
          this.$refs.canvas.style.cursor = _.isEmpty(this.hovering) ? '' : 'pointer'
        }
      },

      onMouseOut () {
        this.hovering = {}
        this.$refs.canvas.style.cursor = ''
      },

      toClickCoordinates ({ x, y }) {
        const scale = this.clickResoultionRatio
        return {
          x: Math.round(scale * x),
          y: Math.round(scale * y)
        }
      },

      getHoveredClickArea () {
        const canvas = this.$refs.canvas
        if (!canvas) {
          return
        }

        const [x, y] = mouse(canvas)
        const c = this.toClickCoordinates({ x, y })
        const [r, g, b, a] = this.clickCtx.getImageData(c.x, c.y, 1, 1).data
        if (a !== 255) {
          // alpha channel indicates the area is clickable at all
          return
        }

        const clickColor = `rgb(${r},${g},${b})`
        return this.clickAreas[clickColor]
      },

      zoomToSkill (skill) {
        this.zoomTo(Math.max(4, this.zoomTransform.k), skill)
      },

      zoomToLink (link) {
        this.zoomTo(
          Math.max(4, this.zoomTransform.k),
          {
            x: (link.source.x + link.target.x) / 2,
            y: (link.source.y + link.target.y) / 2
          }
        )
      },

      focusSkill (skill) {
        if (!this.selectedSkillsSet.has(skill.id)) {
          this.focusedSkillNode = skill
        }
        this.zoomToSkill(skill)
      },

      highlightSuggestedSkills (skillKeys) {
        this.suggestedSkillKeys = new Set(skillKeys)
        this.skillKeyForCompletion = skillKeys[0]
        this.draw()
      },

      selectSkill (skillKey, slot = null) {
        if (this.linkEditorDisabled) {
          return
        }

        this.focusedSkillNode = null

        if (!slot && !this.selectedSkillKeys.left) {
          slot = 'left'
        }

        if (!slot && !this.selectedSkillKeys.right) {
          slot = 'right'
        }

        if (!slot) {
          return
        }

        Vue.set(this.selectedSkillKeys, slot, skillKey)
        this.draw()
      },

      performSkillHudAction (button) {
        switch (button) {
          case SKILL_HUD_BUTTON_SELECT_LEFT:
            this.selectSkill(this.focusedSkillNode.id, 'left')
            break

          case SKILL_HUD_BUTTON_SELECT_RIGHT:
            this.selectSkill(this.focusedSkillNode.id, 'right')
            break

          default:
            console.error('Unknown skill HUD button:', button)
        }
      },

      performLinkEditorAction (button) {
        if (this.linkEditorDisabled) {
          return
        }

        switch (button) {
          case LINK_EDITOR_SLOT_LEFT:
            if (this.selectedSkillKeys.left) {
              this.selectSkill(null, 'left')
            } else if (this.skillKeyForCompletion) {
              this.selectSkill(this.skillKeyForCompletion, 'left')
            } else {
              this.$refs.skillTypeAhead.focus()
            }
            break

          case LINK_EDITOR_SLOT_RIGHT:
            if (this.selectedSkillKeys.right) {
              this.selectSkill(null, 'right')
            } else if (this.skillKeyForCompletion) {
              this.selectSkill(this.skillKeyForCompletion, 'right')
            } else {
              this.$refs.skillTypeAhead.focus()
            }
            break

          case LINK_EDITOR_ACTION:
            if (this.selectedOwnVote) {
              this.performVoteAction('voteAsNotSimilar')
            } else {
              this.performVoteAction('voteAsSimilar')
            }
            break

          default:
            console.error('Unknown skill HUD button:', button)
        }
      },

      performVoteAction (action) {
        const data = {
          skillKey1: this.selectedSkillKeys.left,
          skillKey2: this.selectedSkillKeys.right
        }

        if (!data.skillKey1 || !data.skillKey2) {
          return
        }

        this.linkEditorDisabled = true

        this.$store.dispatch('skill/' + action, data)
          .then(() => {
            this.linkEditorDisabled = false

            this.selectSkill(null, 'left')
            this.selectSkill(null, 'right')
          })
          .catch(err => {
            if (err) {
              console.error(err)
            }
            this.linkEditorDisabled = false
          })
          .finally(() => {
            this.draw()
          })

        this.draw()
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

        const suggestions = []
        const selections = []

        const nodes = this.simulation.nodes()
        for (const node of nodes) {
          if (this.suggestedSkillKeys.has(node.id)) {
            suggestions.push(node)
          }

          if (this.selectedSkillsSet.has(node.id)) {
            selections.push(node)
          }

          if (this.isSkillFocused(node)) {
            focused = node
          } else if (this.isSkillHovered(node)) {
            hovered = node
          } else {
            this.drawSkill(node)
          }
        }

        for (const node of suggestions) {
          this.drawSkillDirectionIndicator(node, SKILL_SELECT_LEFT_COLOR, SKILL_SELECT_LEFT_BG_COLOR)
        }

        for (const node of selections) {
          this.drawSkillDirectionIndicator(node, SKILL_SELECT_LEFT_COLOR, SKILL_SELECT_LEFT_BG_COLOR)
        }

        if (focused) {
          this.drawSkill(focused)
          this.drawSkillDirectionIndicator(focused, SKILL_FOCUS_COLOR, SKILL_FOCUS_BG_COLOR)
        }

        if (hovered) {
          this.drawSkill(hovered)
        }

        if (this.focusedSkillNode) {
          this.drawSkillHud(this.focusedSkillNode)
        }

        this.drawLinkEditor()
      },

      isSkillFocused (node) {
        return this.focusedSkillNode && node.id === this.focusedSkillNode.id
      },

      isSkillHovered (node) {
        return node.id === this.hovering.skill
      },

      drawCircle (x, y, r, ...actions) {
        this.ctx.beginPath()
        this.ctx.arc(x, y, r, 0, 2 * Math.PI, true)
        for (const action of actions) {
          this.ctx[action]()
        }
        this.ctx.closePath()
      },

      drawClickCircle (x, y, r, color) {
        this.clickCtx.save()

        this.clickCtx.fillStyle = color
        this.clickCtx.beginPath()
        this.clickCtx.arc(
          Math.floor(this.clickResoultionRatio * x),
          Math.floor(this.clickResoultionRatio * y),
          Math.ceil(this.clickResoultionRatio * r),
          0,
          2 * Math.PI,
          true
        )
        this.clickCtx.closePath()
        this.clickCtx.fill()

        this.clickCtx.restore()
      },

      drawClickRect (x, y, w, h, color) {
        this.clickCtx.fillStyle = color
        this.clickCtx.fillRect(
          Math.floor(this.clickResoultionRatio * x),
          Math.floor(this.clickResoultionRatio * y),
          Math.ceil(this.clickResoultionRatio * w),
          Math.ceil(this.clickResoultionRatio * h)
        )
      },

      drawTriangle: function (x, y, l, w, arc, ...actions) {
        this.ctx.save()

        this.ctx.translate(x, y)
        this.ctx.rotate(arc)
        this.ctx.translate(-x, -y)

        this.ctx.beginPath()
        this.ctx.moveTo(x, y)
        this.ctx.lineTo(x - l, y + w / 2)
        this.ctx.lineTo(x - l, y - w / 2)
        this.ctx.closePath()

        for (const action of actions) {
          this.ctx[action]()
        }

        this.ctx.restore()
      },

      drawClickTriangle: function (x, y, l, w, d, arc, color) {
        this.clickCtx.save()

        this.clickCtx.fillStyle = color

        const cx = this.clickResoultionRatio * x
        const cy = this.clickResoultionRatio * y
        const cw = this.clickResoultionRatio * w
        const cl = this.clickResoultionRatio * l
        const cd = this.clickResoultionRatio * d

        this.clickCtx.translate(cx, cy)
        this.clickCtx.rotate(arc)
        this.clickCtx.translate(-cx, -cy)

        this.clickCtx.beginPath()
        this.clickCtx.moveTo(cx + cd, cy - cd / 2)
        this.clickCtx.lineTo(cx + cd, cy + cd / 2)
        this.clickCtx.lineTo(cx - cl - cd, cy + cw / 2 + cd)
        this.clickCtx.lineTo(cx - cl - cd, cy - cw / 2 - cd)
        this.clickCtx.closePath()

        this.clickCtx.fill()

        this.clickCtx.restore()
      },

      drawHexagon (x, y, r, ...actions) {
        this.ctx.beginPath()

        const p0 = calcHexagonPoint(x, y, r, 0)
        this.ctx.moveTo(p0.x, p0.y)
        for (let n = 1; n < 6; n++) {
          const p = calcHexagonPoint(x, y, r, n)
          this.ctx.lineTo(p.x, p.y)
        }

        this.ctx.closePath()
        for (const action of actions) {
          this.ctx[action]()
        }
      },

      drawClickHexagon (x, y, r, color) {
        const cx = Math.floor(this.clickResoultionRatio * x)
        const cy = Math.floor(this.clickResoultionRatio * y)
        const cr = Math.ceil(this.clickResoultionRatio * r)

        this.clickCtx.save()

        this.clickCtx.fillStyle = color
        this.clickCtx.beginPath()

        const p0 = calcHexagonPoint(cx, cy, cr, 0)
        this.clickCtx.moveTo(p0.x, p0.y)
        for (let n = 1; n < 6; n++) {
          const p = calcHexagonPoint(cx, cy, cr, n)
          this.clickCtx.lineTo(p.x, p.y)
        }

        this.clickCtx.closePath()
        this.clickCtx.fill()

        this.clickCtx.restore()
      },

      drawClickLine (x0, y0, x1, y1, w, color) {
        const cx0 = this.clickResoultionRatio * x0
        const cy0 = this.clickResoultionRatio * y0
        const cx1 = this.clickResoultionRatio * x1
        const cy1 = this.clickResoultionRatio * y1
        const cw = Math.ceil(this.clickResoultionRatio * w)

        this.clickCtx.save()

        this.clickCtx.strokeStyle = color
        this.clickCtx.lineWidth = cw

        this.clickCtx.beginPath()
        this.clickCtx.moveTo(cx0, cy0)
        this.clickCtx.lineTo(cx1, cy1)
        this.clickCtx.closePath()
        this.clickCtx.stroke()

        this.clickCtx.restore()
      },

      drawCrossHair (x, y, r) {
        for (let n = 0; n < 6; n++) {
          const p0 = calcHexagonPoint(x, y, r, n - 1)
          const p1 = calcHexagonPoint(x, y, r, n)
          const p2 = calcHexagonPoint(x, y, r, n + 1)

          const q = 0.2

          this.ctx.beginPath()
          this.ctx.moveTo(q * p0.x + (1 - q) * p1.x, q * p0.y + (1 - q) * p1.y)
          this.ctx.lineTo(p1.x, p1.y)
          this.ctx.lineTo((1 - q) * p1.x + q * p2.x, (1 - q) * p1.y + q * p2.y)
          this.ctx.stroke()
          this.ctx.closePath()
        }
      },

      isInView ({ x, y }, tolerance = 0) {
        return (
          x >= 0 - tolerance &&
          x < this.width + tolerance &&
          y >= 0 - tolerance &&
          y < this.height + tolerance
        )
      },

      drawSkill (node) {
        const { x, y } = this.applyZoomTransform(node)

        if (!this.isInView({ x, y }, 250)) {
          return false
        }

        const r = this.applyZoomScale(SKILL_RADIUS)
        const focused = this.isSkillFocused(node)
        const hovered = this.isSkillHovered(node)
        const selected =
          (this.selectedSkillKeys.left === node.id && 'left') ||
          (this.selectedSkillKeys.right === node.id && 'right')
        const suggested =
          (this.suggestedSkillKeys.has(node.id) && 'left')

        let skillColor = SKILL_COLOR
        let skillBgColor = SKILL_BG_COLOR
        let overviewColor = SKILL_OVERVIEW_COLOR
        let hoverColor = SKILL_HOVER_COLOR
        if (node.ownSkill) {
          skillColor = OWN_SKILL_COLOR
          skillBgColor = OWN_SKILL_BG_COLOR
        }
        if (focused) {
          skillColor = SKILL_FOCUS_COLOR
          skillBgColor = SKILL_FOCUS_BG_COLOR
          overviewColor = skillColor
        }
        if (selected) {
          this.ctx.lineWidth = 3
          this.ctx.strokeStyle = selected === 'left' ? SKILL_SELECT_LEFT_COLOR : SKILL_SELECT_RIGHT_COLOR
          this.drawCrossHair(x, y, 1.5 * r)
        }
        if (suggested && hovered) {
          this.ctx.lineWidth = 3
          this.ctx.strokeStyle = suggested === 'left' ? SKILL_SELECT_LEFT_COLOR : SKILL_SELECT_RIGHT_COLOR
          this.drawCrossHair(x, y, 1.5 * r)
        }
        if (suggested) {
          skillColor = suggested === 'left' ? SKILL_SELECT_LEFT_COLOR : SKILL_SELECT_RIGHT_COLOR
          skillBgColor = suggested === 'left' ? SKILL_SELECT_LEFT_BG_COLOR : SKILL_SELECT_RIGHT_BG_COLOR
          overviewColor = skillColor
          hoverColor = skillColor
        }

        const clickRadius = Math.max(
          this.applyZoomScale(SKILL_RADIUS + 1),
          MIN_SKILL_CLICK_RADIUS
        )

        this.drawClickCircle(x, y, clickRadius, node.clickColor)

        this.ctx.save()

        if (hovered) {
          this.ctx.shadowColor = hoverColor
          this.ctx.shadowBlur = 20
        }

        if (this.zoomTransform.k >= SKILL_CIRCLE_MIN_ZOOMLEVEL) {
          const borderScale = Math.min(this.zoomTransform.k - SKILL_CIRCLE_MIN_ZOOMLEVEL, 1)
          const w = this.applyZoomScale(0.5)

          this.ctx.lineWidth = w * borderScale
          this.ctx.fillStyle = skillBgColor
          this.ctx.strokeStyle = skillColor

          this.drawCircle(x, y, borderScale * r, 'fill', 'stroke')
        }

        if (this.zoomTransform.k < SKILL_DOT_MAX_ZOOMLEVEL) {
          const dotScale = Math.min(SKILL_DOT_MAX_ZOOMLEVEL - this.zoomTransform.k, 1)

          this.ctx.fillStyle = overviewColor
          const dotRatio = suggested || focused ? 0.6 : 0.2
          this.drawCircle(x, y, dotScale * r * dotRatio, 'fill')
        }

        if (this.zoomTransform.k >= SKILL_TEXT_MIN_ZOOMLEVEL) {
          const textScale = Math.min(this.zoomTransform.k - SKILL_TEXT_MIN_ZOOMLEVEL, 1)

          const tx = x
          const ty = y + r + textScale * this.applyZoomScale(7)
          const th = this.applyZoomScale(5) * textScale

          this.ctx.font = th + 'px OpenSansRegular'
          this.ctx.fillStyle = skillColor
          this.ctx.textAlign = 'center'
          this.ctx.fillText(node.text, tx, ty)

          const tw = this.ctx.measureText(node.text).width

          this.drawClickRect(tx - 1.2 * tw / 2, ty - th, 1.2 * tw, 1.5 * th, node.clickColor)
          this.drawClickRect(x - clickRadius, y, 2 * clickRadius, ty - y + th / 3)
        }

        this.ctx.restore()

        return true
      },

      drawSkillDirectionIndicator (node, color, bgColor) {
        const { x, y } = this.applyZoomTransform(node)
        if (this.isInView({ x, y }, this.applyZoomScale(SKILL_RADIUS))) {
          return
        }

        // center
        const cx = this.width / 2
        const cy = this.height / 2

        // coordinates relative to center
        const xs = x - cx
        const ys = y - cy

        // distance from center
        const dc = Math.sqrt(xs * xs + ys * ys)
        if (dc === 0) {
          // should not happen
          return
        }

        // rotation angle relative to center in rad
        const arc = ys >= 0 ? Math.acos(xs / dc) : 2 * Math.PI - Math.acos(xs / dc)

        let xi
        let yi

        if (x < 0) {
          // left of screen
          xi = 0
          yi = xs === 0 ? cy : -ys / xs * this.width / 2 + cy

          if (yi < 0) {
            xi = ys === 0 ? cx : -xs / ys * this.height / 2 + cx
            yi = 0
          } else if (yi >= this.height) {
            xi = ys === 0 ? cx : xs / ys * this.height / 2 + cx
            yi = this.height - 1
          }
        } else if (x >= this.width) {
          // right of screen
          xi = this.width - 1
          yi = xs === 0 ? cy : ys / xs * this.width / 2 + cy

          if (yi < 0) {
            xi = ys === 0 ? cx : -xs / ys * this.height / 2 + cx
            yi = 0
          } else if (yi >= this.height) {
            xi = ys === 0 ? cx : xs / ys * this.height / 2 + cx
            yi = this.height - 1
          }
        } else if (y < 0) {
          // above screen
          xi = ys === 0 ? cx : -xs / ys * this.height / 2 + cx
          yi = 0
        } else if (y >= this.height) {
          // below screen
          xi = ys === 0 ? cx : xs / ys * this.height / 2 + cx
          yi = this.height - 1
        } else {
          // invalid case, node is on screen
          return
        }

        this.ctx.save()

        this.ctx.strokeStyle = color
        this.ctx.lineWidth = 2
        this.ctx.fillStyle = bgColor

        this.drawTriangle(xi, yi, DIRECTION_INDICATOR_LENGTH, DIRECTION_INDICATOR_WIDTH, arc, 'fill', 'stroke')
        this.drawClickTriangle(
          xi,
          yi,
          DIRECTION_INDICATOR_LENGTH,
          DIRECTION_INDICATOR_WIDTH,
          10,
          arc,
          node.clickGoToColor
        )

        this.ctx.restore()
      },

      drawLink (link) {
        const source = this.applyZoomTransform(link.source)
        const target = this.applyZoomTransform(link.target)

        // Note: We draw all the links even if both nodes aren't visible, because the links can go
        // across the sceen anyways.

        const hoveringSkill = this.isSkillHovered(link.source) || this.isSkillHovered(link.target)
        const focusedSkill = this.isSkillFocused(link.source) || this.isSkillFocused(link.target)
        const hasOwnSimilarityVote = !!link.ownVote
        const hoveringLink = this.hovering.link && this.hovering.link.id === link.id

        this.ctx.save()

        if (focusedSkill) {
          this.ctx.shadowColor = SKILL_FOCUS_COLOR
          this.ctx.shadowBlur = 20
        }

        if (hoveringSkill) {
          this.ctx.shadowColor = SKILL_HOVER_COLOR
          this.ctx.shadowBlur = 20
        }

        if (hoveringLink) {
          this.ctx.shadowColor = LINK_HOVER_COLOR
          this.ctx.shadowBlur = 20
        }

        this.ctx.strokeStyle = hasOwnSimilarityVote ? SKILL_SIMILARITY_OWN_VOTE_COLOR : SKILL_SIMILARITY_COLOR

        if (hoveringLink) {
          this.ctx.lineWidth = 2
        } else {
          this.ctx.lineWidth = Math.max(1 + Math.log(this.applyZoomScale(1)), 0.5)
          this.ctx.globalAlpha = Math.max(1 / this.zoomTransform.k, 0.4)
        }

        this.ctx.beginPath()
        this.ctx.moveTo(source.x, source.y)
        this.ctx.lineTo(target.x, target.y)
        this.ctx.closePath()
        this.ctx.stroke()

        this.drawClickLine(source.x, source.y, target.x, target.y, 19, link.clickColor)

        if (this.debugging.showVotes) {
          const cx = (source.x + target.x) / 2
          const cy = (source.y + target.y) / 2

          this.ctx.globalAlpha = 1
          this.ctx.font = Math.max(12, this.applyZoomScale(6)) + 'px OpenSansRegular'
          this.ctx.fillStyle = DEBUG_COLOR
          this.ctx.textAlign = 'center'
          this.ctx.fillText(`v: ${link.votes} d: ${link.distance}`, cx, cy)
        }

        this.ctx.restore()
      },

      drawSkillHud (node) {
        if (this.zoomTransform.k < SKILL_HUD_MIN_ZOOMLEVEL) {
          return
        }

        // no select buttons for selected skill
        if (this.selectedSkillKeys.left !== node.id && this.selectedSkillKeys.right !== node.id) {
          this.drawSkillHudButton(node, SKILL_HUD_BUTTON_SELECT_LEFT)
          this.drawSkillHudButton(node, SKILL_HUD_BUTTON_SELECT_RIGHT)
        }
      },

      drawSkillHudButton (node, button) {
        this.ctx.save()

        const sPos = this.applyZoomTransform(node)
        const sx = sPos.x
        const sy = sPos.y

        const hudScale = Math.min(this.zoomTransform.k - SKILL_HUD_MIN_ZOOMLEVEL, 1)
        const sr = this.applyZoomScale(SKILL_RADIUS)

        const angle = Math.PI * ((1 + button) / (SKILL_HUD_BUTTONS + 1))
        const offset = 2 * sr

        const bx = sx - offset * Math.cos(angle)
        const by = sy - offset * Math.sin(angle)
        const br = hudScale * sr * 2 / 3

        const hovered = button === this.hovering.skillHudButton

        this.drawClickHexagon(bx, by, br + 4, this.skillHudButtonClickColors[button])

        this.ctx.lineWidth = 2
        this.ctx.fillStyle = SKILL_HUD_BUTTON_BG_COLORS[button]
        this.ctx.strokeStyle = SKILL_HUD_BUTTON_COLORS[button]

        if (hovered) {
          this.ctx.shadowColor = SKILL_HUD_BUTTON_HOVER_COLOR
          this.ctx.shadowBlur = 20
        }

        this.drawHexagon(bx, by, br, 'fill')
        this.drawCrossHair(bx, by, br)

        this.ctx.font = 'bold ' + br + 'px OpenSansRegular'
        this.ctx.textAlign = 'center'
        this.ctx.textBaseline = 'middle'
        this.ctx.fillStyle = SKILL_HUD_BUTTON_COLORS[button]

        this.ctx.fillText('+', bx, by)

        this.ctx.restore()
      },

      drawLinkEditor () {
        this.ctx.save()

        const rSlot = Math.ceil(Math.min(35, this.height * 0.03))
        const rButton = Math.ceil(rSlot * 0.7)

        const cx = this.width / 2
        const cy = Math.floor(this.height - Math.max(2 * rSlot + 10, 50 + rButton))

        const typeAheadBottom = this.height - cy + 7
        if (this.typeAheadBottom !== typeAheadBottom) {
          this.typeAheadBottom = typeAheadBottom
        }

        const w = 450

        const lx = cx - w / 2
        const rx = cx + w / 2

        const hoveringSuggestedSkill = this.hovering.skill && this.suggestedSkillKeys.has(this.hovering.skill)
        const completionSkill =
          this.nodesById[hoveringSuggestedSkill ? this.hovering.skill : this.skillKeyForCompletion]

        const leftNode = this.selectedSkillKeys.left && this.nodesById[this.selectedSkillKeys.left]
        const rightNode = this.selectedSkillKeys.right && this.nodesById[this.selectedSkillKeys.right]

        const linkColor = !this.selectedOwnVote ? SKILL_SIMILARITY_COLOR : SKILL_SIMILARITY_OWN_VOTE_COLOR

        let leftSlot = null
        let rightSlot = null

        if (!leftNode && completionSkill) {
          leftSlot = {
            text: completionSkill.text,
            isCompletion: true
          }
        } else if (!rightNode && completionSkill) {
          rightSlot = {
            text: completionSkill.text,
            isCompletion: true
          }
        }

        if (!leftSlot) {
          leftSlot = {
            text: leftNode && leftNode.text,
            isCompletion: false
          }
        }
        if (!rightSlot) {
          rightSlot = {
            text: rightNode && rightNode.text,
            isCompletion: false
          }
        }

        if (this.focusedSkillNode) {
          switch (this.hovering.skillHudButton) {
            case SKILL_HUD_BUTTON_SELECT_LEFT:
              leftSlot = {
                text: this.focusedSkillNode.text,
                isCompletion: true
              }
              break

            case SKILL_HUD_BUTTON_SELECT_RIGHT:
              rightSlot = {
                text: this.focusedSkillNode.text,
                isCompletion: true
              }
              break
          }
        }

        leftSlot.button = LINK_EDITOR_SLOT_LEFT
        rightSlot.button = LINK_EDITOR_SLOT_RIGHT

        this.ctx.save()

        this.drawLinkEditorBg(lx, rx, cy, rSlot)

        this.ctx.strokeStyle = linkColor
        this.ctx.lineWidth = 1

        this.ctx.beginPath()
        this.ctx.moveTo(lx + rSlot, cy)
        if (leftNode && rightNode) {
          this.ctx.lineTo(cx - rButton, cy)
          this.ctx.moveTo(cx + rButton, cy)
        }
        this.ctx.lineTo(rx - rSlot, cy)
        this.ctx.closePath()
        this.ctx.stroke()

        this.ctx.restore()

        if (leftNode && rightNode) {
          this.drawLinkEditorButton(
            cx,
            cy,
            rButton,
            this.selectedOwnVote,
            linkColor,
            linkColor,
            TALE_DARK_GREY
          )
        }

        this.drawLinkEditorSlot(
          lx,
          cy,
          rSlot,
          leftSlot,
          TALE_BLUE,
          SKILL_COLOR,
          SKILL_COLOR,
          leftNode ? SKILL_SELECT_LEFT_COLOR : SKILL_COLOR,
          SKILL_BG_COLOR
        )
        this.drawLinkEditorSlot(
          rx,
          cy,
          rSlot,
          rightSlot,
          TALE_BLUE,
          SKILL_COLOR,
          SKILL_COLOR,
          rightNode ? SKILL_SELECT_RIGHT_COLOR : SKILL_COLOR,
          SKILL_BG_COLOR
        )

        this.ctx.restore()
      },

      drawLinkEditorBg (lx, rx, cy, rSlot) {
        this.ctx.save()
        // draw transparent background
        this.ctx.fillStyle = LINK_EDITOR_BG_COLOR
        this.ctx.strokeStyle = LINK_EDITOR_BORDER_COLOR
        this.ctx.lineWidth = 0.4
        this.ctx.globalAlpha = 0.9

        const by = (calcHexagonPoint(lx, cy, rSlot, 0).y + calcHexagonPoint(lx, cy, rSlot, 1).y) / 2

        const p0 = calcHexagonPoint(lx, cy, rSlot, 3)
        const p1 = calcHexagonPoint(lx, cy, rSlot, 4)

        const ml = (p0.y - p1.y) / (p0.x - p1.x)
        const mr = -ml

        const plt = calcHexagonPoint(lx, cy, rSlot + 30, 4)
        const prt = calcHexagonPoint(rx, cy, rSlot + 30, 5)

        const blx = (by - plt.y + ml * plt.x) / ml
        const brx = (by - prt.y + mr * prt.x) / mr

        this.ctx.beginPath()
        this.ctx.moveTo(-this.ctx.lineWidth, by)
        this.ctx.lineTo(blx, by)
        this.ctx.lineTo(plt.x, plt.y)
        this.ctx.lineTo(prt.x, prt.y)
        this.ctx.lineTo(brx, by)
        this.ctx.lineTo(this.width + this.ctx.lineWidth, by)
        this.ctx.lineTo(this.width + this.ctx.lineWidth, this.height + this.ctx.lineWidth)
        this.ctx.lineTo(-this.ctx.lineWidth, this.height + this.ctx.lineWidth)
        this.ctx.closePath()
        this.ctx.fill()
        this.ctx.stroke()

        this.ctx.restore()
      },

      drawLinkEditorButton (x, y, r, ownVote, iconColor, strokeColor, bgColor) {
        const hovering = this.hovering.linkEditor === LINK_EDITOR_ACTION

        this.ctx.save()

        if (hovering) {
          this.ctx.shadowColor = TALE_BLUE
          this.ctx.shadowBlur = 10
        }

        this.ctx.fillStyle = bgColor
        this.ctx.strokeStyle = strokeColor
        this.ctx.lineWidth = 1

        this.drawHexagon(x, y, r, 'stroke')

        this.ctx.font = 'bold ' + r + 'px OpenSansRegular'
        this.ctx.textAlign = 'center'
        this.ctx.textBaseline = 'middle'
        this.ctx.fillStyle = iconColor

        this.ctx.fillText(ownVote ? '×' : '+', x, y)

        this.ctx.restore()

        this.drawClickHexagon(x, y, 1.1 * r, this.linkEditorClickColors[LINK_EDITOR_ACTION])
      },

      drawLinkEditorSlot (x, y, r, slot, hoverColor, iconColor, skillNameColor, strokeColor) {
        const fontSize = 18
        const ty = y + 1.5 * r

        const hovering = this.hovering.linkEditor === slot.button
        const hasText = !!slot.text
        const hasSkill = hasText && !slot.isCompletion

        this.ctx.save()

        if (hovering || slot.isCompletion) {
          this.ctx.shadowColor = hoverColor
          this.ctx.shadowBlur = 10
        }

        this.ctx.save()
        this.ctx.lineWidth = 3
        this.ctx.strokeStyle = strokeColor
        this.drawCrossHair(x, y, r)
        this.ctx.restore()

        if (hasText) {
          this.ctx.save()
          this.ctx.lineWidth = 2
          this.ctx.strokeStyle = iconColor
          this.drawCircle(x, y, r * 0.6, 'stroke')
          this.ctx.restore()

          // TODO: Position wide skill names so that those won't clip into identity image
          this.ctx.save()
          this.ctx.font = fontSize + 'px OpenSansRegular'
          this.ctx.textAlign = 'center'
          this.ctx.textBaseline = 'middle'

          this.ctx.fillStyle = skillNameColor
          this.ctx.fillText(slot.text, x, ty)
          this.ctx.restore()
        }

        if (!hasSkill || hovering) {
          this.ctx.save()
          this.ctx.font = r + 'px OpenSansRegular'
          this.ctx.fillStyle = iconColor
          this.ctx.textAlign = 'center'
          this.ctx.textBaseline = 'middle'
          this.ctx.fillText(hasSkill ? '×' : '+', x, y)
          this.ctx.restore()
        }

        this.ctx.restore()

        this.drawClickHexagon(x, y, 1.1 * r, this.linkEditorClickColors[slot.button])
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

    .t-skill-graph-zoom-panel {
      pointer-events: none;

      position: absolute;
      bottom: $skilliverse-zoom-panel-bottom;
      right: $skilliverse-zoom-panel-right;
    }

    .t-skill-graph-zoom-slider {
      margin-bottom: $skilliverse-zoom-panel-slider-offset;
    }

    .t-skill-graph-zoom-button {
      margin-top: -1px;
    }
  }
</style>
