<template>
  <div :class="classes" :style="{bottom: bottom + 'px'}">
    <input ref="input" @keyup.enter="onEnter()" type="text" v-model="term" title=""/>
  </div>
</template>

<script>
  import _ from 'lodash'

  export default {
    props: {
      skills: {
        required: true,
        type: Object
      },

      selectedSkills: {
        required: true,
        type: Set
      },

      bottom: {
        required: true,
        type: Number
      }
    },

    data () {
      return {
        term: ''
      }
    },

    beforeDestroy () {
      this.$emit('suggest', [])
    },

    watch: {
      matches () {
        this.suggestSkills()
      }
    },

    computed: {
      classes () {
        return {
          't-skilliverse-skill-type-ahead': true
        }
      },

      matches () {
        const term = this.term
        const skills = this.skills
        const selectedSkills = this.selectedSkills

        const trimmedTerm = term && term.trim()
        if (!trimmedTerm) {
          return []
        }

        const normalizedTerm = trimmedTerm.toLowerCase()
        const matches = Object.values(skills)
          .filter(skill =>
            skill.name().toLowerCase().includes(normalizedTerm) &&
            !selectedSkills.has(skill.key())
          )

        return _.sortBy(matches, skill => skill.name())
      }
    },

    methods: {
      focus () {
        this.$refs.input.focus()
      },

      suggestSkills () {
        this.$emit('suggest', this.matches.map(skill => skill.key()))
      },

      onEnter () {
        const matches = this.matches
        if (_.size(matches) >= 1) {
          const match = matches[0]
          this.term = ''
          this.$refs.input.blur()

          this.$emit('select', match.key())
        }
      }
    }
  }
</script>

<style lang="scss" scoped>
  @import "../../variables";
  @import "../../mixins";

  .t-skilliverse-skill-type-ahead {
    position: absolute;
    left: 50%;
    width: $skilliverse-type-ahead-width;
    margin-left: -$skilliverse-type-ahead-width / 2;

    input {
      width: 100%;

      border: none;
      background-color: rgba($skilliverse-type-ahead-bg, $skilliverse-type-ahead-bg-alpha);
      color: $skilliverse-type-ahead-color;

      text-align: center;

      &, &:focus, &:active {
        outline: none;
        box-shadow: none;
      }
    }
  }
</style>
