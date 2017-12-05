import Vue from 'vue'

import TextareaGroup from './form/TextareaGroup.vue'
import InputGroup from './form/InputGroup.vue'
import LoadingAnimation from './LoadingAnimation.vue'
import MarkdownText from './MarkdownText.vue'
import HexagonImage from './HexagonImage.vue'
import IntroductionBox from './IntroductionBox.vue'

import IdentityCard from './identity/IdentityCard.vue'

import CreateSkillForm from './skills/CreateSkillForm.vue'
import SkillSelector from './skills/SkillSelector.vue'

import CreateIdeaForm from './idea/CreateIdeaForm.vue'
import IdeaList from './idea/IdeaList.vue'
import IdeaDetailView from './idea/IdeaDetailView.vue'
import IdeaPreview from './idea/IdeaPreview.vue'
import IdeaEditForm from './idea/IdeaEditForm.vue'
import IdeaCommentsView from './idea/IdeaCommentsView.vue'
import PostIdeaCommentForm from './idea/PostIdeaCommentForm.vue'
import ReplyToIdeaCommentForm from './idea/ReplyToIdeaCommentForm.vue'

/**
 * Definition of globally available components. Only list components that are reusable.
 */
export default {
  register () {
    Vue.component('t-textarea-group', TextareaGroup)
    Vue.component('t-input-group', InputGroup)

    Vue.component('t-loading-animation', LoadingAnimation)
    Vue.component('t-markdown-text', MarkdownText)
    Vue.component('t-hexagon-image', HexagonImage)
    Vue.component('t-introduction-box', IntroductionBox)

    Vue.component('t-identity-card', IdentityCard)

    Vue.component('t-create-skill-form', CreateSkillForm)
    Vue.component('t-skill-selector', SkillSelector)

    Vue.component('t-create-idea-form', CreateIdeaForm)
    Vue.component('t-idea-list', IdeaList)
    Vue.component('t-idea-detail-view', IdeaDetailView)
    Vue.component('t-idea-preview', IdeaPreview)
    Vue.component('t-idea-edit-form', IdeaEditForm)
    Vue.component('t-idea-comments', IdeaCommentsView)
    Vue.component('t-post-idea-comment-form', PostIdeaCommentForm)
    Vue.component('t-reply-to-idea-comment-form', ReplyToIdeaCommentForm)
  }
}
