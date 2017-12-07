import Vue from 'vue'

import { subscribeKeys } from '../util/store'

/**
 * Constraints for ideas.
 */
const IDEA_CONSTRAINTS = {
  title: {
    required: true
  },
  description: {
    required: true
  }
}

/**
 * Constraints for comment ideas.
 */
const IDEA_COMMENT_CONSTRAINTS = {
  text: {
    required: true
  }
}

/**
 * Constraints for a reply to a comment.
 */
const IDEA_COMMENT_REPLY_CONSTRAINTS = IDEA_COMMENT_CONSTRAINTS

/**
 * Store module for holding idea data.
 */
export default function ({ persistence }) {
  return {
    namespaced: true,

    state () {
      return {
        ideas: {},
        matches: []
      }
    },

    getters: {
      constraints () {
        return IDEA_CONSTRAINTS
      },

      commentConstraints () {
        return IDEA_COMMENT_CONSTRAINTS
      },

      commentReplyConstraints () {
        return IDEA_COMMENT_REPLY_CONSTRAINTS
      },

      get (state) {
        return (key) => state.ideas[key]
      },

      /**
       * Array of keys for ideas matching the current identities skills.
       */
      matches (state) {
        return state.matches
      }
    },

    mutations: {
      /**
       * Sets the given idea on the store.
       */
      set (state, idea) {
        Vue.set(state.ideas, idea.key(), idea)
      },

      /**
       * Sets the matches for the current identity on the store.
       */
      setMatches (state, matches) {
        state.matches = [...matches]
      }
    },

    actions: {
      /**
       * Subscribe for one or more ideas to recieve updates via the store. The current
       * state of each idea can then be retrieved via the getter 'idea/get'.
       *
       * The component subscribing is responsible for cancelling the subscription if
       * it is no longer needed.
       *
       * @return Promise to cancel the subscription (just call <code>cancel()</code>).
       */
      subscribe (context, ideaKeys) {
        return subscribeKeys(context, ideaKeys, 'set', persistence.subscribeIdeas.bind(persistence))
      },

      /**
       * Subscribe for matching ideas for the current identity and to recieve updates via the store.
       * The current keys of matching ideas can then be retrieved via the getter 'idea/matches'.
       *
       * The component subscribing is responsible for cancelling the subscription if
       * it is no longer needed.
       *
       * @return Promise to cancel the subscription (just call <code>cancel()</code>).
       */
      subscribeMatches ({ commit }) {
        return persistence.subscribeIdeaMatches((matches) => {
          commit('setMatches', matches)
        })
      },

      /**
       * Creates a new idea.
       *
       * @return A promise that provides the key of the created idea.
       */
      create (context, ideaPersistenceData) {
        return persistence.createIdea(ideaPersistenceData)
      },

      /**
       * Updates an existing idea.
       *
       * @return A promise that provides the key of the updated idea.
       */
      update (context, ideaPersistenceData) {
        return persistence.updateIdea(ideaPersistenceData)
      },

      /**
       * Assigns the specified skill to the specified idea.
       *
       * @return A promise that provides the key of the assigned skill.
       */
      assignSkill (context, ideaKey, skillKey) {
        return persistence.assignSkillToIdea(ideaKey, skillKey)
      },

      /**
       * Unassigns the specified skill from the specified idea.
       *
       * @return A promise that provides the key of the unassigned skill.
       */
      unassignSkill (context, ideaKey, skillKey) {
        return persistence.unassignSkillFromIdea(ideaKey, skillKey)
      },

      /**
       * Takes the hat for the specified idea.
       *
       * @return Promise providing the idea key for which the hat has been taken.
       */
      takeHat (context, key) {
        return persistence.takeHat(key)
      },

      /**
       * Discards the hat for the specified idea.
       *
       * @return Promise providing the idea key for which the hat has been discarded.
       */
      discardHat (context, key) {
        return persistence.discardHat(key)
      },

      /**
       * Associates the current identity with the specified idea.
       *
       * @return Promise providing the idea key for which the association has been set.
       */
      associateWith (context, key) {
        return persistence.associateWithIdea(key)
      },

      /**
       * Disassociates the current identity from the specified idea.
       *
       * @return Promise providing the idea key for which the association has been removed.
       */
      disassociateFrom (context, key) {
        return persistence.disassociateFromIdea(key)
      },

      /**
       * Posts a comment at an idea.
       *
       * @return Promise providing the key of the posted comment.
       */
      postComment (context, ideaComment) {
        return persistence.postIdeaComment(ideaComment)
      },

      /**
       * Reply to a comment at an idea.
       *
       * @return Promise providing the key of the posted reply.
       */
      replyToComment (context, ideaCommentReply) {
        return persistence.replyToIdeaComment(ideaCommentReply)
      }
    }
  }
}
