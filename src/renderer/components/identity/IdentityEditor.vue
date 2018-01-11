<template>
  <div v-if="ownIdentity">
    <div class="row">
      <div class="t-wide-col">
        <t-introduction-box messagesKey="identity.edit.introduction"></t-introduction-box>
      </div>
    </div>

    <b-form class="t-identity-editor-panel" @submit="$event.preventDefault()">
      <fieldset :disabled="saving">
        <div class="row">
          <div class="t-wide-col">
            <t-input-group
              v-model="name"
              name="name"
              @focus="touchedDetails()"
              :maxLength="constraints.name.max"
              :label="$t('identity.edit.name.label')"
              :placeholder="$t('identity.edit.name.placeholder')"
              :description="$t('identity.edit.name.description')"
            ></t-input-group>
          </div>
        </div>

        <t-markdown-input-group
          v-model="description"
          :rows="10"
          name="description"
          @focus="touchedDetails()"
          :label="$t('identity.edit.description.label')"
          :placeholder="$t('identity.edit.description.placeholder')"
          :markdown-label="$t('identity.edit.description.markdownLabel')"
        ></t-markdown-input-group>

        <div class="row">
          <div class="t-wide-col">
            <t-button-panel>
              <t-action-button
                slot="left"
                ref="saveDetails"
                variant="primary"
                @click="saveDetails()">
                {{$t('identity.edit.details.save.button')}}
              </t-action-button>
              <b-button
                slot="right"
                variant="outline-primary"
                @click="clearDetails()">
                {{$t('identity.edit.details.cancel.button')}}
              </b-button>
            </t-button-panel>
          </div>
        </div>
      </fieldset>
    </b-form>

    <div class="row t-identity-editor-panel">
      <div class="t-wide-col">
        <b-form @submit="$event.preventDefault()">
          <fieldset :disabled="saving">
            <div class="t-identity-editor-image-label">{{$t('identity.edit.image.label')}}</div>

            <t-identity-image-chooser
              class="t-identity-editor-image-chooser"
              v-model="selectedImageFile"
              @change="showImageButtons()"
              :currentImageKey="ownIdentity.imageKey()"
            ></t-identity-image-chooser>

            <t-button-panel v-if="imageUnsaved">
              <t-action-button
                slot="left"
                ref="saveImage"
                variant="primary"
                @click="saveImage()">
                {{$t('identity.edit.image.save.button')}}
              </t-action-button>
              <b-button
                slot="left"
                variant="outline-primary"
                @click="clearImage()">
                {{$t('identity.edit.image.cancel.button')}}
              </b-button>
            </t-button-panel>
          </fieldset>
        </b-form>
      </div>
    </div>

    <div class="row">
      <div class="t-wide-col">
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
        saving: false,
        detailsTouched: false,
        name: null,
        description: null,
        selectedImageFile: null,
        imageUnsaved: false
      }
    },

    watch: {
      ownIdentity (ownIdentity) {
        if (!this.detailsTouched) {
          this.name = ownIdentity.name() || ownIdentity.key()
          this.description = ownIdentity.description()
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
      clearDetails () {
        this.name = this.ownIdentity.name() || this.ownIdentity.key()
        this.description = this.ownIdentity.description()
        resetValidation(this)
        this.$refs.saveDetails.reset()
        this.detailsTouched = false
      },

      touchedDetails () {
        this.detailsTouched = true
      },

      clearImage () {
        this.selectedImageFile = null
        this.imageUnsaved = false
        this.$refs.saveImage.reset()
      },

      showImageButtons () {
        this.imageUnsaved = this.selectedImageFile !== null
      },

      saveDetails () {
        this.saving = true
        const data = {
          description: this.description
        }
        if (this.name !== this.ownIdentityKey) {
          data.name = this.name
        }
        this.$refs.saveDetails.execute(
          Promise.resolve(this.$validator.validateAll(data)).then(valid => {
            if (!valid) {
              this.$refs.saveDetails.fail()
              return null
            }

            return this.$store.dispatch(
              'identity/saveDetails',
              {
                identityKey: this.ownIdentityKey,
                ...data
              }
            )
          })
        ).then((key) => {
          if (key) {
            this.clearDetails()
          }

          return null
        }).catch((err) => {
          console.error(err)
        }).finally(() => {
          this.saving = false
        })
      },

      saveImage () {
        if (!this.selectedImageFile) {
          return
        }

        this.saving = true

        this.$refs.saveImage.dispatch(
          'identity/setImage',
          {
            identityKey: this.ownIdentityKey,
            imageFile: this.selectedImageFile
          }
        ).then((key) => {
          if (key) {
            this.clearImage()
          }

          return null
        }).catch((err) => {
          if (err) {
            console.log(err)
          }
        }).finally(() => {
          this.saving = false
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
