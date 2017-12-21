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
        skills: {}
      }
    },

    getters: {
      constraints () {
        return SKILL_CONSTRAINTS
      },

      get (state) {
        return (key) => state.skills[key]
      }
    },

    mutations: {
      set (state, skill) {
        for (const key of skill.keys()) {
          Vue.set(state.skills, key, skill)
        }
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
       * Creates a new skill.
       *
       * @return A promise that provides the key of the created skill.
       */
      create (context, newSkill) {
        return skillAdapter.createSkill(newSkill)
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
