import Promise from 'bluebird'
import pull from 'pull-stream'

import SSBAdapter from './SSBAdapter'

export default class PostAdapter {
  _allPMs = []
  _ownPrivateMessageSubscriptions = []

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
          SSBAdapter.propagateUpdate(this._ownPrivateMessageSubscriptions, this._allPMs)
          resolve() // TODO: live query - messages are only fetched once on load
        })
      )
    })
  }

  subscribeAllPrivateMessages (subsciptionId, onUpdate) {
    const subscription = this._ssbAdapter.subscribe(subsciptionId, this._ownPrivateMessageSubscriptions, null, onUpdate)
    onUpdate([...this._allPMs])
    return subscription
  }
}
