const ssbClient = require('ssb-client')
const ssbKeys = require('ssb-keys')
const ssbRef = require('ssb-ref')
const prompt = require('prompt')

// for this to work, the key using this script must be in the master array of the pub's config
const clientOpt = {
		host: "pub.t4l3.net",
		port: 8008,
		key:  "@WndnBREUvtFVF14XYEq01icpt91753bA+nVycEJIAX4=.ed25519"
}

console.log("hello fellow travler. I heared you have trouble with somebody on our pub?")
console.dir(clientOpt)

prompt.start();

prompt.get(['offensiveID'], function (err, result) {
	if(err) {
		console.error('prompt err:', err)
		process.exit(1)
	}

  console.log('Okay. here is what you told me:');
  console.log('  to block: ' + result.offensiveID);

  if (typeof result.offensiveID !== 'string' || !ssbRef.isFeedId(result.offensiveID)) {
    console.warn('sorry. that doesn\'t look like a pubkey id to me...')
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

      sbot.publish({type: 'contact', blocking: true, contact: result.offensiveID}, function (err, msg) {
        if(err) {
        console.error('publish err:', err)
        process.exit(2)
        }
        console.log('publish successfull. have a nice day.')
      })
    })
  })
});
