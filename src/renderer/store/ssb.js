import pull from 'pull-stream'
import ssbClient from 'ssb-client'
import marked from 'ssb-marked'

/**
 * Store module holding connection to our scuttlebot
 */
export default {
  namespaced: true,

  state: {
    connected: false,
    msgPreview: '',
    id: '',
    latest: [],
    sbot: null
  },

  mutations: {
    disconnect (state) {
      state.connected = false
      // wait and trigger connect action?
    },

    connected (state, _sbot) {
      state.sbot = _sbot
      state.id = _sbot.id
      state.connected = true
    },

    latest (state, msgs) {
      state.latest = msgs
    },

    renderPreview (state, msg) {
      state.msgPreview = marked(msg)
    }
  },

  getters: {
    connected: (state) => {
      return state.connected
    },

    whoami: (state) => {
      return state.id
    }
  },

  actions: {
    connect ({ commit }) {
      ssbClient((err, sbot) => {
        if (err) throw err // TODO: how to display such errors to the user?
        console.log('connected sbot:' + sbot.id)

        // get latest mesages
        pull(
          sbot.createLogStream({
            live: false,
            limit: 20
          }),
          pull.collect((err, msgs) => {
            if (err) throw err
            commit('latest', msgs)
          })
        )

        commit('connected', sbot)

        // notice disconnect
        sbot.on('closed', () => { // this triggers a vuex strict violation somehow
          commit('disconnect')
        })
      })
    }
  }
}
