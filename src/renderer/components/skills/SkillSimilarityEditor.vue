<template>
  <div class="t-skill-similarity-editor d-flex flex-column align-items-center">
    <b-form
      class="t-skill-similarity-editor-form form-inline d-flex align-items-center"
      @submit="$event.preventDefault()">
      <div :class="classes.left">
        <b-form-input
          :placeholder="leftSkillName"
          v-model="leftTerm">
        </b-form-input>
        <div v-if="previewLeft" class="t-skill-similarity-editor-preview-left">
          {{previewLeft}}
        </div>
      </div>

      <div class="line">
        <span>is similar to</span>
      </div>

      <div :class="classes.right">
        <b-form-input
          :placeholder="rightSkillName"
          v-model="rightTerm">
        </b-form-input>
        <div v-if="previewRight" class="t-skill-similarity-editor-preview-right">
          {{previewRight}}
        </div>
      </div>

      <t-action-button
        v-if="leftSkillKey && rightSkillKey && leftSkillKey !== rightSkillKey"
        variant="outline-primary"
        ref="voteSimilar"
        @click="voteSimilar()">
        confirm
      </t-action-button>
    </b-form>
  </div>
</template>

<script>
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

    watch: {
      leftTerm (term) {
        this.searchLeft(term)
      },

      rightTerm (term) {
        this.searchRight(term)
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
            't-skill-similarity-editor-has-preview': this.previewLeft
          },
          right: {
            't-skill-similarity-editor-has-preview': this.previewRight
          }
        }
      }
    },

    methods: {
      search (slot, term) {
        const trimmedTerm = term && term.trim()
        if (!trimmedTerm) {
          this.clearSuggests(slot)
          return []
        }
        const normalizedTerm = trimmedTerm.toLowerCase()
        const matchingSkills = Object.values(this.skills)
          .filter(skill => skill.name().toLowerCase().includes(normalizedTerm))

        this.$emit('suggest', {
          [slot]: matchingSkills.map(skill => skill.key())
        })

        return matchingSkills
      },

      searchLeft (term) {
        this.clearSuggests('left')

        if (!term) {
          return
        }

        this.leftSkillKey = null
        return this.search('left', term)
      },

      searchRight (term) {
        this.clearSuggests('right')

        if (!term) {
          return
        }

        this.rightSkillKey = null
        return this.search('right', term)
      },

      clearSuggests (slot) {
        this.$emit('suggest', { [slot]: [] })
      },

      setLeftSkill (skillKey) {
        this.leftTerm = ''
        this.leftSkillKey = skillKey
        this.clearPreview()
        this.clearSuggests('left')
      },

      setRightSkill (skillKey) {
        this.rightTerm = ''
        this.rightSkillKey = skillKey
        this.clearPreview()
        this.clearSuggests('right')
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

  .t-skill-similarity-editor {
    position: absolute;
    left: 6rem;
    right: 6rem;
    bottom: 4rem;

    .t-skill-similarity-editor-form {
      padding: 1rem;
      color: $tale-blue;
      background-color: $tale-dark-grey;

      .t-skill-similarity-editor-has-preview {
        position: relative;

        input {
          color: transparent;

          &::placeholder {
            color: transparent;
          }
        }
      }

      .t-skill-similarity-editor-preview-left,
      .t-skill-similarity-editor-preview-right {
        position: absolute;

        top: 0;
        left: 0;
        right: 0;
        bottom: 0;

        text-align: center;

        padding: $input-btn-padding-y $input-btn-padding-x;
      }

      .t-skill-similarity-editor-preview-left {
        color: $tale-yellow;
      }

      .t-skill-similarity-editor-preview-right {
        color: $tale-red;
      }

      input {
        &::placeholder {
          color: $tale-dark-blue;
        }

        &:focus::placeholder {
          color: transparent;
        }

        border-color: $tale-dark-blue;
        color: $tale-blue;
        text-align: center;
      }

      .line {
        height: 1px;
        border-bottom: 1px dashed $tale-dark-blue;
        padding: {
          left: 1.5rem;
          right: 1.5rem;
        }

        span {
          display: block;
          margin-top: -$line-height-base * $font-size-base;
        }
      }

      button {
        margin-left: 1.5rem;
      }
    }
  }
</style>
