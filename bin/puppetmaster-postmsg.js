const ssbConfig = require('ssb-config/inject')
const ssbClient = require('ssb-client')
const ssbKeys = require('ssb-keys')
const ssbRef = require('ssb-ref')
const prompt = require('prompt')

// for this to work, the key using this script must be in the master array of the pub's config
const clientOpt = ssbConfig('ssb',{
		host: "pub.t4l3.net",
		port: 8008,
		key:  "@WndnBREUvtFVF14XYEq01icpt91753bA+nVycEJIAX4=.ed25519",
    // path: '/home/user/.ssb'
})

console.log("hello fellow travler. I heared you have trouble with somebody on our pub?")
console.dir(clientOpt)

prompt.start();

prompt.get(['pubMessage'], function (err, result) {
	if(err) {
		console.error('prompt err:', err)
		process.exit(1)
	}

  console.log('Okay. here is what you told me:');
  console.log('  to post: ' + result.pubMessage);

  if (typeof result.pubMessage !== 'string') {
    console.warn('sorry. that doesn\'t look like a message to me...')
    process.exit(1)
  }
  var keys = ssbKeys.loadOrCreateSync('./puppetmaster.key')
  ssbClient(
    keys,
    clientOpt,
    function (err, sbot) {
    if(err) {
      console.log('ssb-client err', err)
      process.exit(2)
    }
    sbot.whoami(function (err, msg) {
      if(err) {
        console.error('whoami err:', err)
        process.exit(2)
      }
      console.log('whoami:')
      console.dir(msg)
prompt.get(['sure'], function (err, verify) {
	if(err) {
		console.error('prompt err:', err)
		process.exit(1)
	}
	if(verify.sure !== 'YES') {
		console.error('no? okay...')
		process.exit(1)
	}


  sbot.publish({
    type: 'post',
    text: result.pubMessage
  }, function (err, msg) {
        if(err) {
        console.error('publish err:', err)
        process.exit(2)
        }
        console.log('publish successfull. have a nice day.')
        sbot.close()
      })
})
    })
  })
});
