<template>
  <t-loading-animation size="xs" v-if="loading"></t-loading-animation>
  <b-badge
    v-else
    :class="classes"
    @click="$emit('click', $event)"
  >
    {{displayName}}
  </b-badge>
</template>

<script>
  import SubscriptionMixin from '../../mixins/Subscription'
  import { mapGetters } from 'vuex'

  const ACTION_SYMBOLS = {
    'add': '+',
    'remove': '–'
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

    data () {
      return {
        timedout: false
      }
    },

    mounted () {
      setTimeout(() => {
        this.timedout = true
      }, 3000)
    },

    computed: {
      ...mapGetters({
        getSkill: 'skill/get'
      }),

      loading () {
        const skillName = this.skillName
        const skill = this.skill
        const timedout = this.timedout

        return !(skillName || skill || timedout)
      },

      skill () {
        if (!this.skillKey) {
          return
        }
        return this.getSkill(this.skillKey)
      },

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
          const skill = this.skill
          if (!skill) {
            name = this.skillKey.substr(0, 6)
          } else {
            name = skill.name() || this.skillKey.substr(0, 6)
          }
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

    &.t-skill-badge-create {
      border: $skill-badge-create-border;
      color: $skill-badge-create-color;
    }
  }
</style>
