<template>
  <div v-if="ownIdentity">
    <div class="row">
      <div class="t-center-col">
        <t-introduction-box messagesKey="identity.edit.introduction"></t-introduction-box>
      </div>
    </div>

    <div class="row t-identity-editor-panel">
      <div class="t-center-col">
        <b-form @submit="$event.preventDefault()">
          <t-input-group
            v-model="name"
            name="name"
            :label="$t('identity.edit.name.label')"
            :placeholder="$t('identity.edit.name.placeholder')"
            :description="$t('identity.edit.name.description')"
          ></t-input-group>

          <t-button-panel>
            <b-button
              slot="left"
              variant="primary"
              @click="saveName()">
              {{$t('identity.edit.name.save.button')}}
            </b-button>
          </t-button-panel>
        </b-form>
      </div>
    </div>

    <div class="row t-identity-editor-panel">
      <div class="t-center-col">
        <b-form @submit="$event.preventDefault()">
          <div class="t-identity-editor-image-label">{{$t('identity.edit.image.label')}}</div>

          <t-identity-image-chooser
            class="t-identity-editor-image-chooser"
            v-model="selectedImageFile"
            @change="showImageButtons()"
            :currentImageKey="ownIdentity.imageKey()"
          ></t-identity-image-chooser>

          <t-button-panel v-if="imageUnsaved">
            <b-button
              slot="left"
              variant="primary"
              @click="saveImage()">
              {{$t('identity.edit.image.save.button')}}
            </b-button>
            <b-button
              slot="left"
              variant="outline-primary"
              @click="clearImage()">
              {{$t('identity.edit.image.cancel.button')}}
            </b-button>
          </t-button-panel>
        </b-form>
      </div>
    </div>

    <div class="row">
      <div class="t-center-col">
        <t-identity-key-pair-download></t-identity-key-pair-download>
      </div>
    </div>
  </div>

  <t-center-on-page v-else>
    <t-loading-animation size="xl"></t-loading-animation>
  </t-center-on-page>
</template>

<script>
  import SubscriptionMixin from '../../mixins/Subscription'
  import { registerConstraints, resetValidation } from '../../util/validation.js'
  import { mapGetters } from 'vuex'

  export default {
    mixins: [
      SubscriptionMixin({
        '!': 'identity/subscribeOwnIdentityKey',
        'ownIdentityKey': 'identity/subscribe'
      })
    ],

    data () {
      return {
        name: null,
        selectedImageFile: null,
        imageUnsaved: false
      }
    },

    watch: {
      ownIdentity (ownIdentity) {
        if (this.name === null) {
          this.name = ownIdentity.name() || ownIdentity.key()
        }
      }
    },

    created () {
      registerConstraints(this, this.constraints)
    },

    computed: {
      ...mapGetters({
        constraints: 'identity/constraints',
        ownIdentity: 'identity/own',
        ownIdentityKey: 'identity/ownIdentityKey'
      })
    },

    methods: {
      clearName () {
        this.name = this.ownIdentity.name() || this.ownIdentity.key()
        resetValidation(this)
      },

      clearImage () {
        this.selectedImageFile = null
        this.imageUnsaved = false
      },

      showImageButtons () {
        this.imageUnsaved = this.selectedImageFile !== null
      },

      saveName () {
        const data = {
          name: this.name
        }
        Promise.resolve(this.$validator.validateAll(data)).then(valid => {
          if (!valid) {
            return null
          }

          return this.$store.dispatch(
            'identity/setName',
            {
              identityKey: this.ownIdentityKey,
              name: this.name
            }
          )
        }).then((key) => {
          if (key) {
            this.clearName()
          }
        }).catch((err) => {
          console.error(err)
        })
      },

      saveImage () {
        if (!this.selectedImageFile) {
          return
        }

        this.$store.dispatch(
          'identity/setImage',
          {
            identityKey: this.ownIdentityKey,
            imageFile: this.selectedImageFile
          }
        ).then((key) => {
          if (key) {
            this.clearImage()
          }
        }).catch((err) => {
          if (err) {
            console.log(err)
          }
        })
      }
    }
  }
</script>

<style lang="scss" scoped>
  @import "../../variables";

  .t-identity-editor-image-label,
  .t-identity-editor-image-chooser {
    margin: {
      left: $identity-editor-offset-x;
      right: $identity-editor-offset-x;
    }

  }

  .t-identity-editor-image-label {
    margin: {
      top: $identity-editor-offset-y;
    }
  }

  .t-identity-editor-image-chooser {
    margin: {
      bottom: $identity-editor-image-button-offset-y;
    }
  }

  .t-identity-editor-panel {
    margin: {
      top: $identity-editor-offset-y;
      bottom: $identity-editor-offset-y;
    }
  }
</style>
