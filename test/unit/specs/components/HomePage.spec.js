import { mount } from '../../helpers/util'
import Vue from 'vue'
import Vuex from 'vuex'
import HomePage from '@/components/HomePage.vue'

Vue.use(Vuex)

describe('HomePage.vue', () => {
  let store

  beforeEach(() => {
    store = new Vuex.Store({ })
  })

  it('should render correct contents', () => {
    const home = mount(HomePage, { store })
    expect(home.find('.home h1')[0].text())
      .to.equal('Welcome to tale:net, the intergalactic skill & idea sharing community.')
  })
})
