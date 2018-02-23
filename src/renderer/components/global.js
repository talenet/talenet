import Vue from 'vue'

import AlphaContactBox from './form/AlphaContactBox.vue'

import ButtonPanel from './form/ButtonPanel.vue'
import ActionPanel from './form/ActionPanel.vue'
import TextareaGroup from './form/TextareaGroup.vue'
import InputGroup from './form/InputGroup.vue'
import MarkdownInputGroup from './form/MarkdownInputGroup.vue'
import ActionButton from './form/ActionButton.vue'
import HexagonButton from './form/HexagonButton.vue'
import Slider from './form/Slider.vue'

import Navbar from './Navbar.vue'
import ErrorView from './ErrorView.vue'
import PubInfoPost from './PubInfoPost.vue'
import DevPanel from './DevPanel.vue'
import DevGrid from './DevGrid.vue'
import CenterOnPage from './CenterOnPage.vue'
import LoadingAnimation from './LoadingAnimation.vue'
import ConnectionActivityIndicator from './ConnectionActivityIndicator.vue'
import TextBox from './TextBox.vue'
import MarkdownText from './MarkdownText.vue'
import HexagonImage from './HexagonImage.vue'
import IntroductionBox from './IntroductionBox.vue'
import HistoryButton from './HistoryButton.vue'
import SearchField from './search/SearchField.vue'

import InviteAcceptForm from './InviteAcceptForm.vue'

import IdeaCommitmentCard from './idea/IdeaCommitmentCard.vue'

import IdentityImage from './identity/IdentityImage.vue'
import IdentityLink from './identity/IdentityLink.vue'
import IdentityDetailView from './identity/IdentityDetailView.vue'
import IdentityEditor from './identity/IdentityEditor.vue'
import IdentityImageChooser from './identity/IdentityImageChooser.vue'
import IdentitySkillEditor from './identity/IdentitySkillEditor.vue'
import IdentityKeyPairDownload from './identity/IdentityKeyPairDownload.vue'

import SkillSelector from './skills/SkillSelector.vue'
import SkillBadge from './skills/SkillBadge.vue'
import SkillGraph from './skills/SkillGraph.vue'
import SkilliverseSkillTypeAhead from './skills/SkilliverseSkillTypeAhead.vue'

import CreateIdeaForm from './idea/CreateIdeaForm.vue'
import IdeaList from './idea/IdeaList.vue'
import IdeaDetailView from './idea/IdeaDetailView.vue'
import IdeaPreview from './idea/IdeaPreview.vue'
import IdeaEditForm from './idea/IdeaEditForm.vue'
import IdeaSkillSelector from './idea/IdeaSkillSelector.vue'
import IdeaCommentsView from './idea/IdeaCommentsView.vue'
import IdeaCommentView from './idea/IdeaCommentView.vue'
import IdeaCommentCard from './idea/IdeaCommentCard.vue'
import PostIdeaCommentForm from './idea/PostIdeaCommentForm.vue'
import ReplyToIdeaCommentForm from './idea/ReplyToIdeaCommentForm.vue'

import MessageThreadCard from './messages/MessageThreadCard.vue'
import MessageTextTeaser from './messages/MessageTextTeaser.vue'
import MessageThreadView from './messages/MessageThreadView.vue'
import MessageThreadHeader from './messages/MessageThreadHeader.vue'
import MessageThreadPostsGroup from './messages/MessageThreadPostsGroup.vue'
import MessageThreadStartForm from './messages/MessageThreadStartForm.vue'
import MessageThreadReplyForm from './messages/MessageThreadReplyForm.vue'

import PubList from './ssb/PubList.vue'

/**
 * Definition of globally available components. Only list components that are reusable.
 */
export default {
  register () {
    Vue.component('t-alpha-contact-box', AlphaContactBox)

    Vue.component('t-button-panel', ButtonPanel)
    Vue.component('t-action-panel', ActionPanel)
    Vue.component('t-textarea-group', TextareaGroup)
    Vue.component('t-input-group', InputGroup)
    Vue.component('t-markdown-input-group', MarkdownInputGroup)
    Vue.component('t-action-button', ActionButton)
    Vue.component('t-hexagon-button', HexagonButton)
    Vue.component('t-slider', Slider)

    Vue.component('t-navbar', Navbar)
    Vue.component('t-error-view', ErrorView)
    Vue.component('t-pub-info-post', PubInfoPost)
    Vue.component('t-dev-panel', DevPanel)
    Vue.component('t-dev-grid', DevGrid)
    Vue.component('t-center-on-page', CenterOnPage)
    Vue.component('t-loading-animation', LoadingAnimation)
    Vue.component('t-connection-activity-indicator', ConnectionActivityIndicator)
    Vue.component('t-text-box', TextBox)
    Vue.component('t-markdown-text', MarkdownText)
    Vue.component('t-hexagon-image', HexagonImage)
    Vue.component('t-introduction-box', IntroductionBox)
    Vue.component('t-history-button', HistoryButton)
    Vue.component('t-search-field', SearchField)

    Vue.component('t-invite-accept-form', InviteAcceptForm)

    Vue.component('t-identity-image', IdentityImage)
    Vue.component('t-identity-link', IdentityLink)
    Vue.component('t-identity-detail-view', IdentityDetailView)
    Vue.component('t-identity-editor', IdentityEditor)
    Vue.component('t-identity-image-chooser', IdentityImageChooser)
    Vue.component('t-identity-skill-editor', IdentitySkillEditor)
    Vue.component('t-identity-key-pair-download', IdentityKeyPairDownload)

    Vue.component('t-skill-selector', SkillSelector)
    Vue.component('t-skill-badge', SkillBadge)
    Vue.component('t-skill-graph', SkillGraph)
    Vue.component('t-skilliverse-skill-type-ahead', SkilliverseSkillTypeAhead)

    Vue.component('t-create-idea-form', CreateIdeaForm)
    Vue.component('t-idea-list', IdeaList)
    Vue.component('t-idea-detail-view', IdeaDetailView)
    Vue.component('t-idea-preview', IdeaPreview)
    Vue.component('t-idea-edit-form', IdeaEditForm)
    Vue.component('t-idea-skill-selector', IdeaSkillSelector)
    Vue.component('t-idea-commitment-card', IdeaCommitmentCard)
    Vue.component('t-idea-comments', IdeaCommentsView)
    Vue.component('t-idea-comment', IdeaCommentView)
    Vue.component('t-idea-comment-card', IdeaCommentCard)
    Vue.component('t-post-idea-comment-form', PostIdeaCommentForm)
    Vue.component('t-reply-to-idea-comment-form', ReplyToIdeaCommentForm)

    Vue.component('t-message-thread-card', MessageThreadCard)
    Vue.component('t-message-text-teaser', MessageTextTeaser)
    Vue.component('t-message-thread-view', MessageThreadView)
    Vue.component('t-message-thread-header', MessageThreadHeader)
    Vue.component('t-message-thread-posts-group', MessageThreadPostsGroup)
    Vue.component('t-message-thread-start-form', MessageThreadStartForm)
    Vue.component('t-message-thread-reply-form', MessageThreadReplyForm)

    Vue.component('t-pub-list', PubList)
  }
}
