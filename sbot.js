'use strict'

var fs = require('fs')
var Path = require('path')
var electron = require('electron')
var spawn = require('child_process').spawn
var fixPath = require('fix-path')

var createSbot = require('scuttlebot')
  .use(require('scuttlebot/plugins/master'))
  .use(require('scuttlebot/plugins/gossip'))
  .use(require('scuttlebot/plugins/replicate'))
  .use(require('ssb-friends'))
  .use(require('ssb-blobs'))
  .use(require('scuttlebot/plugins/invite'))
  .use(require('scuttlebot/plugins/local'))
  .use(require('scuttlebot/plugins/logging'))
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
