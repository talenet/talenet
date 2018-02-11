<template>
  <div class="t-identity-image-chooser">
    <b-form-file
      class="t-identity-image-chooser-file"
      plain
      v-model="selectedImageFile"
      ref="imageChooser"
      accept="image/jpeg, image/png, image/gif">
    </b-form-file>
    <t-hexagon-image
      class="t-identity-image-chooser-image"
      @click="chooseFile()"
      :href="selectedImageData || imageUrl(currentImageKey)">
    </t-hexagon-image>
    <div class="t-identity-image-chooser-overlay"></div>
    <div class="t-identity-image-chooser-icon"></div>
  </div>
</template>

<script>
  import { mapGetters } from 'vuex'

  export default {
    model: {
      prop: 'image',
      event: 'change'
    },

    props: {
      image: {
        type: File,
        required: false
      },
      currentImageKey: {
        type: String,
        required: true
      }
    },

    data () {
      return {
        selectedImageFile: null,
        selectedImageData: null
      }
    },

    watch: {
      image (image) {
        if (!image) {
          this.$refs.imageChooser.reset()
          this.selectedImageFile = null
          this.selectedImageData = null
        }
      },

      selectedImageFile () {
        this.$emit('change', this.selectedImageFile)

        if (!this.selectedImageFile) {
          return
        }

        const reader = new FileReader()

        reader.onload = (e) => {
          this.selectedImageData = e.target.result
        }
        reader.readAsDataURL(this.selectedImageFile)
      }
    },

    computed: {
      ...mapGetters({
        imageUrl: 'ssb/blobUrl'
      })
    },

    methods: {
      chooseFile () {
        this.$refs.imageChooser.$el.click()
      }
    }
  }
</script>

<style lang="scss">
  @import "../../variables";
  @import "../../mixins";

  .t-identity-image-chooser {
    position: relative;

    width: $identity-image-chooser-size;
    margin: {
      top: $identity-image-chooser-margin-y;
      bottom: $identity-image-chooser-margin-y;
    }

    .t-identity-image-chooser-image {
      cursor: pointer;
      width: 100%;
    }

    .t-identity-image-chooser-file {
      width: 0;
      height: 0;

      opacity: 0; // Hide but still allow clicking.
    }

    .t-identity-image-chooser-icon,
    .t-identity-image-chooser-overlay {
      pointer-events: none;
      opacity: 0;
      @include transition(opacity 0.3s ease-out);

      position: absolute;
      top: 0;
      left: 0;

      width: 100%;
      height: 100%;
    }

    .t-identity-image-chooser-icon {
      background: url(../../static/img/image-icon.svg) no-repeat center;
    }

    .t-identity-image-chooser-overlay {
      background-color: $identity-image-chooser-overlay-color;
    }

    &:hover .t-identity-image-chooser-icon {
      opacity: 1.0;
    }
    &:hover .t-identity-image-chooser-overlay {
      opacity: 0.7;
    }
  }
</style>
