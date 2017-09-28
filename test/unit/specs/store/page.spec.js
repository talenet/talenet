import { mount } from '../../helpers/util'
import Vue from 'vue'
import Vuex from 'vuex'
import VueI18N from 'vue-i18n'
import page from '@/store/page'
import { updateTitleFromRoute } from '@/util/page'

Vue.use(Vuex)
Vue.use(VueI18N)

describe('store/page.js', () => {
  const enUS = {
    page: {
      default: {
        title: 'This is the default title'
      }
    },

    test: {
      title: 'This is the test title'
    }
  }

  const deDE = {
    page: {
      default: {
        title: 'Das ist der Standard-Titel'
      }
    },

    test: {
      title: 'Das ist der Test-Titel'
    }
  }

  let doc
  let i18n
  let store

  beforeEach(() => {
    doc = {
      title: '[unset]'
    }
    i18n = new VueI18N({
      messages: {
        'en-US': enUS,
        'de-DE': deDE
      },
      locale: 'en-US'
    })
    store = new Vuex.Store({
      state: {},
      modules: {
        page: page({ i18n, document: doc })
      }
    })
  })

  const Component = {
    template: '<div>{{ $t("test.title") }}</div>'
  }

  it('should use initial language first', () => {
    const c = mount(Component, { i18n, store })
    expect(c.text()).to.equal(enUS.test.title)
  })

  it('should use switched language', () => {
    const c = mount(Component, { i18n, store })
    store.dispatch('page/setLocale', 'de-DE')
    c.update()
    expect(c.text()).to.equal(deDE.test.title)
  })

  it('should set default page title if no meta data specified', () => {
    updateTitleFromRoute({
      path: '/no-title'
    }, store)
    expect(doc.title).to.equal(enUS.page.default.title)
  })

  it('should set default page title if no title in meta data specified', () => {
    updateTitleFromRoute({
      path: '/no-title',
      meta: {
        foo: 'bar'
      }
    }, store)
    expect(doc.title).to.equal(enUS.page.default.title)
  })

  it('should set the page title specified in the meta data', () => {
    updateTitleFromRoute({
      path: '/with-title',
      meta: {
        title: 'test.title'
      }
    }, store)
    expect(doc.title).to.equal(enUS.test.title)
  })

  it('should update the page title when switching language', () => {
    store.dispatch('page/setTitle', 'test.title')
    expect(doc.title).to.equal(enUS.test.title)
    store.dispatch('page/setLocale', 'de-DE')
    expect(doc.title).to.equal(deDE.test.title)
  })
})
