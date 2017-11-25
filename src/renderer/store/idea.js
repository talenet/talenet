import Vue from 'vue'

/**
 * Constraints for ideas.
 */
const IDEA_CONSTRAINTS = {
  title: [
    'required'
  ],
  description: [
    'required'
  ]
}

/**
 * Constraints for comment ideas.
 */
const IDEA_COMMENT_CONSTRAINTS = {
  text: [
    'required'
  ]
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
        ideas: {}
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

      all (state) {
        return Object.values(state.ideas)
      },

      get (state) {
        return (key) => state.ideas[key]
      }
    },

    mutations: {
      set (state, idea) {
        Vue.set(state.ideas, idea.key(), idea)
      }
    },

    actions: {
      /**
       * Creates a new idea.
       *
       * @return A promise that provides the key of the created idea.
       */
      create (context, newIdea) {
        return persistence.createIdea(newIdea)
      },

      /**
       * Updates an existing idea.
       *
       * @return A promise that provides the key of the updated idea.
       */
      update (context, ideaUpdate) {
        return persistence.updateIdea(ideaUpdate)
      },

      /**
       * Make sure the idea with the specified key is loaded.
       *
       * @return Promise providing an object with the field 'exists' specifying if the idea exists.
       */
      load (context, key) {
        return persistence.loadIdea(key)
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
