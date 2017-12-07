<template>
  <div v-if="ownIdentity">
    <t-hexagon-image :radius="100" :href="imageUrl(ownIdentity.imageKey())"></t-hexagon-image>
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
        name: ''
      }
    },

    created () {
      registerConstraints(this, this.constraints)
    },

    computed: {
      ...mapGetters({
        constraints: 'identity/constraints',
        ownIdentity: 'identity/own',
        ownIdentityKey: 'identity/ownIdentityKey',
        imageUrl: 'ssb/blobUrl'
      })
    },

    methods: {
      clear () {
        this.name = ''
        resetValidation(this)
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
            this.clear()
          }
        }).catch((err) => {
          console.error(err)
        })
      }
    }
  }
</script>
