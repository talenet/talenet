import { mount } from '../../helpers/util'
import Vue from 'vue'
import Vuex from 'vuex'
import Home from '@/components/Home.vue'

Vue.use(Vuex)

describe('Home.vue', () => {
  let store

  beforeEach(() => {
    store = new Vuex.Store({ })
  })

  it('should render correct contents', () => {
    const home = mount(Home, { store })
    expect(home.find('.home h1')[0].text())
      .to.equal('Welcome to TALEnet, the intergalactic skill & idea sharing community.')
  })
})
