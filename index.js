'use strict'

process.on('uncaughtException', (err) => {
  console.error(err)
  process.exit()
})

/* ==[ this should be as less code as possible ]==
 * it's only perpuse is to use plain electron to load sbot
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

let mainPath = process.env.NODE_ENV === 'development'
  ? path.join(__dirname, 'dist/electron/main.js') // <= inside ASAR
  : path.join(__dirname, 'main.js') // <= inside source
let main = require(mainPath).default()

// from patchbay & patchwork

var windows = {}
var quitting = false
var ssbConfig = null

console.log('STARTING electron')

electron.app.on('ready', () => {
  setupContext('ssb', {
    server: !(process.argv.includes('-g') || process.argv.includes('--use-global-ssb'))
  }, () => {
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
      windows.background.webContents.openDevTools({detach: true})
      windows.main.webContents.openDevTools({detach: true})
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

  electron.ipcMain.on('open-background-devtools', function (ev, config) {
    if (windows.background) {
      windows.background.webContents.openDevTools({detach: true})
    }
  })
})

function setupContext (appName, opts, cb) {
  ssbConfig = require('ssb-config/inject')(appName, {
    /* TODO: randomize port
    baldo made a good case for multiple sbot servers.
    ssb_appname already works to split up the database folder but than the port is taken.
    */
    port: 8008,
    blobsPort: 7777,
    friends: {
      dunbar: 150,
      hops: 2 // down from 3
    }})

  ssbConfig.keys = ssbKeys.loadOrCreateSync(path.join(ssbConfig.path, 'secret'))

  // fix offline on windows by specifying 127.0.0.1 instead of localhost (default)
  var id = ssbConfig.keys.id
  ssbConfig.remote = `net:127.0.0.1:${ssbConfig.port}~shs:${id.slice(1).replace('.ed25519', '')}`

  if (opts.server === false) {
    cb && cb()
  } else {
    // try to connect, don't start our own sbot otherwise
    require('ssb-client')(ssbConfig.keys, ssbConfig, (err, sbot) => {
      if (!err) {
        cb && cb()
      } else {
        electron.ipcMain.once('server-started', function (ev, config) {
          ssbConfig = config
          cb && cb()
        })
        startBackgroundProcess()
        // windows.background.on('close', (ev) => {
        //   ev.preventDefault()
        //   windows.background.hide()
        // })
      }
    })
  }
}

function startBackgroundProcess () {
  if (!windows.background) {
    windows.background = openWindow(ssbConfig, path.join(__dirname, 'sbot'), {
      center: true,
      // fullscreen: false,
      // fullscreenable: false,
      // height: 150,
      // maximizable: false,
      // minimizable: false,
      // resizable: false,
      show: true, // TODO: idea is to not show this window at all once this fully works and maybe just expose it
      // skipTaskbar: true,
      title: 'TALEnet-server',
      useContentSize: true,
      width: 150
    })
  }
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
      title: 'TALEnet',
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
  }
}

function openWindow (ssbCfg, p, opts) {
  var window = new electron.BrowserWindow(opts)
  window.webContents.on('dom-ready', function () {
    window.webContents.executeJavaScript(`
      var electron = require('electron')
      var cfg = ${JSON.stringify(ssbCfg)}
      electron.webFrame.setZoomLevelLimits(1, 1)
      // todo?: localized version
      // var title = ${JSON.stringify(opts.title || 'Patchbay')}
      // document.documentElement.querySelector('head').appendChild(
      //   h('title', title)
      // )
      console.warn("hello from openWindow():",${JSON.stringify(p)})
      // the following line uses some black magic and makes it impossible to use webpack all the way
      // since the requires() re-written sbot itself also breaks when trying to webpack it
      var obj = require(${JSON.stringify(p)})
      if (typeof obj === "function") { // init sbot
        obj(cfg)
      } else if (typeof obj === "object") { // goto render url
        // console.warn('redirecting to:', obj)
        // window.location = obj
        obj.init()
      }
    `) // NOTE tried process(electron)
  })

  window.webContents.on('will-navigate', function (e, url) {
    e.preventDefault()
    electron.shell.openExternal(url)
  })

  window.webContents.on('new-window', function (e, url) {
    e.preventDefault()
    electron.shell.openExternal(url)
  })

  window.loadURL('file://' + path.join(__dirname, '..', 'static', 'base.html'))
  return window
}
