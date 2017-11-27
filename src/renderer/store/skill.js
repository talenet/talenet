import Vue from 'vue'

/**
 * Constraints for skills.
 */
const SKILL_CONSTRAINTS = {
  name: [
    'required'
  ]
}

/**
 * Store module for holding skill data.
 */
export default function ({ persistence }) {
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
        Vue.set(state.skills, skill.key(), skill)
      }
    },

    actions: {
      /**
       * Creates a new skill.
       *
       * @return A promise that provides the key of the created skill.
       */
      create (context, newSkill) {
        return persistence.createSkill(newSkill)
      },

      /**
       * Searchs for skills matching the specified search term. The search will perform a
       * case-insensitive infix search with the search term.
       *
       * @return A promise that provides a list of skill keys matching the search term.
       */
      search (context, term) {
        return persistence.searchSkills(term)
      }
    }
  }
}
