'use strict'

var fs = require('fs')
var Path = require('path')
var electron = require('electron')
var fixPath = require('fix-path')

var createSbot = require('ssb-server')
  .use(require('ssb-server/plugins/master'))
  .use(require('ssb-server/plugins/logging'))
  .use(require('ssb-server/plugins/unix-socket'))
  .use(require('ssb-server/plugins/no-auth'))
  .use(require('ssb-server/plugins/onion'))
  .use(require('ssb-server/plugins/local'))
  .use(require('ssb-gossip'))
  .use(require('ssb-replicate'))
  .use(require('ssb-friends'))
  .use(require('ssb-blobs'))
  .use(require('ssb-private'))
  .use(require('ssb-query'))
  .use(require('ssb-links'))
  .use(require('ssb-talequery'))
  .use(require('ssb-about'))
  .use(require('ssb-ws'))

fixPath()

module.exports = function (ssbConfig) {
  var context = {
    sbot: createSbot(ssbConfig),
    config: ssbConfig
  }
  if (process.env.NODE_ENV !== 'production') {
    // allow direct access to sbot during development
    window.sbot = context.sbot
  }
  ssbConfig.manifest = context.sbot.getManifest()
  fs.writeFileSync(Path.join(ssbConfig.path, 'manifest.json'), JSON.stringify(ssbConfig.manifest))
  console.warn('sbot started. sending IPC.')
  electron.ipcRenderer.send('server-started', ssbConfig)
}
