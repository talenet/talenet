<template>
  <b-badge
    v-if="displayName"
    :class="classes"
    @click="$emit('click', $event)"
  >
    {{displayName}}
  </b-badge>
  <t-loading-animation size="xs" v-else></t-loading-animation>
</template>

<script>
  import SubscriptionMixin from '../../mixins/Subscription'
  import { mapGetters } from 'vuex'

  const ACTION_SYMBOLS = {
    'add': '+',
    'remove': '-'
  }

  export default {
    mixins: [
      SubscriptionMixin({
        'skillKey': 'skill/subscribe'
      })
    ],

    props: {
      skillKey: {
        type: String,
        required: false
      },

      skillName: {
        type: String,
        required: false
      },

      variant: {
        type: String,
        default: 'default'
      },

      action: {
        type: String,
        default: null
      }
    },

    computed: {
      ...mapGetters({
        skill: 'skill/get'
      }),

      classes () {
        const classes = [
          't-skill-badge',
          't-skill-badge-' + this.variant
        ]

        if (this.$listeners.click) {
          classes.push('t-skill-badge-clickable')
        }

        return classes
      },

      displayName () {
        let name
        if (!this.skillKey) {
          name = this.skillName
        } else {
          const skill = this.skill(this.skillKey)
          if (!skill) {
            return null
          }
          name = skill.name() || skill.key().substr(0, 6)
        }

        const action = ACTION_SYMBOLS[this.action]
        if (action) {
          return action + ' ' + name
        }
        return name
      }
    }
  }
</script>

<style lang="scss" scoped>
  @import "../../variables";

  .t-skill-badge-clickable {
    cursor: pointer;
  }

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
