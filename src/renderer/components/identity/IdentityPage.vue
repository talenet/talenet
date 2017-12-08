<template>
  <div v-if="ownIdentity">
    <b-form @submit="$event.preventDefault()">
      <t-identity-image-chooser
        v-model="selectedImageFile"
        :currentImageKey="ownIdentity.imageKey()"
      ></t-identity-image-chooser>

      <b-button variant="success" @click="saveImage()">{{$t('identity.edit.image.save.button')}}</b-button>
      <b-button variant="secondary" @click="clearImage()">{{$t('identity.edit.image.cancel.button')}}</b-button>
    </b-form>

    <span>{{ownIdentity.name()}}</span>

    <b-form @submit="$event.preventDefault()">
      <t-input-group
        v-model="name"
        name="name"
        :label="$t('identity.edit.name.label')"
        :placeholder="$t('identity.edit.name.placeholder')"
        :description="$t('identity.edit.name.description')"
      ></t-input-group>

      <b-button variant="success" @click="saveName()">{{$t('identity.edit.name.save.button')}}</b-button>
    </b-form>
  </div>
  <t-loading-animation v-else></t-loading-animation>
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
        name: '',
        selectedImageFile: null
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
        this.name = ''
        resetValidation(this)
      },

      clearImage () {
        this.selectedImageFile = null
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
