<template>
  <div class="t-skill-similarity-editor d-flex flex-column align-items-center">
    <b-form
      class="t-skill-similarity-editor-form form-inline d-flex align-items-center"
      @submit="$event.preventDefault()">
      <div :class="classes.left">
        <b-form-input
          ref="leftInput"
          :placeholder="leftSkillName"
          v-model="leftTerm">
        </b-form-input>
        <div v-if="previewLeft" class="t-skill-similarity-editor-preview">
          {{previewLeft}}
        </div>
      </div>

      <div class="line">
        <span>is similar to</span>
      </div>

      <div :class="classes.right">
        <b-form-input
          ref="rightInput"
          :placeholder="rightSkillName"
          v-model="rightTerm">
        </b-form-input>
        <div v-if="previewRight" class="t-skill-similarity-editor-preview">
          {{previewRight}}
        </div>
      </div>

      <div
        v-if="leftSkillKey && rightSkillKey && leftSkillKey !== rightSkillKey"
        class="t-skill-similarity-editor-button-container">
        <t-action-button
          variant="primary"
          ref="voteSimilar"
          @click="voteSimilar()">
          confirm
        </t-action-button>
      </div>
    </b-form>
  </div>
</template>

<script>
  import _ from 'lodash'

  export default {
    props: {
      skills: {
        required: true,
        type: Object
      }
    },

    data () {
      return {
        leftSkillKey: null,
        rightSkillKey: null,
        previewLeft: null,
        previewRight: null,
        leftTerm: '',
        rightTerm: ''
      }
    },

    mounted () {
      this.$refs.leftInput.$el.onkeyup = this.selectLeftSkillOnEnter
      this.$refs.rightInput.$el.onkeyup = this.selectRightSkillOnEnter
    },

    watch: {
      leftTerm (term) {
        this.searchLeft(term)
      },

      rightTerm (term) {
        this.searchRight(term)
      },

      leftSkillKey (key) {
        this.$emit('select', {
          left: key
        })
      },

      rightSkillKey (key) {
        this.$emit('select', {
          right: key
        })
      }
    },

    computed: {
      leftSkillName () {
        const skill = this.skills[this.leftSkillKey]
        return skill && skill.name()
      },

      rightSkillName () {
        const skill = this.skills[this.rightSkillKey]
        return skill && skill.name()
      },

      classes () {
        return {
          left: {
            't-skill-similarity-editor-left': true,
            't-skill-similarity-editor-has-preview': this.previewLeft
          },
          right: {
            't-skill-similarity-editor-right': true,
            't-skill-similarity-editor-has-preview': this.previewRight
          }
        }
      }
    },

    methods: {
      search (slot, term) {
        const trimmedTerm = term && term.trim()
        if (!trimmedTerm) {
          return []
        }
        const normalizedTerm = trimmedTerm.toLowerCase()
        return Object.values(this.skills)
          .filter(skill =>
            skill.name().toLowerCase().includes(normalizedTerm) &&
            skill.key() !== this.leftSkillKey &&
            skill.key() !== this.rightSkillKey
          )
      },

      searchLeft (term) {
        if (!term) {
          this.clearSuggests('left')
          return
        }

        this.leftSkillKey = null
        const skills = this.search('left', term)
        this.suggestSkills('left', skills)
        return skills
      },

      searchRight (term) {
        if (!term) {
          this.clearSuggests('right')
          return
        }

        this.rightSkillKey = null
        const skills = this.search('right', term)
        this.suggestSkills('right', skills)
        return skills
      },

      suggestSkills (slot, skills) {
        this.$emit('suggest', {
          [slot]: skills.map(skill => skill.key())
        })
      },

      clearSuggests (slot) {
        this.$emit('suggest', { [slot]: [] })
      },

      setLeftSkill (skillKey) {
        this.leftTerm = ''
        this.leftSkillKey = skillKey
        this.clearPreview()
        this.clearSuggests('left')
        this.$refs.leftInput.$el.blur()
      },

      setRightSkill (skillKey) {
        this.rightTerm = ''
        this.rightSkillKey = skillKey
        this.clearPreview()
        this.clearSuggests('right')
        this.$refs.rightInput.$el.blur()
      },

      selectLeftSkillOnEnter (event) {
        if (event.code !== 'Enter') {
          return
        }
        const skills = this.search('left', this.leftTerm)
        if (_.size(skills) === 1) {
          this.setLeftSkill(skills[0].key())
        }
      },

      selectRightSkillOnEnter () {
        if (event.code !== 'Enter') {
          return
        }
        const skills = this.search('right', this.rightTerm)
        if (_.size(skills) === 1) {
          this.setRightSkill(skills[0].key())
        }
      },

      setPreviewLeft (key) {
        this.previewLeft = this.skills[key].name()
      },

      setPreviewRight (key) {
        this.previewRight = this.skills[key].name()
      },

      clearPreview () {
        this.previewLeft = null
        this.previewRight = null
      },

      voteSimilar () {
        const data = {
          skillKey1: this.leftSkillKey,
          skillKey2: this.rightSkillKey
        }

        if (!data.skillKey1 || !data.skillKey2) {
          return
        }

        this.$refs.voteSimilar.dispatch('skill/voteAsSimilar', data)
          .then(() => {
            this.leftSkillKey = null
            this.rightSkillKey = null
          })
          .catch(err => {
            if (err) {
              console.error(err)
            }
          })
      }
    }
  }
</script>

<style lang="scss">
  @import "../../variables";
  @import "../../mixins";

  .t-skill-similarity-editor {
    pointer-events: none;

    position: absolute;
    left: 6rem;
    right: 6rem;
    bottom: 4rem;

    .t-skill-similarity-editor-form {
      position: relative;

      padding: $skill-similarity-editor-padding;
      color: $skill-similarity-editor-text-color;
      background-color: $skill-similarity-editor-bg;

      .t-skill-similarity-editor-has-preview {
        &.t-skill-similarity-editor-left {
          box-shadow: 0 0 $skill-similarity-editor-glow-size $skill-similarity-editor-left-color;
        }
        &.t-skill-similarity-editor-right {
          box-shadow: 0 0 $skill-similarity-editor-glow-size $skill-similarity-editor-right-color;
        }
      }

      .t-skill-similarity-editor-has-preview {
        &.t-skill-similarity-editor-left,
        &.t-skill-similarity-editor-right {
          position: relative;

          input {
            color: transparent;

            &::placeholder {
              color: transparent;
            }
          }
        }
      }

      .t-skill-similarity-editor-preview {
        position: absolute;

        top: 0;
        left: 0;
        right: 0;
        bottom: 0;

        text-align: center;

        padding: $input-btn-padding-y $input-btn-padding-x;
      }

      .t-skill-similarity-editor-left {
        color: $skill-similarity-editor-left-color;

        input {
          border-color: $skill-similarity-editor-left-color;

          &::placeholder {
            color: $skill-similarity-editor-left-color;
          }
        }
      }

      .t-skill-similarity-editor-right {
        color: $skill-similarity-editor-right-color;

        input {
          border-color: $skill-similarity-editor-right-color;

          &::placeholder {
            color: $skill-similarity-editor-right-color;
          }
        }
      }

      input, button {
        pointer-events: initial;
      }

      input {
        &, &:focus, &:active {
          outline: none;
          box-shadow: none;
        }

        &:focus::placeholder {
          color: transparent;
        }

        color: $skill-similarity-editor-input-color;
        text-align: center;
      }

      .line {
        height: $skill-similarity-editor-line-width;
        border-bottom: $skill-similarity-editor-line-width $skill-similarity-editor-line-style $skill-similarity-editor-line-color;
        padding: {
          left: $skill-similarity-editor-line-text-padding-x;
          right: $skill-similarity-editor-line-text-padding-x;
        }

        span {
          display: block;
          margin-top: $skill-similarity-editor-line-text-offset-y;
        }
      }

      .t-skill-similarity-editor-button-container {
        position: absolute;
        left: 100%;
        background-color: $skill-similarity-editor-bg;
        padding: $skill-similarity-editor-padding;
        padding-left: $skill-similarity-editor-button-offset-x;
      }
    }
  }
</style>
