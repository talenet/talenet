<template>
  <div v-if="ownIdentity">
    <t-skill-selector @select="addSkill($event)"></t-skill-selector>

    <div>
      <b-badge
        variant="success"
        v-for="skillKey in skillKeys" :key="skillKey"
        @click="removeSkill(skillKey)"
      >
        <span v-if="skill(skillKey)">{{skill(skillKey).name()}} [-]</span>
        <t-loading-animation v-else></t-loading-animation>
      </b-badge>
    </div>
  </div>
  <t-loading-animation v-else></t-loading-animation>
</template>

<script>
  import SubscriptionMixin from '../../mixins/Subscription'
  import { mapGetters } from 'vuex'

  export default {
    mixins: [
      SubscriptionMixin({
        '!': 'identity/subscribeOwnIdentityKey',
        'ownIdentityKey': 'identity/subscribe',
        'skillKeys': 'skill/subscribe'
      })
    ],

    computed: {
      ...mapGetters({
        ownIdentity: 'identity/own',
        ownIdentityKey: 'identity/ownIdentityKey',
        skill: 'skill/get'
      }),

      skillKeys () {
        return this.ownIdentity ? this.ownIdentity.skills() : []
      }
    },

    methods: {
      addSkill (key) {
        this.$store.dispatch('identity/assignSkill', key)
          .catch((err) => {
            if (err) {
              console.error(err)
            }
          })
      },

      removeSkill (key) {
        this.$store.dispatch('identity/unassignSkill', key)
          .catch((err) => {
            if (err) {
              console.error(err)
            }
          })
      }
    }
  }
</script>
