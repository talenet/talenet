import { mount } from 'avoriaz'
import Vue from 'vue'
import Vuex from 'vuex'
import Home from '@/components/Home'

Vue.use(Vuex)

describe('Home.vue', () => {
  let store

  beforeEach(() => {
    // Mocked store for testing. As soon as the real store triggers actions in ssb this becomes more relevant.
    store = new Vuex.Store({
      state: {
        loggedIn: false
      },
      mutations: {
        login: state => { state.loggedIn = true }
      }
    })
  })

  it('should render correct contents', () => {
    const home = mount(Home, { store })
    expect(home.find('.home h1')[0].text())
      .to.equal('Welcome to TALEnet, the intergalactic skill & idea sharing community.')
  })

  it('should initially show login button', () => {
    const home = mount(Home, { store })
    expect(home.find('button.login')[0].text())
      .to.equal('Login')
  })

  it('should hide login button on click', () => {
    const home = mount(Home, { store })
    const button = home.find('button.login')[0]
    button.trigger('click')
    expect(home.find('button.login').length)
      .to.equal(0)
  })
})
