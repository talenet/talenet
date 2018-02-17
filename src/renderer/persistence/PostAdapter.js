import Promise from 'bluebird'
import pull from 'pull-stream'
import pullSort from 'pull-sort'

import SSBAdapter from './SSBAdapter'

export default class PostAdapter {
  _allPMs = [] // duplicated in store..
  _ownPMOverviewSubscriptions = []

  _openThreads = {} // duplicated in store..
  _ownPMThreadSubscriptions = []

  constructor ({ ssbAdapter }) {
    this._ssbAdapter = ssbAdapter
  }

  overviewMergeAndSort (pms) {
    pull(
      pull.values(this._allPMs.concat(pms)),
      pullSort((msgA, msgB) => {
        return msgB.value.timestamp - msgA.value.timestamp
      }),
      pull.unique((msg) => { // threadKey
        const r = msg.value.content.root
        if (!r) return msg.key
        return r
      }),
      pull.collect((err, msgs) => {
        if (err) {
          return console.error(err)
        }
        this._allPMs = msgs
        SSBAdapter.propagateUpdate(
          this._ownPMOverviewSubscriptions,
          this._allPMs)
      })
    )
  }

  connect () {
    return Promise.resolve()
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
    const newT = this._openThreads[threadKey] = []
    pull( // TODO: cancel me
      this._ssbAdapter.streamPrivate({
        dest: threadKey,
        gt: Date.now(),
        live: true
      }),
      pull.drain((msg) => {
        newT.push(msg)
        SSBAdapter.propagateUpdate(
          this._ownPMThreadSubscriptions,
          newT,
          threadKey)
      })
    )
    return this._ssbAdapter.collectThread(threadKey).then((msgs) => {
      // newT = newT.concat(msgs) doesn't work for const newT
      for (const m of msgs) {
        newT.push(m)
      }
      SSBAdapter.propagateUpdate(
        this._ownPMThreadSubscriptions,
        newT,
        threadKey)
      return Promise.resolve()
    })
  }

  subscribeOverview (subsciptionId, onUpdate) {
    // live messages
    pull( // TODO: cancel me
      this._ssbAdapter.streamPrivate({
        gt: Date.now(),
        live: true }),
      pull.drain((msg) => {
        this.overviewMergeAndSort([msg])
      })
    )
    // old messages
    pull(
      this._ssbAdapter.streamPrivate({
        /* TODO: can not see messages that are older.
         * make a <load more> button after the last message
         * which fires a query timestamp > $last-message.timestamp
         */
        limit: 50,
        reverse: true
      }),
      pull.collect((err, msgs) => {
        if (err) return console.error(err)
        this.overviewMergeAndSort(msgs)
      })
    )
    return this._ssbAdapter.subscribe(subsciptionId, this._ownPMOverviewSubscriptions, null, onUpdate)
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
