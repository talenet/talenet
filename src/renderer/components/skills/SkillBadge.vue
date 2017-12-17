<template>
  <b-badge class="t-skill-badge" v-if="skillName">
    {{skillName}}
  </b-badge>
  <t-loading-animation size="xs" v-else></t-loading-animation>
</template>

<script>
  import SubscriptionMixin from '../../mixins/Subscription'
  import { mapGetters } from 'vuex'

  export default {
    mixins: [
      SubscriptionMixin({
        'skillKey': 'skill/subscribe'
      })
    ],

    props: {
      skillKey: {
        type: String,
        required: true
      }
    },

    computed: {
      ...mapGetters({
        skill: 'skill/get'
      }),

      skillName () {
        const skill = this.skill(this.skillKey)
        if (!skill) {
          return null
        }

        return skill.name() || skill.key().substr(0, 6)
      }
    }
  }
</script>

<style lang="scss" scoped>
  @import "../../variables";

  .t-skill-badge {
    margin-right: $skill-badge-gap;

    padding: {
      top: $skill-badge-padding-y;
      bottom: $skill-badge-padding-y;
      left: $skill-badge-padding-x;
      right: $skill-badge-padding-x;
    }

    background: none;
    border: $skill-badge-default-border;
    color: $skill-badge-default-color;
  }
</style>
