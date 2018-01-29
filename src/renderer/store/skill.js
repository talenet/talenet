import Vue from 'vue'

import { subscribeKeys } from '../util/store'

/**
 * Constraints for skills.
 */
const SKILL_CONSTRAINTS = {
  name: {
    required: true,
    max: 30
  }
}

/**
 * Store module for holding skill data.
 */
export default function ({ skillAdapter }) {
  return {
    namespaced: true,

    state () {
      return {
        skills: {},
        similarities: {}
      }
    },

    getters: {
      constraints () {
        return SKILL_CONSTRAINTS
      },

      all (state) {
        const nonUniqueSkills = Object.values(state.skills)
        const uniqueSkillKeys = new Set()
        for (const skill of nonUniqueSkills) {
          uniqueSkillKeys.add(skill.key())
        }

        const uniqueSkills = {}
        for (const key of uniqueSkillKeys) {
          uniqueSkills[key] = state.skills[key]
        }

        return uniqueSkills
      },

      get (state) {
        return (key) => state.skills[key]
      },

      similarities (state) {
        return state.similarities
      }
    },

    mutations: {
      set (state, skill) {
        for (const key of skill.keys()) {
          Vue.set(state.skills, key, skill)
        }
      },

      setSimilarities (state, similarities) {
        state.similarities = similarities
      }
    },

    actions: {
      /**
       * Subscribe for one or more skills to recieve updates via the store. The current
       * state of each skill can then be retrieved via the getter 'skill/get'.
       *
       * The component subscribing is responsible for cancelling the subscription if
       * it is no longer needed.
       *
       * @return Promise to cancel the subscription (just call <code>cancel()</code>).
       */
      subscribe (context, skillKeys) {
        return subscribeKeys(context, skillKeys, 'set', skillAdapter.subscribeSkills.bind(skillAdapter))
      },

      /**
       * Subscribe for all skills.
       *
       * FIXME: This is probably a bad idea performance- / scaling-wise. We need to discuss a better way
       * to handle / index / load skilliverse data.
       */
      subscribeAll ({ commit }) {
        return skillAdapter.subscribeAllSkills((skill) => {
          commit('set', skill)
        })
      },

      /**
       * Subscribe for skill similarities.
       *
       * FIXME: This is probably a bad idea performance- / scaling-wise. We need to discuss a better way
       * to handle / index / load skilliverse data.
       */
      subscribeSimilarities ({ commit }) {
        return skillAdapter.subscribeSimilarities((similarities) => {
          commit('setSimilarities', similarities)
        })
      },

      /**
       * Creates a new skill.
       *
       * @return A promise that provides the key of the created skill.
       */
      create (context, newSkill) {
        return skillAdapter.createSkill(newSkill)
      },

      /**
       * Vote a pair of skills as being similar.
       */
      voteAsSimilar (context, { skillKey1, skillKey2 }) {
        return skillAdapter.voteSkillsAsSimilar(skillKey1, skillKey2)
      },

      /**
       * Vote a pair of skills as not being similar.
       */
      voteAsNotSimilar (context, { skillKey1, skillKey2 }) {
        return skillAdapter.voteSkillsAsNotSimilar(skillKey1, skillKey2)
      },

      /**
       * Searchs for skills matching the specified search term. The search will perform a
       * case-insensitive infix search with the search term.
       *
       * @return A promise that provides a list of skill keys matching the search term.
       */
      search (context, term) {
        return skillAdapter.searchSkills(term)
      }
    }
  }
}
