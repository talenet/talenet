# This file has been generated by node2nix 1.6.0. Do not edit!

{nodeEnv, fetchurl, fetchgit, globalBuildInputs ? []}:

let
  sources = {
    "ansi-escapes-1.4.0" = {
      name = "ansi-escapes";
      packageName = "ansi-escapes";
      version = "1.4.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/ansi-escapes/-/ansi-escapes-1.4.0.tgz";
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
    "ansi-styles-3.2.1" = {
      name = "ansi-styles";
      packageName = "ansi-styles";
      version = "3.2.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/ansi-styles/-/ansi-styles-3.2.1.tgz";
        sha512 = "VT0ZI6kZRdTh8YyJw3SMbYm/u+NqfsAxEpWO0Pf9sq8/e94WxxOpPKx9FR1FlyCtOVDNOQ+8ntlqFxiRc+r5qA==";
      };
    };
    "array-union-1.0.2" = {
      name = "array-union";
      packageName = "array-union";
      version = "1.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/array-union/-/array-union-1.0.2.tgz";
        sha1 = "9a34410e4f4e3da23dea375be5be70f24778ec39";
      };
    };
    "array-uniq-1.0.3" = {
      name = "array-uniq";
      packageName = "array-uniq";
      version = "1.0.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/array-uniq/-/array-uniq-1.0.3.tgz";
        sha1 = "af6ac877a25cc7f74e058894753858dfdb24fdb6";
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
    "balanced-match-1.0.0" = {
      name = "balanced-match";
      packageName = "balanced-match";
      version = "1.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/balanced-match/-/balanced-match-1.0.0.tgz";
        sha1 = "89b4d199ab2bee49de164ea02b89ce462d71b767";
      };
    };
    "brace-expansion-1.1.11" = {
      name = "brace-expansion";
      packageName = "brace-expansion";
      version = "1.1.11";
      src = fetchurl {
        url = "https://registry.npmjs.org/brace-expansion/-/brace-expansion-1.1.11.tgz";
        sha512 = "iCuPHDFgrHX7H2vEI/5xpz07zSHB00TpugqhmYtVmMO6518mCuRMoOYFldEBl0g187ufozdaHgWKcYFb61qGiA==";
      };
    };
    "camel-case-3.0.0" = {
      name = "camel-case";
      packageName = "camel-case";
      version = "3.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/camel-case/-/camel-case-3.0.0.tgz";
        sha1 = "ca3c3688a4e9cf3a4cda777dc4dcbc713249cf73";
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
    "chalk-2.4.1" = {
      name = "chalk";
      packageName = "chalk";
      version = "2.4.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/chalk/-/chalk-2.4.1.tgz";
        sha512 = "ObN6h1v2fTJSmUXoS3nMQ92LbDK9be4TV+6G+omQlGJFdcUX5heKi1LZ1YnRMIgwTLEj3E24bT6tYni50rlCfQ==";
      };
    };
    "change-case-3.0.2" = {
      name = "change-case";
      packageName = "change-case";
      version = "3.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/change-case/-/change-case-3.0.2.tgz";
        sha512 = "Mww+SLF6MZ0U6kdg11algyKd5BARbyM4TbFBepwowYSR5ClfQGCGtxNXgykpN0uF/bstWeaGDT4JWaDh8zWAHA==";
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
    "color-convert-1.9.3" = {
      name = "color-convert";
      packageName = "color-convert";
      version = "1.9.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/color-convert/-/color-convert-1.9.3.tgz";
        sha512 = "QfAUtd+vFdAtFQcC8CCyYt1fYWxSqAiK2cSD6zDB8N3cpsEBAvRxp9zOGg6G/SHHJYAT88/az/IuDGALsNVbGg==";
      };
    };
    "color-name-1.1.3" = {
      name = "color-name";
      packageName = "color-name";
      version = "1.1.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/color-name/-/color-name-1.1.3.tgz";
        sha1 = "a7d0558bd89c42f795dd42328f740831ca53bc25";
      };
    };
    "concat-map-0.0.1" = {
      name = "concat-map";
      packageName = "concat-map";
      version = "0.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/concat-map/-/concat-map-0.0.1.tgz";
        sha1 = "d8a96bd77fd68df7793a73036a3ba0d5405d477b";
      };
    };
    "constant-case-2.0.0" = {
      name = "constant-case";
      packageName = "constant-case";
      version = "2.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/constant-case/-/constant-case-2.0.0.tgz";
        sha1 = "4175764d389d3fa9c8ecd29186ed6005243b6a46";
      };
    };
    "core-js-2.5.7" = {
      name = "core-js";
      packageName = "core-js";
      version = "2.5.7";
      src = fetchurl {
        url = "https://registry.npmjs.org/core-js/-/core-js-2.5.7.tgz";
        sha512 = "RszJCAxg/PP6uzXVXL6BsxSXx/B05oJAQ2vkJRjyjrEcNVycaqOmNb5OTxZPE3xa5gwZduqza6L9JOCenh/Ecw==";
      };
    };
    "define-property-1.0.0" = {
      name = "define-property";
      packageName = "define-property";
      version = "1.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/define-property/-/define-property-1.0.0.tgz";
        sha1 = "769ebaaf3f4a63aad3af9e8d304c9bbe79bfb0e6";
      };
    };
    "dot-case-2.1.1" = {
      name = "dot-case";
      packageName = "dot-case";
      version = "2.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/dot-case/-/dot-case-2.1.1.tgz";
        sha1 = "34dcf37f50a8e93c2b3bca8bb7fb9155c7da3bee";
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
    "fs.realpath-1.0.0" = {
      name = "fs.realpath";
      packageName = "fs.realpath";
      version = "1.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/fs.realpath/-/fs.realpath-1.0.0.tgz";
        sha1 = "1504ad2523158caa40db4a2787cb01411994ea4f";
      };
    };
    "glob-7.1.3" = {
      name = "glob";
      packageName = "glob";
      version = "7.1.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/glob/-/glob-7.1.3.tgz";
        sha512 = "vcfuiIxogLV4DlGBHIUOwI0IbrJ8HWPc4MU7HzviGeNho/UJDfi6B5p3sHeWIQ0KGIU0Jpxi5ZHxemQfLkkAwQ==";
      };
    };
    "globby-6.1.0" = {
      name = "globby";
      packageName = "globby";
      version = "6.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/globby/-/globby-6.1.0.tgz";
        sha1 = "f5a6d70e8395e21c858fb0489d64df02424d506c";
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
    "has-flag-3.0.0" = {
      name = "has-flag";
      packageName = "has-flag";
      version = "3.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/has-flag/-/has-flag-3.0.0.tgz";
        sha1 = "b5d454dc2199ae225699f3467e5a07f3b955bafd";
      };
    };
    "header-case-1.0.1" = {
      name = "header-case";
      packageName = "header-case";
      version = "1.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/header-case/-/header-case-1.0.1.tgz";
        sha1 = "9535973197c144b09613cd65d317ef19963bd02d";
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
    "inflight-1.0.6" = {
      name = "inflight";
      packageName = "inflight";
      version = "1.0.6";
      src = fetchurl {
        url = "https://registry.npmjs.org/inflight/-/inflight-1.0.6.tgz";
        sha1 = "49bd6331d7d02d0c09bc910a1075ba8165b56df9";
      };
    };
    "inherits-2.0.3" = {
      name = "inherits";
      packageName = "inherits";
      version = "2.0.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/inherits/-/inherits-2.0.3.tgz";
        sha1 = "633c2c83e3da42a502f52466022480f4208261de";
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
    "is-accessor-descriptor-1.0.0" = {
      name = "is-accessor-descriptor";
      packageName = "is-accessor-descriptor";
      version = "1.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/is-accessor-descriptor/-/is-accessor-descriptor-1.0.0.tgz";
        sha512 = "m5hnHTkcVsPfqx3AKlyttIPb7J+XykHvJP2B9bZDjlhLIoEq4XoK64Vg7boZlVWYK6LUY94dYPEE7Lh0ZkZKcQ==";
      };
    };
    "is-buffer-1.1.6" = {
      name = "is-buffer";
      packageName = "is-buffer";
      version = "1.1.6";
      src = fetchurl {
        url = "https://registry.npmjs.org/is-buffer/-/is-buffer-1.1.6.tgz";
        sha512 = "NcdALwpXkTm5Zvvbk7owOUSvVvBKDgKP5/ewfXEznmQFfs4ZRmanOeKBTjRVjka3QFoN6XJ+9F3USqfHqTaU5w==";
      };
    };
    "is-data-descriptor-1.0.0" = {
      name = "is-data-descriptor";
      packageName = "is-data-descriptor";
      version = "1.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/is-data-descriptor/-/is-data-descriptor-1.0.0.tgz";
        sha512 = "jbRXy1FmtAoCjQkVmIVYwuuqDFUbaOeDjmed1tOGPrsMhtJA4rD9tkgA0F1qJ3gRFRXcHYVkdeaP50Q5rE/jLQ==";
      };
    };
    "is-descriptor-1.0.2" = {
      name = "is-descriptor";
      packageName = "is-descriptor";
      version = "1.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/is-descriptor/-/is-descriptor-1.0.2.tgz";
        sha512 = "2eis5WqQGV7peooDyLmNEPUrps9+SXX5c9pL3xEB+4e9HnGuDa7mB7kHxHw4CbqS9k1T2hOH3miL8n8WtiYVtg==";
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
    "is-lower-case-1.1.3" = {
      name = "is-lower-case";
      packageName = "is-lower-case";
      version = "1.1.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/is-lower-case/-/is-lower-case-1.1.3.tgz";
        sha1 = "7e147be4768dc466db3bfb21cc60b31e6ad69393";
      };
    };
    "is-number-3.0.0" = {
      name = "is-number";
      packageName = "is-number";
      version = "3.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/is-number/-/is-number-3.0.0.tgz";
        sha1 = "24fd6201a4782cf50561c810276afc7d12d71195";
      };
    };
    "is-path-cwd-1.0.0" = {
      name = "is-path-cwd";
      packageName = "is-path-cwd";
      version = "1.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/is-path-cwd/-/is-path-cwd-1.0.0.tgz";
        sha1 = "d225ec23132e89edd38fda767472e62e65f1106d";
      };
    };
    "is-path-in-cwd-1.0.1" = {
      name = "is-path-in-cwd";
      packageName = "is-path-in-cwd";
      version = "1.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/is-path-in-cwd/-/is-path-in-cwd-1.0.1.tgz";
        sha512 = "FjV1RTW48E7CWM7eE/J2NJvAEEVektecDBVBE5Hh3nM1Jd0kvhHtX68Pr3xsDf857xt3Y4AkwVULK1Vku62aaQ==";
      };
    };
    "is-path-inside-1.0.1" = {
      name = "is-path-inside";
      packageName = "is-path-inside";
      version = "1.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/is-path-inside/-/is-path-inside-1.0.1.tgz";
        sha1 = "8ef5b7de50437a3fdca6b4e865ef7aa55cb48036";
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
    "is-upper-case-1.1.2" = {
      name = "is-upper-case";
      packageName = "is-upper-case";
      version = "1.1.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/is-upper-case/-/is-upper-case-1.1.2.tgz";
        sha1 = "8d0b1fa7e7933a1e58483600ec7d9661cbaf756f";
      };
    };
    "kind-of-3.2.2" = {
      name = "kind-of";
      packageName = "kind-of";
      version = "3.2.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/kind-of/-/kind-of-3.2.2.tgz";
        sha1 = "31ea21a734bab9bbb0f32466d893aea51e4a3c64";
      };
    };
    "kind-of-6.0.2" = {
      name = "kind-of";
      packageName = "kind-of";
      version = "6.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/kind-of/-/kind-of-6.0.2.tgz";
        sha512 = "s5kLOcnH0XqDO+FvuaLX8DDjZ18CGFk7VygH40QoKPUQhW4e2rvM0rwUq0t8IQDOwYSeLK01U90OjzBTme2QqA==";
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
    "lower-case-1.1.4" = {
      name = "lower-case";
      packageName = "lower-case";
      version = "1.1.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/lower-case/-/lower-case-1.1.4.tgz";
        sha1 = "9a2cabd1b9e8e0ae993a4bf7d5875c39c42e8eac";
      };
    };
    "lower-case-first-1.0.2" = {
      name = "lower-case-first";
      packageName = "lower-case-first";
      version = "1.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/lower-case-first/-/lower-case-first-1.0.2.tgz";
        sha1 = "e5da7c26f29a7073be02d52bac9980e5922adfa1";
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
    "minimatch-3.0.4" = {
      name = "minimatch";
      packageName = "minimatch";
      version = "3.0.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/minimatch/-/minimatch-3.0.4.tgz";
        sha512 = "yJHVQEhyqPLUTgt9B83PXu6W3rx4MvvHvSUvToogpwoGDOUQ+yDrR0HRot+yOCdCO7u4hX3pWft6kWBBcqh0UA==";
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
    "no-case-2.3.2" = {
      name = "no-case";
      packageName = "no-case";
      version = "2.3.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/no-case/-/no-case-2.3.2.tgz";
        sha512 = "rmTZ9kz+f3rCvK2TD1Ue/oZlns7OGoIWP4fc3llxxRXlOkHKoWPPWJOfFYpITabSow43QJbRIoHQXtt10VldyQ==";
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
    "once-1.4.0" = {
      name = "once";
      packageName = "once";
      version = "1.4.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/once/-/once-1.4.0.tgz";
        sha1 = "583b1aa775961d4b113ac17d9c50baef9dd76bd1";
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
        url = "https://registry.npmjs.org/os-tmpdir/-/os-tmpdir-1.0.2.tgz";
        sha1 = "bbe67406c79aa85c5cfec766fe5734555dfa1274";
      };
    };
    "p-map-1.2.0" = {
      name = "p-map";
      packageName = "p-map";
      version = "1.2.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/p-map/-/p-map-1.2.0.tgz";
        sha512 = "r6zKACMNhjPJMTl8KcFH4li//gkrXWfbD6feV8l6doRHlzljFWGJ2AP6iKaCJXyZmAUMOPtvbW7EXkbWO/pLEA==";
      };
    };
    "param-case-2.1.1" = {
      name = "param-case";
      packageName = "param-case";
      version = "2.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/param-case/-/param-case-2.1.1.tgz";
        sha1 = "df94fd8cf6531ecf75e6bef9a0858fbc72be2247";
      };
    };
    "pascal-case-2.0.1" = {
      name = "pascal-case";
      packageName = "pascal-case";
      version = "2.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/pascal-case/-/pascal-case-2.0.1.tgz";
        sha1 = "2d578d3455f660da65eca18ef95b4e0de912761e";
      };
    };
    "path-case-2.1.1" = {
      name = "path-case";
      packageName = "path-case";
      version = "2.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/path-case/-/path-case-2.1.1.tgz";
        sha1 = "94b8037c372d3fe2906e465bb45e25d226e8eea5";
      };
    };
    "path-is-absolute-1.0.1" = {
      name = "path-is-absolute";
      packageName = "path-is-absolute";
      version = "1.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/path-is-absolute/-/path-is-absolute-1.0.1.tgz";
        sha1 = "174b9268735534ffbc7ace6bf53a5a9e1b5c5f5f";
      };
    };
    "path-is-inside-1.0.2" = {
      name = "path-is-inside";
      packageName = "path-is-inside";
      version = "1.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/path-is-inside/-/path-is-inside-1.0.2.tgz";
        sha1 = "365417dede44430d1c11af61027facf074bdfc53";
      };
    };
    "pify-2.3.0" = {
      name = "pify";
      packageName = "pify";
      version = "2.3.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/pify/-/pify-2.3.0.tgz";
        sha1 = "ed141a6ac043a849ea588498e7dca8b15330e90c";
      };
    };
    "pify-3.0.0" = {
      name = "pify";
      packageName = "pify";
      version = "3.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/pify/-/pify-3.0.0.tgz";
        sha1 = "e5a4acd2c101fdf3d9a4d07f0dbc4db49dd28176";
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
    "rimraf-2.6.2" = {
      name = "rimraf";
      packageName = "rimraf";
      version = "2.6.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/rimraf/-/rimraf-2.6.2.tgz";
        sha512 = "lreewLK/BlghmxtfH36YYVg1i8IAce4TI7oao75I1g245+6BctqTVQiBP3YUJ9C6DQOXJmkYR9X9fCLtCOJc5w==";
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
    "sentence-case-2.1.1" = {
      name = "sentence-case";
      packageName = "sentence-case";
      version = "2.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/sentence-case/-/sentence-case-2.1.1.tgz";
        sha1 = "1f6e2dda39c168bf92d13f86d4a918933f667ed4";
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
    "snake-case-2.1.0" = {
      name = "snake-case";
      packageName = "snake-case";
      version = "2.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/snake-case/-/snake-case-2.1.0.tgz";
        sha1 = "41bdb1b73f30ec66a04d4e2cad1b76387d4d6d9f";
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
    "supports-color-5.5.0" = {
      name = "supports-color";
      packageName = "supports-color";
      version = "5.5.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/supports-color/-/supports-color-5.5.0.tgz";
        sha512 = "QjVjwdXIt408MIiAqCX4oUKsgU2EqAGzs2Ppkm4aQYbjm+ZEWEcW4SfFNTr4uMNZma0ey4f5lgLrkB0aX0QMow==";
      };
    };
    "swap-case-1.1.2" = {
      name = "swap-case";
      packageName = "swap-case";
      version = "1.1.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/swap-case/-/swap-case-1.1.2.tgz";
        sha1 = "c39203a4587385fad3c850a0bd1bcafa081974e3";
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
    "title-case-2.1.1" = {
      name = "title-case";
      packageName = "title-case";
      version = "2.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/title-case/-/title-case-2.1.1.tgz";
        sha1 = "3e127216da58d2bc5becf137ab91dae3a7cd8faa";
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
    "upper-case-1.1.3" = {
      name = "upper-case";
      packageName = "upper-case";
      version = "1.1.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/upper-case/-/upper-case-1.1.3.tgz";
        sha1 = "f6b4501c2ec4cdd26ba78be7222961de77621598";
      };
    };
    "upper-case-first-1.1.2" = {
      name = "upper-case-first";
      packageName = "upper-case-first";
      version = "1.1.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/upper-case-first/-/upper-case-first-1.1.2.tgz";
        sha1 = "5d79bedcff14419518fd2edb0a0507c9b6859115";
      };
    };
    "window-size-1.1.1" = {
      name = "window-size";
      packageName = "window-size";
      version = "1.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/window-size/-/window-size-1.1.1.tgz";
        sha512 = "5D/9vujkmVQ7pSmc0SCBmHXbkv6eaHwXEx65MywhmUMsI8sGqJ972APq1lotfcwMKPFLuCFfL8xGHLIp7jaBmA==";
      };
    };
    "wrappy-1.0.2" = {
      name = "wrappy";
      packageName = "wrappy";
      version = "1.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/wrappy/-/wrappy-1.0.2.tgz";
        sha1 = "b5243d8f3ec1aa35f1364605bc0d1036e30ab69f";
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
      sources."core-js-2.5.7"
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
  };
  node-gyp-build = nodeEnv.buildNodePackage {
    name = "node-gyp-build";
    packageName = "node-gyp-build";
    version = "3.5.0";
    src = fetchurl {
      url = "https://registry.npmjs.org/node-gyp-build/-/node-gyp-build-3.5.0.tgz";
      sha512 = "qjEE8eIWVyqZhkAFUzytGpOGvLHeX5kXBB6MYyTOCPZBrBlsLyXAAzTsp/hWMbVlg8kVpzDJCZZowIrnKpwmqQ==";
    };
    buildInputs = globalBuildInputs;
    meta = {
      description = "Build tool and bindings loader for node-gyp that supports prebuilds";
      homepage = https://github.com/mafintosh/node-gyp-build;
      license = "MIT";
    };
    production = true;
    bypassCache = true;
  };
  cfonts = nodeEnv.buildNodePackage {
    name = "cfonts";
    packageName = "cfonts";
    version = "2.2.2";
    src = fetchurl {
      url = "https://registry.npmjs.org/cfonts/-/cfonts-2.2.2.tgz";
      sha512 = "CEyPlCSI9cMnksYeD7Rg1xEWoOjvP4JfRc2AeOzoQCB1rk/3Yuvn4+VMIRFH3IrKw/AT93WX/JLK/Ppcyk+gKw==";
    };
    dependencies = [
      sources."ansi-styles-3.2.1"
      sources."babel-runtime-6.26.0"
      sources."camel-case-3.0.0"
      sources."chalk-2.4.1"
      sources."change-case-3.0.2"
      sources."color-convert-1.9.3"
      sources."color-name-1.1.3"
      sources."constant-case-2.0.0"
      sources."core-js-2.5.7"
      sources."define-property-1.0.0"
      sources."dot-case-2.1.1"
      sources."escape-string-regexp-1.0.5"
      sources."has-flag-3.0.0"
      sources."header-case-1.0.1"
      sources."is-accessor-descriptor-1.0.0"
      sources."is-buffer-1.1.6"
      sources."is-data-descriptor-1.0.0"
      sources."is-descriptor-1.0.2"
      sources."is-lower-case-1.1.3"
      (sources."is-number-3.0.0" // {
        dependencies = [
          sources."kind-of-3.2.2"
        ];
      })
      sources."is-upper-case-1.1.2"
      sources."kind-of-6.0.2"
      sources."lower-case-1.1.4"
      sources."lower-case-first-1.0.2"
      sources."no-case-2.3.2"
      sources."param-case-2.1.1"
      sources."pascal-case-2.0.1"
      sources."path-case-2.1.1"
      sources."regenerator-runtime-0.11.1"
      sources."sentence-case-2.1.1"
      sources."snake-case-2.1.0"
      sources."supports-color-5.5.0"
      sources."swap-case-1.1.2"
      sources."title-case-2.1.1"
      sources."upper-case-1.1.3"
      sources."upper-case-first-1.1.2"
      sources."window-size-1.1.1"
    ];
    buildInputs = globalBuildInputs;
    meta = {
      description = "Sexy fonts for the console";
      homepage = https://github.com/dominikwilkowski/cfonts;
      license = "GNU-GPLv2";
    };
    production = true;
    bypassCache = true;
  };
  chalk = nodeEnv.buildNodePackage {
    name = "chalk";
    packageName = "chalk";
    version = "2.4.1";
    src = fetchurl {
      url = "https://registry.npmjs.org/chalk/-/chalk-2.4.1.tgz";
      sha512 = "ObN6h1v2fTJSmUXoS3nMQ92LbDK9be4TV+6G+omQlGJFdcUX5heKi1LZ1YnRMIgwTLEj3E24bT6tYni50rlCfQ==";
    };
    dependencies = [
      sources."ansi-styles-3.2.1"
      sources."color-convert-1.9.3"
      sources."color-name-1.1.3"
      sources."escape-string-regexp-1.0.5"
      sources."has-flag-3.0.0"
      sources."supports-color-5.5.0"
    ];
    buildInputs = globalBuildInputs;
    meta = {
      description = "Terminal string styling done right";
      homepage = "https://github.com/chalk/chalk#readme";
      license = "MIT";
    };
    production = true;
    bypassCache = true;
  };
  del = nodeEnv.buildNodePackage {
    name = "del";
    packageName = "del";
    version = "3.0.0";
    src = fetchurl {
      url = "https://registry.npmjs.org/del/-/del-3.0.0.tgz";
      sha1 = "53ecf699ffcbcb39637691ab13baf160819766e5";
    };
    dependencies = [
      sources."array-union-1.0.2"
      sources."array-uniq-1.0.3"
      sources."balanced-match-1.0.0"
      sources."brace-expansion-1.1.11"
      sources."concat-map-0.0.1"
      sources."fs.realpath-1.0.0"
      sources."glob-7.1.3"
      (sources."globby-6.1.0" // {
        dependencies = [
          sources."pify-2.3.0"
        ];
      })
      sources."inflight-1.0.6"
      sources."inherits-2.0.3"
      sources."is-path-cwd-1.0.0"
      sources."is-path-in-cwd-1.0.1"
      sources."is-path-inside-1.0.1"
      sources."minimatch-3.0.4"
      sources."object-assign-4.1.1"
      sources."once-1.4.0"
      sources."p-map-1.2.0"
      sources."path-is-absolute-1.0.1"
      sources."path-is-inside-1.0.2"
      sources."pify-3.0.0"
      sources."pinkie-2.0.4"
      sources."pinkie-promise-2.0.1"
      sources."rimraf-2.6.2"
      sources."wrappy-1.0.2"
    ];
    buildInputs = globalBuildInputs;
    meta = {
      description = "Delete files and folders";
      homepage = "https://github.com/sindresorhus/del#readme";
      license = "MIT";
    };
    production = true;
    bypassCache = true;
  };
}