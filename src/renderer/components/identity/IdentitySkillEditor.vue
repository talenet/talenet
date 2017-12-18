<template>
  <div v-if="ownIdentity">
    <div class="row">
      <div class="t-center-col">
        <t-introduction-box messagesKey="identity.defineSkills.introduction"></t-introduction-box>
      </div>
    </div>

    <div class="row">
      <div class="t-center-col">
        <div class="t-identity-skill-editor-current">
          <div class="t-identity-skill-editor-current-label">
            {{$t('identity.defineSkills.currentSkills.label')}}
          </div>

          <div v-if="skillKeys.length">
            <t-skill-badge
              v-for="skillKey in skillKeys"
              :key="skillKey"
              :skill-key="skillKey"
              action="remove"
              @click="removeSkill(skillKey)"
            >
            </t-skill-badge>
          </div>
          <div v-else class="t-identity-skill-editor-current-no-skills">
            {{$t('identity.defineSkills.currentSkills.noSkills')}}
          </div>
        </div>

        <t-skill-selector
          @select="addSkill($event)"
          :label="$t('identity.defineSkills.selectSkill.label')"
          :placeholder="$t('identity.defineSkills.selectSkill.placeholder')"
          :description="$t('identity.defineSkills.selectSkill.description')"
          :selectedSkillKeys="selectedSkillKeys"
        ></t-skill-selector>
      </div>
    </div>
  </div>

  <t-center-on-page v-else>
    <t-loading-animation size="xl"></t-loading-animation>
  </t-center-on-page>
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
      },

      selectedSkillKeys () {
        const getSkill = this.skill
        const selectedKeys = new Set()

        for (const key of this.skillKeys) {
          const skill = getSkill(key)
          if (skill) {
            selectedKeys.add(...skill.keys())
          } else {
            selectedKeys.add(key)
          }
        }

        return [...selectedKeys]
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

<style lang="scss" scoped>
  @import "../../variables";

  .t-identity-skill-editor-current {
    margin: {
      top: $identity-skill-editor-offset-y;
      bottom: $identity-skill-editor-offset-y;
      left: $identity-skill-editor-offset-x;
      right: $identity-skill-editor-offset-x;
    }
  }

  .t-identity-skill-editor-current-label {
    margin-bottom: $identity-skill-editor-current-label-margin-bottom;
  }

  .t-identity-skill-editor-current-no-skills {
    color: $identity-skill-editor-no-skills-color;
    font-style: italic;
  }
</style>
