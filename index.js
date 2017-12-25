'use strict'

process.on('uncaughtException', (err) => {
  console.error(err)
  process.exit()
})

/* ==[ this should be as less code as possible ]==
 * it's only purpose is to use plain electron to load sbot
 * and then start the webpack/babled main/render code
 *
 * not sure what kind of black hole i'm opening here.
 * it is crossing require spaces so to speak..
 * here be dragons...
 *
 * TODO: paths to require (main|render).js and loady are not called correctly in production build
*/

const defaultMenu = require('electron-default-menu')
const WindowState = require('electron-window-state')
const electron = require('electron')
const path = require('path')
const ssbKeys = require('ssb-keys')
const nodeOpen = require('open')

let mainPath = process.env.NODE_ENV === 'development'
  ? path.join(__dirname, 'dist/electron/main.js') // <= inside ASAR
  : path.join(__dirname, 'main.js') // <= inside source
let main = require(mainPath).default()

let appName = process.env.ssb_appname || 'ssb' //  'ssb-talenet' ? might make sense when we use our own set of sbot plugins

// from patchbay & patchwork

var windows = {}
var quitting = false
var ssbConfig = null

function open (url) {
  electron.shell.openExternal(url, err => {
    if (!err) {
      return
    }

    console.error(err)

    const proc = nodeOpen(url)
    proc.stdout.on('data', (data) => {
      console.log(data)
    })
    proc.stderr.on('data', (data) => {
      console.error(data)
    })
  })
}

electron.app.on('ready', () => {
  setupContext(appName, {
    server: !(process.argv.includes('-g') || process.argv.includes('--use-global-ssb'))
  }, () => {
    // TODO: should be moved to src/main/
    var menu = defaultMenu(electron.app, electron.shell)
    var view = menu.find(x => x.label === 'View')
    view.submenu = [
      { role: 'reload' },
      { role: 'toggledevtools' },
      { type: 'separator' },
      { role: 'resetzoom' },
      { role: 'zoomin' },
      { role: 'zoomout' },
      { type: 'separator' },
      { role: 'togglefullscreen' }
    ]
    if (process.platform === 'darwin') {
      var win = menu.find(x => x.label === 'Window')
      win.submenu = [
        { role: 'minimize' },
        { role: 'zoom' },
        { role: 'close', label: 'Close' },
        { type: 'separator' },
        { role: 'front' }
      ]
    }
    electron.Menu.setApplicationMenu(electron.Menu.buildFromTemplate(menu))
    openMainWindow()

  })

  electron.app.on('activate', function (e) {
    if (windows.main) {
      windows.main.show()
    }
  })

  electron.app.on('window-all-closed', () => {
    if (process.platform !== 'darwin') {
      electron.app.quit()
    }
  })

  electron.app.on('before-quit', function () {
    quitting = true
  })
})

function setupContext (appName, opts, cb) {
  ssbConfig = require('ssb-config/inject')(appName, {
    /* TODO: randomize port
    baldo made a good case for multiple sbot servers.
    ssb_appname already works to split up the database folder but than the port is taken.
    (ps: opening two sbots in the same folder leads to a lot of _lock taken_ errors but shouldn't lead to desasters)
    */
    port: 8008,
    // blobsPort: 7777, using ssb-ws' blob server for now
    friends: {
      dunbar: 150,
      hops: 2 // down from 3
    }
  })

  ssbConfig.keys = ssbKeys.loadOrCreateSync(path.join(ssbConfig.path, 'secret'))

  // fix offline on windows by specifying 127.0.0.1 instead of localhost (default)
  var id = ssbConfig.keys.id
  ssbConfig.remote = `net:127.0.0.1:${ssbConfig.port}~shs:${id.slice(1).replace('.ed25519', '')}`

  if (opts.server === false) {
    cb && cb()
  } else {
    electron.ipcMain.once('server-started', function (ev, config) {
      ssbConfig = config
      cb && cb()
    })
    startBackgroundProcess()
    /* FIXME(cryptix) try to connect, don't start our own sbot otherwise
     * howto overcome race on manifest.json?
    require('ssb-client')(ssbConfig.keys, ssbConfig, (err, sbot) => {
      if (!err) {
        cb && cb()
      } else {
      }
    */
  }
}

function startBackgroundProcess () {
  if (!windows.background) {
    windows.background = openWindow(ssbConfig, path.join(__dirname, 'sbot'), {
      fullscreen: false,
      fullscreenable: false,
      maximizable: false,
      minimizable: false,
      resizable: false,
      show: false,
      skipTaskbar: true,
      title: 'tale:net-server',
      useContentSize: true
    })
  }
}

function shallOpenInBrowser (url) {
  return !url.startsWith('file://') && !url.startsWith('http://localhost:')
}

function openMainWindow () {
  if (!windows.main) {
    var windowState = WindowState({
      defaultWidth: 1024,
      defaultHeight: 768
    })
    windows.main = main.createWindow(ssbConfig, {
      minWidth: 800,
      x: windowState.x,
      y: windowState.y,
      width: windowState.width,
      height: windowState.height,
      autoHideMenuBar: true,
      title: 'tale:net',
      show: true,
      backgroundColor: '#FFF'
    })
    windowState.manage(windows.main)
    windows.main.setSheetOffset(40)
    windows.main.on('close', function (e) {
      if (!quitting && process.platform === 'darwin') {
        e.preventDefault()
        windows.main.hide()
      }
    })
    windows.main.on('closed', function () {
      windows.main = null
      if (process.platform !== 'darwin') electron.app.quit()
    })

    windows.main.webContents.on('will-navigate', function (e, url) {
      console.log('will-navigate', url)
      if (shallOpenInBrowser(url)) {
        e.preventDefault()
        open(url)
      }
    })

    windows.main.webContents.on('new-window', function (e, url) {
      console.log('new-window', url)
      // always prevent default as we do not want to open new tabs anyways
      e.preventDefault()
      if (shallOpenInBrowser(url)) {
        open(url)
      }
    })
  }
}

function openWindow (ssbCfg, p, opts) {
  var window = new electron.BrowserWindow(opts)
  window.webContents.on('dom-ready', function () {
    window.webContents.executeJavaScript(`
      var electron = require('electron')
      var cfg = ${JSON.stringify(ssbCfg)}
      electron.webFrame.setZoomLevelLimits(1, 1)
      // the following line uses some black magic and makes it impossible to use webpack all the way
      // since the re-written requires() already break sbot itself
      var obj = require(${JSON.stringify(p)})
      if (typeof obj === "function") { // init sbot
        obj(cfg)
      } else if (typeof obj === "object") { // goto render url
        // window.location = obj
        obj.init()
      }
    `) // NOTE tried process(electron)
  })

  if (process.env.DEV_TOOLS === 'YES') {
    console.warn('using DEV_TOOLS override.')
    window.webContents.openDevTools({ detach: true })
  }
  window.loadURL('file://' + path.join(__dirname, '..', 'static', 'base.html'))
  return window
}
