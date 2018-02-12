<template>
  <div>
    <t-skill-selector
      @select="$emit('add-skill', $event)"
      :label="$t('idea.selectSkill.label')"
      :placeholder="$t('idea.selectSkill.placeholder')"
      :description="$t('idea.selectSkill.description')"
      :selectedSkillKeys="skillKeys"
    ></t-skill-selector>

    <div class="t-skill-selector-current-skills-label">
      {{$t('idea.selectedSkillsSet.label')}}
    </div>

    <div v-if="skillKeys.length" class="t-skill-selector-current-skills">
      <t-skill-badge
        v-for="skillKey in skillKeys"
        :key="skillKey"
        :skill-key="skillKey"
        action="remove"
        @click="$emit('remove-skill', skillKey)"
      >
      </t-skill-badge>
    </div>
    <div v-else class="t-skill-selector-current-skills-no-skills">
      <small class="text-muted">{{$t('idea.selectedSkillsSet.noSkills')}}</small>
    </div>
  </div>
</template>

<script>
  export default {
    props: {
      skillKeys: {
        type: Array,
        required: true
      }
    }
  }
</script>

<style lang="scss" scoped>
  @import "../../variables";

  .t-skill-selector-current-skills-label,
  .t-skill-selector-current-skills,
  .t-skill-selector-current-skills-no-skills {
    margin: {
      left: $idea-skill-selector-offset-x;
      right: $idea-skill-selector-offset-x;
    }
  }

  .t-skill-selector-current-skills-label {
    margin: {
      top: $idea-skill-selector-offset-y;
    }
  }

  .t-skill-selector-current-skills {
    margin: {
      bottom: $idea-skill-selector-offset-y;
    }
  }

  .t-skill-selector-current-skills-no-skills {
    margin: {
      bottom: $idea-skill-selector-offset-y;
    }
  }
</style>
