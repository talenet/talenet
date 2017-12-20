<template>
  <div class="t-identity-image-chooser">
    <b-form-file
      class="t-identity-image-chooser-file"
      v-model="selectedImageFile"
      ref="imageChooser"
      accept="image/jpeg, image/png, image/gif">
    </b-form-file>
    <t-hexagon-image
      class="t-identity-image-chooser-image"
      @click="chooseFile()"
      :href="selectedImageData || imageUrl(currentImageKey)">
    </t-hexagon-image>
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

<style lang="scss" scoped>
  @import "../../variables";

  .t-identity-image-chooser {
    position: relative;

    width: $identity-image-chooser-size;
    height: $identity-image-chooser-size;

    .t-identity-image-chooser-image {
      width: 100%;
      height: 100%;
    }

    &:hover .t-identity-image-chooser-image {
      opacity: 0.6;
      cursor: pointer;
    }

    .t-identity-image-chooser-file {
      width: 0;
      height: 0;

      opacity: 0; // Hide but still allow clicking.
    }
  }
</style>
