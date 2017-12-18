import Vue from 'vue'

import ButtonPanel from './form/ButtonPanel.vue'
import ActionPanel from './form/ActionPanel.vue'
import TextareaGroup from './form/TextareaGroup.vue'
import InputGroup from './form/InputGroup.vue'

import Navbar from './Navbar.vue'
import CenterOnPage from './CenterOnPage.vue'
import LoadingAnimation from './LoadingAnimation.vue'
import TextBox from './TextBox.vue'
import MarkdownText from './MarkdownText.vue'
import HexagonImage from './HexagonImage.vue'
import IntroductionBox from './IntroductionBox.vue'

import InviteAcceptForm from './InviteAcceptForm.vue'

import IdentityCard from './identity/IdentityCard.vue'
import IdentityDetailView from './identity/IdentityDetailView.vue'
import IdentityEditor from './identity/IdentityEditor.vue'
import IdentityImageChooser from './identity/IdentityImageChooser.vue'
import IdentitySkillEditor from './identity/IdentitySkillEditor.vue'
import IdentityKeyPairDownload from './identity/IdentityKeyPairDownload.vue'

import SkillSelector from './skills/SkillSelector.vue'
import SkillBadge from './skills/SkillBadge.vue'

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
    Vue.component('t-button-panel', ButtonPanel)
    Vue.component('t-action-panel', ActionPanel)
    Vue.component('t-textarea-group', TextareaGroup)
    Vue.component('t-input-group', InputGroup)

    Vue.component('t-navbar', Navbar)
    Vue.component('t-center-on-page', CenterOnPage)
    Vue.component('t-loading-animation', LoadingAnimation)
    Vue.component('t-text-box', TextBox)
    Vue.component('t-markdown-text', MarkdownText)
    Vue.component('t-hexagon-image', HexagonImage)
    Vue.component('t-introduction-box', IntroductionBox)

    Vue.component('t-invite-accept-form', InviteAcceptForm)

    Vue.component('t-identity-card', IdentityCard)
    Vue.component('t-identity-detail-view', IdentityDetailView)
    Vue.component('t-identity-editor', IdentityEditor)
    Vue.component('t-identity-image-chooser', IdentityImageChooser)
    Vue.component('t-identity-skill-editor', IdentitySkillEditor)
    Vue.component('t-identity-key-pair-download', IdentityKeyPairDownload)

    Vue.component('t-skill-selector', SkillSelector)
    Vue.component('t-skill-badge', SkillBadge)

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
