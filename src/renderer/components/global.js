import Vue from 'vue'

import TextareaGroup from './form/TextareaGroup.vue'
import InputGroup from './form/InputGroup.vue'
import LoadingAnimation from './LoadingAnimation.vue'
import MarkdownText from './MarkdownText.vue'

import CreateIdeaForm from './idea/CreateIdeaForm.vue'
import IdeaList from './idea/IdeaList.vue'
import IdeaDetailView from './idea/IdeaDetailView.vue'
/**
 * Definition of globally available components. Only list components that are reusable.
 */
export default {
  register () {
    Vue.component('t-textarea-group', TextareaGroup)
    Vue.component('t-input-group', InputGroup)

    Vue.component('t-loading-animation', LoadingAnimation)
    Vue.component('t-markdown-text', MarkdownText)

    Vue.component('t-create-idea-form', CreateIdeaForm)
    Vue.component('t-idea-list', IdeaList)
    Vue.component('t-idea-detail-view', IdeaDetailView)
  }
}