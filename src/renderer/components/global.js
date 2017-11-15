import Vue from 'vue'

import TextareaGroup from './form/TextareaGroup.vue'
import InputGroup from './form/InputGroup.vue'
import LoadingAnimation from './LoadingAnimation.vue'
import MarkdownText from './MarkdownText.vue'

/**
 * Definition of globally available components. Only list components that are reusable.
 */
export default {
  register () {
    Vue.component('t-textarea-group', TextareaGroup)
    Vue.component('t-input-group', InputGroup)

    Vue.component('t-loading-animation', LoadingAnimation)
    Vue.component('t-markdown-text', MarkdownText)
  }
}
