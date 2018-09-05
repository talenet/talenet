'use strict'
const electron = require('electron')
const Client = require('ssb-client')
const scuttleshell = require("scuttle-shell")

module.exports = (ssbConfig) => {
	// Check if scuttle-shell is already running

	Client(config.keys, config, (err, sbot) => {
		// err implies no server currently running
		if (err) {
			console.log('> starting scuttle-shell')
			console.warn('ssb-client error:', err)
			scuttleshell.start()
			
			console.warn('sbot started. sending IPC.')
		} else {
			// TODO - make this check for scuttle-shell specifically (and not just an sbot)
			// partialy done in rendere client check  (ssbAdapter) but could do better
			console.log('> scuttle-shell / sbot already running')
		}
		if (process.env.NODE_ENV === 'production') {
			sbot.close() // close this connection (app starts one of its own)
		} else {
			// allow direct access to sbot during development
			window.sbot = sbot
		}
		electron.ipcRenderer.send('server-started', ssbConfig)
	})

}
