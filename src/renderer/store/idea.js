import Vue from 'vue'

import { subscribeKeys } from '../util/store'

/**
 * Constraints for ideas.
 */
const IDEA_CONSTRAINTS = {
  title: {
    required: true,
    max: 200
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
export default function ({ ideaAdapter }) {
  return {
    namespaced: true,

    state () {
      return {
        ideas: {},
        matches: {},
        ownIdeas: []
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
      },

      /**
       * Array of keys for ideas the current identity is associated with.
       */
      ownIdeas (state) {
        return state.ownIdeas
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
        state.matches = { ...matches }
      },

      /**
       * Set own ideas for the current identity on the store.
       */
      setOwnIdeas (state, ownIdeas) {
        state.ownIdeas = [...ownIdeas]
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
        return subscribeKeys(context, ideaKeys, 'set', ideaAdapter.subscribeIdeas.bind(ideaAdapter))
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
        return ideaAdapter.subscribeIdeaMatches((matches) => {
          commit('setMatches', matches)
        })
      },

      /**
       * Subscribe for ideas the current identity is associated with and to recieve updates via the store.
       * The current keys of the own ideas can then be retrieved via the getter 'idea/ownIdeas'.
       *
       * The component subscribing is responsible for cancelling the subscription if
       * it is no longer needed.
       *
       * @return Promise to cancel the subscription (just call <code>cancel()</code>).
       */
      subscribeOwnIdeas ({ commit }) {
        return ideaAdapter.subscribeOwnIdeas((ownIdeas) => {
          commit('setOwnIdeas', ownIdeas)
        })
      },

      /**
       * Creates a new idea.
       *
       * @return A promise that provides the key of the created idea.
       */
      create (context, ideaPersistenceData) {
        return ideaAdapter.createIdea(ideaPersistenceData)
      },

      /**
       * Copies the specified idea.
       *
       * @return A promise that provides the key of the idea copy.
       */
      copy (context, ideaKey) {
        return ideaAdapter.copyIdea(ideaKey)
      },

      /**
       * Updates an existing idea.
       *
       * @return A promise that provides the key of the updated idea.
       */
      update (context, ideaPersistenceData) {
        return ideaAdapter.updateIdea(ideaPersistenceData)
      },

      /**
       * Assigns the specified skill to the specified idea.
       *
       * @return A promise that provides the key of the assigned skill.
       */
      assignSkill (context, ideaKey, skillKey) {
        return ideaAdapter.assignSkillToIdea(ideaKey, skillKey)
      },

      /**
       * Unassigns the specified skill from the specified idea.
       *
       * @return A promise that provides the key of the unassigned skill.
       */
      unassignSkill (context, ideaKey, skillKey) {
        return ideaAdapter.unassignSkillFromIdea(ideaKey, skillKey)
      },

      /**
       * Takes the hat for the specified idea.
       *
       * @return Promise providing the idea key for which the hat has been taken.
       */
      takeHat (context, key) {
        return ideaAdapter.takeHat(key)
      },

      /**
       * Discards the hat for the specified idea.
       *
       * @return Promise providing the idea key for which the hat has been discarded.
       */
      discardHat (context, key) {
        return ideaAdapter.discardHat(key)
      },

      /**
       * Associates the current identity with the specified idea.
       *
       * @return Promise providing the idea key for which the association has been set.
       */
      associateWith (context, key) {
        return ideaAdapter.associateWithIdea(key)
      },

      /**
       * Disassociates the current identity from the specified idea.
       *
       * @return Promise providing the idea key for which the association has been removed.
       */
      disassociateFrom (context, key) {
        return ideaAdapter.disassociateFromIdea(key)
      },

      /**
       * Posts a comment at an idea.
       *
       * @return Promise providing the key of the posted comment.
       */
      postComment (context, ideaComment) {
        return ideaAdapter.postIdeaComment(ideaComment)
      },

      /**
       * Reply to a comment at an idea.
       *
       * @return Promise providing the key of the posted reply.
       */
      replyToComment (context, ideaCommentReply) {
        return ideaAdapter.replyToIdeaComment(ideaCommentReply)
      }
    }
  }
}
