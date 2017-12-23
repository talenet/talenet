<template>
  <svg :width="width" :height="height" @click="$emit('click', $event)" :class="classes">
    <polygon class="t-hexagon-image-bg" :points="points"></polygon>
    <clipPath v-if="href" :id="clipPathId">
      <polygon :points="points"></polygon>
    </clipPath>
    <image
      v-if="href"
      class="t-hexagon-image-img"
      :width="width"
      :height="height"
      preserveAspectRatio="xMidYMid slice"
      :clip-path="'url(#' + clipPathId + ')'"
      :xlink:href="href">
    </image>
    <image
      class="t-hexagon-image-static"
      v-if="href"
      :width="width"
      :height="height"
      preserveAspectRatio="xMidYMid slice"
      :clip-path="'url(#' + clipPathId + ')'"
      :xlink:href="staticImage">
    </image>
    <polygon class="t-hexagon-image-border" :points="points"></polygon>
  </svg>
</template>

<script>
  import HexagonMixin from '../mixins/Hexagon'

  export default {
    mixins: [HexagonMixin],

    data () {
      return {
        staticImage: null
      }
    },

    props: {
      'href': {
        type: String,
        required: false
      }
    },

    mounted () {
      this.updateStaticImage()
    },

    watch: {
      href () {
        this.updateStaticImage()
      }
    },

    computed: {
      classes () {
        const classes = ['t-hexagon-image']
        if (this.$listeners.click) {
          classes.push('t-hexagon-image-clickable')
        }

        return classes
      },

      clipPathId () {
        // Needs to be globally unique, otherwise the clip path of a different hexagon might be used.
        return 'hexagon-clip-' + this._uid
      }
    },

    methods: {
      updateStaticImage () {
        const img = document.createElement('img')
        img.crossOrigin = 'anonymous'
        img.src = this.href

        img.onload = () => {
          const canvas = document.createElement('canvas')
          canvas.setAttribute('width', img.width)
          canvas.setAttribute('height', img.height)
          canvas.getContext('2d').drawImage(img, 0, 0)
          this.staticImage = canvas.toDataURL()
        }
      }
    }
  }
</script>

<style lang="scss" scoped>
  @import "../variables";

  .t-hexagon-image-clickable {
    cursor: pointer;
  }

  .t-hexagon-image-bg {
    fill: $hexagon-image-bg;
  }

  .t-hexagon-image-img {
    display: none;
  }

  .t-hexagon-image:hover {
    .t-hexagon-image-img {
      display: block;
    }
    .t-hexagon-image-static {
      display: none;
    }
  }

  .t-hexagon-image-border {
    fill: none;
    stroke: $hexagon-image-border-color;
    stroke-width: 1px;
  }
</style>
