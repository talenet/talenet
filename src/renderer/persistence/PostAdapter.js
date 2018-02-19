import Promise from 'bluebird'
import pull from 'pull-stream'

import SSBAdapter from './SSBAdapter'

export default class PostAdapter {
  _allPMs = []
  _ownPMOverviewSubscriptions = []

  _openThreads = {}
  _ownPMThreadSubscriptions = []

  constructor ({ ssbAdapter }) {
    this._ssbAdapter = ssbAdapter
  }

  connect () {
    return new Promise((resolve, reject) => {
      pull(
        this._ssbAdapter.streamPrivate({
          limit: 15 // TODO: pagination
        }),
        pull.collect((err, msgs) => {
          if (err) {
            return reject(err)
          }
          this._allPMs = [...msgs]
          SSBAdapter.propagateUpdate(this._ownPMOverviewSubscriptions, this._allPMs)
          resolve() // TODO: live query - messages are only fetched once on load
        })
      )
    })
  }

  startPrivateThread ({ recipients, text }) {
    return this.publishPrivate({
      type: 'post',
      text,
      recps: recipients
    }).then(msg => msg.key)
  }

  publishPrivate (msg) {
    if (!msg.recps || !Array.isArray(msg.recps)) {
      return Promise.reject(new Error('need recpient array to publish private message'))
    }
    return this._ssbAdapter.publish(msg.type, msg)
  }

  crawlThread (threadKey) {
    const forThread = []
    this._openThreads[threadKey] = forThread // overwrite existing?!
    // TODO: also open live qry - could be returned in the same pullstream?!
    return this._ssbAdapter.getPrivate(threadKey).then((msg) => {
      forThread.push(msg) // TODO: can't update single messages?!?
      SSBAdapter.propagateUpdate(this._ownPMThreadSubscriptions, forThread, threadKey)
      return new Promise((resolve, reject) => {
        pull(
          this._ssbAdapter.streamBacklinksByKey(threadKey),
          pull.drain((msg) => {
            forThread.push(msg) // TODO: can't update single messages?!?
            SSBAdapter.propagateUpdate(this._ownPMThreadSubscriptions, forThread, threadKey)
            resolve()
          })
        )
      })
    })
  }

  subscribeAllPrivateMessages (subsciptionId, onUpdate) {
    const subscription = this._ssbAdapter.subscribe(subsciptionId, this._ownPMOverviewSubscriptions, null, onUpdate)
    onUpdate([...this._allPMs])
    return subscription
  }

  subscribeThread (subsciptionId, onUpdate, threadKeys) {
    for (const tk of threadKeys) {
      const openThread = this._openThreads[tk]
      if (!openThread) {
        this.crawlThread(tk).catch(console.error)
      } else {
        onUpdate([...openThread])
      }
    }
    return this._ssbAdapter.subscribe(subsciptionId, this._ownPMThreadSubscriptions, threadKeys, onUpdate)
  }
}
