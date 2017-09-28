import { mount } from '../../helpers/util'
import Vue from 'vue'
import Vuex from 'vuex'
import VueI18N from 'vue-i18n'
import i18nModule from '@/store/i18n'

Vue.use(Vuex)
Vue.use(VueI18N)

describe('store/i18n.js', () => {
  const enUS = {
    test: 'This is a test.'
  }

  const deDE = {
    test: 'Das ist ein Test.'
  }

  const i18n = new VueI18N({
    messages: {
      'en-US': enUS,
      'de-DE': deDE
    },
    locale: 'en-US'
  })
  const store = new Vuex.Store({
    state: {},
    modules: {
      i18n: i18nModule({
        $i18n: i18n
      })
    }
  })

  const Component = {
    template: '<div>{{ $t("test") }}</div>'
  }

  it('should use initial language first', () => {
    const c = mount(Component, { i18n, store })
    expect(c.text()).to.equal(enUS.test)
  })

  it('should use switched language', () => {
    const c = mount(Component, { i18n, store })
    store.dispatch('i18n/setLocale', 'de-DE')
    c.update()
    expect(c.text()).to.equal(deDE.test)
  })
})
