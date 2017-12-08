import Vue from 'vue'
import VueI18N from 'vue-i18n'

import enUS from './en-US.json'

Vue.use(VueI18N)

const locale = 'en-US'

const messages = {
  'en-US': enUS
}

/**
 * VueI18N instance used for translation. The locale can be switched via the store module i18n.
 */
export default new VueI18N({
  locale,
  fallbackLocale: 'none',
  messages
})
