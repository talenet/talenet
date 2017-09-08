import Vue from 'vue'
import Hello from '@/components/Home'

describe('Home.vue', () => {
  it('should render correct contents', () => {
    const Constructor = Vue.extend(Hello)
    const vm = new Constructor().$mount()
    expect(vm.$el.querySelector('.home h1').textContent)
      .to.equal('Welcome to TALEnet, the intergalactic skill & idea sharing community.')
  })
})
