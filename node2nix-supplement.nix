# This file has been generated by node2nix 1.6.1. Do not edit!

{nodeEnv, fetchurl, fetchgit, globalBuildInputs ? []}:

let
  sources = {
    "ansi-escapes-1.4.0" = {
      name = "ansi-escapes";
      packageName = "ansi-escapes";
      version = "1.4.0";
      src = fetchurl {
        url = "http://registry.npmjs.org/ansi-escapes/-/ansi-escapes-1.4.0.tgz";
        sha1 = "d3a8a83b319aa67793662b13e761c7911422306e";
      };
    };
    "ansi-regex-2.1.1" = {
      name = "ansi-regex";
      packageName = "ansi-regex";
      version = "2.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/ansi-regex/-/ansi-regex-2.1.1.tgz";
        sha1 = "c3b33ab5ee360d86e0e628f0468ae7ef27d654df";
      };
    };
    "ansi-regex-3.0.0" = {
      name = "ansi-regex";
      packageName = "ansi-regex";
      version = "3.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/ansi-regex/-/ansi-regex-3.0.0.tgz";
        sha1 = "ed0317c322064f79466c02966bddb605ab37d998";
      };
    };
    "ansi-styles-2.2.1" = {
      name = "ansi-styles";
      packageName = "ansi-styles";
      version = "2.2.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/ansi-styles/-/ansi-styles-2.2.1.tgz";
        sha1 = "b432dd3358b634cf75e1e4664368240533c1ddbe";
      };
    };
    "babel-polyfill-6.23.0" = {
      name = "babel-polyfill";
      packageName = "babel-polyfill";
      version = "6.23.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/babel-polyfill/-/babel-polyfill-6.23.0.tgz";
        sha1 = "8364ca62df8eafb830499f699177466c3b03499d";
      };
    };
    "babel-runtime-6.26.0" = {
      name = "babel-runtime";
      packageName = "babel-runtime";
      version = "6.26.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/babel-runtime/-/babel-runtime-6.26.0.tgz";
        sha1 = "965c7058668e82b55d7bfe04ff2337bc8b5647fe";
      };
    };
    "chalk-1.1.3" = {
      name = "chalk";
      packageName = "chalk";
      version = "1.1.3";
      src = fetchurl {
        url = "http://registry.npmjs.org/chalk/-/chalk-1.1.3.tgz";
        sha1 = "a8115c55e4a702fe4d150abd3872822a7e09fc98";
      };
    };
    "chardet-0.4.2" = {
      name = "chardet";
      packageName = "chardet";
      version = "0.4.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/chardet/-/chardet-0.4.2.tgz";
        sha1 = "b5473b33dc97c424e5d98dc87d55d4d8a29c8bf2";
      };
    };
    "cli-cursor-2.1.0" = {
      name = "cli-cursor";
      packageName = "cli-cursor";
      version = "2.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/cli-cursor/-/cli-cursor-2.1.0.tgz";
        sha1 = "b35dac376479facc3e94747d41d0d0f5238ffcb5";
      };
    };
    "cli-width-2.2.0" = {
      name = "cli-width";
      packageName = "cli-width";
      version = "2.2.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/cli-width/-/cli-width-2.2.0.tgz";
        sha1 = "ff19ede8a9a5e579324147b0c11f0fbcbabed639";
      };
    };
    "core-js-2.6.1" = {
      name = "core-js";
      packageName = "core-js";
      version = "2.6.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/core-js/-/core-js-2.6.1.tgz";
        sha512 = "L72mmmEayPJBejKIWe2pYtGis5r0tQ5NaJekdhyXgeMQTpJoBsH0NL4ElY2LfSoV15xeQWKQ+XTTOZdyero5Xg==";
      };
    };
    "encoding-0.1.12" = {
      name = "encoding";
      packageName = "encoding";
      version = "0.1.12";
      src = fetchurl {
        url = "https://registry.npmjs.org/encoding/-/encoding-0.1.12.tgz";
        sha1 = "538b66f3ee62cd1ab51ec323829d1f9480c74beb";
      };
    };
    "escape-string-regexp-1.0.5" = {
      name = "escape-string-regexp";
      packageName = "escape-string-regexp";
      version = "1.0.5";
      src = fetchurl {
        url = "https://registry.npmjs.org/escape-string-regexp/-/escape-string-regexp-1.0.5.tgz";
        sha1 = "1b61c0562190a8dff6ae3bb2cf0200ca130b86d4";
      };
    };
    "external-editor-2.2.0" = {
      name = "external-editor";
      packageName = "external-editor";
      version = "2.2.0";
      src = fetchurl {
        url = "http://registry.npmjs.org/external-editor/-/external-editor-2.2.0.tgz";
        sha512 = "bSn6gvGxKt+b7+6TKEv1ZycHleA7aHhRHyAqJyp5pbUFuYYNIzpZnQDk7AsYckyWdEnTeAnay0aCy2aV6iTk9A==";
      };
    };
    "figures-2.0.0" = {
      name = "figures";
      packageName = "figures";
      version = "2.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/figures/-/figures-2.0.0.tgz";
        sha1 = "3ab1a2d2a62c8bfb431a0c94cb797a2fce27c962";
      };
    };
    "has-ansi-2.0.0" = {
      name = "has-ansi";
      packageName = "has-ansi";
      version = "2.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/has-ansi/-/has-ansi-2.0.0.tgz";
        sha1 = "34f5049ce1ecdf2b0649af3ef24e45ed35416d91";
      };
    };
    "iconv-lite-0.4.24" = {
      name = "iconv-lite";
      packageName = "iconv-lite";
      version = "0.4.24";
      src = fetchurl {
        url = "https://registry.npmjs.org/iconv-lite/-/iconv-lite-0.4.24.tgz";
        sha512 = "v3MXnZAcvnywkTUEZomIActle7RXXeedOR31wwl7VlyoXO4Qi9arvSenNQWne1TcRwhCL1HwLI21bEqdpj8/rA==";
      };
    };
    "inquirer-3.0.6" = {
      name = "inquirer";
      packageName = "inquirer";
      version = "3.0.6";
      src = fetchurl {
        url = "https://registry.npmjs.org/inquirer/-/inquirer-3.0.6.tgz";
        sha1 = "e04aaa9d05b7a3cb9b0f407d04375f0447190347";
      };
    };
    "is-fullwidth-code-point-2.0.0" = {
      name = "is-fullwidth-code-point";
      packageName = "is-fullwidth-code-point";
      version = "2.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/is-fullwidth-code-point/-/is-fullwidth-code-point-2.0.0.tgz";
        sha1 = "a3b30a5c4f199183167aaab93beefae3ddfb654f";
      };
    };
    "is-promise-2.1.0" = {
      name = "is-promise";
      packageName = "is-promise";
      version = "2.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/is-promise/-/is-promise-2.1.0.tgz";
        sha1 = "79a2a9ece7f096e80f36d2b2f3bc16c1ff4bf3fa";
      };
    };
    "is-stream-1.1.0" = {
      name = "is-stream";
      packageName = "is-stream";
      version = "1.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/is-stream/-/is-stream-1.1.0.tgz";
        sha1 = "12d4a3dd4e68e0b79ceb8dbc84173ae80d91ca44";
      };
    };
    "lodash-4.17.11" = {
      name = "lodash";
      packageName = "lodash";
      version = "4.17.11";
      src = fetchurl {
        url = "https://registry.npmjs.org/lodash/-/lodash-4.17.11.tgz";
        sha512 = "cQKh8igo5QUhZ7lg38DYWAxMvjSAKG0A8wGSVimP07SIUEK2UO+arSRKbRZWtelMtN5V0Hkwh5ryOto/SshYIg==";
      };
    };
    "mimic-fn-1.2.0" = {
      name = "mimic-fn";
      packageName = "mimic-fn";
      version = "1.2.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/mimic-fn/-/mimic-fn-1.2.0.tgz";
        sha512 = "jf84uxzwiuiIVKiOLpfYk7N46TSy8ubTonmneY9vrpHNAnp0QBt2BxWV9dO3/j+BoVAb+a5G6YDPW3M5HOdMWQ==";
      };
    };
    "minimist-1.2.0" = {
      name = "minimist";
      packageName = "minimist";
      version = "1.2.0";
      src = fetchurl {
        url = "http://registry.npmjs.org/minimist/-/minimist-1.2.0.tgz";
        sha1 = "a35008b20f41383eec1fb914f4cd5df79a264284";
      };
    };
    "mute-stream-0.0.7" = {
      name = "mute-stream";
      packageName = "mute-stream";
      version = "0.0.7";
      src = fetchurl {
        url = "https://registry.npmjs.org/mute-stream/-/mute-stream-0.0.7.tgz";
        sha1 = "3075ce93bc21b8fab43e1bc4da7e8115ed1e7bab";
      };
    };
    "node-fetch-1.6.3" = {
      name = "node-fetch";
      packageName = "node-fetch";
      version = "1.6.3";
      src = fetchurl {
        url = "http://registry.npmjs.org/node-fetch/-/node-fetch-1.6.3.tgz";
        sha1 = "dc234edd6489982d58e8f0db4f695029abcd8c04";
      };
    };
    "object-assign-4.1.1" = {
      name = "object-assign";
      packageName = "object-assign";
      version = "4.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/object-assign/-/object-assign-4.1.1.tgz";
        sha1 = "2109adc7965887cfc05cbbd442cac8bfbb360863";
      };
    };
    "onetime-2.0.1" = {
      name = "onetime";
      packageName = "onetime";
      version = "2.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/onetime/-/onetime-2.0.1.tgz";
        sha1 = "067428230fd67443b2794b22bba528b6867962d4";
      };
    };
    "opn-4.0.2" = {
      name = "opn";
      packageName = "opn";
      version = "4.0.2";
      src = fetchurl {
        url = "http://registry.npmjs.org/opn/-/opn-4.0.2.tgz";
        sha1 = "7abc22e644dff63b0a96d5ab7f2790c0f01abc95";
      };
    };
    "os-tmpdir-1.0.2" = {
      name = "os-tmpdir";
      packageName = "os-tmpdir";
      version = "1.0.2";
      src = fetchurl {
        url = "http://registry.npmjs.org/os-tmpdir/-/os-tmpdir-1.0.2.tgz";
        sha1 = "bbe67406c79aa85c5cfec766fe5734555dfa1274";
      };
    };
    "pinkie-2.0.4" = {
      name = "pinkie";
      packageName = "pinkie";
      version = "2.0.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/pinkie/-/pinkie-2.0.4.tgz";
        sha1 = "72556b80cfa0d48a974e80e77248e80ed4f7f870";
      };
    };
    "pinkie-promise-2.0.1" = {
      name = "pinkie-promise";
      packageName = "pinkie-promise";
      version = "2.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/pinkie-promise/-/pinkie-promise-2.0.1.tgz";
        sha1 = "2135d6dfa7a358c069ac9b178776288228450ffa";
      };
    };
    "regenerator-runtime-0.10.5" = {
      name = "regenerator-runtime";
      packageName = "regenerator-runtime";
      version = "0.10.5";
      src = fetchurl {
        url = "https://registry.npmjs.org/regenerator-runtime/-/regenerator-runtime-0.10.5.tgz";
        sha1 = "336c3efc1220adcedda2c9fab67b5a7955a33658";
      };
    };
    "regenerator-runtime-0.11.1" = {
      name = "regenerator-runtime";
      packageName = "regenerator-runtime";
      version = "0.11.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/regenerator-runtime/-/regenerator-runtime-0.11.1.tgz";
        sha512 = "MguG95oij0fC3QV3URf4V2SDYGJhJnJGqvIIgdECeODCT98wSWDAJ94SSuVpYQUoTcGUIL6L4yNB7j1DFFHSBg==";
      };
    };
    "restore-cursor-2.0.0" = {
      name = "restore-cursor";
      packageName = "restore-cursor";
      version = "2.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/restore-cursor/-/restore-cursor-2.0.0.tgz";
        sha1 = "9f7ee287f82fd326d4fd162923d62129eee0dfaf";
      };
    };
    "run-async-2.3.0" = {
      name = "run-async";
      packageName = "run-async";
      version = "2.3.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/run-async/-/run-async-2.3.0.tgz";
        sha1 = "0371ab4ae0bdd720d4166d7dfda64ff7a445a6c0";
      };
    };
    "rx-4.1.0" = {
      name = "rx";
      packageName = "rx";
      version = "4.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/rx/-/rx-4.1.0.tgz";
        sha1 = "a5f13ff79ef3b740fe30aa803fb09f98805d4782";
      };
    };
    "safer-buffer-2.1.2" = {
      name = "safer-buffer";
      packageName = "safer-buffer";
      version = "2.1.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/safer-buffer/-/safer-buffer-2.1.2.tgz";
        sha512 = "YZo3K82SD7Riyi0E1EQPojLz7kpepnSQI9IyPbHHg1XXXevb5dJI7tpyN2ADxGcQbHG7vcyRHk0cbwqcQriUtg==";
      };
    };
    "signal-exit-3.0.2" = {
      name = "signal-exit";
      packageName = "signal-exit";
      version = "3.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/signal-exit/-/signal-exit-3.0.2.tgz";
        sha1 = "b5fdc08f1287ea1178628e415e25132b73646c6d";
      };
    };
    "string-width-2.1.1" = {
      name = "string-width";
      packageName = "string-width";
      version = "2.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/string-width/-/string-width-2.1.1.tgz";
        sha512 = "nOqH59deCq9SRHlxq1Aw85Jnt4w6KvLKqWVik6oA9ZklXLNIOlqg4F2yrT1MVaTjAqvVwdfeZ7w7aCvJD7ugkw==";
      };
    };
    "strip-ansi-3.0.1" = {
      name = "strip-ansi";
      packageName = "strip-ansi";
      version = "3.0.1";
      src = fetchurl {
        url = "http://registry.npmjs.org/strip-ansi/-/strip-ansi-3.0.1.tgz";
        sha1 = "6a385fb8853d952d5ff05d0e8aaf94278dc63dcf";
      };
    };
    "strip-ansi-4.0.0" = {
      name = "strip-ansi";
      packageName = "strip-ansi";
      version = "4.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/strip-ansi/-/strip-ansi-4.0.0.tgz";
        sha1 = "a8479022eb1ac368a871389b635262c505ee368f";
      };
    };
    "supports-color-2.0.0" = {
      name = "supports-color";
      packageName = "supports-color";
      version = "2.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/supports-color/-/supports-color-2.0.0.tgz";
        sha1 = "535d045ce6b6363fa40117084629995e9df324c7";
      };
    };
    "through-2.3.8" = {
      name = "through";
      packageName = "through";
      version = "2.3.8";
      src = fetchurl {
        url = "http://registry.npmjs.org/through/-/through-2.3.8.tgz";
        sha1 = "0dd4c9ffaabc357960b1b724115d7e0e86a2e1f5";
      };
    };
    "tmp-0.0.33" = {
      name = "tmp";
      packageName = "tmp";
      version = "0.0.33";
      src = fetchurl {
        url = "https://registry.npmjs.org/tmp/-/tmp-0.0.33.tgz";
        sha512 = "jRCJlojKnZ3addtTOjdIqoRuPEKBvNXcGYqzO6zWZX8KfKEpnGY5jfggJQ3EjKuu8D4bJRr0y+cYJFmYbImXGw==";
      };
    };
  };
in
{
  opencollective = nodeEnv.buildNodePackage {
    name = "opencollective";
    packageName = "opencollective";
    version = "1.0.3";
    src = fetchurl {
      url = "https://registry.npmjs.org/opencollective/-/opencollective-1.0.3.tgz";
      sha1 = "aee6372bc28144583690c3ca8daecfc120dd0ef1";
    };
    dependencies = [
      sources."ansi-escapes-1.4.0"
      sources."ansi-regex-2.1.1"
      sources."ansi-styles-2.2.1"
      sources."babel-polyfill-6.23.0"
      (sources."babel-runtime-6.26.0" // {
        dependencies = [
          sources."regenerator-runtime-0.11.1"
        ];
      })
      sources."chalk-1.1.3"
      sources."chardet-0.4.2"
      sources."cli-cursor-2.1.0"
      sources."cli-width-2.2.0"
      sources."core-js-2.6.1"
      sources."encoding-0.1.12"
      sources."escape-string-regexp-1.0.5"
      sources."external-editor-2.2.0"
      sources."figures-2.0.0"
      sources."has-ansi-2.0.0"
      sources."iconv-lite-0.4.24"
      sources."inquirer-3.0.6"
      sources."is-fullwidth-code-point-2.0.0"
      sources."is-promise-2.1.0"
      sources."is-stream-1.1.0"
      sources."lodash-4.17.11"
      sources."mimic-fn-1.2.0"
      sources."minimist-1.2.0"
      sources."mute-stream-0.0.7"
      sources."node-fetch-1.6.3"
      sources."object-assign-4.1.1"
      sources."onetime-2.0.1"
      sources."opn-4.0.2"
      sources."os-tmpdir-1.0.2"
      sources."pinkie-2.0.4"
      sources."pinkie-promise-2.0.1"
      sources."regenerator-runtime-0.10.5"
      sources."restore-cursor-2.0.0"
      sources."run-async-2.3.0"
      sources."rx-4.1.0"
      sources."safer-buffer-2.1.2"
      sources."signal-exit-3.0.2"
      (sources."string-width-2.1.1" // {
        dependencies = [
          sources."ansi-regex-3.0.0"
          sources."strip-ansi-4.0.0"
        ];
      })
      sources."strip-ansi-3.0.1"
      sources."supports-color-2.0.0"
      sources."through-2.3.8"
      sources."tmp-0.0.33"
    ];
    buildInputs = globalBuildInputs;
    meta = {
      description = "Official Command Line Interface for Open Collective";
      homepage = "https://github.com/opencollective/opencollective-cli#readme";
      license = "MIT";
    };
    production = true;
    bypassCache = true;
    reconstructLock = true;
  };
  node-gyp-build = nodeEnv.buildNodePackage {
    name = "node-gyp-build";
    packageName = "node-gyp-build";
    version = "3.6.0";
    src = fetchurl {
      url = "https://registry.npmjs.org/node-gyp-build/-/node-gyp-build-3.6.0.tgz";
      sha512 = "4yfIUBKGAjjsgRI50D1U5RF8zgOn+xfV8qmP9zQ078erdxIX6dOPCRb37Vj0nm1yaONuWAJJcWwSZqrt+Fq/MA==";
    };
    buildInputs = globalBuildInputs;
    meta = {
      description = "Build tool and bindings loader for node-gyp that supports prebuilds";
      homepage = https://github.com/mafintosh/node-gyp-build;
      license = "MIT";
    };
    production = true;
    bypassCache = true;
    reconstructLock = true;
  };
}