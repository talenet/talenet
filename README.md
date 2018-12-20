# tale:net
[![Travis Status](https://travis-ci.org/talenet/talenet.svg?branch=master)](https://travis-ci.org/talenet/talenet)
[![AppVeyor status](https://ci.appveyor.com/api/projects/status/kenxoweop5q36jbt?svg=true)](https://ci.appveyor.com/project/cryptix/talenet)

Intergalactic skill & idea sharing community.

# Screenshots


![welcome](screenshots/welcome.png)

![pull:ideas](screenshots/pull_ideas.png)

![push:ideas](screenshots/push_idea.png)

![skilliverse](screenshots/skilliverse.png)

# Development dependencies

(prelude: nixos is not required to work on this. Just skip to _Build Setup_.)

## NixOS

This repository contains a `shell.nix` that provides all required dependecies
for development. Enter the environment by simply running:

```bash
nix-shell
```

### Regenerate

```bash
node2nix -8 -c node2nix-taleEnv.nix --supplement-input node2nix-supplement.json --supplement-output node2nix-supplement.nix
```


## Git setup

Enable automatic rebasing when pulling:

```bash
git config branch.autosetuprebase always
```

## Build Setup

```bash
# install dependencies
npm install

# to manually start sbot just run (uses dev identity to not spam own ssb identity)
ssb_appname=talenet-dev ./node_modules/.bin/sbot server

# serve with hot reload (uses dev identity to not spam own ssb identity)
ssb_appname=talenet-dev npm run dev

# build electron application for production
npm run build

# TODO: what part of our stack runs this actually?
# build for production and view the bundle analyzer report
# npm run build --report

# run unit tests
npm run unit

# run e2e tests
npm run e2e

# run all tests
npm test
```

This project was generated with [electron-vue](https://github.com/SimulatedGREG/electron-vue)@[331f85f](https://github.com/SimulatedGREG/electron-vue/tree/331f85fd556cc0d60a30ad019a44a29baaed49f5) using [vue-cli](https://github.com/vuejs/vue-cli). Documentation about the original structure can be found [here](https://simulatedgreg.gitbooks.io/electron-vue/content/index.html).


## SSB

### standalone sbot server
`sbot` now runs as a _background process_ inside electron as a hidden window.

If you want to use a standalone sbot with talenet, it has to be installed and started in a separate terminal window.
This makes it possbile to use patchfoo or other ssb clients in parallel with talenet.

```bash
# clone it from github
git clone https://github.com/ssbc/scuttlebot.git

# change into the cloned directory
cd scuttlebot

# install it's dependencies
npm i

# run it
$HOME/scuttlebot/bin.js server
```

To use tale:net with a seperate/standalone sbot, you need to use `talenet -g` (`npm run dev -- -g` for development) to start it.

Your sbot then also needs to have the [ssb-talequery](https://www.npmjs.com/package/ssb-talequery) plugin installed. Run `sbot plugins.install ssb-talequery` to do this.

### test:net and test:identity
**TODO**: we want to supply a network where you can freely spam, to develop and test new features.
This will use an secret-handshake _appkey_ so that your sbot can't connect to the mainnet.

If you want to run `sbot` for testing and want to avoid using your regular key pair you can specify
the `ssb_appname` environment variable. If you e.g. set `ssb_appname=test` sbot will store data in `~/.test`.
Be aware that you need to run tale:net with the same environment variable, e.g.:

```bash
ssb_appname=test npm run dev
```

## wonders of modern javascript

### testing problems

**TODO**: clean this up. might be outdated.

our tests parse all the included npm modules, too. this surfaces lot's of dirty hacks in these modules. some frequent cases:

```
ERROR in ./node_modules/rc/index.js
Module parse failed: /home/user/TALEnet/node_modules/rc/index.js Unexpected character '#' (1:0)
You may need an appropriate loader to handle this file type.
```

Some modules use a _[hashbang](https://en.wikipedia.org/wiki/Shebang_(Unix))_ (`#!/bin/sh` in the first line) to tell their shells to run the module code with node. Pretty esoteric but it can work. Not for the webpack/karma configuration we currently use though. I found two instance of this and the following script works around the problem by removing the first line of the file.

```bash
sed -i '1d' node_modules/rc/index.js
sed -i '1d' node_modules/non-private-ip/index.js
```

```
ERROR in ./node_modules/pull-ws/server.js
Module parse failed: /home/user/TALEnet/node_modules/pull-ws/server.js 'return' outside of function (9:2)
```

This code works around exporting semantics by conditionally exporting something different in a specific setting. This isn't supported by es2015.

```bash
patch node_modules/pull-ws/server.js < pull-ws-server.patch
```

### sodium/chloride crypto warning
until sodium-native is updated to support electron 1.8 you might see warnings like these:

```
Error: No native build was found for runtime=electron abi=57 platform=linux arch=x64
```

It will fallback to a JS polyfill but will be _quite_ slow...

workaround: `cd node_modules/sodium-native && npm i && npm run prebuild`

more info: https://github.com/ssbc/patchwork/issues/597#issuecomment-333345420

# Links
<div style="text-align: center;">
  <a href="https://ind.ie/ethical-design/" target="_blank"><img src="./src/renderer/static/img/ethical-design-badge-small.svg" style="height: 200px;" /></a>
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <a href="https://prototypefund.de/en/" target="_blank"><img src="./src/renderer/static/img/PrototypeFund-P-Logo.svg" style="height: 200px;" /></a>
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <a href="https://www.bmbf.de/en/index.html" target="_blank"><img src="./src/renderer/static/img/BMBF_gefoerdert_2017_en.jpg" style="height: 200px;" /></a>
</div>
