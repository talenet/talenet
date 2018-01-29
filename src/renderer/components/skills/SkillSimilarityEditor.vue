<template>
  <div class="t-skill-similarity-editor d-flex flex-column align-items-center">
    <b-form
      class="t-skill-similarity-editor-form form-inline d-flex align-items-center"
      @submit="$event.preventDefault()">
      <b-form-input :value="leftSkillName"></b-form-input>

      <div class="line">
        <span>is similar to</span>
      </div>

      <b-form-input :value="rightSkillName"></b-form-input>

      <t-action-button
        v-if="leftSkillKey && rightSkillKey"
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
        rightSkillKey: null
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
      }
    },

    methods: {
      setLeftSkill (skillKey) {
        this.leftSkillKey = skillKey
      },

      setRightSkill (skillKey) {
        this.rightSkillKey = skillKey
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

<style lang="scss" scoped>
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

      input {
        border-color: $tale-dark-blue;
        color: $tale-dark-blue;
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
