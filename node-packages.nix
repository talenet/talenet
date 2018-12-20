{ nodeEnv
, fetchurl
, fetchgit
, globalBuildInputs ? []
, propagatedBuildInputs ? []
}:

# This file has been editied to include propogatedBuildInputs

let
  sources = {
    "@babel/code-frame-7.0.0-beta.44" = {
      name = "_at_babel_slash_code-frame";
      packageName = "@babel/code-frame";
      version = "7.0.0-beta.44";
      src = fetchurl {
        url = "http://registry.npmjs.org/@babel/code-frame/-/code-frame-7.0.0-beta.44.tgz";
        sha512 = "cuAuTTIQ9RqcFRJ/Y8PvTh+paepNcaGxwQwjIDRWPXmzzyAeCO4KqS9ikMvq0MCbRk6GlYKwfzStrcP3/jSL8g==";
      };
    };
    "@babel/generator-7.0.0-beta.44" = {
      name = "_at_babel_slash_generator";
      packageName = "@babel/generator";
      version = "7.0.0-beta.44";
      src = fetchurl {
        url = "http://registry.npmjs.org/@babel/generator/-/generator-7.0.0-beta.44.tgz";
        sha512 = "5xVb7hlhjGcdkKpMXgicAVgx8syK5VJz193k0i/0sLP6DzE6lRrU1K3B/rFefgdo9LPGMAOOOAWW4jycj07ShQ==";
      };
    };
    "@babel/helper-function-name-7.0.0-beta.44" = {
      name = "_at_babel_slash_helper-function-name";
      packageName = "@babel/helper-function-name";
      version = "7.0.0-beta.44";
      src = fetchurl {
        url = "http://registry.npmjs.org/@babel/helper-function-name/-/helper-function-name-7.0.0-beta.44.tgz";
        sha512 = "MHRG2qZMKMFaBavX0LWpfZ2e+hLloT++N7rfM3DYOMUOGCD8cVjqZpwiL8a0bOX3IYcQev1ruciT0gdFFRTxzg==";
      };
    };
    "@babel/helper-get-function-arity-7.0.0-beta.44" = {
      name = "_at_babel_slash_helper-get-function-arity";
      packageName = "@babel/helper-get-function-arity";
      version = "7.0.0-beta.44";
      src = fetchurl {
        url = "http://registry.npmjs.org/@babel/helper-get-function-arity/-/helper-get-function-arity-7.0.0-beta.44.tgz";
        sha512 = "w0YjWVwrM2HwP6/H3sEgrSQdkCaxppqFeJtAnB23pRiJB5E/O9Yp7JAAeWBl+gGEgmBFinnTyOv2RN7rcSmMiw==";
      };
    };
    "@babel/helper-split-export-declaration-7.0.0-beta.44" = {
      name = "_at_babel_slash_helper-split-export-declaration";
      packageName = "@babel/helper-split-export-declaration";
      version = "7.0.0-beta.44";
      src = fetchurl {
        url = "http://registry.npmjs.org/@babel/helper-split-export-declaration/-/helper-split-export-declaration-7.0.0-beta.44.tgz";
        sha512 = "aQ7QowtkgKKzPGf0j6u77kBMdUFVBKNHw2p/3HX/POt5/oz8ec5cs0GwlgM8Hz7ui5EwJnzyfRmkNF1Nx1N7aA==";
      };
    };
    "@babel/highlight-7.0.0-beta.44" = {
      name = "_at_babel_slash_highlight";
      packageName = "@babel/highlight";
      version = "7.0.0-beta.44";
      src = fetchurl {
        url = "http://registry.npmjs.org/@babel/highlight/-/highlight-7.0.0-beta.44.tgz";
        sha512 = "Il19yJvy7vMFm8AVAh6OZzaFoAd0hbkeMZiX3P5HGD+z7dyI7RzndHB0dg6Urh/VAFfHtpOIzDUSxmY6coyZWQ==";
      };
    };
    "@babel/template-7.0.0-beta.44" = {
      name = "_at_babel_slash_template";
      packageName = "@babel/template";
      version = "7.0.0-beta.44";
      src = fetchurl {
        url = "http://registry.npmjs.org/@babel/template/-/template-7.0.0-beta.44.tgz";
        sha512 = "w750Sloq0UNifLx1rUqwfbnC6uSUk0mfwwgGRfdLiaUzfAOiH0tHJE6ILQIUi3KYkjiCDTskoIsnfqZvWLBDng==";
      };
    };
    "@babel/traverse-7.0.0-beta.44" = {
      name = "_at_babel_slash_traverse";
      packageName = "@babel/traverse";
      version = "7.0.0-beta.44";
      src = fetchurl {
        url = "http://registry.npmjs.org/@babel/traverse/-/traverse-7.0.0-beta.44.tgz";
        sha512 = "UHuDz8ukQkJCDASKHf+oDt3FVUzFd+QYfuBIsiNu/4+/ix6pP/C+uQZJ6K1oEfbCMv/IKWbgDEh7fcsnIE5AtA==";
      };
    };
    "@babel/types-7.0.0-beta.44" = {
      name = "_at_babel_slash_types";
      packageName = "@babel/types";
      version = "7.0.0-beta.44";
      src = fetchurl {
        url = "http://registry.npmjs.org/@babel/types/-/types-7.0.0-beta.44.tgz";
        sha512 = "5eTV4WRmqbaFM3v9gHAIljEQJU4Ssc6fxL61JN+Oe2ga/BwyjzjamwkCVVAQjHGuAX8i0BWo42dshL8eO5KfLQ==";
      };
    };
    "abbrev-1.1.1" = {
      name = "abbrev";
      packageName = "abbrev";
      version = "1.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/abbrev/-/abbrev-1.1.1.tgz";
        sha512 = "nne9/IiQ/hzIhY6pdDnbBtz7DjPTKrY00P/zvPSm5pOFkl6xuGrGnXn/VtTNNfNtAfZ9/1RtehkszU9qcTii0Q==";
      };
    };
    "abstract-leveldown-0.12.4" = {
      name = "abstract-leveldown";
      packageName = "abstract-leveldown";
      version = "0.12.4";
      src = fetchurl {
        url = "http://registry.npmjs.org/abstract-leveldown/-/abstract-leveldown-0.12.4.tgz";
        sha1 = "29e18e632e60e4e221d5810247852a63d7b2e410";
      };
    };
    "abstract-leveldown-4.0.3" = {
      name = "abstract-leveldown";
      packageName = "abstract-leveldown";
      version = "4.0.3";
      src = fetchurl {
        url = "http://registry.npmjs.org/abstract-leveldown/-/abstract-leveldown-4.0.3.tgz";
        sha512 = "qsIHFQy0u17JqSY+3ZUT+ykqxYY17yOfvAsLkFkw8kSQqi05d1jyj0bCuSX6sjYlXuY9cKpgUt5EudQdP4aXyA==";
      };
    };
    "abstract-leveldown-5.0.0" = {
      name = "abstract-leveldown";
      packageName = "abstract-leveldown";
      version = "5.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/abstract-leveldown/-/abstract-leveldown-5.0.0.tgz";
        sha512 = "5mU5P1gXtsMIXg65/rsYGsi93+MlogXZ9FA8JnwKurHQg64bfXwGYVdVdijNTVNOlAsuIiOwHdvFFD5JqCJQ7A==";
      };
    };
    "accepts-1.3.5" = {
      name = "accepts";
      packageName = "accepts";
      version = "1.3.5";
      src = fetchurl {
        url = "https://registry.npmjs.org/accepts/-/accepts-1.3.5.tgz";
        sha1 = "eb777df6011723a3b14e8a72c0805c8e86746bd2";
      };
    };
    "acorn-4.0.13" = {
      name = "acorn";
      packageName = "acorn";
      version = "4.0.13";
      src = fetchurl {
        url = "https://registry.npmjs.org/acorn/-/acorn-4.0.13.tgz";
        sha1 = "105495ae5361d697bd195c825192e1ad7f253787";
      };
    };
    "acorn-5.7.3" = {
      name = "acorn";
      packageName = "acorn";
      version = "5.7.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/acorn/-/acorn-5.7.3.tgz";
        sha512 = "T/zvzYRfbVojPWahDsE5evJdHb3oJoQfFbsrKM7w5Zcs++Tr257tia3BmMP8XYVjp1S9RZXQMh7gao96BlqZOw==";
      };
    };
    "acorn-dynamic-import-2.0.2" = {
      name = "acorn-dynamic-import";
      packageName = "acorn-dynamic-import";
      version = "2.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/acorn-dynamic-import/-/acorn-dynamic-import-2.0.2.tgz";
        sha1 = "c752bd210bef679501b6c6cb7fc84f8f47158cc4";
      };
    };
    "adm-zip-0.4.13" = {
      name = "adm-zip";
      packageName = "adm-zip";
      version = "0.4.13";
      src = fetchurl {
        url = "https://registry.npmjs.org/adm-zip/-/adm-zip-0.4.13.tgz";
        sha512 = "fERNJX8sOXfel6qCBCMPvZLzENBEhZTzKqg6vrOW5pvoEaQuJhRU4ndTAh6lHOxn1I6jnz2NHra56ZODM751uw==";
      };
    };
    "agent-base-2.1.1" = {
      name = "agent-base";
      packageName = "agent-base";
      version = "2.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/agent-base/-/agent-base-2.1.1.tgz";
        sha1 = "d6de10d5af6132d5bd692427d46fc538539094c7";
      };
    };
    "ajv-5.5.2" = {
      name = "ajv";
      packageName = "ajv";
      version = "5.5.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/ajv/-/ajv-5.5.2.tgz";
        sha1 = "73b5eeca3fab653e3d3f9422b341ad42205dc965";
      };
    };
    "ajv-6.6.2" = {
      name = "ajv";
      packageName = "ajv";
      version = "6.6.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/ajv/-/ajv-6.6.2.tgz";
        sha512 = "FBHEW6Jf5TB9MGBgUUA9XHkTbjXYfAUjY43ACMfmdMRHniyoMHjHjzD50OK8LGDWQwp4rWEsIq5kEqq7rvIM1g==";
      };
    };
    "ajv-keywords-3.2.0" = {
      name = "ajv-keywords";
      packageName = "ajv-keywords";
      version = "3.2.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/ajv-keywords/-/ajv-keywords-3.2.0.tgz";
        sha1 = "e86b819c602cf8821ad637413698f1dec021847a";
      };
    };
    "align-text-0.1.4" = {
      name = "align-text";
      packageName = "align-text";
      version = "0.1.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/align-text/-/align-text-0.1.4.tgz";
        sha1 = "0cd90a561093f35d0a99256c22b7069433fad117";
      };
    };
    "aligned-block-file-1.1.4" = {
      name = "aligned-block-file";
      packageName = "aligned-block-file";
      version = "1.1.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/aligned-block-file/-/aligned-block-file-1.1.4.tgz";
        sha512 = "KE27h781ueGONLqSBY2ik6LJRr9vo0L/i3GGhtQgJfCk0MO2QNSgrXZVCk2t7UeZKYTxcTfl+yBgcZWqBiAGPQ==";
      };
    };
    "alphanum-sort-1.0.2" = {
      name = "alphanum-sort";
      packageName = "alphanum-sort";
      version = "1.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/alphanum-sort/-/alphanum-sort-1.0.2.tgz";
        sha1 = "97a1119649b211ad33691d9f9f486a8ec9fbe0a3";
      };
    };
    "amdefine-1.0.1" = {
      name = "amdefine";
      packageName = "amdefine";
      version = "1.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/amdefine/-/amdefine-1.0.1.tgz";
        sha1 = "4a5282ac164729e93619bcfd3ad151f817ce91f5";
      };
    };
    "ansi-escapes-1.4.0" = {
      name = "ansi-escapes";
      packageName = "ansi-escapes";
      version = "1.4.0";
      src = fetchurl {
        url = "http://registry.npmjs.org/ansi-escapes/-/ansi-escapes-1.4.0.tgz";
        sha1 = "d3a8a83b319aa67793662b13e761c7911422306e";
      };
    };
    "ansi-escapes-3.1.0" = {
      name = "ansi-escapes";
      packageName = "ansi-escapes";
      version = "3.1.0";
      src = fetchurl {
        url = "http://registry.npmjs.org/ansi-escapes/-/ansi-escapes-3.1.0.tgz";
        sha512 = "UgAb8H9D41AQnu/PbWlCofQVcnV4Gs2bBJi9eZPxfU/hgglFh3SMDMENRIqdr7H6XFnXdoknctFByVsCOotTVw==";
      };
    };
    "ansi-html-0.0.7" = {
      name = "ansi-html";
      packageName = "ansi-html";
      version = "0.0.7";
      src = fetchurl {
        url = "https://registry.npmjs.org/ansi-html/-/ansi-html-0.0.7.tgz";
        sha1 = "813584021962a9e9e6fd039f940d12f56ca7859e";
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
    "anymatch-1.3.2" = {
      name = "anymatch";
      packageName = "anymatch";
      version = "1.3.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/anymatch/-/anymatch-1.3.2.tgz";
        sha512 = "0XNayC8lTHQ2OI8aljNCN3sSx6hsr/1+rlcDAotXJR7C1oZZHCNsfpbKwMjRA3Uqb5tF1Rae2oloTr4xpq+WjA==";
      };
    };
    "anymatch-2.0.0" = {
      name = "anymatch";
      packageName = "anymatch";
      version = "2.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/anymatch/-/anymatch-2.0.0.tgz";
        sha512 = "5teOsQWABXHHBFP9y3skS5P3d/WfWXpv3FUpy+LorMrNYaT9pI4oLMQX7jzQ2KklNpGpWHzdCXTDT2Y3XGlZBw==";
      };
    };
    "append-batch-0.0.1" = {
      name = "append-batch";
      packageName = "append-batch";
      version = "0.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/append-batch/-/append-batch-0.0.1.tgz";
        sha1 = "9224858e556997ccc07f11f1ee9a128532aa0d25";
      };
    };
    "aproba-1.2.0" = {
      name = "aproba";
      packageName = "aproba";
      version = "1.2.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/aproba/-/aproba-1.2.0.tgz";
        sha512 = "Y9J6ZjXtoYh8RnXVCMOU/ttDmk1aBjunq9vO0ta5x85WDQiQfUF9sIPBITdbiiIVcBo03Hi3jMxigBtsddlXRw==";
      };
    };
    "archiver-2.1.1" = {
      name = "archiver";
      packageName = "archiver";
      version = "2.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/archiver/-/archiver-2.1.1.tgz";
        sha1 = "ff662b4a78201494a3ee544d3a33fe7496509ebc";
      };
    };
    "archiver-utils-1.3.0" = {
      name = "archiver-utils";
      packageName = "archiver-utils";
      version = "1.3.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/archiver-utils/-/archiver-utils-1.3.0.tgz";
        sha1 = "e50b4c09c70bf3d680e32ff1b7994e9f9d895174";
      };
    };
    "are-we-there-yet-1.1.5" = {
      name = "are-we-there-yet";
      packageName = "are-we-there-yet";
      version = "1.1.5";
      src = fetchurl {
        url = "https://registry.npmjs.org/are-we-there-yet/-/are-we-there-yet-1.1.5.tgz";
        sha512 = "5hYdAkZlcG8tOLujVDTgCT+uPX0VnpAH28gWsLfzpXYm7wP6mp5Q/gYyR7YQ0cKVJcXJnl3j2kpBan13PtQf6w==";
      };
    };
    "argparse-1.0.10" = {
      name = "argparse";
      packageName = "argparse";
      version = "1.0.10";
      src = fetchurl {
        url = "https://registry.npmjs.org/argparse/-/argparse-1.0.10.tgz";
        sha512 = "o5Roy6tNG4SL/FOkCAN6RzjiakZS25RLYFrcMttJqbdd8BWrnA+fGz57iN5Pb06pvBGvl5gQ0B48dJlslXvoTg==";
      };
    };
    "arr-diff-2.0.0" = {
      name = "arr-diff";
      packageName = "arr-diff";
      version = "2.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/arr-diff/-/arr-diff-2.0.0.tgz";
        sha1 = "8f3b827f955a8bd669697e4a4256ac3ceae356cf";
      };
    };
    "arr-diff-4.0.0" = {
      name = "arr-diff";
      packageName = "arr-diff";
      version = "4.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/arr-diff/-/arr-diff-4.0.0.tgz";
        sha1 = "d6461074febfec71e7e15235761a329a5dc7c520";
      };
    };
    "arr-flatten-1.1.0" = {
      name = "arr-flatten";
      packageName = "arr-flatten";
      version = "1.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/arr-flatten/-/arr-flatten-1.1.0.tgz";
        sha512 = "L3hKV5R/p5o81R7O02IGnwpDmkp6E982XhtbuwSe3O4qOtMMMtodicASA1Cny2U+aCXcNpml+m4dPsvsJ3jatg==";
      };
    };
    "arr-union-3.1.0" = {
      name = "arr-union";
      packageName = "arr-union";
      version = "3.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/arr-union/-/arr-union-3.1.0.tgz";
        sha1 = "e39b09aea9def866a8f206e288af63919bae39c4";
      };
    };
    "array-find-index-1.0.2" = {
      name = "array-find-index";
      packageName = "array-find-index";
      version = "1.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/array-find-index/-/array-find-index-1.0.2.tgz";
        sha1 = "df010aa1287e164bbda6f9723b0a96a1ec4187a1";
      };
    };
    "array-flatten-1.1.1" = {
      name = "array-flatten";
      packageName = "array-flatten";
      version = "1.1.1";
      src = fetchurl {
        url = "http://registry.npmjs.org/array-flatten/-/array-flatten-1.1.1.tgz";
        sha1 = "9a5f699051b1e7073328f2a008968b64ea2955d2";
      };
    };
    "array-flatten-2.1.2" = {
      name = "array-flatten";
      packageName = "array-flatten";
      version = "2.1.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/array-flatten/-/array-flatten-2.1.2.tgz";
        sha512 = "hNfzcOV8W4NdualtqBFPyVO+54DSJuZGY9qT4pRroB6S9e3iiido2ISIC5h9R2sPJ8H3FHCIiEnsv1lPXO3KtQ==";
      };
    };
    "array-includes-3.0.3" = {
      name = "array-includes";
      packageName = "array-includes";
      version = "3.0.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/array-includes/-/array-includes-3.0.3.tgz";
        sha1 = "184b48f62d92d7452bb31b323165c7f8bd02266d";
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
    "array-unique-0.2.1" = {
      name = "array-unique";
      packageName = "array-unique";
      version = "0.2.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/array-unique/-/array-unique-0.2.1.tgz";
        sha1 = "a1d97ccafcbc2625cc70fadceb36a50c58b01a53";
      };
    };
    "array-unique-0.3.2" = {
      name = "array-unique";
      packageName = "array-unique";
      version = "0.3.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/array-unique/-/array-unique-0.3.2.tgz";
        sha1 = "a894b75d4bc4f6cd679ef3244a9fd8f46ae2d428";
      };
    };
    "arrify-1.0.1" = {
      name = "arrify";
      packageName = "arrify";
      version = "1.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/arrify/-/arrify-1.0.1.tgz";
        sha1 = "898508da2226f380df904728456849c1501a4b0d";
      };
    };
    "asn1-0.2.4" = {
      name = "asn1";
      packageName = "asn1";
      version = "0.2.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/asn1/-/asn1-0.2.4.tgz";
        sha512 = "jxwzQpLQjSmWXgwaCZE9Nz+glAG01yF1QnWgbhGwHI5A6FRIEY6IVqtHhIepHqI7/kyEyQEagBC5mBEFlIYvdg==";
      };
    };
    "asn1.js-4.10.1" = {
      name = "asn1.js";
      packageName = "asn1.js";
      version = "4.10.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/asn1.js/-/asn1.js-4.10.1.tgz";
        sha512 = "p32cOF5q0Zqs9uBiONKYLm6BClCoBCM5O9JfeUSlnQLBTxYdTK+pW+nXflm8UkKd2UYlEbYz5qEi0JuZR9ckSw==";
      };
    };
    "assert-1.4.1" = {
      name = "assert";
      packageName = "assert";
      version = "1.4.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/assert/-/assert-1.4.1.tgz";
        sha1 = "99912d591836b5a6f5b345c0f07eefc08fc65d91";
      };
    };
    "assert-plus-1.0.0" = {
      name = "assert-plus";
      packageName = "assert-plus";
      version = "1.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/assert-plus/-/assert-plus-1.0.0.tgz";
        sha1 = "f12e0f3c5d77b0b1cdd9146942e4e96c1e4dd525";
      };
    };
    "assertion-error-1.0.0" = {
      name = "assertion-error";
      packageName = "assertion-error";
      version = "1.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/assertion-error/-/assertion-error-1.0.0.tgz";
        sha1 = "c7f85438fdd466bc7ca16ab90c81513797a5d23b";
      };
    };
    "assertion-error-1.1.0" = {
      name = "assertion-error";
      packageName = "assertion-error";
      version = "1.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/assertion-error/-/assertion-error-1.1.0.tgz";
        sha512 = "jgsaNduz+ndvGyFt3uSuWqvy4lCnIJiovtouQN5JZHOKCS2QuhEdbcQHFhVksz2N2U9hXJo8odG7ETyWlEeuDw==";
      };
    };
    "assign-symbols-1.0.0" = {
      name = "assign-symbols";
      packageName = "assign-symbols";
      version = "1.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/assign-symbols/-/assign-symbols-1.0.0.tgz";
        sha1 = "59667f41fadd4f20ccbc2bb96b8d4f7f78ec0367";
      };
    };
    "ast-types-0.11.7" = {
      name = "ast-types";
      packageName = "ast-types";
      version = "0.11.7";
      src = fetchurl {
        url = "https://registry.npmjs.org/ast-types/-/ast-types-0.11.7.tgz";
        sha512 = "2mP3TwtkY/aTv5X3ZsMpNAbOnyoC/aMJwJSoaELPkHId0nSQgFcnU4dRW3isxiz7+zBexk0ym3WNVjMiQBnJSw==";
      };
    };
    "async-0.9.2" = {
      name = "async";
      packageName = "async";
      version = "0.9.2";
      src = fetchurl {
        url = "http://registry.npmjs.org/async/-/async-0.9.2.tgz";
        sha1 = "aea74d5e61c1f899613bf64bda66d4c78f2fd17d";
      };
    };
    "async-1.0.0" = {
      name = "async";
      packageName = "async";
      version = "1.0.0";
      src = fetchurl {
        url = "http://registry.npmjs.org/async/-/async-1.0.0.tgz";
        sha1 = "f8fc04ca3a13784ade9e1641af98578cfbd647a9";
      };
    };
    "async-1.5.2" = {
      name = "async";
      packageName = "async";
      version = "1.5.2";
      src = fetchurl {
        url = "http://registry.npmjs.org/async/-/async-1.5.2.tgz";
        sha1 = "ec6a61ae56480c0c3cb241c95618e20892f9672a";
      };
    };
    "async-2.6.1" = {
      name = "async";
      packageName = "async";
      version = "2.6.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/async/-/async-2.6.1.tgz";
        sha512 = "fNEiL2+AZt6AlAw/29Cr0UDe4sRAHCpEHh54WMz+Bb7QfNcFw4h3loofyJpLeQs4Yx7yuqu/2dLgM5hKOs6HlQ==";
      };
    };
    "async-each-1.0.1" = {
      name = "async-each";
      packageName = "async-each";
      version = "1.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/async-each/-/async-each-1.0.1.tgz";
        sha1 = "19d386a1d9edc6e7c1c85d388aedbcc56d33602d";
      };
    };
    "async-foreach-0.1.3" = {
      name = "async-foreach";
      packageName = "async-foreach";
      version = "0.1.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/async-foreach/-/async-foreach-0.1.3.tgz";
        sha1 = "36121f845c0578172de419a97dbeb1d16ec34542";
      };
    };
    "async-single-1.0.5" = {
      name = "async-single";
      packageName = "async-single";
      version = "1.0.5";
      src = fetchurl {
        url = "https://registry.npmjs.org/async-single/-/async-single-1.0.5.tgz";
        sha1 = "125dd09de95d3ea30a378adbed021092179b03c9";
      };
    };
    "async-write-2.1.0" = {
      name = "async-write";
      packageName = "async-write";
      version = "2.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/async-write/-/async-write-2.1.0.tgz";
        sha1 = "1e762817d849ce44bfac07925a42036787061b15";
      };
    };
    "asynckit-0.4.0" = {
      name = "asynckit";
      packageName = "asynckit";
      version = "0.4.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/asynckit/-/asynckit-0.4.0.tgz";
        sha1 = "c79ed97f7f34cb8f2ba1bc9790bcc366474b4b79";
      };
    };
    "atob-2.1.2" = {
      name = "atob";
      packageName = "atob";
      version = "2.1.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/atob/-/atob-2.1.2.tgz";
        sha512 = "Wm6ukoaOGJi/73p/cl2GvLjTI5JM1k/O14isD73YML8StrH/7/lRFgmg8nICZgD3bZZvjwCGxtMOD3wWNAu8cg==";
      };
    };
    "atomic-file-1.1.5" = {
      name = "atomic-file";
      packageName = "atomic-file";
      version = "1.1.5";
      src = fetchurl {
        url = "https://registry.npmjs.org/atomic-file/-/atomic-file-1.1.5.tgz";
        sha512 = "TG+5YFiaKQ6CZiSQsosGMJ/IJzwMZ4V/rSdEXlD6+DwKyv8OyeUcprq34kp4yuS6bfQYXhxBC2Vm8PWo+iKBGQ==";
      };
    };
    "attach-ware-1.1.1" = {
      name = "attach-ware";
      packageName = "attach-ware";
      version = "1.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/attach-ware/-/attach-ware-1.1.1.tgz";
        sha1 = "28f51393dd8bb8bdaad972342519bf09621a35a3";
      };
    };
    "autoprefixer-6.7.7" = {
      name = "autoprefixer";
      packageName = "autoprefixer";
      version = "6.7.7";
      src = fetchurl {
        url = "https://registry.npmjs.org/autoprefixer/-/autoprefixer-6.7.7.tgz";
        sha1 = "1dbd1c835658e35ce3f9984099db00585c782014";
      };
    };
    "autoprefixer-8.6.5" = {
      name = "autoprefixer";
      packageName = "autoprefixer";
      version = "8.6.5";
      src = fetchurl {
        url = "https://registry.npmjs.org/autoprefixer/-/autoprefixer-8.6.5.tgz";
        sha512 = "PLWJN3Xo/rycNkx+mp8iBDMTm3FeWe4VmYaZDSqL5QQB9sLsQkG5k8n+LNDFnhh9kdq2K+egL/icpctOmDHwig==";
      };
    };
    "avoriaz-6.3.0" = {
      name = "avoriaz";
      packageName = "avoriaz";
      version = "6.3.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/avoriaz/-/avoriaz-6.3.0.tgz";
        sha512 = "NjqjZ7hj5DZx5tQ1aZ6Fot9F1kQCNHdNQcdnaKR1CbRwPR2k4ntQrp06Wc9ScfB6EGl+NDEk0Lh1WTZ8Me/9Zw==";
      };
    };
    "aws-sign2-0.7.0" = {
      name = "aws-sign2";
      packageName = "aws-sign2";
      version = "0.7.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/aws-sign2/-/aws-sign2-0.7.0.tgz";
        sha1 = "b46e890934a9591f2d2f6f86d7e6a9f1b3fe76a8";
      };
    };
    "aws4-1.8.0" = {
      name = "aws4";
      packageName = "aws4";
      version = "1.8.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/aws4/-/aws4-1.8.0.tgz";
        sha512 = "ReZxvNHIOv88FlT7rxcXIIC0fPt4KZqZbOlivyWtXLt8ESx84zd3kMC6iK5jVeS2qt+g7ftS7ye4fi06X5rtRQ==";
      };
    };
    "babel-code-frame-6.26.0" = {
      name = "babel-code-frame";
      packageName = "babel-code-frame";
      version = "6.26.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/babel-code-frame/-/babel-code-frame-6.26.0.tgz";
        sha1 = "63fd43f7dc1e3bb7ce35947db8fe369a3f58c74b";
      };
    };
    "babel-core-6.26.3" = {
      name = "babel-core";
      packageName = "babel-core";
      version = "6.26.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/babel-core/-/babel-core-6.26.3.tgz";
        sha512 = "6jyFLuDmeidKmUEb3NM+/yawG0M2bDZ9Z1qbZP59cyHLz8kYGKYwpJP0UwUKKUiTRNvxfLesJnTedqczP7cTDA==";
      };
    };
    "babel-eslint-8.2.6" = {
      name = "babel-eslint";
      packageName = "babel-eslint";
      version = "8.2.6";
      src = fetchurl {
        url = "https://registry.npmjs.org/babel-eslint/-/babel-eslint-8.2.6.tgz";
        sha512 = "aCdHjhzcILdP8c9lej7hvXKvQieyRt20SF102SIGyY4cUIiw6UaAtK4j2o3dXX74jEmy0TJ0CEhv4fTIM3SzcA==";
      };
    };
    "babel-generator-6.26.1" = {
      name = "babel-generator";
      packageName = "babel-generator";
      version = "6.26.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/babel-generator/-/babel-generator-6.26.1.tgz";
        sha512 = "HyfwY6ApZj7BYTcJURpM5tznulaBvyio7/0d4zFOeMPUmfxkCjHocCuoLa2SAGzBI8AREcH3eP3758F672DppA==";
      };
    };
    "babel-helper-bindify-decorators-6.24.1" = {
      name = "babel-helper-bindify-decorators";
      packageName = "babel-helper-bindify-decorators";
      version = "6.24.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/babel-helper-bindify-decorators/-/babel-helper-bindify-decorators-6.24.1.tgz";
        sha1 = "14c19e5f142d7b47f19a52431e52b1ccbc40a330";
      };
    };
    "babel-helper-builder-binary-assignment-operator-visitor-6.24.1" = {
      name = "babel-helper-builder-binary-assignment-operator-visitor";
      packageName = "babel-helper-builder-binary-assignment-operator-visitor";
      version = "6.24.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/babel-helper-builder-binary-assignment-operator-visitor/-/babel-helper-builder-binary-assignment-operator-visitor-6.24.1.tgz";
        sha1 = "cce4517ada356f4220bcae8a02c2b346f9a56664";
      };
    };
    "babel-helper-call-delegate-6.24.1" = {
      name = "babel-helper-call-delegate";
      packageName = "babel-helper-call-delegate";
      version = "6.24.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/babel-helper-call-delegate/-/babel-helper-call-delegate-6.24.1.tgz";
        sha1 = "ece6aacddc76e41c3461f88bfc575bd0daa2df8d";
      };
    };
    "babel-helper-define-map-6.26.0" = {
      name = "babel-helper-define-map";
      packageName = "babel-helper-define-map";
      version = "6.26.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/babel-helper-define-map/-/babel-helper-define-map-6.26.0.tgz";
        sha1 = "a5f56dab41a25f97ecb498c7ebaca9819f95be5f";
      };
    };
    "babel-helper-evaluate-path-0.1.0" = {
      name = "babel-helper-evaluate-path";
      packageName = "babel-helper-evaluate-path";
      version = "0.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/babel-helper-evaluate-path/-/babel-helper-evaluate-path-0.1.0.tgz";
        sha1 = "95d98c4ea36150483db2e7d3ec9e1954a72629cb";
      };
    };
    "babel-helper-explode-assignable-expression-6.24.1" = {
      name = "babel-helper-explode-assignable-expression";
      packageName = "babel-helper-explode-assignable-expression";
      version = "6.24.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/babel-helper-explode-assignable-expression/-/babel-helper-explode-assignable-expression-6.24.1.tgz";
        sha1 = "f25b82cf7dc10433c55f70592d5746400ac22caa";
      };
    };
    "babel-helper-explode-class-6.24.1" = {
      name = "babel-helper-explode-class";
      packageName = "babel-helper-explode-class";
      version = "6.24.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/babel-helper-explode-class/-/babel-helper-explode-class-6.24.1.tgz";
        sha1 = "7dc2a3910dee007056e1e31d640ced3d54eaa9eb";
      };
    };
    "babel-helper-flip-expressions-0.1.2" = {
      name = "babel-helper-flip-expressions";
      packageName = "babel-helper-flip-expressions";
      version = "0.1.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/babel-helper-flip-expressions/-/babel-helper-flip-expressions-0.1.2.tgz";
        sha1 = "77f6652f9de9c42401d827bd46ebd2109e3ef18a";
      };
    };
    "babel-helper-function-name-6.24.1" = {
      name = "babel-helper-function-name";
      packageName = "babel-helper-function-name";
      version = "6.24.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/babel-helper-function-name/-/babel-helper-function-name-6.24.1.tgz";
        sha1 = "d3475b8c03ed98242a25b48351ab18399d3580a9";
      };
    };
    "babel-helper-get-function-arity-6.24.1" = {
      name = "babel-helper-get-function-arity";
      packageName = "babel-helper-get-function-arity";
      version = "6.24.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/babel-helper-get-function-arity/-/babel-helper-get-function-arity-6.24.1.tgz";
        sha1 = "8f7782aa93407c41d3aa50908f89b031b1b6853d";
      };
    };
    "babel-helper-hoist-variables-6.24.1" = {
      name = "babel-helper-hoist-variables";
      packageName = "babel-helper-hoist-variables";
      version = "6.24.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/babel-helper-hoist-variables/-/babel-helper-hoist-variables-6.24.1.tgz";
        sha1 = "1ecb27689c9d25513eadbc9914a73f5408be7a76";
      };
    };
    "babel-helper-is-nodes-equiv-0.0.1" = {
      name = "babel-helper-is-nodes-equiv";
      packageName = "babel-helper-is-nodes-equiv";
      version = "0.0.1";
      src = fetchurl {
        url = "http://registry.npmjs.org/babel-helper-is-nodes-equiv/-/babel-helper-is-nodes-equiv-0.0.1.tgz";
        sha1 = "34e9b300b1479ddd98ec77ea0bbe9342dfe39684";
      };
    };
    "babel-helper-is-void-0-0.1.1" = {
      name = "babel-helper-is-void-0";
      packageName = "babel-helper-is-void-0";
      version = "0.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/babel-helper-is-void-0/-/babel-helper-is-void-0-0.1.1.tgz";
        sha1 = "72f21a3abba0bef3837f9174fca731aed9a02888";
      };
    };
    "babel-helper-mark-eval-scopes-0.1.1" = {
      name = "babel-helper-mark-eval-scopes";
      packageName = "babel-helper-mark-eval-scopes";
      version = "0.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/babel-helper-mark-eval-scopes/-/babel-helper-mark-eval-scopes-0.1.1.tgz";
        sha1 = "4554345edf9f2549427bd2098e530253f8af2992";
      };
    };
    "babel-helper-optimise-call-expression-6.24.1" = {
      name = "babel-helper-optimise-call-expression";
      packageName = "babel-helper-optimise-call-expression";
      version = "6.24.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/babel-helper-optimise-call-expression/-/babel-helper-optimise-call-expression-6.24.1.tgz";
        sha1 = "f7a13427ba9f73f8f4fa993c54a97882d1244257";
      };
    };
    "babel-helper-regex-6.26.0" = {
      name = "babel-helper-regex";
      packageName = "babel-helper-regex";
      version = "6.26.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/babel-helper-regex/-/babel-helper-regex-6.26.0.tgz";
        sha1 = "325c59f902f82f24b74faceed0363954f6495e72";
      };
    };
    "babel-helper-remap-async-to-generator-6.24.1" = {
      name = "babel-helper-remap-async-to-generator";
      packageName = "babel-helper-remap-async-to-generator";
      version = "6.24.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/babel-helper-remap-async-to-generator/-/babel-helper-remap-async-to-generator-6.24.1.tgz";
        sha1 = "5ec581827ad723fecdd381f1c928390676e4551b";
      };
    };
    "babel-helper-remove-or-void-0.1.1" = {
      name = "babel-helper-remove-or-void";
      packageName = "babel-helper-remove-or-void";
      version = "0.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/babel-helper-remove-or-void/-/babel-helper-remove-or-void-0.1.1.tgz";
        sha1 = "9d7e1856dc6fafcb41b283a416730dc1844f66d7";
      };
    };
    "babel-helper-replace-supers-6.24.1" = {
      name = "babel-helper-replace-supers";
      packageName = "babel-helper-replace-supers";
      version = "6.24.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/babel-helper-replace-supers/-/babel-helper-replace-supers-6.24.1.tgz";
        sha1 = "bf6dbfe43938d17369a213ca8a8bf74b6a90ab1a";
      };
    };
    "babel-helper-to-multiple-sequence-expressions-0.1.1" = {
      name = "babel-helper-to-multiple-sequence-expressions";
      packageName = "babel-helper-to-multiple-sequence-expressions";
      version = "0.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/babel-helper-to-multiple-sequence-expressions/-/babel-helper-to-multiple-sequence-expressions-0.1.1.tgz";
        sha1 = "5f1b832b39e4acf954e9137f0251395c71196b35";
      };
    };
    "babel-helpers-6.24.1" = {
      name = "babel-helpers";
      packageName = "babel-helpers";
      version = "6.24.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/babel-helpers/-/babel-helpers-6.24.1.tgz";
        sha1 = "3471de9caec388e5c850e597e58a26ddf37602b2";
      };
    };
    "babel-loader-7.1.5" = {
      name = "babel-loader";
      packageName = "babel-loader";
      version = "7.1.5";
      src = fetchurl {
        url = "https://registry.npmjs.org/babel-loader/-/babel-loader-7.1.5.tgz";
        sha512 = "iCHfbieL5d1LfOQeeVJEUyD9rTwBcP/fcEbRCfempxTDuqrKpu0AZjLAQHEQa3Yqyj9ORKe2iHfoj4rHLf7xpw==";
      };
    };
    "babel-messages-6.23.0" = {
      name = "babel-messages";
      packageName = "babel-messages";
      version = "6.23.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/babel-messages/-/babel-messages-6.23.0.tgz";
        sha1 = "f3cdf4703858035b2a2951c6ec5edf6c62f2630e";
      };
    };
    "babel-plugin-check-es2015-constants-6.22.0" = {
      name = "babel-plugin-check-es2015-constants";
      packageName = "babel-plugin-check-es2015-constants";
      version = "6.22.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/babel-plugin-check-es2015-constants/-/babel-plugin-check-es2015-constants-6.22.0.tgz";
        sha1 = "35157b101426fd2ffd3da3f75c7d1e91835bbf8a";
      };
    };
    "babel-plugin-istanbul-4.1.6" = {
      name = "babel-plugin-istanbul";
      packageName = "babel-plugin-istanbul";
      version = "4.1.6";
      src = fetchurl {
        url = "http://registry.npmjs.org/babel-plugin-istanbul/-/babel-plugin-istanbul-4.1.6.tgz";
        sha512 = "PWP9FQ1AhZhS01T/4qLSKoHGY/xvkZdVBGlKM/HuxxS3+sC66HhTNR7+MpbO/so/cz/wY94MeSWJuP1hXIPfwQ==";
      };
    };
    "babel-plugin-minify-builtins-0.1.3" = {
      name = "babel-plugin-minify-builtins";
      packageName = "babel-plugin-minify-builtins";
      version = "0.1.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/babel-plugin-minify-builtins/-/babel-plugin-minify-builtins-0.1.3.tgz";
        sha1 = "4f21a7dcb51f91a04ea71d47ff0e8e3b05fec021";
      };
    };
    "babel-plugin-minify-constant-folding-0.1.3" = {
      name = "babel-plugin-minify-constant-folding";
      packageName = "babel-plugin-minify-constant-folding";
      version = "0.1.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/babel-plugin-minify-constant-folding/-/babel-plugin-minify-constant-folding-0.1.3.tgz";
        sha1 = "57bd172adf8b8d74ad7c99612eb950414ebea3ca";
      };
    };
    "babel-plugin-minify-dead-code-elimination-0.1.7" = {
      name = "babel-plugin-minify-dead-code-elimination";
      packageName = "babel-plugin-minify-dead-code-elimination";
      version = "0.1.7";
      src = fetchurl {
        url = "https://registry.npmjs.org/babel-plugin-minify-dead-code-elimination/-/babel-plugin-minify-dead-code-elimination-0.1.7.tgz";
        sha1 = "774f536f347b98393a27baa717872968813c342c";
      };
    };
    "babel-plugin-minify-flip-comparisons-0.1.2" = {
      name = "babel-plugin-minify-flip-comparisons";
      packageName = "babel-plugin-minify-flip-comparisons";
      version = "0.1.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/babel-plugin-minify-flip-comparisons/-/babel-plugin-minify-flip-comparisons-0.1.2.tgz";
        sha1 = "e286b40b7599b18dfea195071e4279465cfc1884";
      };
    };
    "babel-plugin-minify-guarded-expressions-0.1.2" = {
      name = "babel-plugin-minify-guarded-expressions";
      packageName = "babel-plugin-minify-guarded-expressions";
      version = "0.1.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/babel-plugin-minify-guarded-expressions/-/babel-plugin-minify-guarded-expressions-0.1.2.tgz";
        sha1 = "dfc3d473b0362d9605d3ce0ac1e22328c60d1007";
      };
    };
    "babel-plugin-minify-infinity-0.1.2" = {
      name = "babel-plugin-minify-infinity";
      packageName = "babel-plugin-minify-infinity";
      version = "0.1.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/babel-plugin-minify-infinity/-/babel-plugin-minify-infinity-0.1.2.tgz";
        sha1 = "5f1cf67ddedcba13c8a00da832542df0091a1cd4";
      };
    };
    "babel-plugin-minify-mangle-names-0.1.3" = {
      name = "babel-plugin-minify-mangle-names";
      packageName = "babel-plugin-minify-mangle-names";
      version = "0.1.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/babel-plugin-minify-mangle-names/-/babel-plugin-minify-mangle-names-0.1.3.tgz";
        sha1 = "bfa24661a6794fb03833587e55828b65449e06fe";
      };
    };
    "babel-plugin-minify-numeric-literals-0.1.1" = {
      name = "babel-plugin-minify-numeric-literals";
      packageName = "babel-plugin-minify-numeric-literals";
      version = "0.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/babel-plugin-minify-numeric-literals/-/babel-plugin-minify-numeric-literals-0.1.1.tgz";
        sha1 = "d4b8b0c925f874714ee33ee4b26678583d7ce7fb";
      };
    };
    "babel-plugin-minify-replace-0.1.2" = {
      name = "babel-plugin-minify-replace";
      packageName = "babel-plugin-minify-replace";
      version = "0.1.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/babel-plugin-minify-replace/-/babel-plugin-minify-replace-0.1.2.tgz";
        sha1 = "b90b9e71ab4d3b36325629a91beabe13b0b16ac1";
      };
    };
    "babel-plugin-minify-simplify-0.1.2" = {
      name = "babel-plugin-minify-simplify";
      packageName = "babel-plugin-minify-simplify";
      version = "0.1.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/babel-plugin-minify-simplify/-/babel-plugin-minify-simplify-0.1.2.tgz";
        sha1 = "a968f1658fdeb2fc759e81fe331d89829df0f6b9";
      };
    };
    "babel-plugin-minify-type-constructors-0.1.2" = {
      name = "babel-plugin-minify-type-constructors";
      packageName = "babel-plugin-minify-type-constructors";
      version = "0.1.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/babel-plugin-minify-type-constructors/-/babel-plugin-minify-type-constructors-0.1.2.tgz";
        sha1 = "db53c5b76cb8e2fcd45d862f17104c78761337ee";
      };
    };
    "babel-plugin-syntax-async-functions-6.13.0" = {
      name = "babel-plugin-syntax-async-functions";
      packageName = "babel-plugin-syntax-async-functions";
      version = "6.13.0";
      src = fetchurl {
        url = "http://registry.npmjs.org/babel-plugin-syntax-async-functions/-/babel-plugin-syntax-async-functions-6.13.0.tgz";
        sha1 = "cad9cad1191b5ad634bf30ae0872391e0647be95";
      };
    };
    "babel-plugin-syntax-async-generators-6.13.0" = {
      name = "babel-plugin-syntax-async-generators";
      packageName = "babel-plugin-syntax-async-generators";
      version = "6.13.0";
      src = fetchurl {
        url = "http://registry.npmjs.org/babel-plugin-syntax-async-generators/-/babel-plugin-syntax-async-generators-6.13.0.tgz";
        sha1 = "6bc963ebb16eccbae6b92b596eb7f35c342a8b9a";
      };
    };
    "babel-plugin-syntax-class-constructor-call-6.18.0" = {
      name = "babel-plugin-syntax-class-constructor-call";
      packageName = "babel-plugin-syntax-class-constructor-call";
      version = "6.18.0";
      src = fetchurl {
        url = "http://registry.npmjs.org/babel-plugin-syntax-class-constructor-call/-/babel-plugin-syntax-class-constructor-call-6.18.0.tgz";
        sha1 = "9cb9d39fe43c8600bec8146456ddcbd4e1a76416";
      };
    };
    "babel-plugin-syntax-class-properties-6.13.0" = {
      name = "babel-plugin-syntax-class-properties";
      packageName = "babel-plugin-syntax-class-properties";
      version = "6.13.0";
      src = fetchurl {
        url = "http://registry.npmjs.org/babel-plugin-syntax-class-properties/-/babel-plugin-syntax-class-properties-6.13.0.tgz";
        sha1 = "d7eb23b79a317f8543962c505b827c7d6cac27de";
      };
    };
    "babel-plugin-syntax-decorators-6.13.0" = {
      name = "babel-plugin-syntax-decorators";
      packageName = "babel-plugin-syntax-decorators";
      version = "6.13.0";
      src = fetchurl {
        url = "http://registry.npmjs.org/babel-plugin-syntax-decorators/-/babel-plugin-syntax-decorators-6.13.0.tgz";
        sha1 = "312563b4dbde3cc806cee3e416cceeaddd11ac0b";
      };
    };
    "babel-plugin-syntax-do-expressions-6.13.0" = {
      name = "babel-plugin-syntax-do-expressions";
      packageName = "babel-plugin-syntax-do-expressions";
      version = "6.13.0";
      src = fetchurl {
        url = "http://registry.npmjs.org/babel-plugin-syntax-do-expressions/-/babel-plugin-syntax-do-expressions-6.13.0.tgz";
        sha1 = "5747756139aa26d390d09410b03744ba07e4796d";
      };
    };
    "babel-plugin-syntax-dynamic-import-6.18.0" = {
      name = "babel-plugin-syntax-dynamic-import";
      packageName = "babel-plugin-syntax-dynamic-import";
      version = "6.18.0";
      src = fetchurl {
        url = "http://registry.npmjs.org/babel-plugin-syntax-dynamic-import/-/babel-plugin-syntax-dynamic-import-6.18.0.tgz";
        sha1 = "8d6a26229c83745a9982a441051572caa179b1da";
      };
    };
    "babel-plugin-syntax-exponentiation-operator-6.13.0" = {
      name = "babel-plugin-syntax-exponentiation-operator";
      packageName = "babel-plugin-syntax-exponentiation-operator";
      version = "6.13.0";
      src = fetchurl {
        url = "http://registry.npmjs.org/babel-plugin-syntax-exponentiation-operator/-/babel-plugin-syntax-exponentiation-operator-6.13.0.tgz";
        sha1 = "9ee7e8337290da95288201a6a57f4170317830de";
      };
    };
    "babel-plugin-syntax-export-extensions-6.13.0" = {
      name = "babel-plugin-syntax-export-extensions";
      packageName = "babel-plugin-syntax-export-extensions";
      version = "6.13.0";
      src = fetchurl {
        url = "http://registry.npmjs.org/babel-plugin-syntax-export-extensions/-/babel-plugin-syntax-export-extensions-6.13.0.tgz";
        sha1 = "70a1484f0f9089a4e84ad44bac353c95b9b12721";
      };
    };
    "babel-plugin-syntax-function-bind-6.13.0" = {
      name = "babel-plugin-syntax-function-bind";
      packageName = "babel-plugin-syntax-function-bind";
      version = "6.13.0";
      src = fetchurl {
        url = "http://registry.npmjs.org/babel-plugin-syntax-function-bind/-/babel-plugin-syntax-function-bind-6.13.0.tgz";
        sha1 = "48c495f177bdf31a981e732f55adc0bdd2601f46";
      };
    };
    "babel-plugin-syntax-object-rest-spread-6.13.0" = {
      name = "babel-plugin-syntax-object-rest-spread";
      packageName = "babel-plugin-syntax-object-rest-spread";
      version = "6.13.0";
      src = fetchurl {
        url = "http://registry.npmjs.org/babel-plugin-syntax-object-rest-spread/-/babel-plugin-syntax-object-rest-spread-6.13.0.tgz";
        sha1 = "fd6536f2bce13836ffa3a5458c4903a597bb3bf5";
      };
    };
    "babel-plugin-syntax-trailing-function-commas-6.22.0" = {
      name = "babel-plugin-syntax-trailing-function-commas";
      packageName = "babel-plugin-syntax-trailing-function-commas";
      version = "6.22.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/babel-plugin-syntax-trailing-function-commas/-/babel-plugin-syntax-trailing-function-commas-6.22.0.tgz";
        sha1 = "ba0360937f8d06e40180a43fe0d5616fff532cf3";
      };
    };
    "babel-plugin-transform-async-generator-functions-6.24.1" = {
      name = "babel-plugin-transform-async-generator-functions";
      packageName = "babel-plugin-transform-async-generator-functions";
      version = "6.24.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/babel-plugin-transform-async-generator-functions/-/babel-plugin-transform-async-generator-functions-6.24.1.tgz";
        sha1 = "f058900145fd3e9907a6ddf28da59f215258a5db";
      };
    };
    "babel-plugin-transform-async-to-generator-6.24.1" = {
      name = "babel-plugin-transform-async-to-generator";
      packageName = "babel-plugin-transform-async-to-generator";
      version = "6.24.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/babel-plugin-transform-async-to-generator/-/babel-plugin-transform-async-to-generator-6.24.1.tgz";
        sha1 = "6536e378aff6cb1d5517ac0e40eb3e9fc8d08761";
      };
    };
    "babel-plugin-transform-class-constructor-call-6.24.1" = {
      name = "babel-plugin-transform-class-constructor-call";
      packageName = "babel-plugin-transform-class-constructor-call";
      version = "6.24.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/babel-plugin-transform-class-constructor-call/-/babel-plugin-transform-class-constructor-call-6.24.1.tgz";
        sha1 = "80dc285505ac067dcb8d6c65e2f6f11ab7765ef9";
      };
    };
    "babel-plugin-transform-class-properties-6.24.1" = {
      name = "babel-plugin-transform-class-properties";
      packageName = "babel-plugin-transform-class-properties";
      version = "6.24.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/babel-plugin-transform-class-properties/-/babel-plugin-transform-class-properties-6.24.1.tgz";
        sha1 = "6a79763ea61d33d36f37b611aa9def81a81b46ac";
      };
    };
    "babel-plugin-transform-decorators-6.24.1" = {
      name = "babel-plugin-transform-decorators";
      packageName = "babel-plugin-transform-decorators";
      version = "6.24.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/babel-plugin-transform-decorators/-/babel-plugin-transform-decorators-6.24.1.tgz";
        sha1 = "788013d8f8c6b5222bdf7b344390dfd77569e24d";
      };
    };
    "babel-plugin-transform-do-expressions-6.22.0" = {
      name = "babel-plugin-transform-do-expressions";
      packageName = "babel-plugin-transform-do-expressions";
      version = "6.22.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/babel-plugin-transform-do-expressions/-/babel-plugin-transform-do-expressions-6.22.0.tgz";
        sha1 = "28ccaf92812d949c2cd1281f690c8fdc468ae9bb";
      };
    };
    "babel-plugin-transform-es2015-arrow-functions-6.22.0" = {
      name = "babel-plugin-transform-es2015-arrow-functions";
      packageName = "babel-plugin-transform-es2015-arrow-functions";
      version = "6.22.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/babel-plugin-transform-es2015-arrow-functions/-/babel-plugin-transform-es2015-arrow-functions-6.22.0.tgz";
        sha1 = "452692cb711d5f79dc7f85e440ce41b9f244d221";
      };
    };
    "babel-plugin-transform-es2015-block-scoped-functions-6.22.0" = {
      name = "babel-plugin-transform-es2015-block-scoped-functions";
      packageName = "babel-plugin-transform-es2015-block-scoped-functions";
      version = "6.22.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/babel-plugin-transform-es2015-block-scoped-functions/-/babel-plugin-transform-es2015-block-scoped-functions-6.22.0.tgz";
        sha1 = "bbc51b49f964d70cb8d8e0b94e820246ce3a6141";
      };
    };
    "babel-plugin-transform-es2015-block-scoping-6.26.0" = {
      name = "babel-plugin-transform-es2015-block-scoping";
      packageName = "babel-plugin-transform-es2015-block-scoping";
      version = "6.26.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/babel-plugin-transform-es2015-block-scoping/-/babel-plugin-transform-es2015-block-scoping-6.26.0.tgz";
        sha1 = "d70f5299c1308d05c12f463813b0a09e73b1895f";
      };
    };
    "babel-plugin-transform-es2015-classes-6.24.1" = {
      name = "babel-plugin-transform-es2015-classes";
      packageName = "babel-plugin-transform-es2015-classes";
      version = "6.24.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/babel-plugin-transform-es2015-classes/-/babel-plugin-transform-es2015-classes-6.24.1.tgz";
        sha1 = "5a4c58a50c9c9461e564b4b2a3bfabc97a2584db";
      };
    };
    "babel-plugin-transform-es2015-computed-properties-6.24.1" = {
      name = "babel-plugin-transform-es2015-computed-properties";
      packageName = "babel-plugin-transform-es2015-computed-properties";
      version = "6.24.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/babel-plugin-transform-es2015-computed-properties/-/babel-plugin-transform-es2015-computed-properties-6.24.1.tgz";
        sha1 = "6fe2a8d16895d5634f4cd999b6d3480a308159b3";
      };
    };
    "babel-plugin-transform-es2015-destructuring-6.23.0" = {
      name = "babel-plugin-transform-es2015-destructuring";
      packageName = "babel-plugin-transform-es2015-destructuring";
      version = "6.23.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/babel-plugin-transform-es2015-destructuring/-/babel-plugin-transform-es2015-destructuring-6.23.0.tgz";
        sha1 = "997bb1f1ab967f682d2b0876fe358d60e765c56d";
      };
    };
    "babel-plugin-transform-es2015-duplicate-keys-6.24.1" = {
      name = "babel-plugin-transform-es2015-duplicate-keys";
      packageName = "babel-plugin-transform-es2015-duplicate-keys";
      version = "6.24.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/babel-plugin-transform-es2015-duplicate-keys/-/babel-plugin-transform-es2015-duplicate-keys-6.24.1.tgz";
        sha1 = "73eb3d310ca969e3ef9ec91c53741a6f1576423e";
      };
    };
    "babel-plugin-transform-es2015-for-of-6.23.0" = {
      name = "babel-plugin-transform-es2015-for-of";
      packageName = "babel-plugin-transform-es2015-for-of";
      version = "6.23.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/babel-plugin-transform-es2015-for-of/-/babel-plugin-transform-es2015-for-of-6.23.0.tgz";
        sha1 = "f47c95b2b613df1d3ecc2fdb7573623c75248691";
      };
    };
    "babel-plugin-transform-es2015-function-name-6.24.1" = {
      name = "babel-plugin-transform-es2015-function-name";
      packageName = "babel-plugin-transform-es2015-function-name";
      version = "6.24.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/babel-plugin-transform-es2015-function-name/-/babel-plugin-transform-es2015-function-name-6.24.1.tgz";
        sha1 = "834c89853bc36b1af0f3a4c5dbaa94fd8eacaa8b";
      };
    };
    "babel-plugin-transform-es2015-literals-6.22.0" = {
      name = "babel-plugin-transform-es2015-literals";
      packageName = "babel-plugin-transform-es2015-literals";
      version = "6.22.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/babel-plugin-transform-es2015-literals/-/babel-plugin-transform-es2015-literals-6.22.0.tgz";
        sha1 = "4f54a02d6cd66cf915280019a31d31925377ca2e";
      };
    };
    "babel-plugin-transform-es2015-modules-amd-6.24.1" = {
      name = "babel-plugin-transform-es2015-modules-amd";
      packageName = "babel-plugin-transform-es2015-modules-amd";
      version = "6.24.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/babel-plugin-transform-es2015-modules-amd/-/babel-plugin-transform-es2015-modules-amd-6.24.1.tgz";
        sha1 = "3b3e54017239842d6d19c3011c4bd2f00a00d154";
      };
    };
    "babel-plugin-transform-es2015-modules-commonjs-6.26.2" = {
      name = "babel-plugin-transform-es2015-modules-commonjs";
      packageName = "babel-plugin-transform-es2015-modules-commonjs";
      version = "6.26.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/babel-plugin-transform-es2015-modules-commonjs/-/babel-plugin-transform-es2015-modules-commonjs-6.26.2.tgz";
        sha512 = "CV9ROOHEdrjcwhIaJNBGMBCodN+1cfkwtM1SbUHmvyy35KGT7fohbpOxkE2uLz1o6odKK2Ck/tz47z+VqQfi9Q==";
      };
    };
    "babel-plugin-transform-es2015-modules-systemjs-6.24.1" = {
      name = "babel-plugin-transform-es2015-modules-systemjs";
      packageName = "babel-plugin-transform-es2015-modules-systemjs";
      version = "6.24.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/babel-plugin-transform-es2015-modules-systemjs/-/babel-plugin-transform-es2015-modules-systemjs-6.24.1.tgz";
        sha1 = "ff89a142b9119a906195f5f106ecf305d9407d23";
      };
    };
    "babel-plugin-transform-es2015-modules-umd-6.24.1" = {
      name = "babel-plugin-transform-es2015-modules-umd";
      packageName = "babel-plugin-transform-es2015-modules-umd";
      version = "6.24.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/babel-plugin-transform-es2015-modules-umd/-/babel-plugin-transform-es2015-modules-umd-6.24.1.tgz";
        sha1 = "ac997e6285cd18ed6176adb607d602344ad38468";
      };
    };
    "babel-plugin-transform-es2015-object-super-6.24.1" = {
      name = "babel-plugin-transform-es2015-object-super";
      packageName = "babel-plugin-transform-es2015-object-super";
      version = "6.24.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/babel-plugin-transform-es2015-object-super/-/babel-plugin-transform-es2015-object-super-6.24.1.tgz";
        sha1 = "24cef69ae21cb83a7f8603dad021f572eb278f8d";
      };
    };
    "babel-plugin-transform-es2015-parameters-6.24.1" = {
      name = "babel-plugin-transform-es2015-parameters";
      packageName = "babel-plugin-transform-es2015-parameters";
      version = "6.24.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/babel-plugin-transform-es2015-parameters/-/babel-plugin-transform-es2015-parameters-6.24.1.tgz";
        sha1 = "57ac351ab49caf14a97cd13b09f66fdf0a625f2b";
      };
    };
    "babel-plugin-transform-es2015-shorthand-properties-6.24.1" = {
      name = "babel-plugin-transform-es2015-shorthand-properties";
      packageName = "babel-plugin-transform-es2015-shorthand-properties";
      version = "6.24.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/babel-plugin-transform-es2015-shorthand-properties/-/babel-plugin-transform-es2015-shorthand-properties-6.24.1.tgz";
        sha1 = "24f875d6721c87661bbd99a4622e51f14de38aa0";
      };
    };
    "babel-plugin-transform-es2015-spread-6.22.0" = {
      name = "babel-plugin-transform-es2015-spread";
      packageName = "babel-plugin-transform-es2015-spread";
      version = "6.22.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/babel-plugin-transform-es2015-spread/-/babel-plugin-transform-es2015-spread-6.22.0.tgz";
        sha1 = "d6d68a99f89aedc4536c81a542e8dd9f1746f8d1";
      };
    };
    "babel-plugin-transform-es2015-sticky-regex-6.24.1" = {
      name = "babel-plugin-transform-es2015-sticky-regex";
      packageName = "babel-plugin-transform-es2015-sticky-regex";
      version = "6.24.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/babel-plugin-transform-es2015-sticky-regex/-/babel-plugin-transform-es2015-sticky-regex-6.24.1.tgz";
        sha1 = "00c1cdb1aca71112cdf0cf6126c2ed6b457ccdbc";
      };
    };
    "babel-plugin-transform-es2015-template-literals-6.22.0" = {
      name = "babel-plugin-transform-es2015-template-literals";
      packageName = "babel-plugin-transform-es2015-template-literals";
      version = "6.22.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/babel-plugin-transform-es2015-template-literals/-/babel-plugin-transform-es2015-template-literals-6.22.0.tgz";
        sha1 = "a84b3450f7e9f8f1f6839d6d687da84bb1236d8d";
      };
    };
    "babel-plugin-transform-es2015-typeof-symbol-6.23.0" = {
      name = "babel-plugin-transform-es2015-typeof-symbol";
      packageName = "babel-plugin-transform-es2015-typeof-symbol";
      version = "6.23.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/babel-plugin-transform-es2015-typeof-symbol/-/babel-plugin-transform-es2015-typeof-symbol-6.23.0.tgz";
        sha1 = "dec09f1cddff94b52ac73d505c84df59dcceb372";
      };
    };
    "babel-plugin-transform-es2015-unicode-regex-6.24.1" = {
      name = "babel-plugin-transform-es2015-unicode-regex";
      packageName = "babel-plugin-transform-es2015-unicode-regex";
      version = "6.24.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/babel-plugin-transform-es2015-unicode-regex/-/babel-plugin-transform-es2015-unicode-regex-6.24.1.tgz";
        sha1 = "d38b12f42ea7323f729387f18a7c5ae1faeb35e9";
      };
    };
    "babel-plugin-transform-exponentiation-operator-6.24.1" = {
      name = "babel-plugin-transform-exponentiation-operator";
      packageName = "babel-plugin-transform-exponentiation-operator";
      version = "6.24.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/babel-plugin-transform-exponentiation-operator/-/babel-plugin-transform-exponentiation-operator-6.24.1.tgz";
        sha1 = "2ab0c9c7f3098fa48907772bb813fe41e8de3a0e";
      };
    };
    "babel-plugin-transform-export-extensions-6.22.0" = {
      name = "babel-plugin-transform-export-extensions";
      packageName = "babel-plugin-transform-export-extensions";
      version = "6.22.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/babel-plugin-transform-export-extensions/-/babel-plugin-transform-export-extensions-6.22.0.tgz";
        sha1 = "53738b47e75e8218589eea946cbbd39109bbe653";
      };
    };
    "babel-plugin-transform-function-bind-6.22.0" = {
      name = "babel-plugin-transform-function-bind";
      packageName = "babel-plugin-transform-function-bind";
      version = "6.22.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/babel-plugin-transform-function-bind/-/babel-plugin-transform-function-bind-6.22.0.tgz";
        sha1 = "c6fb8e96ac296a310b8cf8ea401462407ddf6a97";
      };
    };
    "babel-plugin-transform-inline-consecutive-adds-0.1.2" = {
      name = "babel-plugin-transform-inline-consecutive-adds";
      packageName = "babel-plugin-transform-inline-consecutive-adds";
      version = "0.1.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/babel-plugin-transform-inline-consecutive-adds/-/babel-plugin-transform-inline-consecutive-adds-0.1.2.tgz";
        sha1 = "5442e9f1c19c78a7899f8a4dee6fd481f61001f5";
      };
    };
    "babel-plugin-transform-member-expression-literals-6.9.4" = {
      name = "babel-plugin-transform-member-expression-literals";
      packageName = "babel-plugin-transform-member-expression-literals";
      version = "6.9.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/babel-plugin-transform-member-expression-literals/-/babel-plugin-transform-member-expression-literals-6.9.4.tgz";
        sha1 = "37039c9a0c3313a39495faac2ff3a6b5b9d038bf";
      };
    };
    "babel-plugin-transform-merge-sibling-variables-6.9.4" = {
      name = "babel-plugin-transform-merge-sibling-variables";
      packageName = "babel-plugin-transform-merge-sibling-variables";
      version = "6.9.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/babel-plugin-transform-merge-sibling-variables/-/babel-plugin-transform-merge-sibling-variables-6.9.4.tgz";
        sha1 = "85b422fc3377b449c9d1cde44087203532401dae";
      };
    };
    "babel-plugin-transform-minify-booleans-6.9.4" = {
      name = "babel-plugin-transform-minify-booleans";
      packageName = "babel-plugin-transform-minify-booleans";
      version = "6.9.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/babel-plugin-transform-minify-booleans/-/babel-plugin-transform-minify-booleans-6.9.4.tgz";
        sha1 = "acbb3e56a3555dd23928e4b582d285162dd2b198";
      };
    };
    "babel-plugin-transform-object-rest-spread-6.26.0" = {
      name = "babel-plugin-transform-object-rest-spread";
      packageName = "babel-plugin-transform-object-rest-spread";
      version = "6.26.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/babel-plugin-transform-object-rest-spread/-/babel-plugin-transform-object-rest-spread-6.26.0.tgz";
        sha1 = "0f36692d50fef6b7e2d4b3ac1478137a963b7b06";
      };
    };
    "babel-plugin-transform-property-literals-6.9.4" = {
      name = "babel-plugin-transform-property-literals";
      packageName = "babel-plugin-transform-property-literals";
      version = "6.9.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/babel-plugin-transform-property-literals/-/babel-plugin-transform-property-literals-6.9.4.tgz";
        sha1 = "98c1d21e255736573f93ece54459f6ce24985d39";
      };
    };
    "babel-plugin-transform-regenerator-6.26.0" = {
      name = "babel-plugin-transform-regenerator";
      packageName = "babel-plugin-transform-regenerator";
      version = "6.26.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/babel-plugin-transform-regenerator/-/babel-plugin-transform-regenerator-6.26.0.tgz";
        sha1 = "e0703696fbde27f0a3efcacf8b4dca2f7b3a8f2f";
      };
    };
    "babel-plugin-transform-regexp-constructors-0.1.1" = {
      name = "babel-plugin-transform-regexp-constructors";
      packageName = "babel-plugin-transform-regexp-constructors";
      version = "0.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/babel-plugin-transform-regexp-constructors/-/babel-plugin-transform-regexp-constructors-0.1.1.tgz";
        sha1 = "312ab7487cc88a1c62ee25ea1b6087e89b87799c";
      };
    };
    "babel-plugin-transform-remove-console-6.9.4" = {
      name = "babel-plugin-transform-remove-console";
      packageName = "babel-plugin-transform-remove-console";
      version = "6.9.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/babel-plugin-transform-remove-console/-/babel-plugin-transform-remove-console-6.9.4.tgz";
        sha1 = "b980360c067384e24b357a588d807d3c83527780";
      };
    };
    "babel-plugin-transform-remove-debugger-6.9.4" = {
      name = "babel-plugin-transform-remove-debugger";
      packageName = "babel-plugin-transform-remove-debugger";
      version = "6.9.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/babel-plugin-transform-remove-debugger/-/babel-plugin-transform-remove-debugger-6.9.4.tgz";
        sha1 = "42b727631c97978e1eb2d199a7aec84a18339ef2";
      };
    };
    "babel-plugin-transform-remove-undefined-0.1.2" = {
      name = "babel-plugin-transform-remove-undefined";
      packageName = "babel-plugin-transform-remove-undefined";
      version = "0.1.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/babel-plugin-transform-remove-undefined/-/babel-plugin-transform-remove-undefined-0.1.2.tgz";
        sha1 = "e1ebf51110f6b1e0665f28382ef73f95e5023652";
      };
    };
    "babel-plugin-transform-runtime-6.23.0" = {
      name = "babel-plugin-transform-runtime";
      packageName = "babel-plugin-transform-runtime";
      version = "6.23.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/babel-plugin-transform-runtime/-/babel-plugin-transform-runtime-6.23.0.tgz";
        sha1 = "88490d446502ea9b8e7efb0fe09ec4d99479b1ee";
      };
    };
    "babel-plugin-transform-simplify-comparison-operators-6.9.4" = {
      name = "babel-plugin-transform-simplify-comparison-operators";
      packageName = "babel-plugin-transform-simplify-comparison-operators";
      version = "6.9.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/babel-plugin-transform-simplify-comparison-operators/-/babel-plugin-transform-simplify-comparison-operators-6.9.4.tgz";
        sha1 = "f62afe096cab0e1f68a2d753fdf283888471ceb9";
      };
    };
    "babel-plugin-transform-strict-mode-6.24.1" = {
      name = "babel-plugin-transform-strict-mode";
      packageName = "babel-plugin-transform-strict-mode";
      version = "6.24.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/babel-plugin-transform-strict-mode/-/babel-plugin-transform-strict-mode-6.24.1.tgz";
        sha1 = "d5faf7aa578a65bbe591cf5edae04a0c67020758";
      };
    };
    "babel-plugin-transform-undefined-to-void-6.9.4" = {
      name = "babel-plugin-transform-undefined-to-void";
      packageName = "babel-plugin-transform-undefined-to-void";
      version = "6.9.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/babel-plugin-transform-undefined-to-void/-/babel-plugin-transform-undefined-to-void-6.9.4.tgz";
        sha1 = "be241ca81404030678b748717322b89d0c8fe280";
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
    "babel-polyfill-6.26.0" = {
      name = "babel-polyfill";
      packageName = "babel-polyfill";
      version = "6.26.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/babel-polyfill/-/babel-polyfill-6.26.0.tgz";
        sha1 = "379937abc67d7895970adc621f284cd966cf2153";
      };
    };
    "babel-preset-babili-0.1.4" = {
      name = "babel-preset-babili";
      packageName = "babel-preset-babili";
      version = "0.1.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/babel-preset-babili/-/babel-preset-babili-0.1.4.tgz";
        sha1 = "ad9d6651002f5bc3f07cab300781167f54724bf2";
      };
    };
    "babel-preset-env-1.7.0" = {
      name = "babel-preset-env";
      packageName = "babel-preset-env";
      version = "1.7.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/babel-preset-env/-/babel-preset-env-1.7.0.tgz";
        sha512 = "9OR2afuKDneX2/q2EurSftUYM0xGu4O2D9adAhVfADDhrYDaxXV0rBbevVYoY9n6nyX1PmQW/0jtpJvUNr9CHg==";
      };
    };
    "babel-preset-es2040-1.1.1" = {
      name = "babel-preset-es2040";
      packageName = "babel-preset-es2040";
      version = "1.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/babel-preset-es2040/-/babel-preset-es2040-1.1.1.tgz";
        sha1 = "408cc33724708205c780667b930fa78df5bc8f94";
      };
    };
    "babel-preset-stage-0-6.24.1" = {
      name = "babel-preset-stage-0";
      packageName = "babel-preset-stage-0";
      version = "6.24.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/babel-preset-stage-0/-/babel-preset-stage-0-6.24.1.tgz";
        sha1 = "5642d15042f91384d7e5af8bc88b1db95b039e6a";
      };
    };
    "babel-preset-stage-1-6.24.1" = {
      name = "babel-preset-stage-1";
      packageName = "babel-preset-stage-1";
      version = "6.24.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/babel-preset-stage-1/-/babel-preset-stage-1-6.24.1.tgz";
        sha1 = "7692cd7dcd6849907e6ae4a0a85589cfb9e2bfb0";
      };
    };
    "babel-preset-stage-2-6.24.1" = {
      name = "babel-preset-stage-2";
      packageName = "babel-preset-stage-2";
      version = "6.24.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/babel-preset-stage-2/-/babel-preset-stage-2-6.24.1.tgz";
        sha1 = "d9e2960fb3d71187f0e64eec62bc07767219bdc1";
      };
    };
    "babel-preset-stage-3-6.24.1" = {
      name = "babel-preset-stage-3";
      packageName = "babel-preset-stage-3";
      version = "6.24.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/babel-preset-stage-3/-/babel-preset-stage-3-6.24.1.tgz";
        sha1 = "836ada0a9e7a7fa37cb138fb9326f87934a48395";
      };
    };
    "babel-register-6.26.0" = {
      name = "babel-register";
      packageName = "babel-register";
      version = "6.26.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/babel-register/-/babel-register-6.26.0.tgz";
        sha1 = "6ed021173e2fcb486d7acb45c6009a856f647071";
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
    "babel-template-6.26.0" = {
      name = "babel-template";
      packageName = "babel-template";
      version = "6.26.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/babel-template/-/babel-template-6.26.0.tgz";
        sha1 = "de03e2d16396b069f46dd9fff8521fb1a0e35e02";
      };
    };
    "babel-traverse-6.26.0" = {
      name = "babel-traverse";
      packageName = "babel-traverse";
      version = "6.26.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/babel-traverse/-/babel-traverse-6.26.0.tgz";
        sha1 = "46a9cbd7edcc62c8e5c064e2d2d8d0f4035766ee";
      };
    };
    "babel-types-6.26.0" = {
      name = "babel-types";
      packageName = "babel-types";
      version = "6.26.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/babel-types/-/babel-types-6.26.0.tgz";
        sha1 = "a3b073f94ab49eb6fa55cd65227a334380632497";
      };
    };
    "babili-webpack-plugin-0.1.2" = {
      name = "babili-webpack-plugin";
      packageName = "babili-webpack-plugin";
      version = "0.1.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/babili-webpack-plugin/-/babili-webpack-plugin-0.1.2.tgz";
        sha1 = "164ac03d5932f6a52143e7ffc06f2711c651b6f2";
      };
    };
    "babylon-6.18.0" = {
      name = "babylon";
      packageName = "babylon";
      version = "6.18.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/babylon/-/babylon-6.18.0.tgz";
        sha512 = "q/UEjfGJ2Cm3oKV71DJz9d25TPnq5rhBVL2Q4fA5wcC3jcrdn7+SssEybFIxwAvvP+YCsCYNKughoF33GxgycQ==";
      };
    };
    "babylon-7.0.0-beta.44" = {
      name = "babylon";
      packageName = "babylon";
      version = "7.0.0-beta.44";
      src = fetchurl {
        url = "http://registry.npmjs.org/babylon/-/babylon-7.0.0-beta.44.tgz";
        sha512 = "5Hlm13BJVAioCHpImtFqNOF2H3ieTOHd0fmFGMxOJ9jgeFqeAwsv3u5P5cR7CSeFrkgHsT19DgFJkHV0/Mcd8g==";
      };
    };
    "bail-1.0.3" = {
      name = "bail";
      packageName = "bail";
      version = "1.0.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/bail/-/bail-1.0.3.tgz";
        sha512 = "1X8CnjFVQ+a+KW36uBNMTU5s8+v5FzeqrP7hTG5aTb4aPreSbZJlhwPon9VKMuEVgV++JM+SQrALY3kr7eswdg==";
      };
    };
    "balanced-match-0.4.2" = {
      name = "balanced-match";
      packageName = "balanced-match";
      version = "0.4.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/balanced-match/-/balanced-match-0.4.2.tgz";
        sha1 = "cb3f3e3c732dc0f01ee70b403f302e61d7709838";
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
    "base-0.11.2" = {
      name = "base";
      packageName = "base";
      version = "0.11.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/base/-/base-0.11.2.tgz";
        sha512 = "5T6P4xPgpp0YDFvSWwEZ4NoE3aM4QBQXDzmVbraCkFj8zHM+mba8SyqB5DbZWyR7mYHo6Y7BdQo3MoA4m0TeQg==";
      };
    };
    "base64-js-1.3.0" = {
      name = "base64-js";
      packageName = "base64-js";
      version = "1.3.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/base64-js/-/base64-js-1.3.0.tgz";
        sha512 = "ccav/yGvoa80BQDljCxsmmQ3Xvx60/UpBIij5QN21W3wBi/hhIC9OoO+KLpu9IJTS9j4DRVJ3aDDF9cMSoa2lw==";
      };
    };
    "base64-url-2.2.0" = {
      name = "base64-url";
      packageName = "base64-url";
      version = "2.2.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/base64-url/-/base64-url-2.2.0.tgz";
        sha512 = "Y4qHHAE+rWjmAFPQmHPiiD+hWwM/XvuFLlP6kVxlwZJK7rjiE2uIQR9tZ37iEr1E6iCj9799yxMAmiXzITb3lQ==";
      };
    };
    "bash-color-0.0.4" = {
      name = "bash-color";
      packageName = "bash-color";
      version = "0.0.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/bash-color/-/bash-color-0.0.4.tgz";
        sha1 = "e9be8ce33540cada4881768c59bd63865736e913";
      };
    };
    "batch-0.6.1" = {
      name = "batch";
      packageName = "batch";
      version = "0.6.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/batch/-/batch-0.6.1.tgz";
        sha1 = "dc34314f4e679318093fc760272525f94bf25c16";
      };
    };
    "bcrypt-pbkdf-1.0.2" = {
      name = "bcrypt-pbkdf";
      packageName = "bcrypt-pbkdf";
      version = "1.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/bcrypt-pbkdf/-/bcrypt-pbkdf-1.0.2.tgz";
        sha1 = "a4301d389b6a43f9b67ff3ca11a3f6637e360e9e";
      };
    };
    "big.js-3.2.0" = {
      name = "big.js";
      packageName = "big.js";
      version = "3.2.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/big.js/-/big.js-3.2.0.tgz";
        sha512 = "+hN/Zh2D08Mx65pZ/4g5bsmNiZUuChDiQfTUQ7qJr4/kuopCr88xZsAXv6mBoZEsUI4OuGHlX59qE94K2mMW8Q==";
      };
    };
    "binary-extensions-1.12.0" = {
      name = "binary-extensions";
      packageName = "binary-extensions";
      version = "1.12.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/binary-extensions/-/binary-extensions-1.12.0.tgz";
        sha512 = "DYWGk01lDcxeS/K9IHPGWfT8PsJmbXRtRd2Sx72Tnb8pcYZQFF1oSDb8hJtS1vhp212q1Rzi5dUf9+nq0o9UIg==";
      };
    };
    "binary-search-1.3.4" = {
      name = "binary-search";
      packageName = "binary-search";
      version = "1.3.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/binary-search/-/binary-search-1.3.4.tgz";
        sha512 = "dPxU/vZLnH0tEVjVPgi015oSwqu6oLfCeHywuFRhBE0yM0mYocvleTl8qsdM1YFhRzTRhM1+VzS8XLDVrHPopg==";
      };
    };
    "bindings-1.3.1" = {
      name = "bindings";
      packageName = "bindings";
      version = "1.3.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/bindings/-/bindings-1.3.1.tgz";
        sha512 = "i47mqjF9UbjxJhxGf+pZ6kSxrnI3wBLlnGI2ArWJ4r0VrvDS7ZYXkprq/pLaBWYq4GM0r4zdHY+NNRqEMU7uew==";
      };
    };
    "bl-0.8.2" = {
      name = "bl";
      packageName = "bl";
      version = "0.8.2";
      src = fetchurl {
        url = "http://registry.npmjs.org/bl/-/bl-0.8.2.tgz";
        sha1 = "c9b6bca08d1bc2ea00fc8afb4f1a5fd1e1c66e4e";
      };
    };
    "bl-1.2.2" = {
      name = "bl";
      packageName = "bl";
      version = "1.2.2";
      src = fetchurl {
        url = "http://registry.npmjs.org/bl/-/bl-1.2.2.tgz";
        sha512 = "e8tQYnZodmebYDWGH7KMRvtzKXaJHx3BbilrgZCfvyLUYdKpK1t5PSPmpkny/SgiTSCnjfLW7v5rlONXVFkQEA==";
      };
    };
    "blake2s-1.0.1" = {
      name = "blake2s";
      packageName = "blake2s";
      version = "1.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/blake2s/-/blake2s-1.0.1.tgz";
        sha1 = "1598822a320ece6aa401ba982954f82f61b0cd7b";
      };
    };
    "block-stream-0.0.9" = {
      name = "block-stream";
      packageName = "block-stream";
      version = "0.0.9";
      src = fetchurl {
        url = "https://registry.npmjs.org/block-stream/-/block-stream-0.0.9.tgz";
        sha1 = "13ebfe778a03205cfe03751481ebb4b3300c126a";
      };
    };
    "bluebird-3.5.3" = {
      name = "bluebird";
      packageName = "bluebird";
      version = "3.5.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/bluebird/-/bluebird-3.5.3.tgz";
        sha512 = "/qKPUQlaW1OyR51WeCPBvRnAlnZFUJkCSG5HzGnuIqhgyJtF+T94lFnn33eiazjRm2LAHVy2guNnaq48X9SJuw==";
      };
    };
    "bn.js-4.11.8" = {
      name = "bn.js";
      packageName = "bn.js";
      version = "4.11.8";
      src = fetchurl {
        url = "https://registry.npmjs.org/bn.js/-/bn.js-4.11.8.tgz";
        sha512 = "ItfYfPLkWHUjckQCk8xC+LwxgK8NYcXywGigJgSwOP8Y2iyWT4f2vsZnoOXTTbo+o5yXmIUJ4gn5538SO5S3gA==";
      };
    };
    "body-parser-1.18.3" = {
      name = "body-parser";
      packageName = "body-parser";
      version = "1.18.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/body-parser/-/body-parser-1.18.3.tgz";
        sha1 = "5b292198ffdd553b3a0f20ded0592b956955c8b4";
      };
    };
    "bonjour-3.5.0" = {
      name = "bonjour";
      packageName = "bonjour";
      version = "3.5.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/bonjour/-/bonjour-3.5.0.tgz";
        sha1 = "8e890a183d8ee9a2393b3844c691a42bcf7bc9f5";
      };
    };
    "boolbase-1.0.0" = {
      name = "boolbase";
      packageName = "boolbase";
      version = "1.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/boolbase/-/boolbase-1.0.0.tgz";
        sha1 = "68dff5fbe60c51eb37725ea9e3ed310dcc1e776e";
      };
    };
    "bootstrap-4.1.3" = {
      name = "bootstrap";
      packageName = "bootstrap";
      version = "4.1.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/bootstrap/-/bootstrap-4.1.3.tgz";
        sha512 = "rDFIzgXcof0jDyjNosjv4Sno77X4KuPeFxG2XZZv1/Kc8DRVGVADdoQyyOVDwPqL36DDmtCQbrpMCqvpPLJQ0w==";
      };
    };
    "bootstrap-vue-2.0.0-rc.11" = {
      name = "bootstrap-vue";
      packageName = "bootstrap-vue";
      version = "2.0.0-rc.11";
      src = fetchurl {
        url = "https://registry.npmjs.org/bootstrap-vue/-/bootstrap-vue-2.0.0-rc.11.tgz";
        sha512 = "LxR+oL8yKr1DVoWUWTX+XhiT0xaTMH6142u2VSFDm4tewTH8HIrzN2YIl7HLZrw2DIuE9bRMIdWJqqn3aQe7Hw==";
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
    "braces-1.8.5" = {
      name = "braces";
      packageName = "braces";
      version = "1.8.5";
      src = fetchurl {
        url = "https://registry.npmjs.org/braces/-/braces-1.8.5.tgz";
        sha1 = "ba77962e12dff969d6b76711e914b737857bf6a7";
      };
    };
    "braces-2.3.2" = {
      name = "braces";
      packageName = "braces";
      version = "2.3.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/braces/-/braces-2.3.2.tgz";
        sha512 = "aNdbnj9P8PjdXU4ybaWLK2IF3jc/EoDYbC7AazW6to3TRsfXxscC9UXOB5iDiEQrkyIbWp2SLQda4+QAa7nc3w==";
      };
    };
    "broadcast-stream-0.2.2" = {
      name = "broadcast-stream";
      packageName = "broadcast-stream";
      version = "0.2.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/broadcast-stream/-/broadcast-stream-0.2.2.tgz";
        sha1 = "79e7bb14a9abba77f72ac9258220242a8fd3919d";
      };
    };
    "brorand-1.1.0" = {
      name = "brorand";
      packageName = "brorand";
      version = "1.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/brorand/-/brorand-1.1.0.tgz";
        sha1 = "12c25efe40a45e3c323eb8675a0a0ce57b22371f";
      };
    };
    "browser-split-0.0.1" = {
      name = "browser-split";
      packageName = "browser-split";
      version = "0.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/browser-split/-/browser-split-0.0.1.tgz";
        sha1 = "7b097574f8e3ead606fb4664e64adfdda2981a93";
      };
    };
    "browser-stdout-1.3.0" = {
      name = "browser-stdout";
      packageName = "browser-stdout";
      version = "1.3.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/browser-stdout/-/browser-stdout-1.3.0.tgz";
        sha1 = "f351d32969d32fa5d7a5567154263d928ae3bd1f";
      };
    };
    "browserify-aes-1.2.0" = {
      name = "browserify-aes";
      packageName = "browserify-aes";
      version = "1.2.0";
      src = fetchurl {
        url = "http://registry.npmjs.org/browserify-aes/-/browserify-aes-1.2.0.tgz";
        sha512 = "+7CHXqGuspUn/Sl5aO7Ea0xWGAtETPXNSAjHo48JfLdPWcMng33Xe4znFvQweqc/uzk5zSOI3H52CYnjCfb5hA==";
      };
    };
    "browserify-cipher-1.0.1" = {
      name = "browserify-cipher";
      packageName = "browserify-cipher";
      version = "1.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/browserify-cipher/-/browserify-cipher-1.0.1.tgz";
        sha512 = "sPhkz0ARKbf4rRQt2hTpAHqn47X3llLkUGn+xEJzLjwY8LRs2p0v7ljvI5EyoRO/mexrNunNECisZs+gw2zz1w==";
      };
    };
    "browserify-des-1.0.2" = {
      name = "browserify-des";
      packageName = "browserify-des";
      version = "1.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/browserify-des/-/browserify-des-1.0.2.tgz";
        sha512 = "BioO1xf3hFwz4kc6iBhI3ieDFompMhrMlnDFC4/0/vd5MokpuAc3R+LYbwTA9A5Yc9pq9UYPqffKpW2ObuwX5A==";
      };
    };
    "browserify-rsa-4.0.1" = {
      name = "browserify-rsa";
      packageName = "browserify-rsa";
      version = "4.0.1";
      src = fetchurl {
        url = "http://registry.npmjs.org/browserify-rsa/-/browserify-rsa-4.0.1.tgz";
        sha1 = "21e0abfaf6f2029cf2fafb133567a701d4135524";
      };
    };
    "browserify-sign-4.0.4" = {
      name = "browserify-sign";
      packageName = "browserify-sign";
      version = "4.0.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/browserify-sign/-/browserify-sign-4.0.4.tgz";
        sha1 = "aa4eb68e5d7b658baa6bf6a57e630cbd7a93d298";
      };
    };
    "browserify-zlib-0.1.4" = {
      name = "browserify-zlib";
      packageName = "browserify-zlib";
      version = "0.1.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/browserify-zlib/-/browserify-zlib-0.1.4.tgz";
        sha1 = "bb35f8a519f600e0fa6b8485241c979d0141fb2d";
      };
    };
    "browserify-zlib-0.2.0" = {
      name = "browserify-zlib";
      packageName = "browserify-zlib";
      version = "0.2.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/browserify-zlib/-/browserify-zlib-0.2.0.tgz";
        sha512 = "Z942RysHXmJrhqk88FmKBVq/v5tqmSkDz7p54G/MGyjMnCFFnC79XWNbg+Vta8W6Wb2qtSZTSxIGkJrRpCFEiA==";
      };
    };
    "browserslist-1.7.7" = {
      name = "browserslist";
      packageName = "browserslist";
      version = "1.7.7";
      src = fetchurl {
        url = "https://registry.npmjs.org/browserslist/-/browserslist-1.7.7.tgz";
        sha1 = "0bd76704258be829b2398bb50e4b62d1a166b0b9";
      };
    };
    "browserslist-3.2.8" = {
      name = "browserslist";
      packageName = "browserslist";
      version = "3.2.8";
      src = fetchurl {
        url = "https://registry.npmjs.org/browserslist/-/browserslist-3.2.8.tgz";
        sha512 = "WHVocJYavUwVgVViC0ORikPHQquXwVh939TaelZ4WDqpWgTX/FsGhl/+P4qBUAGcRvtOgDgC+xftNWWp2RUTAQ==";
      };
    };
    "buffer-4.9.1" = {
      name = "buffer";
      packageName = "buffer";
      version = "4.9.1";
      src = fetchurl {
        url = "http://registry.npmjs.org/buffer/-/buffer-4.9.1.tgz";
        sha1 = "6d1bb601b07a4efced97094132093027c95bc298";
      };
    };
    "buffer-5.2.1" = {
      name = "buffer";
      packageName = "buffer";
      version = "5.2.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/buffer/-/buffer-5.2.1.tgz";
        sha512 = "c+Ko0loDaFfuPWiL02ls9Xd3GO3cPVmUobQ6t3rXNUk304u6hGq+8N/kFi+QEIKhzK3uwolVhLzszmfLmMLnqg==";
      };
    };
    "buffer-alloc-1.2.0" = {
      name = "buffer-alloc";
      packageName = "buffer-alloc";
      version = "1.2.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/buffer-alloc/-/buffer-alloc-1.2.0.tgz";
        sha512 = "CFsHQgjtW1UChdXgbyJGtnm+O/uLQeZdtbDo8mfUgYXCHSM1wgrVxXm6bSyrUuErEb+4sYVGCzASBRot7zyrow==";
      };
    };
    "buffer-alloc-unsafe-1.1.0" = {
      name = "buffer-alloc-unsafe";
      packageName = "buffer-alloc-unsafe";
      version = "1.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/buffer-alloc-unsafe/-/buffer-alloc-unsafe-1.1.0.tgz";
        sha512 = "TEM2iMIEQdJ2yjPJoSIsldnleVaAk1oW3DBVUykyOLsEsFmEc9kn+SFFPz+gl54KQNxlDnAwCXosOS9Okx2xAg==";
      };
    };
    "buffer-crc32-0.2.13" = {
      name = "buffer-crc32";
      packageName = "buffer-crc32";
      version = "0.2.13";
      src = fetchurl {
        url = "https://registry.npmjs.org/buffer-crc32/-/buffer-crc32-0.2.13.tgz";
        sha1 = "0d333e3f00eac50aa1454abd30ef8c2a5d9a7242";
      };
    };
    "buffer-fill-1.0.0" = {
      name = "buffer-fill";
      packageName = "buffer-fill";
      version = "1.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/buffer-fill/-/buffer-fill-1.0.0.tgz";
        sha1 = "f8f78b76789888ef39f205cd637f68e702122b2c";
      };
    };
    "buffer-from-1.1.1" = {
      name = "buffer-from";
      packageName = "buffer-from";
      version = "1.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/buffer-from/-/buffer-from-1.1.1.tgz";
        sha512 = "MQcXEUbCKtEo7bhqEs6560Hyd4XaovZlO/k9V3hjVUF/zwW7KBVdSK4gIt/bzwS9MbR5qob+F5jusZsb0YQK2A==";
      };
    };
    "buffer-indexof-1.1.1" = {
      name = "buffer-indexof";
      packageName = "buffer-indexof";
      version = "1.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/buffer-indexof/-/buffer-indexof-1.1.1.tgz";
        sha512 = "4/rOEg86jivtPTeOUUT61jJO1Ya1TrR/OkqCSZDyq84WJh3LuuiphBYJN+fm5xufIk4XAFcEwte/8WzC8If/1g==";
      };
    };
    "buffer-xor-1.0.3" = {
      name = "buffer-xor";
      packageName = "buffer-xor";
      version = "1.0.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/buffer-xor/-/buffer-xor-1.0.3.tgz";
        sha1 = "26e61ed1422fb70dd42e6e36729ed51d855fe8d9";
      };
    };
    "builtin-modules-1.1.1" = {
      name = "builtin-modules";
      packageName = "builtin-modules";
      version = "1.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/builtin-modules/-/builtin-modules-1.1.1.tgz";
        sha1 = "270f076c5a72c02f5b65a47df94c5fe3a278892f";
      };
    };
    "builtin-status-codes-3.0.0" = {
      name = "builtin-status-codes";
      packageName = "builtin-status-codes";
      version = "3.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/builtin-status-codes/-/builtin-status-codes-3.0.0.tgz";
        sha1 = "85982878e21b98e1c66425e03d0174788f569ee8";
      };
    };
    "bytes-3.0.0" = {
      name = "bytes";
      packageName = "bytes";
      version = "3.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/bytes/-/bytes-3.0.0.tgz";
        sha1 = "d32815404d689699f85a4ea4fa8755dd13a96048";
      };
    };
    "bytewise-1.1.0" = {
      name = "bytewise";
      packageName = "bytewise";
      version = "1.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/bytewise/-/bytewise-1.1.0.tgz";
        sha1 = "1d13cbff717ae7158094aa881b35d081b387253e";
      };
    };
    "bytewise-core-1.2.3" = {
      name = "bytewise-core";
      packageName = "bytewise-core";
      version = "1.2.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/bytewise-core/-/bytewise-core-1.2.3.tgz";
        sha1 = "3fb410c7e91558eb1ab22a82834577aa6bd61d42";
      };
    };
    "cacache-10.0.4" = {
      name = "cacache";
      packageName = "cacache";
      version = "10.0.4";
      src = fetchurl {
        url = "http://registry.npmjs.org/cacache/-/cacache-10.0.4.tgz";
        sha512 = "Dph0MzuH+rTQzGPNT9fAnrPmMmjKfST6trxJeK7NQuHRaVw24VzPRWTmg9MpcwOVQZO0E1FBICUlFeNaKPIfHA==";
      };
    };
    "cache-base-1.0.1" = {
      name = "cache-base";
      packageName = "cache-base";
      version = "1.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/cache-base/-/cache-base-1.0.1.tgz";
        sha512 = "AKcdTnFSWATd5/GCPRxr2ChwIJ85CeyrEyjRHlKxQ56d4XJMGym0uAiKn0xbLOGOl3+yRpOTi484dVCEc5AUzQ==";
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
    "camelcase-1.2.1" = {
      name = "camelcase";
      packageName = "camelcase";
      version = "1.2.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/camelcase/-/camelcase-1.2.1.tgz";
        sha1 = "9bb5304d2e0b56698b2c758b08a3eaa9daa58a39";
      };
    };
    "camelcase-2.1.1" = {
      name = "camelcase";
      packageName = "camelcase";
      version = "2.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/camelcase/-/camelcase-2.1.1.tgz";
        sha1 = "7c1d16d679a1bbe59ca02cacecfb011e201f5a1f";
      };
    };
    "camelcase-3.0.0" = {
      name = "camelcase";
      packageName = "camelcase";
      version = "3.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/camelcase/-/camelcase-3.0.0.tgz";
        sha1 = "32fc4b9fcdaf845fcdf7e73bb97cac2261f0ab0a";
      };
    };
    "camelcase-4.1.0" = {
      name = "camelcase";
      packageName = "camelcase";
      version = "4.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/camelcase/-/camelcase-4.1.0.tgz";
        sha1 = "d545635be1e33c542649c69173e5de6acfae34dd";
      };
    };
    "camelcase-keys-2.1.0" = {
      name = "camelcase-keys";
      packageName = "camelcase-keys";
      version = "2.1.0";
      src = fetchurl {
        url = "http://registry.npmjs.org/camelcase-keys/-/camelcase-keys-2.1.0.tgz";
        sha1 = "308beeaffdf28119051efa1d932213c91b8f92e7";
      };
    };
    "caniuse-api-1.6.1" = {
      name = "caniuse-api";
      packageName = "caniuse-api";
      version = "1.6.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/caniuse-api/-/caniuse-api-1.6.1.tgz";
        sha1 = "b534e7c734c4f81ec5fbe8aca2ad24354b962c6c";
      };
    };
    "caniuse-db-1.0.30000923" = {
      name = "caniuse-db";
      packageName = "caniuse-db";
      version = "1.0.30000923";
      src = fetchurl {
        url = "https://registry.npmjs.org/caniuse-db/-/caniuse-db-1.0.30000923.tgz";
        sha512 = "PlFnZSgXcf/Z1kuNhTRq9vV4FnzizSDHpcgs5b/EY9sN60F3aBpkJwvEsHNeACHZi56/L8Cm3VsONdY1bOus/g==";
      };
    };
    "caniuse-lite-1.0.30000923" = {
      name = "caniuse-lite";
      packageName = "caniuse-lite";
      version = "1.0.30000923";
      src = fetchurl {
        url = "https://registry.npmjs.org/caniuse-lite/-/caniuse-lite-1.0.30000923.tgz";
        sha512 = "j5ur7eeluOFjjPUkydtXP4KFAsmH3XaQNch5tvWSO+dLHYt5PE+VgJZLWtbVOodfWij6m6zas28T4gB/cLYq1w==";
      };
    };
    "caseless-0.12.0" = {
      name = "caseless";
      packageName = "caseless";
      version = "0.12.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/caseless/-/caseless-0.12.0.tgz";
        sha1 = "1b681c21ff84033c826543090689420d187151dc";
      };
    };
    "ccount-1.0.3" = {
      name = "ccount";
      packageName = "ccount";
      version = "1.0.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/ccount/-/ccount-1.0.3.tgz";
        sha512 = "Jt9tIBkRc9POUof7QA/VwWd+58fKkEEfI+/t1/eOlxKM7ZhrczNzMFefge7Ai+39y1pR/pP6cI19guHy3FSLmw==";
      };
    };
    "center-align-0.1.3" = {
      name = "center-align";
      packageName = "center-align";
      version = "0.1.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/center-align/-/center-align-0.1.3.tgz";
        sha1 = "aa0d32629b6ee972200411cbd4461c907bc2b7ad";
      };
    };
    "cfonts-1.2.0" = {
      name = "cfonts";
      packageName = "cfonts";
      version = "1.2.0";
      src = fetchurl {
        url = "http://registry.npmjs.org/cfonts/-/cfonts-1.2.0.tgz";
        sha512 = "gT9tfte2tCN6ZddA531ACPnUMvD6hCXiVHSUVZcCvejvKhsjD2Ph+ot8Vl39hG0CBh/9LvihnXKvtY9RL/UrLg==";
      };
    };
    "chai-4.2.0" = {
      name = "chai";
      packageName = "chai";
      version = "4.2.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/chai/-/chai-4.2.0.tgz";
        sha512 = "XQU3bhBukrOsQCuwZndwGcCVQHyZi53fQ6Ys1Fym7E4olpIqqZZhhoFJoaKVvV17lWQoXYwgWN2nF5crA8J2jw==";
      };
    };
    "chai-nightwatch-0.1.1" = {
      name = "chai-nightwatch";
      packageName = "chai-nightwatch";
      version = "0.1.1";
      src = fetchurl {
        url = "http://registry.npmjs.org/chai-nightwatch/-/chai-nightwatch-0.1.1.tgz";
        sha1 = "1ca56de768d3c0868fe7fc2f4d32c2fe894e6be9";
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
    "character-entities-1.2.2" = {
      name = "character-entities";
      packageName = "character-entities";
      version = "1.2.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/character-entities/-/character-entities-1.2.2.tgz";
        sha512 = "sMoHX6/nBiy3KKfC78dnEalnpn0Az0oSNvqUWYTtYrhRI5iUIYsROU48G+E+kMFQzqXaJ8kHJZ85n7y6/PHgwQ==";
      };
    };
    "character-entities-html4-1.1.2" = {
      name = "character-entities-html4";
      packageName = "character-entities-html4";
      version = "1.1.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/character-entities-html4/-/character-entities-html4-1.1.2.tgz";
        sha512 = "sIrXwyna2+5b0eB9W149izTPJk/KkJTg6mEzDGibwBUkyH1SbDa+nf515Ppdi3MaH35lW0JFJDWeq9Luzes1Iw==";
      };
    };
    "character-entities-legacy-1.1.2" = {
      name = "character-entities-legacy";
      packageName = "character-entities-legacy";
      version = "1.1.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/character-entities-legacy/-/character-entities-legacy-1.1.2.tgz";
        sha512 = "9NB2VbXtXYWdXzqrvAHykE/f0QJxzaKIpZ5QzNZrrgQ7Iyxr2vnfS8fCBNVW9nUEZE0lo57nxKRqnzY/dKrwlA==";
      };
    };
    "character-reference-invalid-1.1.2" = {
      name = "character-reference-invalid";
      packageName = "character-reference-invalid";
      version = "1.1.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/character-reference-invalid/-/character-reference-invalid-1.1.2.tgz";
        sha512 = "7I/xceXfKyUJmSAn/jw8ve/9DyOP7XxufNYLI9Px7CmsKgEUaZLUTax6nZxGQtaoiZCjpu6cHPj20xC/vqRReQ==";
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
    "charwise-3.0.1" = {
      name = "charwise";
      packageName = "charwise";
      version = "3.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/charwise/-/charwise-3.0.1.tgz";
        sha512 = "RcdumNsM6fJZ5HHbYunqj2bpurVRGsXour3OR+SlLEHFhG6ALm54i6Osnh+OvO7kEoSBzwExpblYFH8zKQiEPw==";
      };
    };
    "check-error-1.0.2" = {
      name = "check-error";
      packageName = "check-error";
      version = "1.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/check-error/-/check-error-1.0.2.tgz";
        sha1 = "574d312edd88bb5dd8912e9286dd6c0aed4aac82";
      };
    };
    "chloride-2.2.10" = {
      name = "chloride";
      packageName = "chloride";
      version = "2.2.10";
      src = fetchurl {
        url = "https://registry.npmjs.org/chloride/-/chloride-2.2.10.tgz";
        sha512 = "CbU1ISGiB2JBV6PDXx7hkl8D94d2TPD1BANUMFbr8rZYKJi8De2d3Hu2XDIOLAhXf+8yhoFOdjtLG6fxz3QByQ==";
      };
    };
    "chloride-test-1.2.2" = {
      name = "chloride-test";
      packageName = "chloride-test";
      version = "1.2.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/chloride-test/-/chloride-test-1.2.2.tgz";
        sha1 = "178686a85e9278045112e96e8c791793f9a10aea";
      };
    };
    "chokidar-1.7.0" = {
      name = "chokidar";
      packageName = "chokidar";
      version = "1.7.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/chokidar/-/chokidar-1.7.0.tgz";
        sha1 = "798e689778151c8076b4b360e5edd28cda2bb468";
      };
    };
    "chokidar-2.0.4" = {
      name = "chokidar";
      packageName = "chokidar";
      version = "2.0.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/chokidar/-/chokidar-2.0.4.tgz";
        sha512 = "z9n7yt9rOvIJrMhvDtDictKrkFHeihkNl6uWMmZlmL6tJtX9Cs+87oK+teBx+JIgzvbX3yZHT3eF8vpbDxHJXQ==";
      };
    };
    "chownr-1.1.1" = {
      name = "chownr";
      packageName = "chownr";
      version = "1.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/chownr/-/chownr-1.1.1.tgz";
        sha512 = "j38EvO5+LHX84jlo6h4UzmOwi0UgW61WRyPtJz4qaadK5eY3BTS5TY/S1Stc3Uk2lIM6TPevAlULiEJwie860g==";
      };
    };
    "chrome-native-messaging-0.2.0" = {
      name = "chrome-native-messaging";
      packageName = "chrome-native-messaging";
      version = "0.2.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/chrome-native-messaging/-/chrome-native-messaging-0.2.0.tgz";
        sha1 = "c142cde524bd1b1854e14f57e078a396a6da3826";
      };
    };
    "cipher-base-1.0.4" = {
      name = "cipher-base";
      packageName = "cipher-base";
      version = "1.0.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/cipher-base/-/cipher-base-1.0.4.tgz";
        sha512 = "Kkht5ye6ZGmwv40uUDZztayT2ThLQGfnj/T71N/XzeZeo3nf8foyW7zGTsPYkEya3m5f3cAypH+qe7YOrM1U2Q==";
      };
    };
    "clap-1.2.3" = {
      name = "clap";
      packageName = "clap";
      version = "1.2.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/clap/-/clap-1.2.3.tgz";
        sha512 = "4CoL/A3hf90V3VIEjeuhSvlGFEHKzOz+Wfc2IVZc+FaUgU0ZQafJTP49fvnULipOPcAfqhyI2duwQyns6xqjYA==";
      };
    };
    "class-utils-0.3.6" = {
      name = "class-utils";
      packageName = "class-utils";
      version = "0.3.6";
      src = fetchurl {
        url = "https://registry.npmjs.org/class-utils/-/class-utils-0.3.6.tgz";
        sha512 = "qOhPa/Fj7s6TY8H8esGu5QNpMMQxz79h+urzrNYN6mn+9BnxlDGf5QZ+XeCDsxSjPqsSR56XOZOJmpeurnLMeg==";
      };
    };
    "clean-css-4.2.1" = {
      name = "clean-css";
      packageName = "clean-css";
      version = "4.2.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/clean-css/-/clean-css-4.2.1.tgz";
        sha512 = "4ZxI6dy4lrY6FHzfiy1aEOXgu4LIsW2MhwG0VBKdcoGoH/XLFgaHSdLTGr4O8Be6A8r3MOphEiI8Gc1n0ecf3g==";
      };
    };
    "cli-cursor-1.0.2" = {
      name = "cli-cursor";
      packageName = "cli-cursor";
      version = "1.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/cli-cursor/-/cli-cursor-1.0.2.tgz";
        sha1 = "64da3f7d56a54412e59794bd62dc35295e8f2987";
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
    "cliui-2.1.0" = {
      name = "cliui";
      packageName = "cliui";
      version = "2.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/cliui/-/cliui-2.1.0.tgz";
        sha1 = "4b475760ff80264c762c3a1719032e91c7fea0d1";
      };
    };
    "cliui-3.2.0" = {
      name = "cliui";
      packageName = "cliui";
      version = "3.2.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/cliui/-/cliui-3.2.0.tgz";
        sha1 = "120601537a916d29940f934da3b48d585a39213d";
      };
    };
    "clone-1.0.4" = {
      name = "clone";
      packageName = "clone";
      version = "1.0.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/clone/-/clone-1.0.4.tgz";
        sha1 = "da309cc263df15994c688ca902179ca3c7cd7c7e";
      };
    };
    "clone-deep-2.0.2" = {
      name = "clone-deep";
      packageName = "clone-deep";
      version = "2.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/clone-deep/-/clone-deep-2.0.2.tgz";
        sha512 = "SZegPTKjCgpQH63E+eN6mVEEPdQBOUzjyJm5Pora4lrwWRFS8I0QAxV/KD6vV/i0WuijHZWQC1fMsPEdxfdVCQ==";
      };
    };
    "co-3.0.6" = {
      name = "co";
      packageName = "co";
      version = "3.0.6";
      src = fetchurl {
        url = "https://registry.npmjs.org/co/-/co-3.0.6.tgz";
        sha1 = "1445f226c5eb956138e68c9ac30167ea7d2e6bda";
      };
    };
    "co-3.1.0" = {
      name = "co";
      packageName = "co";
      version = "3.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/co/-/co-3.1.0.tgz";
        sha1 = "4ea54ea5a08938153185e15210c68d9092bc1b78";
      };
    };
    "co-4.6.0" = {
      name = "co";
      packageName = "co";
      version = "4.6.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/co/-/co-4.6.0.tgz";
        sha1 = "6ea6bdf3d853ae54ccb8e47bfa0bf3f9031fb184";
      };
    };
    "coa-1.0.4" = {
      name = "coa";
      packageName = "coa";
      version = "1.0.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/coa/-/coa-1.0.4.tgz";
        sha1 = "a9ef153660d6a86a8bdec0289a5c684d217432fd";
      };
    };
    "code-point-at-1.1.0" = {
      name = "code-point-at";
      packageName = "code-point-at";
      version = "1.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/code-point-at/-/code-point-at-1.1.0.tgz";
        sha1 = "0d070b4d043a5bea33a2f1a40e2edb3d9a4ccf77";
      };
    };
    "collapse-white-space-1.0.4" = {
      name = "collapse-white-space";
      packageName = "collapse-white-space";
      version = "1.0.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/collapse-white-space/-/collapse-white-space-1.0.4.tgz";
        sha512 = "YfQ1tAUZm561vpYD+5eyWN8+UsceQbSrqqlc/6zDY2gtAE+uZLSdkkovhnGpmCThsvKBFakq4EdY/FF93E8XIw==";
      };
    };
    "collection-visit-1.0.0" = {
      name = "collection-visit";
      packageName = "collection-visit";
      version = "1.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/collection-visit/-/collection-visit-1.0.0.tgz";
        sha1 = "4bc0373c164bc3291b4d368c829cf1a80a59dca0";
      };
    };
    "color-0.11.4" = {
      name = "color";
      packageName = "color";
      version = "0.11.4";
      src = fetchurl {
        url = "http://registry.npmjs.org/color/-/color-0.11.4.tgz";
        sha1 = "6d7b5c74fb65e841cd48792ad1ed5e07b904d764";
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
    "color-string-0.3.0" = {
      name = "color-string";
      packageName = "color-string";
      version = "0.3.0";
      src = fetchurl {
        url = "http://registry.npmjs.org/color-string/-/color-string-0.3.0.tgz";
        sha1 = "27d46fb67025c5c2fa25993bfbf579e47841b991";
      };
    };
    "colormin-1.1.2" = {
      name = "colormin";
      packageName = "colormin";
      version = "1.1.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/colormin/-/colormin-1.1.2.tgz";
        sha1 = "ea2f7420a72b96881a38aae59ec124a6f7298133";
      };
    };
    "colors-0.5.1" = {
      name = "colors";
      packageName = "colors";
      version = "0.5.1";
      src = fetchurl {
        url = "http://registry.npmjs.org/colors/-/colors-0.5.1.tgz";
        sha1 = "7d0023eaeb154e8ee9fce75dcb923d0ed1667774";
      };
    };
    "colors-1.0.3" = {
      name = "colors";
      packageName = "colors";
      version = "1.0.3";
      src = fetchurl {
        url = "http://registry.npmjs.org/colors/-/colors-1.0.3.tgz";
        sha1 = "0433f44d809680fdeb60ed260f1b0c262e82a40b";
      };
    };
    "colors-1.1.2" = {
      name = "colors";
      packageName = "colors";
      version = "1.1.2";
      src = fetchurl {
        url = "http://registry.npmjs.org/colors/-/colors-1.1.2.tgz";
        sha1 = "168a4701756b6a7f51a12ce0c97bfa28c084ed63";
      };
    };
    "colors-1.3.3" = {
      name = "colors";
      packageName = "colors";
      version = "1.3.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/colors/-/colors-1.3.3.tgz";
        sha512 = "mmGt/1pZqYRjMxB1axhTo16/snVZ5krrKkcmMeVKxzECMMXoCgnvTPp10QgHfcbQZw8Dq2jMNG6je4JlWU0gWg==";
      };
    };
    "combined-stream-1.0.7" = {
      name = "combined-stream";
      packageName = "combined-stream";
      version = "1.0.7";
      src = fetchurl {
        url = "https://registry.npmjs.org/combined-stream/-/combined-stream-1.0.7.tgz";
        sha512 = "brWl9y6vOB1xYPZcpZde3N9zDByXTosAeMDo4p1wzo6UMOX4vumB+TP1RZ76sfE6Md68Q0NJSrE/gbezd4Ul+w==";
      };
    };
    "commander-2.17.1" = {
      name = "commander";
      packageName = "commander";
      version = "2.17.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/commander/-/commander-2.17.1.tgz";
        sha512 = "wPMUt6FnH2yzG95SA6mzjQOEKUU3aLaDEmzs1ti+1E9h+CsrZghRlqEM/EJ4KscsQVG8uNN4uVreUeT8+drlgg==";
      };
    };
    "commander-2.19.0" = {
      name = "commander";
      packageName = "commander";
      version = "2.19.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/commander/-/commander-2.19.0.tgz";
        sha512 = "6tvAOO+D6OENvRAh524Dh9jcfKTYDQAqvqezbCW82xj5X0pSrcpxtvRKHLG0yBY6SD7PSDrJaj+0AiOcKVd1Xg==";
      };
    };
    "commander-2.9.0" = {
      name = "commander";
      packageName = "commander";
      version = "2.9.0";
      src = fetchurl {
        url = "http://registry.npmjs.org/commander/-/commander-2.9.0.tgz";
        sha1 = "9c99094176e12240cb22d6c5146098400fe0f7d4";
      };
    };
    "commondir-1.0.1" = {
      name = "commondir";
      packageName = "commondir";
      version = "1.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/commondir/-/commondir-1.0.1.tgz";
        sha1 = "ddd800da0c66127393cca5950ea968a3aaf1253b";
      };
    };
    "compare-at-paths-1.0.0" = {
      name = "compare-at-paths";
      packageName = "compare-at-paths";
      version = "1.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/compare-at-paths/-/compare-at-paths-1.0.0.tgz";
        sha512 = "Ke1ejo/RZ+Hzku4gcW34uPMOR4Cpq87MAotELgV9mwiAzDN726cu+eWo0zWg1vRIfyf6yK5bW9uIW+c/SksQ5w==";
      };
    };
    "component-emitter-1.2.1" = {
      name = "component-emitter";
      packageName = "component-emitter";
      version = "1.2.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/component-emitter/-/component-emitter-1.2.1.tgz";
        sha1 = "137918d6d78283f7df7a6b7c5a63e140e69425e6";
      };
    };
    "compress-commons-1.2.2" = {
      name = "compress-commons";
      packageName = "compress-commons";
      version = "1.2.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/compress-commons/-/compress-commons-1.2.2.tgz";
        sha1 = "524a9f10903f3a813389b0225d27c48bb751890f";
      };
    };
    "compressible-2.0.15" = {
      name = "compressible";
      packageName = "compressible";
      version = "2.0.15";
      src = fetchurl {
        url = "https://registry.npmjs.org/compressible/-/compressible-2.0.15.tgz";
        sha512 = "4aE67DL33dSW9gw4CI2H/yTxqHLNcxp0yS6jB+4h+wr3e43+1z7vm0HU9qXOH8j+qjKuL8+UtkOxYQSMq60Ylw==";
      };
    };
    "compression-1.7.3" = {
      name = "compression";
      packageName = "compression";
      version = "1.7.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/compression/-/compression-1.7.3.tgz";
        sha512 = "HSjyBG5N1Nnz7tF2+O7A9XUhyjru71/fwgNb7oIsEVHR0WShfs2tIS/EySLgiTe98aOK18YDlMXpzjCXY/n9mg==";
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
    "concat-stream-1.6.2" = {
      name = "concat-stream";
      packageName = "concat-stream";
      version = "1.6.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/concat-stream/-/concat-stream-1.6.2.tgz";
        sha512 = "27HBghJxjiZtIk3Ycvn/4kbJk/1uZuJFfuPEns6LaEvpvG1f0hTea8lilrouyo9mVc2GWdcEZ8OLoGmSADlrCw==";
      };
    };
    "connect-history-api-fallback-1.5.0" = {
      name = "connect-history-api-fallback";
      packageName = "connect-history-api-fallback";
      version = "1.5.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/connect-history-api-fallback/-/connect-history-api-fallback-1.5.0.tgz";
        sha1 = "b06873934bc5e344fef611a196a6faae0aee015a";
      };
    };
    "console-browserify-1.1.0" = {
      name = "console-browserify";
      packageName = "console-browserify";
      version = "1.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/console-browserify/-/console-browserify-1.1.0.tgz";
        sha1 = "f0241c45730a9fc6323b206dbf38edc741d0bb10";
      };
    };
    "console-control-strings-1.1.0" = {
      name = "console-control-strings";
      packageName = "console-control-strings";
      version = "1.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/console-control-strings/-/console-control-strings-1.1.0.tgz";
        sha1 = "3d7cf4464db6446ea644bf4b39507f9851008e8e";
      };
    };
    "consolidate-0.14.5" = {
      name = "consolidate";
      packageName = "consolidate";
      version = "0.14.5";
      src = fetchurl {
        url = "https://registry.npmjs.org/consolidate/-/consolidate-0.14.5.tgz";
        sha1 = "5a25047bc76f73072667c8cb52c989888f494c63";
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
    "constants-browserify-1.0.0" = {
      name = "constants-browserify";
      packageName = "constants-browserify";
      version = "1.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/constants-browserify/-/constants-browserify-1.0.0.tgz";
        sha1 = "c20b96d8c617748aaf1c16021760cd27fcb8cb75";
      };
    };
    "cont-1.0.3" = {
      name = "cont";
      packageName = "cont";
      version = "1.0.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/cont/-/cont-1.0.3.tgz";
        sha1 = "6874f1e935fca99d048caeaaad9a0aeb020bcce0";
      };
    };
    "content-disposition-0.5.2" = {
      name = "content-disposition";
      packageName = "content-disposition";
      version = "0.5.2";
      src = fetchurl {
        url = "http://registry.npmjs.org/content-disposition/-/content-disposition-0.5.2.tgz";
        sha1 = "0cf68bb9ddf5f2be7961c3a85178cb85dba78cb4";
      };
    };
    "content-type-1.0.4" = {
      name = "content-type";
      packageName = "content-type";
      version = "1.0.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/content-type/-/content-type-1.0.4.tgz";
        sha512 = "hIP3EEPs8tB9AT1L+NUqtwOAps4mk2Zob89MWXMHjHWg9milF/j4osnnQLXBCBFBk/tvIG/tUc9mOUJiPBhPXA==";
      };
    };
    "continuable-1.1.8" = {
      name = "continuable";
      packageName = "continuable";
      version = "1.1.8";
      src = fetchurl {
        url = "https://registry.npmjs.org/continuable/-/continuable-1.1.8.tgz";
        sha1 = "dc877b474160870ae3bcde87336268ebe50597d5";
      };
    };
    "continuable-1.2.0" = {
      name = "continuable";
      packageName = "continuable";
      version = "1.2.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/continuable/-/continuable-1.2.0.tgz";
        sha1 = "08277468d41136200074ccf87294308d169f25b6";
      };
    };
    "continuable-hash-0.1.4" = {
      name = "continuable-hash";
      packageName = "continuable-hash";
      version = "0.1.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/continuable-hash/-/continuable-hash-0.1.4.tgz";
        sha1 = "81c74d41771d8c92783e1e00e5f11b34d6dfc78c";
      };
    };
    "continuable-list-0.1.6" = {
      name = "continuable-list";
      packageName = "continuable-list";
      version = "0.1.6";
      src = fetchurl {
        url = "https://registry.npmjs.org/continuable-list/-/continuable-list-0.1.6.tgz";
        sha1 = "87cf06ec580716e10dff95fb0b84c5f0e8acac5f";
      };
    };
    "continuable-para-1.2.0" = {
      name = "continuable-para";
      packageName = "continuable-para";
      version = "1.2.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/continuable-para/-/continuable-para-1.2.0.tgz";
        sha1 = "445510f649459dd0fc35c872015146122731c583";
      };
    };
    "continuable-series-1.2.0" = {
      name = "continuable-series";
      packageName = "continuable-series";
      version = "1.2.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/continuable-series/-/continuable-series-1.2.0.tgz";
        sha1 = "3243397ae93a71d655b3026834a51590b958b9e8";
      };
    };
    "convert-source-map-1.6.0" = {
      name = "convert-source-map";
      packageName = "convert-source-map";
      version = "1.6.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/convert-source-map/-/convert-source-map-1.6.0.tgz";
        sha512 = "eFu7XigvxdZ1ETfbgPBohgyQ/Z++C0eEhTor0qRwBw9unw+L0/6V8wkSuGgzdThkiS5lSpdptOQPD8Ak40a+7A==";
      };
    };
    "cookie-0.3.1" = {
      name = "cookie";
      packageName = "cookie";
      version = "0.3.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/cookie/-/cookie-0.3.1.tgz";
        sha1 = "e7e0a1f9ef43b4c8ba925c5c5a96e806d16873bb";
      };
    };
    "cookie-signature-1.0.6" = {
      name = "cookie-signature";
      packageName = "cookie-signature";
      version = "1.0.6";
      src = fetchurl {
        url = "https://registry.npmjs.org/cookie-signature/-/cookie-signature-1.0.6.tgz";
        sha1 = "e303a882b342cc3ee8ca513a79999734dab3ae2c";
      };
    };
    "copy-concurrently-1.0.5" = {
      name = "copy-concurrently";
      packageName = "copy-concurrently";
      version = "1.0.5";
      src = fetchurl {
        url = "https://registry.npmjs.org/copy-concurrently/-/copy-concurrently-1.0.5.tgz";
        sha512 = "f2domd9fsVDFtaFcbaRZuYXwtdmnzqbADSwhSWYxYB/Q8zsdUUFMXVRwXGDMWmbEzAn1kdRrtI1T/KTFOL4X2A==";
      };
    };
    "copy-descriptor-0.1.1" = {
      name = "copy-descriptor";
      packageName = "copy-descriptor";
      version = "0.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/copy-descriptor/-/copy-descriptor-0.1.1.tgz";
        sha1 = "676f6eb3c39997c2ee1ac3a924fd6124748f578d";
      };
    };
    "copy-webpack-plugin-4.6.0" = {
      name = "copy-webpack-plugin";
      packageName = "copy-webpack-plugin";
      version = "4.6.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/copy-webpack-plugin/-/copy-webpack-plugin-4.6.0.tgz";
        sha512 = "Y+SQCF+0NoWQryez2zXn5J5knmr9z/9qSQt7fbL78u83rxmigOy8X5+BFn8CFSuX+nKT8gpYwJX68ekqtQt6ZA==";
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
    "core-util-is-1.0.2" = {
      name = "core-util-is";
      packageName = "core-util-is";
      version = "1.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/core-util-is/-/core-util-is-1.0.2.tgz";
        sha1 = "b5fd54220aa2bc5ab57aab7140c940754503c1a7";
      };
    };
    "cosmiconfig-2.2.2" = {
      name = "cosmiconfig";
      packageName = "cosmiconfig";
      version = "2.2.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/cosmiconfig/-/cosmiconfig-2.2.2.tgz";
        sha512 = "GiNXLwAFPYHy25XmTPpafYvn3CLAkJ8FLsscq78MQd1Kh0OU6Yzhn4eV2MVF4G9WEQZoWEGltatdR+ntGPMl5A==";
      };
    };
    "crc-3.8.0" = {
      name = "crc";
      packageName = "crc";
      version = "3.8.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/crc/-/crc-3.8.0.tgz";
        sha512 = "iX3mfgcTMIq3ZKLIsVFAbv7+Mc10kxabAGQb8HvjA1o3T1PIYprbakQ65d3I+2HGHt6nSKkM9PYjgoJO2KcFBQ==";
      };
    };
    "crc32-stream-2.0.0" = {
      name = "crc32-stream";
      packageName = "crc32-stream";
      version = "2.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/crc32-stream/-/crc32-stream-2.0.0.tgz";
        sha1 = "e3cdd3b4df3168dd74e3de3fbbcb7b297fe908f4";
      };
    };
    "create-ecdh-4.0.3" = {
      name = "create-ecdh";
      packageName = "create-ecdh";
      version = "4.0.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/create-ecdh/-/create-ecdh-4.0.3.tgz";
        sha512 = "GbEHQPMOswGpKXM9kCWVrremUcBmjteUaQ01T9rkKCPDXfUHX0IoP9LpHYo2NPFampa4e+/pFDc3jQdxrxQLaw==";
      };
    };
    "create-hash-1.2.0" = {
      name = "create-hash";
      packageName = "create-hash";
      version = "1.2.0";
      src = fetchurl {
        url = "http://registry.npmjs.org/create-hash/-/create-hash-1.2.0.tgz";
        sha512 = "z00bCGNHDG8mHAkP7CtT1qVu+bFQUPjYq/4Iv3C3kWjTFV10zIjfSoeqXo9Asws8gwSHDGj/hl2u4OGIjapeCg==";
      };
    };
    "create-hmac-1.1.7" = {
      name = "create-hmac";
      packageName = "create-hmac";
      version = "1.1.7";
      src = fetchurl {
        url = "http://registry.npmjs.org/create-hmac/-/create-hmac-1.1.7.tgz";
        sha512 = "MJG9liiZ+ogc4TzUwuvbER1JRdgvUFSB5+VR/g5h82fGaIRWMWddtKBHi7/sVhfjQZ6SehlyhvQYrcYkaUIpLg==";
      };
    };
    "cross-env-5.2.0" = {
      name = "cross-env";
      packageName = "cross-env";
      version = "5.2.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/cross-env/-/cross-env-5.2.0.tgz";
        sha512 = "jtdNFfFW1hB7sMhr/H6rW1Z45LFqyI431m3qU6bFXcQ3Eh7LtBuG3h74o7ohHZ3crrRkkqHlo4jYHFPcjroANg==";
      };
    };
    "cross-spawn-3.0.1" = {
      name = "cross-spawn";
      packageName = "cross-spawn";
      version = "3.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/cross-spawn/-/cross-spawn-3.0.1.tgz";
        sha1 = "1256037ecb9f0c5f79e3d6ef135e30770184b982";
      };
    };
    "cross-spawn-4.0.2" = {
      name = "cross-spawn";
      packageName = "cross-spawn";
      version = "4.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/cross-spawn/-/cross-spawn-4.0.2.tgz";
        sha1 = "7b9247621c23adfdd3856004a823cbe397424d41";
      };
    };
    "cross-spawn-5.1.0" = {
      name = "cross-spawn";
      packageName = "cross-spawn";
      version = "5.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/cross-spawn/-/cross-spawn-5.1.0.tgz";
        sha1 = "e8bd0efee58fcff6f8f94510a0a554bbfa235449";
      };
    };
    "cross-spawn-6.0.5" = {
      name = "cross-spawn";
      packageName = "cross-spawn";
      version = "6.0.5";
      src = fetchurl {
        url = "https://registry.npmjs.org/cross-spawn/-/cross-spawn-6.0.5.tgz";
        sha512 = "eTVLrBSt7fjbDygz805pMnstIs2VTBNkRm0qxZd+M7A5XDdxVRWO5MxGBXZhjY4cqLYLdtrGqRf8mBPmzwSpWQ==";
      };
    };
    "crypto-browserify-3.12.0" = {
      name = "crypto-browserify";
      packageName = "crypto-browserify";
      version = "3.12.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/crypto-browserify/-/crypto-browserify-3.12.0.tgz";
        sha512 = "fz4spIh+znjO2VjL+IdhEpRJ3YN6sMzITSBijk6FK2UvTqruSQW+/cCZTSNsMiZNvUeq0CqurF+dAbyiGOY6Wg==";
      };
    };
    "css-2.2.4" = {
      name = "css";
      packageName = "css";
      version = "2.2.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/css/-/css-2.2.4.tgz";
        sha512 = "oUnjmWpy0niI3x/mPL8dVEI1l7MnG3+HHyRPHf+YFSbK+svOhXpmSOcDURUh2aOCgl2grzrOPt1nHLuCVFULLw==";
      };
    };
    "css-color-names-0.0.4" = {
      name = "css-color-names";
      packageName = "css-color-names";
      version = "0.0.4";
      src = fetchurl {
        url = "http://registry.npmjs.org/css-color-names/-/css-color-names-0.0.4.tgz";
        sha1 = "808adc2e79cf84738069b646cb20ec27beb629e0";
      };
    };
    "css-loader-0.28.11" = {
      name = "css-loader";
      packageName = "css-loader";
      version = "0.28.11";
      src = fetchurl {
        url = "http://registry.npmjs.org/css-loader/-/css-loader-0.28.11.tgz";
        sha512 = "wovHgjAx8ZIMGSL8pTys7edA1ClmzxHeY6n/d97gg5odgsxEgKjULPR0viqyC+FWMCL9sfqoC/QCUBo62tLvPg==";
      };
    };
    "css-parse-2.0.0" = {
      name = "css-parse";
      packageName = "css-parse";
      version = "2.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/css-parse/-/css-parse-2.0.0.tgz";
        sha1 = "a468ee667c16d81ccf05c58c38d2a97c780dbfd4";
      };
    };
    "css-select-1.2.0" = {
      name = "css-select";
      packageName = "css-select";
      version = "1.2.0";
      src = fetchurl {
        url = "http://registry.npmjs.org/css-select/-/css-select-1.2.0.tgz";
        sha1 = "2b3a110539c5355f1cd8d314623e870b121ec858";
      };
    };
    "css-selector-tokenizer-0.7.1" = {
      name = "css-selector-tokenizer";
      packageName = "css-selector-tokenizer";
      version = "0.7.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/css-selector-tokenizer/-/css-selector-tokenizer-0.7.1.tgz";
        sha512 = "xYL0AMZJ4gFzJQsHUKa5jiWWi2vH77WVNg7JYRyewwj6oPh4yb/y6Y9ZCw9dsj/9UauMhtuxR+ogQd//EdEVNA==";
      };
    };
    "css-value-0.0.1" = {
      name = "css-value";
      packageName = "css-value";
      version = "0.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/css-value/-/css-value-0.0.1.tgz";
        sha1 = "5efd6c2eea5ea1fd6b6ac57ec0427b18452424ea";
      };
    };
    "css-what-2.1.2" = {
      name = "css-what";
      packageName = "css-what";
      version = "2.1.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/css-what/-/css-what-2.1.2.tgz";
        sha512 = "wan8dMWQ0GUeF7DGEPVjhHemVW/vy6xUYmFzRY8RYqgA0JtXC9rJmbScBjqSu6dg9q0lwPQy6ZAmJVr3PPTvqQ==";
      };
    };
    "cssesc-0.1.0" = {
      name = "cssesc";
      packageName = "cssesc";
      version = "0.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/cssesc/-/cssesc-0.1.0.tgz";
        sha1 = "c814903e45623371a0477b40109aaafbeeaddbb4";
      };
    };
    "cssnano-3.10.0" = {
      name = "cssnano";
      packageName = "cssnano";
      version = "3.10.0";
      src = fetchurl {
        url = "http://registry.npmjs.org/cssnano/-/cssnano-3.10.0.tgz";
        sha1 = "4f38f6cea2b9b17fa01490f23f1dc68ea65c1c38";
      };
    };
    "csso-2.3.2" = {
      name = "csso";
      packageName = "csso";
      version = "2.3.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/csso/-/csso-2.3.2.tgz";
        sha1 = "ddd52c587033f49e94b71fc55569f252e8ff5f85";
      };
    };
    "currently-unhandled-0.4.1" = {
      name = "currently-unhandled";
      packageName = "currently-unhandled";
      version = "0.4.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/currently-unhandled/-/currently-unhandled-0.4.1.tgz";
        sha1 = "988df33feab191ef799a61369dd76c17adf957ea";
      };
    };
    "cycle-1.0.3" = {
      name = "cycle";
      packageName = "cycle";
      version = "1.0.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/cycle/-/cycle-1.0.3.tgz";
        sha1 = "21e80b2be8580f98b468f379430662b046c34ad2";
      };
    };
    "cyclist-0.2.2" = {
      name = "cyclist";
      packageName = "cyclist";
      version = "0.2.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/cyclist/-/cyclist-0.2.2.tgz";
        sha1 = "1b33792e11e914a2fd6d6ed6447464444e5fa640";
      };
    };
    "d-1.0.0" = {
      name = "d";
      packageName = "d";
      version = "1.0.0";
      src = fetchurl {
        url = "http://registry.npmjs.org/d/-/d-1.0.0.tgz";
        sha1 = "754bb5bfe55451da69a58b94d45f4c5b0462d58f";
      };
    };
    "d3-5.7.0" = {
      name = "d3";
      packageName = "d3";
      version = "5.7.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/d3/-/d3-5.7.0.tgz";
        sha512 = "8KEIfx+dFm8PlbJN9PI0suazrZ41QcaAufsKE9PRcqYPWLngHIyWJZX96n6IQKePGgeSu0l7rtlueSSNq8Zc3g==";
      };
    };
    "d3-array-1.2.4" = {
      name = "d3-array";
      packageName = "d3-array";
      version = "1.2.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/d3-array/-/d3-array-1.2.4.tgz";
        sha512 = "KHW6M86R+FUPYGb3R5XiYjXPq7VzwxZ22buHhAEVG5ztoEcZZMLov530mmccaqA1GghZArjQV46fuc8kUqhhHw==";
      };
    };
    "d3-axis-1.0.12" = {
      name = "d3-axis";
      packageName = "d3-axis";
      version = "1.0.12";
      src = fetchurl {
        url = "https://registry.npmjs.org/d3-axis/-/d3-axis-1.0.12.tgz";
        sha512 = "ejINPfPSNdGFKEOAtnBtdkpr24c4d4jsei6Lg98mxf424ivoDP2956/5HDpIAtmHo85lqT4pruy+zEgvRUBqaQ==";
      };
    };
    "d3-brush-1.0.6" = {
      name = "d3-brush";
      packageName = "d3-brush";
      version = "1.0.6";
      src = fetchurl {
        url = "https://registry.npmjs.org/d3-brush/-/d3-brush-1.0.6.tgz";
        sha512 = "lGSiF5SoSqO5/mYGD5FAeGKKS62JdA1EV7HPrU2b5rTX4qEJJtpjaGLJngjnkewQy7UnGstnFd3168wpf5z76w==";
      };
    };
    "d3-chord-1.0.6" = {
      name = "d3-chord";
      packageName = "d3-chord";
      version = "1.0.6";
      src = fetchurl {
        url = "https://registry.npmjs.org/d3-chord/-/d3-chord-1.0.6.tgz";
        sha512 = "JXA2Dro1Fxw9rJe33Uv+Ckr5IrAa74TlfDEhE/jfLOaXegMQFQTAgAw9WnZL8+HxVBRXaRGCkrNU7pJeylRIuA==";
      };
    };
    "d3-collection-1.0.7" = {
      name = "d3-collection";
      packageName = "d3-collection";
      version = "1.0.7";
      src = fetchurl {
        url = "https://registry.npmjs.org/d3-collection/-/d3-collection-1.0.7.tgz";
        sha512 = "ii0/r5f4sjKNTfh84Di+DpztYwqKhEyUlKoPrzUFfeSkWxjW49xU2QzO9qrPrNkpdI0XJkfzvmTu8V2Zylln6A==";
      };
    };
    "d3-color-1.2.3" = {
      name = "d3-color";
      packageName = "d3-color";
      version = "1.2.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/d3-color/-/d3-color-1.2.3.tgz";
        sha512 = "x37qq3ChOTLd26hnps36lexMRhNXEtVxZ4B25rL0DVdDsGQIJGB18S7y9XDwlDD6MD/ZBzITCf4JjGMM10TZkw==";
      };
    };
    "d3-contour-1.3.2" = {
      name = "d3-contour";
      packageName = "d3-contour";
      version = "1.3.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/d3-contour/-/d3-contour-1.3.2.tgz";
        sha512 = "hoPp4K/rJCu0ladiH6zmJUEz6+u3lgR+GSm/QdM2BBvDraU39Vr7YdDCicJcxP1z8i9B/2dJLgDC1NcvlF8WCg==";
      };
    };
    "d3-dispatch-1.0.5" = {
      name = "d3-dispatch";
      packageName = "d3-dispatch";
      version = "1.0.5";
      src = fetchurl {
        url = "https://registry.npmjs.org/d3-dispatch/-/d3-dispatch-1.0.5.tgz";
        sha512 = "vwKx+lAqB1UuCeklr6Jh1bvC4SZgbSqbkGBLClItFBIYH4vqDJCA7qfoy14lXmJdnBOdxndAMxjCbImJYW7e6g==";
      };
    };
    "d3-drag-1.2.3" = {
      name = "d3-drag";
      packageName = "d3-drag";
      version = "1.2.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/d3-drag/-/d3-drag-1.2.3.tgz";
        sha512 = "8S3HWCAg+ilzjJsNtWW1Mutl74Nmzhb9yU6igspilaJzeZVFktmY6oO9xOh5TDk+BM2KrNFjttZNoJJmDnkjkg==";
      };
    };
    "d3-dsv-1.0.10" = {
      name = "d3-dsv";
      packageName = "d3-dsv";
      version = "1.0.10";
      src = fetchurl {
        url = "https://registry.npmjs.org/d3-dsv/-/d3-dsv-1.0.10.tgz";
        sha512 = "vqklfpxmtO2ZER3fq/B33R/BIz3A1PV0FaZRuFM8w6jLo7sUX1BZDh73fPlr0s327rzq4H6EN1q9U+eCBCSN8g==";
      };
    };
    "d3-ease-1.0.5" = {
      name = "d3-ease";
      packageName = "d3-ease";
      version = "1.0.5";
      src = fetchurl {
        url = "https://registry.npmjs.org/d3-ease/-/d3-ease-1.0.5.tgz";
        sha512 = "Ct1O//ly5y5lFM9YTdu+ygq7LleSgSE4oj7vUt9tPLHUi8VCV7QoizGpdWRWAwCO9LdYzIrQDg97+hGVdsSGPQ==";
      };
    };
    "d3-fetch-1.1.2" = {
      name = "d3-fetch";
      packageName = "d3-fetch";
      version = "1.1.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/d3-fetch/-/d3-fetch-1.1.2.tgz";
        sha512 = "S2loaQCV/ZeyTyIF2oP8D1K9Z4QizUzW7cWeAOAS4U88qOt3Ucf6GsmgthuYSdyB2HyEm4CeGvkQxWsmInsIVA==";
      };
    };
    "d3-force-1.1.2" = {
      name = "d3-force";
      packageName = "d3-force";
      version = "1.1.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/d3-force/-/d3-force-1.1.2.tgz";
        sha512 = "p1vcHAUF1qH7yR+e8ip7Bs61AHjLeKkIn8Z2gzwU2lwEf2wkSpWdjXG0axudTHsVFnYGlMkFaEsVy2l8tAg1Gw==";
      };
    };
    "d3-format-1.3.2" = {
      name = "d3-format";
      packageName = "d3-format";
      version = "1.3.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/d3-format/-/d3-format-1.3.2.tgz";
        sha512 = "Z18Dprj96ExragQ0DeGi+SYPQ7pPfRMtUXtsg/ChVIKNBCzjO8XYJvRTC1usblx52lqge56V5ect+frYTQc8WQ==";
      };
    };
    "d3-geo-1.11.3" = {
      name = "d3-geo";
      packageName = "d3-geo";
      version = "1.11.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/d3-geo/-/d3-geo-1.11.3.tgz";
        sha512 = "n30yN9qSKREvV2fxcrhmHUdXP9TNH7ZZj3C/qnaoU0cVf/Ea85+yT7HY7i8ySPwkwjCNYtmKqQFTvLFngfkItQ==";
      };
    };
    "d3-hierarchy-1.1.8" = {
      name = "d3-hierarchy";
      packageName = "d3-hierarchy";
      version = "1.1.8";
      src = fetchurl {
        url = "https://registry.npmjs.org/d3-hierarchy/-/d3-hierarchy-1.1.8.tgz";
        sha512 = "L+GHMSZNwTpiq4rt9GEsNcpLa4M96lXMR8M/nMG9p5hBE0jy6C+3hWtyZMenPQdwla249iJy7Nx0uKt3n+u9+w==";
      };
    };
    "d3-interpolate-1.3.2" = {
      name = "d3-interpolate";
      packageName = "d3-interpolate";
      version = "1.3.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/d3-interpolate/-/d3-interpolate-1.3.2.tgz";
        sha512 = "NlNKGopqaz9qM1PXh9gBF1KSCVh+jSFErrSlD/4hybwoNX/gt1d8CDbDW+3i+5UOHhjC6s6nMvRxcuoMVNgL2w==";
      };
    };
    "d3-path-1.0.7" = {
      name = "d3-path";
      packageName = "d3-path";
      version = "1.0.7";
      src = fetchurl {
        url = "https://registry.npmjs.org/d3-path/-/d3-path-1.0.7.tgz";
        sha512 = "q0cW1RpvA5c5ma2rch62mX8AYaiLX0+bdaSM2wxSU9tXjU4DNvkx9qiUvjkuWCj3p22UO/hlPivujqMiR9PDzA==";
      };
    };
    "d3-polygon-1.0.5" = {
      name = "d3-polygon";
      packageName = "d3-polygon";
      version = "1.0.5";
      src = fetchurl {
        url = "https://registry.npmjs.org/d3-polygon/-/d3-polygon-1.0.5.tgz";
        sha512 = "RHhh1ZUJZfhgoqzWWuRhzQJvO7LavchhitSTHGu9oj6uuLFzYZVeBzaWTQ2qSO6bz2w55RMoOCf0MsLCDB6e0w==";
      };
    };
    "d3-quadtree-1.0.5" = {
      name = "d3-quadtree";
      packageName = "d3-quadtree";
      version = "1.0.5";
      src = fetchurl {
        url = "https://registry.npmjs.org/d3-quadtree/-/d3-quadtree-1.0.5.tgz";
        sha512 = "U2tjwDFbZ75JRAg8A+cqMvqPg1G3BE7UTJn3h8DHjY/pnsAfWdbJKgyfcy7zKjqGtLAmI0q8aDSeG1TVIKRaHQ==";
      };
    };
    "d3-random-1.1.2" = {
      name = "d3-random";
      packageName = "d3-random";
      version = "1.1.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/d3-random/-/d3-random-1.1.2.tgz";
        sha512 = "6AK5BNpIFqP+cx/sreKzNjWbwZQCSUatxq+pPRmFIQaWuoD+NrbVWw7YWpHiXpCQ/NanKdtGDuB+VQcZDaEmYQ==";
      };
    };
    "d3-scale-2.1.2" = {
      name = "d3-scale";
      packageName = "d3-scale";
      version = "2.1.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/d3-scale/-/d3-scale-2.1.2.tgz";
        sha512 = "bESpd64ylaKzCDzvULcmHKZTlzA/6DGSVwx7QSDj/EnX9cpSevsdiwdHFYI9ouo9tNBbV3v5xztHS2uFeOzh8Q==";
      };
    };
    "d3-scale-chromatic-1.3.3" = {
      name = "d3-scale-chromatic";
      packageName = "d3-scale-chromatic";
      version = "1.3.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/d3-scale-chromatic/-/d3-scale-chromatic-1.3.3.tgz";
        sha512 = "BWTipif1CimXcYfT02LKjAyItX5gKiwxuPRgr4xM58JwlLocWbjPLI7aMEjkcoOQXMkYsmNsvv3d2yl/OKuHHw==";
      };
    };
    "d3-selection-1.3.2" = {
      name = "d3-selection";
      packageName = "d3-selection";
      version = "1.3.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/d3-selection/-/d3-selection-1.3.2.tgz";
        sha512 = "OoXdv1nZ7h2aKMVg3kaUFbLLK5jXUFAMLD/Tu5JA96mjf8f2a9ZUESGY+C36t8R1WFeWk/e55hy54Ml2I62CRQ==";
      };
    };
    "d3-shape-1.2.2" = {
      name = "d3-shape";
      packageName = "d3-shape";
      version = "1.2.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/d3-shape/-/d3-shape-1.2.2.tgz";
        sha512 = "hUGEozlKecFZ2bOSNt7ENex+4Tk9uc/m0TtTEHBvitCBxUNjhzm5hS2GrrVRD/ae4IylSmxGeqX5tWC2rASMlQ==";
      };
    };
    "d3-time-1.0.10" = {
      name = "d3-time";
      packageName = "d3-time";
      version = "1.0.10";
      src = fetchurl {
        url = "https://registry.npmjs.org/d3-time/-/d3-time-1.0.10.tgz";
        sha512 = "hF+NTLCaJHF/JqHN5hE8HVGAXPStEq6/omumPE/SxyHVrR7/qQxusFDo0t0c/44+sCGHthC7yNGFZIEgju0P8g==";
      };
    };
    "d3-time-format-2.1.3" = {
      name = "d3-time-format";
      packageName = "d3-time-format";
      version = "2.1.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/d3-time-format/-/d3-time-format-2.1.3.tgz";
        sha512 = "6k0a2rZryzGm5Ihx+aFMuO1GgelgIz+7HhB4PH4OEndD5q2zGn1mDfRdNrulspOfR6JXkb2sThhDK41CSK85QA==";
      };
    };
    "d3-timer-1.0.9" = {
      name = "d3-timer";
      packageName = "d3-timer";
      version = "1.0.9";
      src = fetchurl {
        url = "https://registry.npmjs.org/d3-timer/-/d3-timer-1.0.9.tgz";
        sha512 = "rT34J5HnQUHhcLvhSB9GjCkN0Ddd5Y8nCwDBG2u6wQEeYxT/Lf51fTFFkldeib/sE/J0clIe0pnCfs6g/lRbyg==";
      };
    };
    "d3-transition-1.1.3" = {
      name = "d3-transition";
      packageName = "d3-transition";
      version = "1.1.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/d3-transition/-/d3-transition-1.1.3.tgz";
        sha512 = "tEvo3qOXL6pZ1EzcXxFcPNxC/Ygivu5NoBY6mbzidATAeML86da+JfVIUzon3dNM6UX6zjDx+xbYDmMVtTSjuA==";
      };
    };
    "d3-voronoi-1.1.4" = {
      name = "d3-voronoi";
      packageName = "d3-voronoi";
      version = "1.1.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/d3-voronoi/-/d3-voronoi-1.1.4.tgz";
        sha512 = "dArJ32hchFsrQ8uMiTBLq256MpnZjeuBtdHpaDlYuQyjU0CVzCJl/BVW+SkszaAeH95D/8gxqAhgx0ouAWAfRg==";
      };
    };
    "d3-zoom-1.7.3" = {
      name = "d3-zoom";
      packageName = "d3-zoom";
      version = "1.7.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/d3-zoom/-/d3-zoom-1.7.3.tgz";
        sha512 = "xEBSwFx5Z9T3/VrwDkMt+mr0HCzv7XjpGURJ8lWmIC8wxe32L39eWHIasEe/e7Ox8MPU4p1hvH8PKN2olLzIBg==";
      };
    };
    "dashdash-1.14.1" = {
      name = "dashdash";
      packageName = "dashdash";
      version = "1.14.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/dashdash/-/dashdash-1.14.1.tgz";
        sha1 = "853cfa0f7cbe2fed5de20326b8dd581035f6e2f0";
      };
    };
    "data-uri-to-buffer-1.2.0" = {
      name = "data-uri-to-buffer";
      packageName = "data-uri-to-buffer";
      version = "1.2.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/data-uri-to-buffer/-/data-uri-to-buffer-1.2.0.tgz";
        sha512 = "vKQ9DTQPN1FLYiiEEOQ6IBGFqvjCa5rSK3cWMy/Nespm5d/x3dGFT9UBZnkLxCwua/IXBi2TYnwTEpsOvhC4UQ==";
      };
    };
    "date-now-0.1.4" = {
      name = "date-now";
      packageName = "date-now";
      version = "0.1.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/date-now/-/date-now-0.1.4.tgz";
        sha1 = "eaf439fd4d4848ad74e5cc7dbef200672b9e345b";
      };
    };
    "de-indent-1.0.2" = {
      name = "de-indent";
      packageName = "de-indent";
      version = "1.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/de-indent/-/de-indent-1.0.2.tgz";
        sha1 = "b2038e846dc33baa5796128d0804b455b8c1e21d";
      };
    };
    "debug-2.2.0" = {
      name = "debug";
      packageName = "debug";
      version = "2.2.0";
      src = fetchurl {
        url = "http://registry.npmjs.org/debug/-/debug-2.2.0.tgz";
        sha1 = "f87057e995b1a1f6ae6a4960664137bc56f039da";
      };
    };
    "debug-2.6.9" = {
      name = "debug";
      packageName = "debug";
      version = "2.6.9";
      src = fetchurl {
        url = "https://registry.npmjs.org/debug/-/debug-2.6.9.tgz";
        sha512 = "bC7ElrdJaJnPbAP+1EotYvqZsb3ecl5wi6Bfi6BJTUcNowp6cvspg0jXznRTKDjm/E7AdgFBVeAPVMNcKGsHMA==";
      };
    };
    "debug-3.1.0" = {
      name = "debug";
      packageName = "debug";
      version = "3.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/debug/-/debug-3.1.0.tgz";
        sha512 = "OX8XqP7/1a9cqkxYw2yXss15f26NKWBpDXQd0/uK/KPqdQhxbPa994hnzjcE2VqQpDslf55723cKPUOGSmMY3g==";
      };
    };
    "debug-3.2.6" = {
      name = "debug";
      packageName = "debug";
      version = "3.2.6";
      src = fetchurl {
        url = "https://registry.npmjs.org/debug/-/debug-3.2.6.tgz";
        sha512 = "mel+jf7nrtEl5Pn1Qx46zARXKDpBbvzezse7p7LqINmdoIk8PYP5SySaxEmYv6TZ0JyEKA1hsCId6DIhgITtWQ==";
      };
    };
    "debug-4.1.0" = {
      name = "debug";
      packageName = "debug";
      version = "4.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/debug/-/debug-4.1.0.tgz";
        sha512 = "heNPJUJIqC+xB6ayLAMHaIrmN9HKa7aQO8MGqKpvCA+uJYVcvR6l5kgdrhRuwPFHU7P5/A1w0BjByPHwpfTDKg==";
      };
    };
    "decamelize-1.2.0" = {
      name = "decamelize";
      packageName = "decamelize";
      version = "1.2.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/decamelize/-/decamelize-1.2.0.tgz";
        sha1 = "f6534d15148269b20352e7bee26f501f9a191290";
      };
    };
    "decode-uri-component-0.2.0" = {
      name = "decode-uri-component";
      packageName = "decode-uri-component";
      version = "0.2.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/decode-uri-component/-/decode-uri-component-0.2.0.tgz";
        sha1 = "eb3913333458775cb84cd1a1fae062106bb87545";
      };
    };
    "decompress-response-3.3.0" = {
      name = "decompress-response";
      packageName = "decompress-response";
      version = "3.3.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/decompress-response/-/decompress-response-3.3.0.tgz";
        sha1 = "80a4dd323748384bfa248083622aedec982adff3";
      };
    };
    "deep-eql-0.1.3" = {
      name = "deep-eql";
      packageName = "deep-eql";
      version = "0.1.3";
      src = fetchurl {
        url = "http://registry.npmjs.org/deep-eql/-/deep-eql-0.1.3.tgz";
        sha1 = "ef558acab8de25206cd713906d74e56930eb69f2";
      };
    };
    "deep-eql-3.0.1" = {
      name = "deep-eql";
      packageName = "deep-eql";
      version = "3.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/deep-eql/-/deep-eql-3.0.1.tgz";
        sha512 = "+QeIQyN5ZuO+3Uk5DYh6/1eKO0m0YmJFGNmFHGACpf1ClL1nmlV/p4gNgbl2pJGxgXb4faqo6UE+M5ACEMyVcw==";
      };
    };
    "deep-equal-0.2.2" = {
      name = "deep-equal";
      packageName = "deep-equal";
      version = "0.2.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/deep-equal/-/deep-equal-0.2.2.tgz";
        sha1 = "84b745896f34c684e98f2ce0e42abaf43bba017d";
      };
    };
    "deep-equal-1.0.1" = {
      name = "deep-equal";
      packageName = "deep-equal";
      version = "1.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/deep-equal/-/deep-equal-1.0.1.tgz";
        sha1 = "f5d260292b660e084eff4cdbc9f08ad3247448b5";
      };
    };
    "deep-extend-0.6.0" = {
      name = "deep-extend";
      packageName = "deep-extend";
      version = "0.6.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/deep-extend/-/deep-extend-0.6.0.tgz";
        sha512 = "LOHxIOaPYdHlJRtCQfDIVZtfw/ufM8+rVj649RIHzcm/vGwQRXFt6OPqIFWsm2XEMrNIEtWR64sY1LEKD2vAOA==";
      };
    };
    "deep-is-0.1.3" = {
      name = "deep-is";
      packageName = "deep-is";
      version = "0.1.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/deep-is/-/deep-is-0.1.3.tgz";
        sha1 = "b369d6fb5dbc13eecf524f91b070feedc357cf34";
      };
    };
    "deepmerge-2.0.1" = {
      name = "deepmerge";
      packageName = "deepmerge";
      version = "2.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/deepmerge/-/deepmerge-2.0.1.tgz";
        sha512 = "VIPwiMJqJ13ZQfaCsIFnp5Me9tnjURiaIFxfz7EH0Ci0dTSQpZtSLrqOicXqEd/z2r+z+Klk9GzmnRsgpgbOsQ==";
      };
    };
    "deepmerge-2.2.1" = {
      name = "deepmerge";
      packageName = "deepmerge";
      version = "2.2.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/deepmerge/-/deepmerge-2.2.1.tgz";
        sha512 = "R9hc1Xa/NOBi9WRVUWg19rl1UB7Tt4kuPd+thNJgFZoxXsTz7ncaPaeIm+40oSGuP33DfMb4sZt1QIGiJzC4EA==";
      };
    };
    "default-shell-1.0.1" = {
      name = "default-shell";
      packageName = "default-shell";
      version = "1.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/default-shell/-/default-shell-1.0.1.tgz";
        sha1 = "752304bddc6174f49eb29cb988feea0b8813c8bc";
      };
    };
    "deferred-leveldown-0.2.0" = {
      name = "deferred-leveldown";
      packageName = "deferred-leveldown";
      version = "0.2.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/deferred-leveldown/-/deferred-leveldown-0.2.0.tgz";
        sha1 = "2cef1f111e1c57870d8bbb8af2650e587cd2f5b4";
      };
    };
    "deferred-leveldown-3.0.0" = {
      name = "deferred-leveldown";
      packageName = "deferred-leveldown";
      version = "3.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/deferred-leveldown/-/deferred-leveldown-3.0.0.tgz";
        sha512 = "ajbXqRPMXRlcdyt0TuWqknOJkp1JgQjGB7xOl2V+ebol7/U11E9h3/nCZAtN1M7djmAJEIhypCUc1tIWxdQAuQ==";
      };
    };
    "deferred-leveldown-4.0.2" = {
      name = "deferred-leveldown";
      packageName = "deferred-leveldown";
      version = "4.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/deferred-leveldown/-/deferred-leveldown-4.0.2.tgz";
        sha512 = "5fMC8ek8alH16QiV0lTCis610D1Zt1+LA4MS4d63JgS32lrCjTFDUFz2ao09/j2I4Bqb5jL4FZYwu7Jz0XO1ww==";
      };
    };
    "define-properties-1.1.3" = {
      name = "define-properties";
      packageName = "define-properties";
      version = "1.1.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/define-properties/-/define-properties-1.1.3.tgz";
        sha512 = "3MqfYKj2lLzdMSf8ZIZE/V+Zuy+BgD6f164e8K2w7dgnpKArBDerGYpM46IYYcjnkdPNMjPk9A6VFB8+3SKlXQ==";
      };
    };
    "define-property-0.2.5" = {
      name = "define-property";
      packageName = "define-property";
      version = "0.2.5";
      src = fetchurl {
        url = "https://registry.npmjs.org/define-property/-/define-property-0.2.5.tgz";
        sha1 = "c35b1ef918ec3c990f9a5bc57be04aacec5c8116";
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
    "define-property-2.0.2" = {
      name = "define-property";
      packageName = "define-property";
      version = "2.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/define-property/-/define-property-2.0.2.tgz";
        sha512 = "jwK2UV4cnPpbcG7+VRARKTZPUWowwXA8bzH5NP6ud0oeAxyYPuGZUAC7hMugpCdz4BeSZl2Dl9k66CHJ/46ZYQ==";
      };
    };
    "defined-1.0.0" = {
      name = "defined";
      packageName = "defined";
      version = "1.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/defined/-/defined-1.0.0.tgz";
        sha1 = "c98d9bcef75674188e110969151199e39b1fa693";
      };
    };
    "degenerator-1.0.4" = {
      name = "degenerator";
      packageName = "degenerator";
      version = "1.0.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/degenerator/-/degenerator-1.0.4.tgz";
        sha1 = "fcf490a37ece266464d9cc431ab98c5819ced095";
      };
    };
    "del-3.0.0" = {
      name = "del";
      packageName = "del";
      version = "3.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/del/-/del-3.0.0.tgz";
        sha1 = "53ecf699ffcbcb39637691ab13baf160819766e5";
      };
    };
    "delayed-stream-1.0.0" = {
      name = "delayed-stream";
      packageName = "delayed-stream";
      version = "1.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/delayed-stream/-/delayed-stream-1.0.0.tgz";
        sha1 = "df3ae199acadfb7d440aaae0b29e2272b24ec619";
      };
    };
    "delegates-1.0.0" = {
      name = "delegates";
      packageName = "delegates";
      version = "1.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/delegates/-/delegates-1.0.0.tgz";
        sha1 = "84c6e159b81904fdca59a0ef44cd870d31250f9a";
      };
    };
    "depd-1.1.2" = {
      name = "depd";
      packageName = "depd";
      version = "1.1.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/depd/-/depd-1.1.2.tgz";
        sha1 = "9bcd52e14c097763e749b274c4346ed2e560b5a9";
      };
    };
    "depnest-1.3.0" = {
      name = "depnest";
      packageName = "depnest";
      version = "1.3.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/depnest/-/depnest-1.3.0.tgz";
        sha1 = "14bd8a361df445d2d34f7ecb362d6c7457288959";
      };
    };
    "des.js-1.0.0" = {
      name = "des.js";
      packageName = "des.js";
      version = "1.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/des.js/-/des.js-1.0.0.tgz";
        sha1 = "c074d2e2aa6a8a9a07dbd61f9a15c2cd83ec8ecc";
      };
    };
    "destroy-1.0.4" = {
      name = "destroy";
      packageName = "destroy";
      version = "1.0.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/destroy/-/destroy-1.0.4.tgz";
        sha1 = "978857442c44749e4206613e37946205826abd80";
      };
    };
    "detab-1.0.2" = {
      name = "detab";
      packageName = "detab";
      version = "1.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/detab/-/detab-1.0.2.tgz";
        sha1 = "01bc2a4abe7bc7cc67c3039808edbae47049a0ee";
      };
    };
    "detect-indent-4.0.0" = {
      name = "detect-indent";
      packageName = "detect-indent";
      version = "4.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/detect-indent/-/detect-indent-4.0.0.tgz";
        sha1 = "f76d064352cdf43a1cb6ce619c4ee3a9475de208";
      };
    };
    "detect-libc-1.0.3" = {
      name = "detect-libc";
      packageName = "detect-libc";
      version = "1.0.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/detect-libc/-/detect-libc-1.0.3.tgz";
        sha1 = "fa137c4bd698edf55cd5cd02ac559f91a4c4ba9b";
      };
    };
    "detect-node-2.0.4" = {
      name = "detect-node";
      packageName = "detect-node";
      version = "2.0.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/detect-node/-/detect-node-2.0.4.tgz";
        sha512 = "ZIzRpLJrOj7jjP2miAtgqIfmzbxa4ZOr5jJc601zklsfEx9oTzmmj2nVpIPRpNlRTIh8lc1kyViIY7BWSGNmKw==";
      };
    };
    "dev-null-0.1.1" = {
      name = "dev-null";
      packageName = "dev-null";
      version = "0.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/dev-null/-/dev-null-0.1.1.tgz";
        sha1 = "5a205ce3c2b2ef77b6238d6ba179eb74c6a0e818";
      };
    };
    "diff-1.4.0" = {
      name = "diff";
      packageName = "diff";
      version = "1.4.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/diff/-/diff-1.4.0.tgz";
        sha1 = "7f28d2eb9ee7b15a97efd89ce63dcfdaa3ccbabf";
      };
    };
    "diffie-hellman-5.0.3" = {
      name = "diffie-hellman";
      packageName = "diffie-hellman";
      version = "5.0.3";
      src = fetchurl {
        url = "http://registry.npmjs.org/diffie-hellman/-/diffie-hellman-5.0.3.tgz";
        sha512 = "kqag/Nl+f3GwyK25fhUMYj81BUOrZ9IuJsjIcDE5icNM9FJHAVm3VcUDxdLPoQtTuUylWm6ZIknYJwwaPxsUzg==";
      };
    };
    "dir-glob-2.0.0" = {
      name = "dir-glob";
      packageName = "dir-glob";
      version = "2.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/dir-glob/-/dir-glob-2.0.0.tgz";
        sha512 = "37qirFDz8cA5fimp9feo43fSuRo2gHwaIn6dXL8Ber1dGwUosDrGZeCCXq57WnIqE4aQ+u3eQZzsk1yOzhdwag==";
      };
    };
    "discontinuous-range-1.0.0" = {
      name = "discontinuous-range";
      packageName = "discontinuous-range";
      version = "1.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/discontinuous-range/-/discontinuous-range-1.0.0.tgz";
        sha1 = "e38331f0844bba49b9a9cb71c771585aab1bc65a";
      };
    };
    "dns-equal-1.0.0" = {
      name = "dns-equal";
      packageName = "dns-equal";
      version = "1.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/dns-equal/-/dns-equal-1.0.0.tgz";
        sha1 = "b39e7f1da6eb0a75ba9c17324b34753c47e0654d";
      };
    };
    "dns-packet-1.3.1" = {
      name = "dns-packet";
      packageName = "dns-packet";
      version = "1.3.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/dns-packet/-/dns-packet-1.3.1.tgz";
        sha512 = "0UxfQkMhYAUaZI+xrNZOz/as5KgDU0M/fQ9b6SpkyLbk3GEswDi6PADJVaYJradtRVsRIlF1zLyOodbcTCDzUg==";
      };
    };
    "dns-txt-2.0.2" = {
      name = "dns-txt";
      packageName = "dns-txt";
      version = "2.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/dns-txt/-/dns-txt-2.0.2.tgz";
        sha1 = "b91d806f5d27188e4ab3e7d107d881a1cc4642b6";
      };
    };
    "dom-converter-0.2.0" = {
      name = "dom-converter";
      packageName = "dom-converter";
      version = "0.2.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/dom-converter/-/dom-converter-0.2.0.tgz";
        sha512 = "gd3ypIPfOMr9h5jIKq8E3sHOTCjeirnl0WK5ZdS1AW0Odt0b1PaWaHdJ4Qk4klv+YB9aJBS7mESXjFoDQPu6DA==";
      };
    };
    "dom-serializer-0.1.0" = {
      name = "dom-serializer";
      packageName = "dom-serializer";
      version = "0.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/dom-serializer/-/dom-serializer-0.1.0.tgz";
        sha1 = "073c697546ce0780ce23be4a28e293e40bc30c82";
      };
    };
    "domain-browser-1.2.0" = {
      name = "domain-browser";
      packageName = "domain-browser";
      version = "1.2.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/domain-browser/-/domain-browser-1.2.0.tgz";
        sha512 = "jnjyiM6eRyZl2H+W8Q/zLMA481hzi0eszAaBUzIVnmYVDBbnLxVNnfu1HgEBvCbL+71FrxMl3E6lpKH7Ge3OXA==";
      };
    };
    "domelementtype-1.1.3" = {
      name = "domelementtype";
      packageName = "domelementtype";
      version = "1.1.3";
      src = fetchurl {
        url = "http://registry.npmjs.org/domelementtype/-/domelementtype-1.1.3.tgz";
        sha1 = "bd28773e2642881aec51544924299c5cd822185b";
      };
    };
    "domelementtype-1.3.1" = {
      name = "domelementtype";
      packageName = "domelementtype";
      version = "1.3.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/domelementtype/-/domelementtype-1.3.1.tgz";
        sha512 = "BSKB+TSpMpFI/HOxCNr1O8aMOTZ8hT3pM3GQ0w/mWRmkhEDSFJkkyzz4XQsBV44BChwGkrDfMyjVD0eA2aFV3w==";
      };
    };
    "domhandler-2.1.0" = {
      name = "domhandler";
      packageName = "domhandler";
      version = "2.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/domhandler/-/domhandler-2.1.0.tgz";
        sha1 = "d2646f5e57f6c3bab11cf6cb05d3c0acf7412594";
      };
    };
    "domutils-1.1.6" = {
      name = "domutils";
      packageName = "domutils";
      version = "1.1.6";
      src = fetchurl {
        url = "https://registry.npmjs.org/domutils/-/domutils-1.1.6.tgz";
        sha1 = "bddc3de099b9a2efacc51c623f28f416ecc57485";
      };
    };
    "domutils-1.5.1" = {
      name = "domutils";
      packageName = "domutils";
      version = "1.5.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/domutils/-/domutils-1.5.1.tgz";
        sha1 = "dcd8488a26f563d61079e48c9f7b7e32373682cf";
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
    "duplexify-3.6.1" = {
      name = "duplexify";
      packageName = "duplexify";
      version = "3.6.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/duplexify/-/duplexify-3.6.1.tgz";
        sha512 = "vM58DwdnKmty+FSPzT14K9JXb90H+j5emaR4KYbr2KTIz00WHGbWOe5ghQTx233ZCLZtrGDALzKwcjEtSt35mA==";
      };
    };
    "dynamic-dijkstra-1.0.0" = {
      name = "dynamic-dijkstra";
      packageName = "dynamic-dijkstra";
      version = "1.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/dynamic-dijkstra/-/dynamic-dijkstra-1.0.0.tgz";
        sha512 = "AUbCFABXNoon689xft5ROX/fO9pdttZ6wZcMXZ4oH85Bn9rtiMdVHVBbAZ9kxAewdm5L1m+y+n97s8ofwya8WA==";
      };
    };
    "ecc-jsbn-0.1.2" = {
      name = "ecc-jsbn";
      packageName = "ecc-jsbn";
      version = "0.1.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/ecc-jsbn/-/ecc-jsbn-0.1.2.tgz";
        sha1 = "3a83a904e54353287874c564b7549386849a98c9";
      };
    };
    "ecstatic-3.3.0" = {
      name = "ecstatic";
      packageName = "ecstatic";
      version = "3.3.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/ecstatic/-/ecstatic-3.3.0.tgz";
        sha512 = "EblWYTd+wPIAMQ0U4oYJZ7QBypT9ZUIwpqli0bKDjeIIQnXDBK2dXtZ9yzRCOlkW1HkO8gn7/FxLK1yPIW17pw==";
      };
    };
    "ed2curve-0.1.4" = {
      name = "ed2curve";
      packageName = "ed2curve";
      version = "0.1.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/ed2curve/-/ed2curve-0.1.4.tgz";
        sha1 = "94a44248bb87da35db0eff7af0aa576168117f59";
      };
    };
    "ee-first-1.1.1" = {
      name = "ee-first";
      packageName = "ee-first";
      version = "1.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/ee-first/-/ee-first-1.1.1.tgz";
        sha1 = "590c61156b0ae2f4f0255732a158b266bc56b21d";
      };
    };
    "ejs-2.5.7" = {
      name = "ejs";
      packageName = "ejs";
      version = "2.5.7";
      src = fetchurl {
        url = "https://registry.npmjs.org/ejs/-/ejs-2.5.7.tgz";
        sha1 = "cc872c168880ae3c7189762fd5ffc00896c9518a";
      };
    };
    "electron-chromedriver-1.8.0" = {
      name = "electron-chromedriver";
      packageName = "electron-chromedriver";
      version = "1.8.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/electron-chromedriver/-/electron-chromedriver-1.8.0.tgz";
        sha512 = "m1f3nle5MaGp94bcDTtMZZMMOgPO54+TXoPBlTbBSUjfINR5SJ46yQXLfuE79/qsFfJKslZB1UzWURDDFIRmpQ==";
      };
    };
    "electron-context-menu-0.9.1" = {
      name = "electron-context-menu";
      packageName = "electron-context-menu";
      version = "0.9.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/electron-context-menu/-/electron-context-menu-0.9.1.tgz";
        sha1 = "ed4df20c080491c3c996abfcb363159946a38058";
      };
    };
    "electron-default-menu-1.0.1" = {
      name = "electron-default-menu";
      packageName = "electron-default-menu";
      version = "1.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/electron-default-menu/-/electron-default-menu-1.0.1.tgz";
        sha1 = "3173c5018eb507404fec63bdf3b78c38eedba808";
      };
    };
    "electron-dl-1.12.0" = {
      name = "electron-dl";
      packageName = "electron-dl";
      version = "1.12.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/electron-dl/-/electron-dl-1.12.0.tgz";
        sha512 = "UMc2CL45Ybpvu66LDPYzwmDRmYK4Ivz+wdnTM0eXcNMztvQwhixAk2UPme1c7McqG8bAlKEkQpZn3epmQy4EWg==";
      };
    };
    "electron-download-4.1.1" = {
      name = "electron-download";
      packageName = "electron-download";
      version = "4.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/electron-download/-/electron-download-4.1.1.tgz";
        sha512 = "FjEWG9Jb/ppK/2zToP+U5dds114fM1ZOJqMAR4aXXL5CvyPE9fiqBK/9YcwC9poIFQTEJk/EM/zyRwziziRZrg==";
      };
    };
    "electron-is-dev-0.1.2" = {
      name = "electron-is-dev";
      packageName = "electron-is-dev";
      version = "0.1.2";
      src = fetchurl {
        url = "http://registry.npmjs.org/electron-is-dev/-/electron-is-dev-0.1.2.tgz";
        sha1 = "8a1043e32b3a1da1c3f553dce28ce764246167e3";
      };
    };
    "electron-to-chromium-1.3.95" = {
      name = "electron-to-chromium";
      packageName = "electron-to-chromium";
      version = "1.3.95";
      src = fetchurl {
        url = "https://registry.npmjs.org/electron-to-chromium/-/electron-to-chromium-1.3.95.tgz";
        sha512 = "0JZEDKOQAE05EO/4rk3vLAE+PYFI9OLCVLAS4QAq1y+Bb2y1N6MyQJz62ynzHN/y0Ka/nO5jVJcahbCEdfiXLQ==";
      };
    };
    "electron-window-state-4.1.1" = {
      name = "electron-window-state";
      packageName = "electron-window-state";
      version = "4.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/electron-window-state/-/electron-window-state-4.1.1.tgz";
        sha1 = "6b34fdc31b38514dfec8b7c8f7b5d4addb67632d";
      };
    };
    "elegant-spinner-1.0.1" = {
      name = "elegant-spinner";
      packageName = "elegant-spinner";
      version = "1.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/elegant-spinner/-/elegant-spinner-1.0.1.tgz";
        sha1 = "db043521c95d7e303fd8f345bedc3349cfb0729e";
      };
    };
    "elliptic-6.4.1" = {
      name = "elliptic";
      packageName = "elliptic";
      version = "6.4.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/elliptic/-/elliptic-6.4.1.tgz";
        sha512 = "BsXLz5sqX8OHcsh7CqBMztyXARmGQ3LWPtGjJi6DiJHq5C/qvi9P3OqgswKSDftbu8+IoI/QDTAm2fFnQ9SZSQ==";
      };
    };
    "emoji-named-characters-1.0.2" = {
      name = "emoji-named-characters";
      packageName = "emoji-named-characters";
      version = "1.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/emoji-named-characters/-/emoji-named-characters-1.0.2.tgz";
        sha1 = "cdeb36d0e66002c4b9d7bf1dfbc3a199fb7d409b";
      };
    };
    "emoji-server-1.0.0" = {
      name = "emoji-server";
      packageName = "emoji-server";
      version = "1.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/emoji-server/-/emoji-server-1.0.0.tgz";
        sha1 = "d063cfee9af118cc5aeefbc2e9b3dd5085815c63";
      };
    };
    "emojis-list-2.1.0" = {
      name = "emojis-list";
      packageName = "emojis-list";
      version = "2.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/emojis-list/-/emojis-list-2.1.0.tgz";
        sha1 = "4daa4d9db00f9819880c79fa457ae5b09a1fd389";
      };
    };
    "encodeurl-1.0.2" = {
      name = "encodeurl";
      packageName = "encodeurl";
      version = "1.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/encodeurl/-/encodeurl-1.0.2.tgz";
        sha1 = "ad3ff4c86ec2d029322f5a02c3a9a606c95b3f59";
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
    "encoding-down-4.0.1" = {
      name = "encoding-down";
      packageName = "encoding-down";
      version = "4.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/encoding-down/-/encoding-down-4.0.1.tgz";
        sha512 = "AlSE+ugBIpLL0i9if2SlnOZ4oWj/XvBb8tw2Ie/pFB73vdYs5O/6plRyqIgjbZbz8onaL20AAuMP87LWbP56IQ==";
      };
    };
    "encoding-down-5.0.4" = {
      name = "encoding-down";
      packageName = "encoding-down";
      version = "5.0.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/encoding-down/-/encoding-down-5.0.4.tgz";
        sha512 = "8CIZLDcSKxgzT+zX8ZVfgNbu8Md2wq/iqa1Y7zyVR18QBEAc0Nmzuvj/N5ykSKpfGzjM8qxbaFntLPwnVoUhZw==";
      };
    };
    "end-of-stream-1.4.1" = {
      name = "end-of-stream";
      packageName = "end-of-stream";
      version = "1.4.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/end-of-stream/-/end-of-stream-1.4.1.tgz";
        sha512 = "1MkrZNvWTKCaigbn+W15elq2BB/L22nqrSY5DKlo3X6+vclJm8Bb5djXJBmEX6fS3+zCh/F4VBK5Z2KxJt4s2Q==";
      };
    };
    "enhanced-resolve-3.4.1" = {
      name = "enhanced-resolve";
      packageName = "enhanced-resolve";
      version = "3.4.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/enhanced-resolve/-/enhanced-resolve-3.4.1.tgz";
        sha1 = "0421e339fd71419b3da13d129b3979040230476e";
      };
    };
    "entities-1.1.2" = {
      name = "entities";
      packageName = "entities";
      version = "1.1.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/entities/-/entities-1.1.2.tgz";
        sha512 = "f2LZMYl1Fzu7YSBKg+RoROelpOaNrcGmE9AZubeDfrCEia483oW4MI4VyFd5VNHIgQ/7qm1I0wUHK1eJnn2y2w==";
      };
    };
    "env-paths-1.0.0" = {
      name = "env-paths";
      packageName = "env-paths";
      version = "1.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/env-paths/-/env-paths-1.0.0.tgz";
        sha1 = "4168133b42bb05c38a35b1ae4397c8298ab369e0";
      };
    };
    "epidemic-broadcast-trees-6.3.5" = {
      name = "epidemic-broadcast-trees";
      packageName = "epidemic-broadcast-trees";
      version = "6.3.5";
      src = fetchurl {
        url = "https://registry.npmjs.org/epidemic-broadcast-trees/-/epidemic-broadcast-trees-6.3.5.tgz";
        sha512 = "FYCOslXU7OBkz8A9FXsykcpgby3WKcRdLTCr1LivLLSU2nzaO/x86jBGNFEZkezZPx9/Z5fDVX8SGQyXLz8WZQ==";
      };
    };
    "errno-0.1.7" = {
      name = "errno";
      packageName = "errno";
      version = "0.1.7";
      src = fetchurl {
        url = "https://registry.npmjs.org/errno/-/errno-0.1.7.tgz";
        sha512 = "MfrRBDWzIWifgq6tJj60gkAwtLNb6sQPlcFrSOflcP1aFmmruKQ2wRnze/8V6kgyz7H3FF8Npzv78mZ7XLLflg==";
      };
    };
    "error-ex-1.3.2" = {
      name = "error-ex";
      packageName = "error-ex";
      version = "1.3.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/error-ex/-/error-ex-1.3.2.tgz";
        sha512 = "7dFHNmqeFSEt2ZBsCriorKnn3Z2pj+fd9kmI6QoWw4//DL+icEBfc0U7qJCisqrTsKTjw4fNFy2pW9OqStD84g==";
      };
    };
    "es-abstract-1.12.0" = {
      name = "es-abstract";
      packageName = "es-abstract";
      version = "1.12.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/es-abstract/-/es-abstract-1.12.0.tgz";
        sha512 = "C8Fx/0jFmV5IPoMOFPA9P9G5NtqW+4cOPit3MIuvR2t7Ag2K15EJTpxnHAYTzL+aYQJIESYeXZmDBfOBE1HcpA==";
      };
    };
    "es-to-primitive-1.2.0" = {
      name = "es-to-primitive";
      packageName = "es-to-primitive";
      version = "1.2.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/es-to-primitive/-/es-to-primitive-1.2.0.tgz";
        sha512 = "qZryBOJjV//LaxLTV6UC//WewneB3LcXOL9NP++ozKVXsIIIpm/2c13UDiD9Jp2eThsecw9m3jPqDwTyobcdbg==";
      };
    };
    "es2040-1.2.6" = {
      name = "es2040";
      packageName = "es2040";
      version = "1.2.6";
      src = fetchurl {
        url = "https://registry.npmjs.org/es2040/-/es2040-1.2.6.tgz";
        sha512 = "+sAm7CSGH2+0NMZqm63huevZVoyk8OwF8lVIdwPcNtvZxX3YIITGiui8bfLYS8oNcgCgHNYO+QsgMafwo1OWwg==";
      };
    };
    "es5-ext-0.10.46" = {
      name = "es5-ext";
      packageName = "es5-ext";
      version = "0.10.46";
      src = fetchurl {
        url = "https://registry.npmjs.org/es5-ext/-/es5-ext-0.10.46.tgz";
        sha512 = "24XxRvJXNFwEMpJb3nOkiRJKRoupmjYmOPVlI65Qy2SrtxwOTB+g6ODjBKOtwEHbYrhWRty9xxOWLNdClT2djw==";
      };
    };
    "es6-iterator-2.0.3" = {
      name = "es6-iterator";
      packageName = "es6-iterator";
      version = "2.0.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/es6-iterator/-/es6-iterator-2.0.3.tgz";
        sha1 = "a7de889141a05a94b0854403b2d0a0fbfa98f3b7";
      };
    };
    "es6-map-0.1.5" = {
      name = "es6-map";
      packageName = "es6-map";
      version = "0.1.5";
      src = fetchurl {
        url = "https://registry.npmjs.org/es6-map/-/es6-map-0.1.5.tgz";
        sha1 = "9136e0503dcc06a301690f0bb14ff4e364e949f0";
      };
    };
    "es6-set-0.1.5" = {
      name = "es6-set";
      packageName = "es6-set";
      version = "0.1.5";
      src = fetchurl {
        url = "https://registry.npmjs.org/es6-set/-/es6-set-0.1.5.tgz";
        sha1 = "d2b3ec5d4d800ced818db538d28974db0a73ccb1";
      };
    };
    "es6-symbol-3.1.1" = {
      name = "es6-symbol";
      packageName = "es6-symbol";
      version = "3.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/es6-symbol/-/es6-symbol-3.1.1.tgz";
        sha1 = "bf00ef4fdab6ba1b46ecb7b629b4c7ed5715cc77";
      };
    };
    "es6-weak-map-2.0.2" = {
      name = "es6-weak-map";
      packageName = "es6-weak-map";
      version = "2.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/es6-weak-map/-/es6-weak-map-2.0.2.tgz";
        sha1 = "5e3ab32251ffd1538a1f8e5ffa1357772f92d96f";
      };
    };
    "escape-html-1.0.3" = {
      name = "escape-html";
      packageName = "escape-html";
      version = "1.0.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/escape-html/-/escape-html-1.0.3.tgz";
        sha1 = "0258eae4d3d0c0974de1c169188ef0051d1d1988";
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
    "escodegen-1.11.0" = {
      name = "escodegen";
      packageName = "escodegen";
      version = "1.11.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/escodegen/-/escodegen-1.11.0.tgz";
        sha512 = "IeMV45ReixHS53K/OmfKAIztN/igDHzTJUhZM3k1jMhIZWjk45SMwAtBsEXiJp3vSPmTcu6CXn7mDvFHRN66fw==";
      };
    };
    "escope-3.6.0" = {
      name = "escope";
      packageName = "escope";
      version = "3.6.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/escope/-/escope-3.6.0.tgz";
        sha1 = "e01975e812781a163a6dadfdd80398dc64c889c3";
      };
    };
    "eslint-scope-3.7.1" = {
      name = "eslint-scope";
      packageName = "eslint-scope";
      version = "3.7.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/eslint-scope/-/eslint-scope-3.7.1.tgz";
        sha1 = "3d63c3edfda02e06e01a452ad88caacc7cdcb6e8";
      };
    };
    "eslint-visitor-keys-1.0.0" = {
      name = "eslint-visitor-keys";
      packageName = "eslint-visitor-keys";
      version = "1.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/eslint-visitor-keys/-/eslint-visitor-keys-1.0.0.tgz";
        sha512 = "qzm/XxIbxm/FHyH341ZrbnMUpe+5Bocte9xkmFMzPMjRaZMcXww+MpBptFvtU+79L362nqiLhekCxCxDPaUMBQ==";
      };
    };
    "esprima-2.7.3" = {
      name = "esprima";
      packageName = "esprima";
      version = "2.7.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/esprima/-/esprima-2.7.3.tgz";
        sha1 = "96e3b70d5779f6ad49cd032673d1c312767ba581";
      };
    };
    "esprima-3.1.3" = {
      name = "esprima";
      packageName = "esprima";
      version = "3.1.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/esprima/-/esprima-3.1.3.tgz";
        sha1 = "fdca51cee6133895e3c88d535ce49dbff62a4633";
      };
    };
    "esrecurse-4.2.1" = {
      name = "esrecurse";
      packageName = "esrecurse";
      version = "4.2.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/esrecurse/-/esrecurse-4.2.1.tgz";
        sha512 = "64RBB++fIOAXPw3P9cy89qfMlvZEXZkqqJkjqqXIvzP5ezRZjW+lPWjw35UX/3EhUPFYbg5ER4JYgDw4007/DQ==";
      };
    };
    "estraverse-4.2.0" = {
      name = "estraverse";
      packageName = "estraverse";
      version = "4.2.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/estraverse/-/estraverse-4.2.0.tgz";
        sha1 = "0dee3fed31fcd469618ce7342099fc1afa0bdb13";
      };
    };
    "esutils-2.0.2" = {
      name = "esutils";
      packageName = "esutils";
      version = "2.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/esutils/-/esutils-2.0.2.tgz";
        sha1 = "0abf4f1caa5bcb1f7a9d8acc6dea4faaa04bac9b";
      };
    };
    "etag-1.8.1" = {
      name = "etag";
      packageName = "etag";
      version = "1.8.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/etag/-/etag-1.8.1.tgz";
        sha1 = "41ae2eeb65efa62268aebfea83ac7d79299b0887";
      };
    };
    "event-emitter-0.3.5" = {
      name = "event-emitter";
      packageName = "event-emitter";
      version = "0.3.5";
      src = fetchurl {
        url = "https://registry.npmjs.org/event-emitter/-/event-emitter-0.3.5.tgz";
        sha1 = "df8c69eef1647923c7157b9ce83840610b02cc39";
      };
    };
    "eventemitter3-3.1.0" = {
      name = "eventemitter3";
      packageName = "eventemitter3";
      version = "3.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/eventemitter3/-/eventemitter3-3.1.0.tgz";
        sha512 = "ivIvhpq/Y0uSjcHDcOIccjmYjGLcP09MFGE7ysAwkAvkXfpZlC985pH2/ui64DKazbTW/4kN3yqozUxlXzI6cA==";
      };
    };
    "events-1.1.1" = {
      name = "events";
      packageName = "events";
      version = "1.1.1";
      src = fetchurl {
        url = "http://registry.npmjs.org/events/-/events-1.1.1.tgz";
        sha1 = "9ebdb7635ad099c70dcc4c2a1f5004288e8bd924";
      };
    };
    "eventsource-0.1.6" = {
      name = "eventsource";
      packageName = "eventsource";
      version = "0.1.6";
      src = fetchurl {
        url = "https://registry.npmjs.org/eventsource/-/eventsource-0.1.6.tgz";
        sha1 = "0acede849ed7dd1ccc32c811bb11b944d4f29232";
      };
    };
    "evp_bytestokey-1.0.3" = {
      name = "evp_bytestokey";
      packageName = "evp_bytestokey";
      version = "1.0.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/evp_bytestokey/-/evp_bytestokey-1.0.3.tgz";
        sha512 = "/f2Go4TognH/KvCISP7OUsHn85hT9nUkxxA9BEWxFn+Oj9o8ZNLm/40hdlgSLyuOimsrTKLUMEorQexp/aPQeA==";
      };
    };
    "execa-0.5.1" = {
      name = "execa";
      packageName = "execa";
      version = "0.5.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/execa/-/execa-0.5.1.tgz";
        sha1 = "de3fb85cb8d6e91c85bcbceb164581785cb57b36";
      };
    };
    "execa-0.7.0" = {
      name = "execa";
      packageName = "execa";
      version = "0.7.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/execa/-/execa-0.7.0.tgz";
        sha1 = "944becd34cc41ee32a63a9faf27ad5a65fc59777";
      };
    };
    "exit-hook-1.1.1" = {
      name = "exit-hook";
      packageName = "exit-hook";
      version = "1.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/exit-hook/-/exit-hook-1.1.1.tgz";
        sha1 = "f05ca233b48c05d54fff07765df8507e95c02ff8";
      };
    };
    "expand-brackets-0.1.5" = {
      name = "expand-brackets";
      packageName = "expand-brackets";
      version = "0.1.5";
      src = fetchurl {
        url = "https://registry.npmjs.org/expand-brackets/-/expand-brackets-0.1.5.tgz";
        sha1 = "df07284e342a807cd733ac5af72411e581d1177b";
      };
    };
    "expand-brackets-2.1.4" = {
      name = "expand-brackets";
      packageName = "expand-brackets";
      version = "2.1.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/expand-brackets/-/expand-brackets-2.1.4.tgz";
        sha1 = "b77735e315ce30f6b6eff0f83b04151a22449622";
      };
    };
    "expand-range-1.8.2" = {
      name = "expand-range";
      packageName = "expand-range";
      version = "1.8.2";
      src = fetchurl {
        url = "http://registry.npmjs.org/expand-range/-/expand-range-1.8.2.tgz";
        sha1 = "a299effd335fe2721ebae8e257ec79644fc85337";
      };
    };
    "expand-template-1.1.1" = {
      name = "expand-template";
      packageName = "expand-template";
      version = "1.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/expand-template/-/expand-template-1.1.1.tgz";
        sha512 = "cebqLtV8KOZfw0UI8TEFWxtczxxC1jvyUvx6H4fyp1K1FN7A4Q+uggVUlOsI1K8AGU0rwOGqP8nCapdrw8CYQg==";
      };
    };
    "explain-error-1.0.4" = {
      name = "explain-error";
      packageName = "explain-error";
      version = "1.0.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/explain-error/-/explain-error-1.0.4.tgz";
        sha1 = "a793d3ac0cad4c6ab571e9968fbbab6cb2532929";
      };
    };
    "express-4.16.4" = {
      name = "express";
      packageName = "express";
      version = "4.16.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/express/-/express-4.16.4.tgz";
        sha512 = "j12Uuyb4FMrd/qQAm6uCHAkPtO8FDTRJZBDd5D2KOL2eLaz1yUNdUB/NOIyq0iU4q4cFarsUCrnFDPBcnksuOg==";
      };
    };
    "ext-list-2.2.2" = {
      name = "ext-list";
      packageName = "ext-list";
      version = "2.2.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/ext-list/-/ext-list-2.2.2.tgz";
        sha512 = "u+SQgsubraE6zItfVA0tBuCBhfU9ogSRnsvygI7wht9TS510oLkBRXBsqopeUG/GBOIQyKZO9wjTqIu/sf5zFA==";
      };
    };
    "ext-name-5.0.0" = {
      name = "ext-name";
      packageName = "ext-name";
      version = "5.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/ext-name/-/ext-name-5.0.0.tgz";
        sha512 = "yblEwXAbGv1VQDmow7s38W77hzAgJAO50ztBLMcUyUBfxv1HC+LGwtiEN+Co6LtlqT/5uwVOxsD4TNIilWhwdQ==";
      };
    };
    "extend-3.0.2" = {
      name = "extend";
      packageName = "extend";
      version = "3.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/extend/-/extend-3.0.2.tgz";
        sha512 = "fjquC59cD7CyW6urNXK0FBufkZcoiGG80wTuPujX590cB5Ttln20E2UB4S/WARVqhXffZl2LNgS+gQdPIIim/g==";
      };
    };
    "extend-shallow-2.0.1" = {
      name = "extend-shallow";
      packageName = "extend-shallow";
      version = "2.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/extend-shallow/-/extend-shallow-2.0.1.tgz";
        sha1 = "51af7d614ad9a9f610ea1bafbb989d6b1c56890f";
      };
    };
    "extend-shallow-3.0.2" = {
      name = "extend-shallow";
      packageName = "extend-shallow";
      version = "3.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/extend-shallow/-/extend-shallow-3.0.2.tgz";
        sha1 = "26a71aaf073b39fb2127172746131c2704028db8";
      };
    };
    "extend.js-0.0.2" = {
      name = "extend.js";
      packageName = "extend.js";
      version = "0.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/extend.js/-/extend.js-0.0.2.tgz";
        sha1 = "0f9c7a81a1f208b703eb0c3131fe5716ac6ecd15";
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
    "extglob-0.3.2" = {
      name = "extglob";
      packageName = "extglob";
      version = "0.3.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/extglob/-/extglob-0.3.2.tgz";
        sha1 = "2e18ff3d2f49ab2765cec9023f011daa8d8349a1";
      };
    };
    "extglob-2.0.4" = {
      name = "extglob";
      packageName = "extglob";
      version = "2.0.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/extglob/-/extglob-2.0.4.tgz";
        sha512 = "Nmb6QXkELsuBr24CJSkilo6UHHgbekK5UiZgfE6UHD3Eb27YC6oD+bhcT+tJ6cl8dmsgdQxnWlcry8ksBIBLpw==";
      };
    };
    "extract-text-webpack-plugin-3.0.2" = {
      name = "extract-text-webpack-plugin";
      packageName = "extract-text-webpack-plugin";
      version = "3.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/extract-text-webpack-plugin/-/extract-text-webpack-plugin-3.0.2.tgz";
        sha512 = "bt/LZ4m5Rqt/Crl2HiKuAl/oqg0psx1tsTLkvWbJen1CtD+fftkZhMaQ9HOtY2gWsl2Wq+sABmMVi9z3DhKWQQ==";
      };
    };
    "extract-zip-1.6.7" = {
      name = "extract-zip";
      packageName = "extract-zip";
      version = "1.6.7";
      src = fetchurl {
        url = "https://registry.npmjs.org/extract-zip/-/extract-zip-1.6.7.tgz";
        sha1 = "a840b4b8af6403264c8db57f4f1a74333ef81fe9";
      };
    };
    "extsprintf-1.3.0" = {
      name = "extsprintf";
      packageName = "extsprintf";
      version = "1.3.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/extsprintf/-/extsprintf-1.3.0.tgz";
        sha1 = "96918440e3041a7a414f8c52e3c574eb3c3e1e05";
      };
    };
    "eyes-0.1.8" = {
      name = "eyes";
      packageName = "eyes";
      version = "0.1.8";
      src = fetchurl {
        url = "https://registry.npmjs.org/eyes/-/eyes-0.1.8.tgz";
        sha1 = "62cf120234c683785d902348a800ef3e0cc20bc0";
      };
    };
    "fast-deep-equal-1.1.0" = {
      name = "fast-deep-equal";
      packageName = "fast-deep-equal";
      version = "1.1.0";
      src = fetchurl {
        url = "http://registry.npmjs.org/fast-deep-equal/-/fast-deep-equal-1.1.0.tgz";
        sha1 = "c053477817c86b51daa853c81e059b733d023614";
      };
    };
    "fast-deep-equal-2.0.1" = {
      name = "fast-deep-equal";
      packageName = "fast-deep-equal";
      version = "2.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/fast-deep-equal/-/fast-deep-equal-2.0.1.tgz";
        sha1 = "7b05218ddf9667bf7f370bf7fdb2cb15fdd0aa49";
      };
    };
    "fast-future-1.0.2" = {
      name = "fast-future";
      packageName = "fast-future";
      version = "1.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/fast-future/-/fast-future-1.0.2.tgz";
        sha1 = "8435a9aaa02d79248d17d704e76259301d99280a";
      };
    };
    "fast-json-stable-stringify-2.0.0" = {
      name = "fast-json-stable-stringify";
      packageName = "fast-json-stable-stringify";
      version = "2.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/fast-json-stable-stringify/-/fast-json-stable-stringify-2.0.0.tgz";
        sha1 = "d5142c0caee6b1189f87d3a76111064f86c8bbf2";
      };
    };
    "fast-levenshtein-2.0.6" = {
      name = "fast-levenshtein";
      packageName = "fast-levenshtein";
      version = "2.0.6";
      src = fetchurl {
        url = "https://registry.npmjs.org/fast-levenshtein/-/fast-levenshtein-2.0.6.tgz";
        sha1 = "3d8a5c66883a16a30ca8643e851f19baa7797917";
      };
    };
    "fastparse-1.1.2" = {
      name = "fastparse";
      packageName = "fastparse";
      version = "1.1.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/fastparse/-/fastparse-1.1.2.tgz";
        sha512 = "483XLLxTVIwWK3QTrMGRqUfUpoOs/0hbQrl2oz4J0pAcm3A3bu84wxTFqGqkJzewCLdME38xJLJAxBABfQT8sQ==";
      };
    };
    "faye-websocket-0.10.0" = {
      name = "faye-websocket";
      packageName = "faye-websocket";
      version = "0.10.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/faye-websocket/-/faye-websocket-0.10.0.tgz";
        sha1 = "4e492f8d04dfb6f89003507f6edbf2d501e7c6f4";
      };
    };
    "faye-websocket-0.11.1" = {
      name = "faye-websocket";
      packageName = "faye-websocket";
      version = "0.11.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/faye-websocket/-/faye-websocket-0.11.1.tgz";
        sha1 = "f0efe18c4f56e4f40afc7e06c719fd5ee6188f38";
      };
    };
    "fd-slicer-1.0.1" = {
      name = "fd-slicer";
      packageName = "fd-slicer";
      version = "1.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/fd-slicer/-/fd-slicer-1.0.1.tgz";
        sha1 = "8b5bcbd9ec327c5041bf9ab023fd6750f1177e65";
      };
    };
    "figures-1.7.0" = {
      name = "figures";
      packageName = "figures";
      version = "1.7.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/figures/-/figures-1.7.0.tgz";
        sha1 = "cbe1e3affcf1cd44b80cadfed28dc793a9701d2e";
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
    "file-loader-1.1.11" = {
      name = "file-loader";
      packageName = "file-loader";
      version = "1.1.11";
      src = fetchurl {
        url = "http://registry.npmjs.org/file-loader/-/file-loader-1.1.11.tgz";
        sha512 = "TGR4HU7HUsGg6GCOPJnFk06RhWgEWFLAGWiT6rcD+GRC2keU3s9RGJ+b3Z6/U73jwwNb2gKLJ7YCrp+jvU4ALg==";
      };
    };
    "file-saver-1.3.8" = {
      name = "file-saver";
      packageName = "file-saver";
      version = "1.3.8";
      src = fetchurl {
        url = "http://registry.npmjs.org/file-saver/-/file-saver-1.3.8.tgz";
        sha512 = "spKHSBQIxxS81N/O21WmuXA2F6wppUCsutpzenOeZzOCCJ5gEfcbqJP983IrpLXzYmXnMUa6J03SubcNPdKrlg==";
      };
    };
    "file-uri-to-path-1.0.0" = {
      name = "file-uri-to-path";
      packageName = "file-uri-to-path";
      version = "1.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/file-uri-to-path/-/file-uri-to-path-1.0.0.tgz";
        sha512 = "0Zt+s3L7Vf1biwWZ29aARiVYLx7iMGnEUl9x33fbB/j3jR81u/O2LbqK+Bm1CDSNDKVtJ/YjwY7TUd5SkeLQLw==";
      };
    };
    "filename-regex-2.0.1" = {
      name = "filename-regex";
      packageName = "filename-regex";
      version = "2.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/filename-regex/-/filename-regex-2.0.1.tgz";
        sha1 = "c1c4b9bee3e09725ddb106b75c1e301fe2f18b26";
      };
    };
    "fill-range-2.2.4" = {
      name = "fill-range";
      packageName = "fill-range";
      version = "2.2.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/fill-range/-/fill-range-2.2.4.tgz";
        sha512 = "cnrcCbj01+j2gTG921VZPnHbjmdAf8oQV/iGeV2kZxGSyfYjjTyY79ErsK1WJWMpw6DaApEX72binqJE+/d+5Q==";
      };
    };
    "fill-range-4.0.0" = {
      name = "fill-range";
      packageName = "fill-range";
      version = "4.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/fill-range/-/fill-range-4.0.0.tgz";
        sha1 = "d544811d428f98eb06a63dc402d2403c328c38f7";
      };
    };
    "finalhandler-1.1.1" = {
      name = "finalhandler";
      packageName = "finalhandler";
      version = "1.1.1";
      src = fetchurl {
        url = "http://registry.npmjs.org/finalhandler/-/finalhandler-1.1.1.tgz";
        sha512 = "Y1GUDo39ez4aHAw7MysnUD5JzYX+WaIj8I57kO3aEPT1fFRL4sr7mjei97FgnwhAyyzRYmQZaTHb2+9uZ1dPtg==";
      };
    };
    "find-cache-dir-1.0.0" = {
      name = "find-cache-dir";
      packageName = "find-cache-dir";
      version = "1.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/find-cache-dir/-/find-cache-dir-1.0.0.tgz";
        sha1 = "9288e3e9e3cc3748717d39eade17cf71fc30ee6f";
      };
    };
    "find-up-1.1.2" = {
      name = "find-up";
      packageName = "find-up";
      version = "1.1.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/find-up/-/find-up-1.1.2.tgz";
        sha1 = "6b2e9822b1a2ce0a60ab64d610eccad53cb24d0f";
      };
    };
    "find-up-2.1.0" = {
      name = "find-up";
      packageName = "find-up";
      version = "2.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/find-up/-/find-up-2.1.0.tgz";
        sha1 = "45d1b7e506c717ddd482775a2b77920a3c0c57a7";
      };
    };
    "fix-path-2.1.0" = {
      name = "fix-path";
      packageName = "fix-path";
      version = "2.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/fix-path/-/fix-path-2.1.0.tgz";
        sha1 = "72ece739de9af4bd63fd02da23e9a70c619b4c38";
      };
    };
    "flatten-1.0.2" = {
      name = "flatten";
      packageName = "flatten";
      version = "1.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/flatten/-/flatten-1.0.2.tgz";
        sha1 = "dae46a9d78fbe25292258cc1e780a41d95c03782";
      };
    };
    "flumecodec-0.0.0" = {
      name = "flumecodec";
      packageName = "flumecodec";
      version = "0.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/flumecodec/-/flumecodec-0.0.0.tgz";
        sha1 = "36ce06abe2e0e01c44dd69f2a165305a2320649b";
      };
    };
    "flumecodec-0.0.1" = {
      name = "flumecodec";
      packageName = "flumecodec";
      version = "0.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/flumecodec/-/flumecodec-0.0.1.tgz";
        sha1 = "ae049a714386bb83e342657a82924b70364a90d6";
      };
    };
    "flumedb-1.0.1" = {
      name = "flumedb";
      packageName = "flumedb";
      version = "1.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/flumedb/-/flumedb-1.0.1.tgz";
        sha512 = "mT0v0dY9EkWRGwDtTfavYNv2Z6nrMNlVZCNJD7qxjfPJymfv8kNYB4UvDdBHleHegvzjufjnE73IkRG5DgMjww==";
      };
    };
    "flumelog-offset-3.3.2" = {
      name = "flumelog-offset";
      packageName = "flumelog-offset";
      version = "3.3.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/flumelog-offset/-/flumelog-offset-3.3.2.tgz";
        sha512 = "KG0TCb+cWuEvnL44xjBhVNu+jRmJ8Msh2b1krYb4FllLwSbjreaCU/hH3uzv+HmUrtU/EhJepcAu79WxLH3EZQ==";
      };
    };
    "flumeview-hashtable-1.0.4" = {
      name = "flumeview-hashtable";
      packageName = "flumeview-hashtable";
      version = "1.0.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/flumeview-hashtable/-/flumeview-hashtable-1.0.4.tgz";
        sha512 = "4L52hBelX7dYVAQQ9uPjksqxOCxLwI4NsfEG/+sTM423axT2Poq5cnfdvGm3HzmNowzwDIKtdy429r6PbfKEIw==";
      };
    };
    "flumeview-level-3.0.6" = {
      name = "flumeview-level";
      packageName = "flumeview-level";
      version = "3.0.6";
      src = fetchurl {
        url = "https://registry.npmjs.org/flumeview-level/-/flumeview-level-3.0.6.tgz";
        sha512 = "omfYDMixWGL8Xx/mFl7xoALZvvOePiN/7jzY/kUJz3TR4px55QV4tZMba63QPyKj7NZVAPE61wq//P5sdiqvQw==";
      };
    };
    "flumeview-query-6.3.0" = {
      name = "flumeview-query";
      packageName = "flumeview-query";
      version = "6.3.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/flumeview-query/-/flumeview-query-6.3.0.tgz";
        sha512 = "8QBannTFLICARmflhHpXNeR5hh6IzIyJz4XhKTofzmxq/hXEn1un7aF6P6dRQkOwthENDTbSB07eWKqwnYDKtw==";
      };
    };
    "flumeview-query-7.1.1" = {
      name = "flumeview-query";
      packageName = "flumeview-query";
      version = "7.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/flumeview-query/-/flumeview-query-7.1.1.tgz";
        sha512 = "3HkgA4u5aIrUIFJ+uRfEpRy/xFwTresz05wf/Sg3NigWrw8JWaGMmHToJpoL8ec9EvYKgP3JNj5wHLw9WEocsA==";
      };
    };
    "flumeview-reduce-1.3.14" = {
      name = "flumeview-reduce";
      packageName = "flumeview-reduce";
      version = "1.3.14";
      src = fetchurl {
        url = "https://registry.npmjs.org/flumeview-reduce/-/flumeview-reduce-1.3.14.tgz";
        sha512 = "hMk9g42JrD92PCmNDiET6JGjur09wQrlAUQRPjmsk8LNqDz/tC5upvCfiynIgWUphe8dZMhUHIzOTh75xa1WKA==";
      };
    };
    "flumeview-search-1.0.6" = {
      name = "flumeview-search";
      packageName = "flumeview-search";
      version = "1.0.6";
      src = fetchurl {
        url = "https://registry.npmjs.org/flumeview-search/-/flumeview-search-1.0.6.tgz";
        sha512 = "gXuKH2Y3/6dkdK2UEOBILnVZcP0mRYeIDZmJK5CB+PjXWn2ZPANSg1vGuKcqMq/bmfbbVtNwsnMFDGWMnhcvPg==";
      };
    };
    "flush-write-stream-1.0.3" = {
      name = "flush-write-stream";
      packageName = "flush-write-stream";
      version = "1.0.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/flush-write-stream/-/flush-write-stream-1.0.3.tgz";
        sha512 = "calZMC10u0FMUqoiunI2AiGIIUtUIvifNwkHhNupZH4cbNnW1Itkoh/Nf5HFYmDrwWPjrUxpkZT0KhuCq0jmGw==";
      };
    };
    "follow-redirects-1.5.10" = {
      name = "follow-redirects";
      packageName = "follow-redirects";
      version = "1.5.10";
      src = fetchurl {
        url = "https://registry.npmjs.org/follow-redirects/-/follow-redirects-1.5.10.tgz";
        sha512 = "0V5l4Cizzvqt5D44aTXbFZz+FtyXV1vrDN6qrelxtfYQKW0KO0W2T/hkE8xvGa/540LkZlkaUjO4ailYTFtHVQ==";
      };
    };
    "for-each-0.3.3" = {
      name = "for-each";
      packageName = "for-each";
      version = "0.3.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/for-each/-/for-each-0.3.3.tgz";
        sha512 = "jqYfLp7mo9vIyQf8ykW2v7A+2N4QjeCeI5+Dz9XraiO1ign81wjiH7Fb9vSOWvQfNtmSa4H2RoQTrrXivdUZmw==";
      };
    };
    "for-in-0.1.8" = {
      name = "for-in";
      packageName = "for-in";
      version = "0.1.8";
      src = fetchurl {
        url = "https://registry.npmjs.org/for-in/-/for-in-0.1.8.tgz";
        sha1 = "d8773908e31256109952b1fdb9b3fa867d2775e1";
      };
    };
    "for-in-1.0.2" = {
      name = "for-in";
      packageName = "for-in";
      version = "1.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/for-in/-/for-in-1.0.2.tgz";
        sha1 = "81068d295a8142ec0ac726c6e2200c30fb6d5e80";
      };
    };
    "for-own-0.1.5" = {
      name = "for-own";
      packageName = "for-own";
      version = "0.1.5";
      src = fetchurl {
        url = "https://registry.npmjs.org/for-own/-/for-own-0.1.5.tgz";
        sha1 = "5265c681a4f294dabbf17c9509b6763aa84510ce";
      };
    };
    "for-own-1.0.0" = {
      name = "for-own";
      packageName = "for-own";
      version = "1.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/for-own/-/for-own-1.0.0.tgz";
        sha1 = "c63332f415cedc4b04dbfe70cf836494c53cb44b";
      };
    };
    "forever-agent-0.6.1" = {
      name = "forever-agent";
      packageName = "forever-agent";
      version = "0.6.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/forever-agent/-/forever-agent-0.6.1.tgz";
        sha1 = "fbc71f0c41adeb37f96c577ad1ed42d8fdacca91";
      };
    };
    "forked-systray-3.0.10" = {
      name = "forked-systray";
      packageName = "forked-systray";
      version = "3.0.10";
      src = fetchurl {
        url = "https://registry.npmjs.org/forked-systray/-/forked-systray-3.0.10.tgz";
        sha512 = "89ATraLpLe0WqBR7Uvgg6qo8rPvR/UnwP8ZlQSeYhgqcOeUtCYqvI541pElYt5fbFzqVQb5sKpmijsNoSbvERw==";
      };
    };
    "form-data-2.3.3" = {
      name = "form-data";
      packageName = "form-data";
      version = "2.3.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/form-data/-/form-data-2.3.3.tgz";
        sha512 = "1lLKB2Mu3aGP1Q/2eCOx0fNbRMe7XdwktwOruhfqqd0rIJWwN4Dh+E3hrPSlDCXnSR7UtZ1N38rVXm+6+MEhJQ==";
      };
    };
    "forwarded-0.1.2" = {
      name = "forwarded";
      packageName = "forwarded";
      version = "0.1.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/forwarded/-/forwarded-0.1.2.tgz";
        sha1 = "98c23dab1175657b8c0573e8ceccd91b0ff18c84";
      };
    };
    "fragment-cache-0.2.1" = {
      name = "fragment-cache";
      packageName = "fragment-cache";
      version = "0.2.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/fragment-cache/-/fragment-cache-0.2.1.tgz";
        sha1 = "4290fad27f13e89be7f33799c6bc5a0abfff0d19";
      };
    };
    "fresh-0.5.2" = {
      name = "fresh";
      packageName = "fresh";
      version = "0.5.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/fresh/-/fresh-0.5.2.tgz";
        sha1 = "3d8cadd90d976569fa835ab1f8e4b23a105605a7";
      };
    };
    "from2-2.3.0" = {
      name = "from2";
      packageName = "from2";
      version = "2.3.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/from2/-/from2-2.3.0.tgz";
        sha1 = "8bfb5502bde4a4d36cfdeea007fcca21d7e382af";
      };
    };
    "fs-constants-1.0.0" = {
      name = "fs-constants";
      packageName = "fs-constants";
      version = "1.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/fs-constants/-/fs-constants-1.0.0.tgz";
        sha512 = "y6OAwoSIf7FyjMIv94u+b5rdheZEjzR63GTyZJm5qh4Bi+2YgwLCcI/fPFZkL5PSixOt6ZNKm+w+Hfp/Bciwow==";
      };
    };
    "fs-extra-4.0.3" = {
      name = "fs-extra";
      packageName = "fs-extra";
      version = "4.0.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/fs-extra/-/fs-extra-4.0.3.tgz";
        sha512 = "q6rbdDd1o2mAnQreO7YADIxf/Whx4AHBiRf6d+/cVT8h44ss+lHgxf1FemcqDnQt9X3ct4McHr+JMGlYSsK7Cg==";
      };
    };
    "fs-write-stream-atomic-1.0.10" = {
      name = "fs-write-stream-atomic";
      packageName = "fs-write-stream-atomic";
      version = "1.0.10";
      src = fetchurl {
        url = "https://registry.npmjs.org/fs-write-stream-atomic/-/fs-write-stream-atomic-1.0.10.tgz";
        sha1 = "b47df53493ef911df75731e70a9ded0189db40c9";
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
    "fsevents-1.2.4" = {
      name = "fsevents";
      packageName = "fsevents";
      version = "1.2.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/fsevents/-/fsevents-1.2.4.tgz";
        sha512 = "z8H8/diyk76B7q5wg+Ud0+CqzcAF3mBBI/bA5ne5zrRUUIvNkJY//D3BqyH571KuAC4Nr7Rw7CjWX4r0y9DvNg==";
      };
    };
    "fstream-1.0.11" = {
      name = "fstream";
      packageName = "fstream";
      version = "1.0.11";
      src = fetchurl {
        url = "https://registry.npmjs.org/fstream/-/fstream-1.0.11.tgz";
        sha1 = "5c1fb1f117477114f0632a0eb4b71b3cb0fd3171";
      };
    };
    "ftp-0.3.10" = {
      name = "ftp";
      packageName = "ftp";
      version = "0.3.10";
      src = fetchurl {
        url = "https://registry.npmjs.org/ftp/-/ftp-0.3.10.tgz";
        sha1 = "9197d861ad8142f3e63d5a83bfe4c59f7330885d";
      };
    };
    "function-bind-1.1.1" = {
      name = "function-bind";
      packageName = "function-bind";
      version = "1.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/function-bind/-/function-bind-1.1.1.tgz";
        sha512 = "yIovAzMX49sF8Yl58fSCWJ5svSLuaibPxXQJFLmBObTuCr0Mf1KiPopGM9NiFjiYBCbfaa2Fh6breQ6ANVTI0A==";
      };
    };
    "gauge-2.7.4" = {
      name = "gauge";
      packageName = "gauge";
      version = "2.7.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/gauge/-/gauge-2.7.4.tgz";
        sha1 = "2c03405c7538c39d7eb37b317022e325fb018bf7";
      };
    };
    "gaze-1.1.3" = {
      name = "gaze";
      packageName = "gaze";
      version = "1.1.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/gaze/-/gaze-1.1.3.tgz";
        sha512 = "BRdNm8hbWzFzWHERTrejLqwHDfS4GibPoq5wjTPIoJHoBtKGPg3xAFfxmM+9ztbXelxcf2hwQcaz1PtmFeue8g==";
      };
    };
    "generate-function-2.3.1" = {
      name = "generate-function";
      packageName = "generate-function";
      version = "2.3.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/generate-function/-/generate-function-2.3.1.tgz";
        sha512 = "eeB5GfMNeevm/GRYq20ShmsaGcmI81kIX2K9XQx5miC8KdHaC6Jm0qQ8ZNeGOi7wYB8OsdxKs+Y2oVuTFuVwKQ==";
      };
    };
    "generate-object-property-1.2.0" = {
      name = "generate-object-property";
      packageName = "generate-object-property";
      version = "1.2.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/generate-object-property/-/generate-object-property-1.2.0.tgz";
        sha1 = "9c0e1c40308ce804f4783618b937fa88f99d50d0";
      };
    };
    "get-caller-file-1.0.3" = {
      name = "get-caller-file";
      packageName = "get-caller-file";
      version = "1.0.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/get-caller-file/-/get-caller-file-1.0.3.tgz";
        sha512 = "3t6rVToeoZfYSGd8YoLFR2DJkiQrIiUrGcjvFX2mDw3bn6k2OtwHN0TNCLbBO+w8qTvimhDkv+LSscbJY1vE6w==";
      };
    };
    "get-func-name-2.0.0" = {
      name = "get-func-name";
      packageName = "get-func-name";
      version = "2.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/get-func-name/-/get-func-name-2.0.0.tgz";
        sha1 = "ead774abee72e20409433a066366023dd6887a41";
      };
    };
    "get-stdin-4.0.1" = {
      name = "get-stdin";
      packageName = "get-stdin";
      version = "4.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/get-stdin/-/get-stdin-4.0.1.tgz";
        sha1 = "b968c6b0a04384324902e8bf1a5df32579a450fe";
      };
    };
    "get-stream-2.3.1" = {
      name = "get-stream";
      packageName = "get-stream";
      version = "2.3.1";
      src = fetchurl {
        url = "http://registry.npmjs.org/get-stream/-/get-stream-2.3.1.tgz";
        sha1 = "5f38f93f346009666ee0150a054167f91bdd95de";
      };
    };
    "get-stream-3.0.0" = {
      name = "get-stream";
      packageName = "get-stream";
      version = "3.0.0";
      src = fetchurl {
        url = "http://registry.npmjs.org/get-stream/-/get-stream-3.0.0.tgz";
        sha1 = "8e943d1358dc37555054ecbe2edb05aa174ede14";
      };
    };
    "get-uri-2.0.2" = {
      name = "get-uri";
      packageName = "get-uri";
      version = "2.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/get-uri/-/get-uri-2.0.2.tgz";
        sha512 = "ZD325dMZOgerGqF/rF6vZXyFGTAay62svjQIT+X/oU2PtxYpFxvSkbsdi+oxIrsNxlZVd4y8wUDqkaExWTI/Cw==";
      };
    };
    "get-value-2.0.6" = {
      name = "get-value";
      packageName = "get-value";
      version = "2.0.6";
      src = fetchurl {
        url = "https://registry.npmjs.org/get-value/-/get-value-2.0.6.tgz";
        sha1 = "dc15ca1c672387ca76bd37ac0a395ba2042a2c28";
      };
    };
    "getpass-0.1.7" = {
      name = "getpass";
      packageName = "getpass";
      version = "0.1.7";
      src = fetchurl {
        url = "https://registry.npmjs.org/getpass/-/getpass-0.1.7.tgz";
        sha1 = "5eff8e3e684d569ae4cb2b1282604e8ba62149fa";
      };
    };
    "github-from-package-0.0.0" = {
      name = "github-from-package";
      packageName = "github-from-package";
      version = "0.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/github-from-package/-/github-from-package-0.0.0.tgz";
        sha1 = "97fb5d96bfde8973313f20e8288ef9a167fa64ce";
      };
    };
    "glob-6.0.4" = {
      name = "glob";
      packageName = "glob";
      version = "6.0.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/glob/-/glob-6.0.4.tgz";
        sha1 = "0f08860f6a155127b2fadd4f9ce24b1aab6e4d22";
      };
    };
    "glob-7.0.5" = {
      name = "glob";
      packageName = "glob";
      version = "7.0.5";
      src = fetchurl {
        url = "https://registry.npmjs.org/glob/-/glob-7.0.5.tgz";
        sha1 = "b4202a69099bbb4d292a7c1b95b6682b67ebdc95";
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
    "glob-base-0.3.0" = {
      name = "glob-base";
      packageName = "glob-base";
      version = "0.3.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/glob-base/-/glob-base-0.3.0.tgz";
        sha1 = "dbb164f6221b1c0b1ccf82aea328b497df0ea3c4";
      };
    };
    "glob-parent-2.0.0" = {
      name = "glob-parent";
      packageName = "glob-parent";
      version = "2.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/glob-parent/-/glob-parent-2.0.0.tgz";
        sha1 = "81383d72db054fcccf5336daa902f182f6edbb28";
      };
    };
    "glob-parent-3.1.0" = {
      name = "glob-parent";
      packageName = "glob-parent";
      version = "3.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/glob-parent/-/glob-parent-3.1.0.tgz";
        sha1 = "9e6af6299d8d3bd2bd40430832bd113df906c5ae";
      };
    };
    "globals-11.9.0" = {
      name = "globals";
      packageName = "globals";
      version = "11.9.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/globals/-/globals-11.9.0.tgz";
        sha512 = "5cJVtyXWH8PiJPVLZzzoIizXx944O4OmRro5MWKx5fT4MgcN7OfaMutPeaTdJCCURwbWdhhcCWcKIffPnmTzBg==";
      };
    };
    "globals-9.18.0" = {
      name = "globals";
      packageName = "globals";
      version = "9.18.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/globals/-/globals-9.18.0.tgz";
        sha512 = "S0nG3CLEQiY/ILxqtztTWH/3iRRdyBLw6KMDxnKMchrtbj2OFmehVh0WUCfW3DUrIgx/qFrJPICrq4Z4sTR9UQ==";
      };
    };
    "globby-4.1.0" = {
      name = "globby";
      packageName = "globby";
      version = "4.1.0";
      src = fetchurl {
        url = "http://registry.npmjs.org/globby/-/globby-4.1.0.tgz";
        sha1 = "080f54549ec1b82a6c60e631fc82e1211dbe95f8";
      };
    };
    "globby-6.1.0" = {
      name = "globby";
      packageName = "globby";
      version = "6.1.0";
      src = fetchurl {
        url = "http://registry.npmjs.org/globby/-/globby-6.1.0.tgz";
        sha1 = "f5a6d70e8395e21c858fb0489d64df02424d506c";
      };
    };
    "globby-7.1.1" = {
      name = "globby";
      packageName = "globby";
      version = "7.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/globby/-/globby-7.1.1.tgz";
        sha1 = "fb2ccff9401f8600945dfada97440cca972b8680";
      };
    };
    "globule-1.2.1" = {
      name = "globule";
      packageName = "globule";
      version = "1.2.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/globule/-/globule-1.2.1.tgz";
        sha512 = "g7QtgWF4uYSL5/dn71WxubOrS7JVGCnFPEnoeChJmBnyR9Mw8nGoEwOgJL/RC2Te0WhbsEUCejfH8SZNJ+adYQ==";
      };
    };
    "gossip-query-0.2.3" = {
      name = "gossip-query";
      packageName = "gossip-query";
      version = "0.2.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/gossip-query/-/gossip-query-0.2.3.tgz";
        sha512 = "j5q/bbD+B/md03ho7QxhT1Ao6KBUV3PetbveQXEfQyqojG0kkXBxnkHjjMcWTMzP1anlk0JxaA1mFsRU8hrFXQ==";
      };
    };
    "graceful-fs-4.1.15" = {
      name = "graceful-fs";
      packageName = "graceful-fs";
      version = "4.1.15";
      src = fetchurl {
        url = "https://registry.npmjs.org/graceful-fs/-/graceful-fs-4.1.15.tgz";
        sha512 = "6uHUhOPEBgQ24HM+r6b/QwWfZq+yiFcipKFrOFiBEnWdy5sdzYoi+pJeQaPI5qOLRFqWmAXUPQNsielzdLoecA==";
      };
    };
    "graceful-readlink-1.0.1" = {
      name = "graceful-readlink";
      packageName = "graceful-readlink";
      version = "1.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/graceful-readlink/-/graceful-readlink-1.0.1.tgz";
        sha1 = "4cafad76bc62f02fa039b2f94e9a3dd3a391a725";
      };
    };
    "grapheme-splitter-1.0.4" = {
      name = "grapheme-splitter";
      packageName = "grapheme-splitter";
      version = "1.0.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/grapheme-splitter/-/grapheme-splitter-1.0.4.tgz";
        sha512 = "bzh50DW9kTPM00T8y4o8vQg89Di9oLJVLW/KaOGIXJWP/iqCN6WKYkbNOF04vFLJhwcpYUh9ydh/+5vpOqV4YQ==";
      };
    };
    "graphlib-2.1.7" = {
      name = "graphlib";
      packageName = "graphlib";
      version = "2.1.7";
      src = fetchurl {
        url = "https://registry.npmjs.org/graphlib/-/graphlib-2.1.7.tgz";
        sha512 = "TyI9jIy2J4j0qgPmOOrHTCtpPqJGN/aurBwc6ZT+bRii+di1I+Wv3obRhVrmBEXet+qkMaEX67dXrwsd3QQM6w==";
      };
    };
    "graphreduce-3.0.4" = {
      name = "graphreduce";
      packageName = "graphreduce";
      version = "3.0.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/graphreduce/-/graphreduce-3.0.4.tgz";
        sha1 = "bf442d0a878e83901e5ef3e652d23ffb5b831ed7";
      };
    };
    "growl-1.9.2" = {
      name = "growl";
      packageName = "growl";
      version = "1.9.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/growl/-/growl-1.9.2.tgz";
        sha1 = "0ea7743715db8d8de2c5ede1775e1b45ac85c02f";
      };
    };
    "growly-1.3.0" = {
      name = "growly";
      packageName = "growly";
      version = "1.3.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/growly/-/growly-1.3.0.tgz";
        sha1 = "f10748cbe76af964b7c96c93c6bcc28af120c081";
      };
    };
    "gunzip-maybe-1.4.1" = {
      name = "gunzip-maybe";
      packageName = "gunzip-maybe";
      version = "1.4.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/gunzip-maybe/-/gunzip-maybe-1.4.1.tgz";
        sha512 = "qtutIKMthNJJgeHQS7kZ9FqDq59/Wn0G2HYCRNjpup7yKfVI6/eqwpmroyZGFoCYaG+sW6psNVb4zoLADHpp2g==";
      };
    };
    "handle-thing-1.2.5" = {
      name = "handle-thing";
      packageName = "handle-thing";
      version = "1.2.5";
      src = fetchurl {
        url = "http://registry.npmjs.org/handle-thing/-/handle-thing-1.2.5.tgz";
        sha1 = "fd7aad726bf1a5fd16dfc29b2f7a6601d27139c4";
      };
    };
    "har-schema-2.0.0" = {
      name = "har-schema";
      packageName = "har-schema";
      version = "2.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/har-schema/-/har-schema-2.0.0.tgz";
        sha1 = "a94c2224ebcac04782a0d9035521f24735b7ec92";
      };
    };
    "har-validator-5.1.3" = {
      name = "har-validator";
      packageName = "har-validator";
      version = "5.1.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/har-validator/-/har-validator-5.1.3.tgz";
        sha512 = "sNvOCzEQNr/qrvJgc3UG/kD4QtlHycrzwS+6mfTrrSq97BvaYcPZZI1ZSqGSPR73Cxn4LKTD4PttRwfU7jWq5g==";
      };
    };
    "has-1.0.3" = {
      name = "has";
      packageName = "has";
      version = "1.0.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/has/-/has-1.0.3.tgz";
        sha512 = "f2dvO0VU6Oej7RkWJGrehjbzMAjFp5/VKPp5tTpWIV4JHHZK1/BxbFRtf/siA2SWTe09caDmVtYYzWEIbBS4zw==";
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
    "has-flag-1.0.0" = {
      name = "has-flag";
      packageName = "has-flag";
      version = "1.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/has-flag/-/has-flag-1.0.0.tgz";
        sha1 = "9d9e793165ce017a00f00418c43f942a7b1d11fa";
      };
    };
    "has-flag-2.0.0" = {
      name = "has-flag";
      packageName = "has-flag";
      version = "2.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/has-flag/-/has-flag-2.0.0.tgz";
        sha1 = "e8207af1cc7b30d446cc70b734b5e8be18f88d51";
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
    "has-network-0.0.1" = {
      name = "has-network";
      packageName = "has-network";
      version = "0.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/has-network/-/has-network-0.0.1.tgz";
        sha1 = "3eea7b44caa9601797124be8ba89d228c4101499";
      };
    };
    "has-symbols-1.0.0" = {
      name = "has-symbols";
      packageName = "has-symbols";
      version = "1.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/has-symbols/-/has-symbols-1.0.0.tgz";
        sha1 = "ba1a8f1af2a0fc39650f5c850367704122063b44";
      };
    };
    "has-unicode-2.0.1" = {
      name = "has-unicode";
      packageName = "has-unicode";
      version = "2.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/has-unicode/-/has-unicode-2.0.1.tgz";
        sha1 = "e0e6fe6a28cf51138855e086d1691e771de2a8b9";
      };
    };
    "has-value-0.3.1" = {
      name = "has-value";
      packageName = "has-value";
      version = "0.3.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/has-value/-/has-value-0.3.1.tgz";
        sha1 = "7b1f58bada62ca827ec0a2078025654845995e1f";
      };
    };
    "has-value-1.0.0" = {
      name = "has-value";
      packageName = "has-value";
      version = "1.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/has-value/-/has-value-1.0.0.tgz";
        sha1 = "18b281da585b1c5c51def24c930ed29a0be6b177";
      };
    };
    "has-values-0.1.4" = {
      name = "has-values";
      packageName = "has-values";
      version = "0.1.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/has-values/-/has-values-0.1.4.tgz";
        sha1 = "6d61de95d91dfca9b9a02089ad384bff8f62b771";
      };
    };
    "has-values-1.0.0" = {
      name = "has-values";
      packageName = "has-values";
      version = "1.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/has-values/-/has-values-1.0.0.tgz";
        sha1 = "95b0b63fec2146619a6fe57fe75628d5a39efe4f";
      };
    };
    "hash-base-3.0.4" = {
      name = "hash-base";
      packageName = "hash-base";
      version = "3.0.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/hash-base/-/hash-base-3.0.4.tgz";
        sha1 = "5fc8686847ecd73499403319a6b0a3f3f6ae4918";
      };
    };
    "hash-sum-1.0.2" = {
      name = "hash-sum";
      packageName = "hash-sum";
      version = "1.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/hash-sum/-/hash-sum-1.0.2.tgz";
        sha1 = "33b40777754c6432573c120cc3808bbd10d47f04";
      };
    };
    "hash.js-1.1.7" = {
      name = "hash.js";
      packageName = "hash.js";
      version = "1.1.7";
      src = fetchurl {
        url = "https://registry.npmjs.org/hash.js/-/hash.js-1.1.7.tgz";
        sha512 = "taOaskGt4z4SOANNseOviYDvjEJinIkRgmp7LbKP2YTTmVxWBl87s/uzK9r+44BclBSp2X7K1hqeNfz9JbBeXA==";
      };
    };
    "hashlru-2.3.0" = {
      name = "hashlru";
      packageName = "hashlru";
      version = "2.3.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/hashlru/-/hashlru-2.3.0.tgz";
        sha512 = "0cMsjjIC8I+D3M44pOQdsy0OHXGLVz6Z0beRuufhKa0KfaD2wGwAev6jILzXsd3/vpnNQJmWyZtIILqM1N+n5A==";
      };
    };
    "he-0.5.0" = {
      name = "he";
      packageName = "he";
      version = "0.5.0";
      src = fetchurl {
        url = "http://registry.npmjs.org/he/-/he-0.5.0.tgz";
        sha1 = "2c05ffaef90b68e860f3fd2b54ef580989277ee2";
      };
    };
    "he-1.2.0" = {
      name = "he";
      packageName = "he";
      version = "1.2.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/he/-/he-1.2.0.tgz";
        sha512 = "F/1DnUGPopORZi0ni+CvrCgHQ5FyEAHRLSApuYWMmrbSwoN2Mn/7k+Gl38gJnR7yyDZk6WLXwiGod1JOWNDKGw==";
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
    "heap-0.2.6" = {
      name = "heap";
      packageName = "heap";
      version = "0.2.6";
      src = fetchurl {
        url = "https://registry.npmjs.org/heap/-/heap-0.2.6.tgz";
        sha1 = "087e1f10b046932fc8594dd9e6d378afc9d1e5ac";
      };
    };
    "highlight.js-9.13.1" = {
      name = "highlight.js";
      packageName = "highlight.js";
      version = "9.13.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/highlight.js/-/highlight.js-9.13.1.tgz";
        sha512 = "Sc28JNQNDzaH6PORtRLMvif9RSn1mYuOoX3omVjnb0+HbpPygU2ALBI0R/wsiqCb4/fcp07Gdo8g+fhtFrQl6A==";
      };
    };
    "hmac-drbg-1.0.1" = {
      name = "hmac-drbg";
      packageName = "hmac-drbg";
      version = "1.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/hmac-drbg/-/hmac-drbg-1.0.1.tgz";
        sha1 = "d2745701025a6c775a6c545793ed502fc0c649a1";
      };
    };
    "home-or-tmp-2.0.0" = {
      name = "home-or-tmp";
      packageName = "home-or-tmp";
      version = "2.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/home-or-tmp/-/home-or-tmp-2.0.0.tgz";
        sha1 = "e36c3f2d2cae7d746a857e38d18d5f32a7882db8";
      };
    };
    "hoox-0.0.1" = {
      name = "hoox";
      packageName = "hoox";
      version = "0.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/hoox/-/hoox-0.0.1.tgz";
        sha1 = "08a74d9272a9cc83ae8e6bbe0303f0ee76432094";
      };
    };
    "hosted-git-info-2.7.1" = {
      name = "hosted-git-info";
      packageName = "hosted-git-info";
      version = "2.7.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/hosted-git-info/-/hosted-git-info-2.7.1.tgz";
        sha512 = "7T/BxH19zbcCTa8XkMlbK5lTo1WtgkFi3GvdWEyNuc4Vex7/9Dqbnpsf4JMydcfj9HCg4zUWFTL3Za6lapg5/w==";
      };
    };
    "hpack.js-2.1.6" = {
      name = "hpack.js";
      packageName = "hpack.js";
      version = "2.1.6";
      src = fetchurl {
        url = "https://registry.npmjs.org/hpack.js/-/hpack.js-2.1.6.tgz";
        sha1 = "87774c0949e513f42e84575b3c45681fade2a0b2";
      };
    };
    "html-comment-regex-1.1.2" = {
      name = "html-comment-regex";
      packageName = "html-comment-regex";
      version = "1.1.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/html-comment-regex/-/html-comment-regex-1.1.2.tgz";
        sha512 = "P+M65QY2JQ5Y0G9KKdlDpo0zK+/OHptU5AaBwUfAIDJZk1MYf32Frm84EcOytfJE0t5JvkAnKlmjsXDnWzCJmQ==";
      };
    };
    "html-entities-1.2.1" = {
      name = "html-entities";
      packageName = "html-entities";
      version = "1.2.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/html-entities/-/html-entities-1.2.1.tgz";
        sha1 = "0df29351f0721163515dfb9e5543e5f6eed5162f";
      };
    };
    "html-minifier-3.5.21" = {
      name = "html-minifier";
      packageName = "html-minifier";
      version = "3.5.21";
      src = fetchurl {
        url = "https://registry.npmjs.org/html-minifier/-/html-minifier-3.5.21.tgz";
        sha512 = "LKUKwuJDhxNa3uf/LPR/KVjm/l3rBqtYeCOAekvG8F1vItxMUpueGd94i/asDDr8/1u7InxzFA5EeGjhhG5mMA==";
      };
    };
    "html-webpack-plugin-2.30.1" = {
      name = "html-webpack-plugin";
      packageName = "html-webpack-plugin";
      version = "2.30.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/html-webpack-plugin/-/html-webpack-plugin-2.30.1.tgz";
        sha1 = "7f9c421b7ea91ec460f56527d78df484ee7537d5";
      };
    };
    "htmlparser2-3.3.0" = {
      name = "htmlparser2";
      packageName = "htmlparser2";
      version = "3.3.0";
      src = fetchurl {
        url = "http://registry.npmjs.org/htmlparser2/-/htmlparser2-3.3.0.tgz";
        sha1 = "cc70d05a59f6542e43f0e685c982e14c924a9efe";
      };
    };
    "http-deceiver-1.2.7" = {
      name = "http-deceiver";
      packageName = "http-deceiver";
      version = "1.2.7";
      src = fetchurl {
        url = "https://registry.npmjs.org/http-deceiver/-/http-deceiver-1.2.7.tgz";
        sha1 = "fa7168944ab9a519d337cb0bec7284dc3e723d87";
      };
    };
    "http-errors-1.6.3" = {
      name = "http-errors";
      packageName = "http-errors";
      version = "1.6.3";
      src = fetchurl {
        url = "http://registry.npmjs.org/http-errors/-/http-errors-1.6.3.tgz";
        sha1 = "8b55680bb4be283a0b5bf4ea2e38580be1d9320d";
      };
    };
    "http-parser-js-0.5.0" = {
      name = "http-parser-js";
      packageName = "http-parser-js";
      version = "0.5.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/http-parser-js/-/http-parser-js-0.5.0.tgz";
        sha512 = "cZdEF7r4gfRIq7ezX9J0T+kQmJNOub71dWbgAXVHDct80TKP4MCETtZQ31xyv38UwgzkWPYF/Xc0ge55dW9Z9w==";
      };
    };
    "http-proxy-1.17.0" = {
      name = "http-proxy";
      packageName = "http-proxy";
      version = "1.17.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/http-proxy/-/http-proxy-1.17.0.tgz";
        sha512 = "Taqn+3nNvYRfJ3bGvKfBSRwy1v6eePlm3oc/aWVxZp57DQr5Eq3xhKJi7Z4hZpS8PC3H4qI+Yly5EmFacGuA/g==";
      };
    };
    "http-proxy-agent-1.0.0" = {
      name = "http-proxy-agent";
      packageName = "http-proxy-agent";
      version = "1.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/http-proxy-agent/-/http-proxy-agent-1.0.0.tgz";
        sha1 = "cc1ce38e453bf984a0f7702d2dd59c73d081284a";
      };
    };
    "http-proxy-middleware-0.17.4" = {
      name = "http-proxy-middleware";
      packageName = "http-proxy-middleware";
      version = "0.17.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/http-proxy-middleware/-/http-proxy-middleware-0.17.4.tgz";
        sha1 = "642e8848851d66f09d4f124912846dbaeb41b833";
      };
    };
    "http-signature-1.2.0" = {
      name = "http-signature";
      packageName = "http-signature";
      version = "1.2.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/http-signature/-/http-signature-1.2.0.tgz";
        sha1 = "9aecd925114772f3d95b65a60abb8f7c18fbace1";
      };
    };
    "https-browserify-1.0.0" = {
      name = "https-browserify";
      packageName = "https-browserify";
      version = "1.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/https-browserify/-/https-browserify-1.0.0.tgz";
        sha1 = "ec06c10e0a34c0f2faf199f7fd7fc78fffd03c73";
      };
    };
    "https-proxy-agent-1.0.0" = {
      name = "https-proxy-agent";
      packageName = "https-proxy-agent";
      version = "1.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/https-proxy-agent/-/https-proxy-agent-1.0.0.tgz";
        sha1 = "35f7da6c48ce4ddbfa264891ac593ee5ff8671e6";
      };
    };
    "i-0.3.6" = {
      name = "i";
      packageName = "i";
      version = "0.3.6";
      src = fetchurl {
        url = "https://registry.npmjs.org/i/-/i-0.3.6.tgz";
        sha1 = "d96c92732076f072711b6b10fd7d4f65ad8ee23d";
      };
    };
    "iconv-lite-0.4.23" = {
      name = "iconv-lite";
      packageName = "iconv-lite";
      version = "0.4.23";
      src = fetchurl {
        url = "https://registry.npmjs.org/iconv-lite/-/iconv-lite-0.4.23.tgz";
        sha512 = "neyTUVFtahjf0mB3dZT77u+8O0QB89jFdnBkd5P1JgYPbPaia3gXXOVL2fq8VyU2gMMD7SaN7QukTB/pmXYvDA==";
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
    "icss-replace-symbols-1.1.0" = {
      name = "icss-replace-symbols";
      packageName = "icss-replace-symbols";
      version = "1.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/icss-replace-symbols/-/icss-replace-symbols-1.1.0.tgz";
        sha1 = "06ea6f83679a7749e386cfe1fe812ae5db223ded";
      };
    };
    "icss-utils-2.1.0" = {
      name = "icss-utils";
      packageName = "icss-utils";
      version = "2.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/icss-utils/-/icss-utils-2.1.0.tgz";
        sha1 = "83f0a0ec378bf3246178b6c2ad9136f135b1c962";
      };
    };
    "ieee754-1.1.12" = {
      name = "ieee754";
      packageName = "ieee754";
      version = "1.1.12";
      src = fetchurl {
        url = "https://registry.npmjs.org/ieee754/-/ieee754-1.1.12.tgz";
        sha512 = "GguP+DRY+pJ3soyIiGPTvdiVXjZ+DbXOxGpXn3eMvNW4x4irjqXm4wHKscC+TfxSJ0yw/S1F24tqdMNsMZTiLA==";
      };
    };
    "if-async-3.7.4" = {
      name = "if-async";
      packageName = "if-async";
      version = "3.7.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/if-async/-/if-async-3.7.4.tgz";
        sha1 = "55868deb0093d3c67bf7166e745353fb9bcb21a2";
      };
    };
    "iferr-0.1.5" = {
      name = "iferr";
      packageName = "iferr";
      version = "0.1.5";
      src = fetchurl {
        url = "https://registry.npmjs.org/iferr/-/iferr-0.1.5.tgz";
        sha1 = "c60eed69e6d8fdb6b3104a1fcbca1c192dc5b501";
      };
    };
    "ignore-3.3.10" = {
      name = "ignore";
      packageName = "ignore";
      version = "3.3.10";
      src = fetchurl {
        url = "https://registry.npmjs.org/ignore/-/ignore-3.3.10.tgz";
        sha512 = "Pgs951kaMm5GXP7MOvxERINe3gsaVjUWFm+UZPSq9xYriQAksyhg0csnS0KXSNRD5NmNdapXEpjxG49+AKh/ug==";
      };
    };
    "import-local-1.0.0" = {
      name = "import-local";
      packageName = "import-local";
      version = "1.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/import-local/-/import-local-1.0.0.tgz";
        sha512 = "vAaZHieK9qjGo58agRBg+bhHX3hoTZU/Oa3GESWLz7t1U62fk63aHuDJJEteXoDeTCcPmUT+z38gkHPZkkmpmQ==";
      };
    };
    "imurmurhash-0.1.4" = {
      name = "imurmurhash";
      packageName = "imurmurhash";
      version = "0.1.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/imurmurhash/-/imurmurhash-0.1.4.tgz";
        sha1 = "9218b9b2b928a238b13dc4fb6b6d576f231453ea";
      };
    };
    "in-publish-2.0.0" = {
      name = "in-publish";
      packageName = "in-publish";
      version = "2.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/in-publish/-/in-publish-2.0.0.tgz";
        sha1 = "e20ff5e3a2afc2690320b6dc552682a9c7fadf51";
      };
    };
    "increment-buffer-1.0.1" = {
      name = "increment-buffer";
      packageName = "increment-buffer";
      version = "1.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/increment-buffer/-/increment-buffer-1.0.1.tgz";
        sha1 = "65076d75189d808b39ad13ab5b958e05216f9e0d";
      };
    };
    "indent-string-2.1.0" = {
      name = "indent-string";
      packageName = "indent-string";
      version = "2.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/indent-string/-/indent-string-2.1.0.tgz";
        sha1 = "8e2d48348742121b4a8218b7a137e9a52049dc80";
      };
    };
    "indexes-of-1.0.1" = {
      name = "indexes-of";
      packageName = "indexes-of";
      version = "1.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/indexes-of/-/indexes-of-1.0.1.tgz";
        sha1 = "f30f716c8e2bd346c7b67d3df3915566a7c05607";
      };
    };
    "indexof-0.0.1" = {
      name = "indexof";
      packageName = "indexof";
      version = "0.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/indexof/-/indexof-0.0.1.tgz";
        sha1 = "82dc336d232b9062179d05ab3293a66059fd435d";
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
    "inherits-2.0.1" = {
      name = "inherits";
      packageName = "inherits";
      version = "2.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/inherits/-/inherits-2.0.1.tgz";
        sha1 = "b17d08d326b4423e568eff719f91b0b1cbdf69f1";
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
    "ini-1.3.5" = {
      name = "ini";
      packageName = "ini";
      version = "1.3.5";
      src = fetchurl {
        url = "https://registry.npmjs.org/ini/-/ini-1.3.5.tgz";
        sha512 = "RZY5huIKCMRWDUqZlEi72f/lmXKMvuszcMBduliQ3nnWbx9X/ZBQO7DijMEYS9EhHBb2qacRUMtC7svLwe0lcw==";
      };
    };
    "inject-loader-3.0.1" = {
      name = "inject-loader";
      packageName = "inject-loader";
      version = "3.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/inject-loader/-/inject-loader-3.0.1.tgz";
        sha512 = "0Kd4NqMJUhknG4ECiJ/mgyHJBpfBBWZ3IKHl2BLNQiFtMO7/xiv9mmHl7mGvE0iKrBeQAZdMcQP3sMXZN0cqeg==";
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
    "inquirer-3.3.0" = {
      name = "inquirer";
      packageName = "inquirer";
      version = "3.3.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/inquirer/-/inquirer-3.3.0.tgz";
        sha512 = "h+xtnyk4EwKvFWHrUYsWErEVR+igKtLdchu+o0Z1RL7VU/jVMFbYir2bp6bAj8efFNxWqHX0dIss6fJQ+/+qeQ==";
      };
    };
    "int53-0.2.4" = {
      name = "int53";
      packageName = "int53";
      version = "0.2.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/int53/-/int53-0.2.4.tgz";
        sha1 = "5ed8d7aad6c5c6567cae69aa7ffc4a109ee80f86";
      };
    };
    "internal-ip-1.2.0" = {
      name = "internal-ip";
      packageName = "internal-ip";
      version = "1.2.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/internal-ip/-/internal-ip-1.2.0.tgz";
        sha1 = "ae9fbf93b984878785d50a8de1b356956058cf5c";
      };
    };
    "interpret-1.1.0" = {
      name = "interpret";
      packageName = "interpret";
      version = "1.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/interpret/-/interpret-1.1.0.tgz";
        sha1 = "7ed1b1410c6a0e0f78cf95d3b8440c63f78b8614";
      };
    };
    "invariant-2.2.4" = {
      name = "invariant";
      packageName = "invariant";
      version = "2.2.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/invariant/-/invariant-2.2.4.tgz";
        sha512 = "phJfQVBuaJM5raOpJjSfkiD6BpbCE4Ns//LaXl6wGYtUBY83nWS6Rf9tXm2e8VaK60JEjYldbPif/A2B1C2gNA==";
      };
    };
    "invert-kv-1.0.0" = {
      name = "invert-kv";
      packageName = "invert-kv";
      version = "1.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/invert-kv/-/invert-kv-1.0.0.tgz";
        sha1 = "104a8e4aaca6d3d8cd157a8ef8bfab2d7a3ffdb6";
      };
    };
    "ip-1.0.1" = {
      name = "ip";
      packageName = "ip";
      version = "1.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/ip/-/ip-1.0.1.tgz";
        sha1 = "c7e356cdea225ae71b36d70f2e71a92ba4e42590";
      };
    };
    "ip-1.1.5" = {
      name = "ip";
      packageName = "ip";
      version = "1.1.5";
      src = fetchurl {
        url = "https://registry.npmjs.org/ip/-/ip-1.1.5.tgz";
        sha1 = "bdded70114290828c0a039e72ef25f5aaec4354a";
      };
    };
    "ipaddr.js-1.8.0" = {
      name = "ipaddr.js";
      packageName = "ipaddr.js";
      version = "1.8.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/ipaddr.js/-/ipaddr.js-1.8.0.tgz";
        sha1 = "eaa33d6ddd7ace8f7f6fe0c9ca0440e706738b1e";
      };
    };
    "irregular-plurals-1.4.0" = {
      name = "irregular-plurals";
      packageName = "irregular-plurals";
      version = "1.4.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/irregular-plurals/-/irregular-plurals-1.4.0.tgz";
        sha1 = "2ca9b033651111855412f16be5d77c62a458a766";
      };
    };
    "is-absolute-url-2.1.0" = {
      name = "is-absolute-url";
      packageName = "is-absolute-url";
      version = "2.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/is-absolute-url/-/is-absolute-url-2.1.0.tgz";
        sha1 = "50530dfb84fcc9aa7dbe7852e83a37b93b9f2aa6";
      };
    };
    "is-accessor-descriptor-0.1.6" = {
      name = "is-accessor-descriptor";
      packageName = "is-accessor-descriptor";
      version = "0.1.6";
      src = fetchurl {
        url = "http://registry.npmjs.org/is-accessor-descriptor/-/is-accessor-descriptor-0.1.6.tgz";
        sha1 = "a9e12cb3ae8d876727eeef3843f8a0897b5c98d6";
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
    "is-alphabetical-1.0.2" = {
      name = "is-alphabetical";
      packageName = "is-alphabetical";
      version = "1.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/is-alphabetical/-/is-alphabetical-1.0.2.tgz";
        sha512 = "V0xN4BYezDHcBSKb1QHUFMlR4as/XEuCZBzMJUU4n7+Cbt33SmUnSol+pnXFvLxSHNq2CemUXNdaXV6Flg7+xg==";
      };
    };
    "is-alphanumerical-1.0.2" = {
      name = "is-alphanumerical";
      packageName = "is-alphanumerical";
      version = "1.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/is-alphanumerical/-/is-alphanumerical-1.0.2.tgz";
        sha512 = "pyfU/0kHdISIgslFfZN9nfY1Gk3MquQgUm1mJTjdkEPpkAKNWuBTSqFwewOpR7N351VkErCiyV71zX7mlQQqsg==";
      };
    };
    "is-arrayish-0.2.1" = {
      name = "is-arrayish";
      packageName = "is-arrayish";
      version = "0.2.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/is-arrayish/-/is-arrayish-0.2.1.tgz";
        sha1 = "77c99840527aa8ecb1a8ba697b80645a7a926a9d";
      };
    };
    "is-binary-path-1.0.1" = {
      name = "is-binary-path";
      packageName = "is-binary-path";
      version = "1.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/is-binary-path/-/is-binary-path-1.0.1.tgz";
        sha1 = "75f16642b480f187a711c814161fd3a4a7655898";
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
    "is-builtin-module-1.0.0" = {
      name = "is-builtin-module";
      packageName = "is-builtin-module";
      version = "1.0.0";
      src = fetchurl {
        url = "http://registry.npmjs.org/is-builtin-module/-/is-builtin-module-1.0.0.tgz";
        sha1 = "540572d34f7ac3119f8f76c30cbc1b1e037affbe";
      };
    };
    "is-callable-1.1.4" = {
      name = "is-callable";
      packageName = "is-callable";
      version = "1.1.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/is-callable/-/is-callable-1.1.4.tgz";
        sha512 = "r5p9sxJjYnArLjObpjA4xu5EKI3CuKHkJXMhT7kwbpUyIFD1n5PMAsoPvWnvtZiNz7LjkYDRZhd7FlI0eMijEA==";
      };
    };
    "is-canonical-base64-1.1.1" = {
      name = "is-canonical-base64";
      packageName = "is-canonical-base64";
      version = "1.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/is-canonical-base64/-/is-canonical-base64-1.1.1.tgz";
        sha512 = "o6t/DwgEapC0bsloqtegAQyZzQXaQ5+8fzsyf2KmLqupC2ifLFq/lMQiFCJeGpdSrK1o6GL+WW2lRU050lLlFg==";
      };
    };
    "is-data-descriptor-0.1.4" = {
      name = "is-data-descriptor";
      packageName = "is-data-descriptor";
      version = "0.1.4";
      src = fetchurl {
        url = "http://registry.npmjs.org/is-data-descriptor/-/is-data-descriptor-0.1.4.tgz";
        sha1 = "0b5ee648388e2c860282e793f1856fec3f301b56";
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
    "is-date-object-1.0.1" = {
      name = "is-date-object";
      packageName = "is-date-object";
      version = "1.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/is-date-object/-/is-date-object-1.0.1.tgz";
        sha1 = "9aa20eb6aeebbff77fbd33e74ca01b33581d3a16";
      };
    };
    "is-decimal-1.0.2" = {
      name = "is-decimal";
      packageName = "is-decimal";
      version = "1.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/is-decimal/-/is-decimal-1.0.2.tgz";
        sha512 = "TRzl7mOCchnhchN+f3ICUCzYvL9ul7R+TYOsZ8xia++knyZAJfv/uA1FvQXsAnYIl1T3B2X5E/J7Wb1QXiIBXg==";
      };
    };
    "is-deflate-1.0.0" = {
      name = "is-deflate";
      packageName = "is-deflate";
      version = "1.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/is-deflate/-/is-deflate-1.0.0.tgz";
        sha1 = "c862901c3c161fb09dac7cdc7e784f80e98f2f14";
      };
    };
    "is-descriptor-0.1.6" = {
      name = "is-descriptor";
      packageName = "is-descriptor";
      version = "0.1.6";
      src = fetchurl {
        url = "https://registry.npmjs.org/is-descriptor/-/is-descriptor-0.1.6.tgz";
        sha512 = "avDYr0SB3DwO9zsMov0gKCESFYqCnE4hq/4z3TdUlukEy5t9C0YRq7HLrsN52NAcqXKaepeCD0n+B0arnVG3Hg==";
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
    "is-directory-0.3.1" = {
      name = "is-directory";
      packageName = "is-directory";
      version = "0.3.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/is-directory/-/is-directory-0.3.1.tgz";
        sha1 = "61339b6f2475fc772fd9c9d83f5c8575dc154ae1";
      };
    };
    "is-dotfile-1.0.3" = {
      name = "is-dotfile";
      packageName = "is-dotfile";
      version = "1.0.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/is-dotfile/-/is-dotfile-1.0.3.tgz";
        sha1 = "a6a2f32ffd2dfb04f5ca25ecd0f6b83cf798a1e1";
      };
    };
    "is-electron-2.2.0" = {
      name = "is-electron";
      packageName = "is-electron";
      version = "2.2.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/is-electron/-/is-electron-2.2.0.tgz";
        sha512 = "SpMppC2XR3YdxSzczXReBjqs2zGscWQpBIKqwXYBFic0ERaxNVgwLCHwOLZeESfdJQjX0RDvrJ1lBXX2ij+G1Q==";
      };
    };
    "is-equal-shallow-0.1.3" = {
      name = "is-equal-shallow";
      packageName = "is-equal-shallow";
      version = "0.1.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/is-equal-shallow/-/is-equal-shallow-0.1.3.tgz";
        sha1 = "2238098fc221de0bcfa5d9eac4c45d638aa1c534";
      };
    };
    "is-extendable-0.1.1" = {
      name = "is-extendable";
      packageName = "is-extendable";
      version = "0.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/is-extendable/-/is-extendable-0.1.1.tgz";
        sha1 = "62b110e289a471418e3ec36a617d472e301dfc89";
      };
    };
    "is-extendable-1.0.1" = {
      name = "is-extendable";
      packageName = "is-extendable";
      version = "1.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/is-extendable/-/is-extendable-1.0.1.tgz";
        sha512 = "arnXMxT1hhoKo9k1LZdmlNyJdDDfy2v0fXjFlmok4+i8ul/6WlbVge9bhM74OpNPQPMGUToDtz+KXa1PneJxOA==";
      };
    };
    "is-extglob-1.0.0" = {
      name = "is-extglob";
      packageName = "is-extglob";
      version = "1.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/is-extglob/-/is-extglob-1.0.0.tgz";
        sha1 = "ac468177c4943405a092fc8f29760c6ffc6206c0";
      };
    };
    "is-extglob-2.1.1" = {
      name = "is-extglob";
      packageName = "is-extglob";
      version = "2.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/is-extglob/-/is-extglob-2.1.1.tgz";
        sha1 = "a88c02535791f02ed37c76a1b9ea9773c833f8c2";
      };
    };
    "is-finite-1.0.2" = {
      name = "is-finite";
      packageName = "is-finite";
      version = "1.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/is-finite/-/is-finite-1.0.2.tgz";
        sha1 = "cc6677695602be550ef11e8b4aa6305342b6d0aa";
      };
    };
    "is-fullwidth-code-point-1.0.0" = {
      name = "is-fullwidth-code-point";
      packageName = "is-fullwidth-code-point";
      version = "1.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/is-fullwidth-code-point/-/is-fullwidth-code-point-1.0.0.tgz";
        sha1 = "ef9e31386f031a7f0d643af82fde50c457ef00cb";
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
    "is-glob-2.0.1" = {
      name = "is-glob";
      packageName = "is-glob";
      version = "2.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/is-glob/-/is-glob-2.0.1.tgz";
        sha1 = "d096f926a3ded5600f3fdfd91198cb0888c2d863";
      };
    };
    "is-glob-3.1.0" = {
      name = "is-glob";
      packageName = "is-glob";
      version = "3.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/is-glob/-/is-glob-3.1.0.tgz";
        sha1 = "7ba5ae24217804ac70707b96922567486cc3e84a";
      };
    };
    "is-glob-4.0.0" = {
      name = "is-glob";
      packageName = "is-glob";
      version = "4.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/is-glob/-/is-glob-4.0.0.tgz";
        sha1 = "9521c76845cc2610a85203ddf080a958c2ffabc0";
      };
    };
    "is-gzip-1.0.0" = {
      name = "is-gzip";
      packageName = "is-gzip";
      version = "1.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/is-gzip/-/is-gzip-1.0.0.tgz";
        sha1 = "6ca8b07b99c77998025900e555ced8ed80879a83";
      };
    };
    "is-hexadecimal-1.0.2" = {
      name = "is-hexadecimal";
      packageName = "is-hexadecimal";
      version = "1.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/is-hexadecimal/-/is-hexadecimal-1.0.2.tgz";
        sha512 = "but/G3sapV3MNyqiDBLrOi4x8uCIw0RY3o/Vb5GT0sMFHrVV7731wFSVy41T5FO1og7G0gXLJh0MkgPRouko/A==";
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
    "is-my-ip-valid-1.0.0" = {
      name = "is-my-ip-valid";
      packageName = "is-my-ip-valid";
      version = "1.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/is-my-ip-valid/-/is-my-ip-valid-1.0.0.tgz";
        sha512 = "gmh/eWXROncUzRnIa1Ubrt5b8ep/MGSnfAUI3aRp+sqTCs1tv1Isl8d8F6JmkN3dXKc3ehZMrtiPN9eL03NuaQ==";
      };
    };
    "is-my-json-valid-2.19.0" = {
      name = "is-my-json-valid";
      packageName = "is-my-json-valid";
      version = "2.19.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/is-my-json-valid/-/is-my-json-valid-2.19.0.tgz";
        sha512 = "mG0f/unGX1HZ5ep4uhRaPOS8EkAY8/j6mDRMJrutq4CqhoJWYp7qAlonIPy3TV7p3ju4TK9fo/PbnoksWmsp5Q==";
      };
    };
    "is-number-2.1.0" = {
      name = "is-number";
      packageName = "is-number";
      version = "2.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/is-number/-/is-number-2.1.0.tgz";
        sha1 = "01fcbbb393463a548f2f466cce16dece49db908f";
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
    "is-number-4.0.0" = {
      name = "is-number";
      packageName = "is-number";
      version = "4.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/is-number/-/is-number-4.0.0.tgz";
        sha512 = "rSklcAIlf1OmFdyAqbnWTLVelsQ58uvZ66S/ZyawjWqIviTWCjg2PzVGw8WUA+nNuPTqb4wgA+NszrJ+08LlgQ==";
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
    "is-plain-obj-1.1.0" = {
      name = "is-plain-obj";
      packageName = "is-plain-obj";
      version = "1.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/is-plain-obj/-/is-plain-obj-1.1.0.tgz";
        sha1 = "71a50c8429dfca773c92a390a4a03b39fcd51d3e";
      };
    };
    "is-plain-object-2.0.4" = {
      name = "is-plain-object";
      packageName = "is-plain-object";
      version = "2.0.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/is-plain-object/-/is-plain-object-2.0.4.tgz";
        sha512 = "h5PpgXkWitc38BBMYawTYMWJHFZJVnBquFE57xFpjB8pJFiF6gZ+bU+WyI/yqXiFR5mdLsgYNaPe8uao6Uv9Og==";
      };
    };
    "is-posix-bracket-0.1.1" = {
      name = "is-posix-bracket";
      packageName = "is-posix-bracket";
      version = "0.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/is-posix-bracket/-/is-posix-bracket-0.1.1.tgz";
        sha1 = "3334dc79774368e92f016e6fbc0a88f5cd6e6bc4";
      };
    };
    "is-primitive-2.0.0" = {
      name = "is-primitive";
      packageName = "is-primitive";
      version = "2.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/is-primitive/-/is-primitive-2.0.0.tgz";
        sha1 = "207bab91638499c07b2adf240a41a87210034575";
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
    "is-property-1.0.2" = {
      name = "is-property";
      packageName = "is-property";
      version = "1.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/is-property/-/is-property-1.0.2.tgz";
        sha1 = "57fe1c4e48474edd65b09911f26b1cd4095dda84";
      };
    };
    "is-regex-1.0.4" = {
      name = "is-regex";
      packageName = "is-regex";
      version = "1.0.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/is-regex/-/is-regex-1.0.4.tgz";
        sha1 = "5517489b547091b0930e095654ced25ee97e9491";
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
    "is-svg-2.1.0" = {
      name = "is-svg";
      packageName = "is-svg";
      version = "2.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/is-svg/-/is-svg-2.1.0.tgz";
        sha1 = "cf61090da0d9efbcab8722deba6f032208dbb0e9";
      };
    };
    "is-symbol-1.0.2" = {
      name = "is-symbol";
      packageName = "is-symbol";
      version = "1.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/is-symbol/-/is-symbol-1.0.2.tgz";
        sha512 = "HS8bZ9ox60yCJLH9snBpIwv9pYUAkcuLhSA1oero1UB5y9aiQpRA8y2ex945AOtCZL1lJDeIk3G5LthswI46Lw==";
      };
    };
    "is-typedarray-1.0.0" = {
      name = "is-typedarray";
      packageName = "is-typedarray";
      version = "1.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/is-typedarray/-/is-typedarray-1.0.0.tgz";
        sha1 = "e479c80858df0c1b11ddda6940f96011fcda4a9a";
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
    "is-utf8-0.2.1" = {
      name = "is-utf8";
      packageName = "is-utf8";
      version = "0.2.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/is-utf8/-/is-utf8-0.2.1.tgz";
        sha1 = "4b0da1442104d1b336340e80797e865cf39f7d72";
      };
    };
    "is-valid-domain-0.0.6" = {
      name = "is-valid-domain";
      packageName = "is-valid-domain";
      version = "0.0.6";
      src = fetchurl {
        url = "https://registry.npmjs.org/is-valid-domain/-/is-valid-domain-0.0.6.tgz";
        sha512 = "XXiNRcLcNKeb0LB3PzB39gJa8QiA+6nnc4NX9zNvFQcaITWU+64hfVqaVppbSd3tSVlJttW6sINkX3xLKPax7A==";
      };
    };
    "is-windows-1.0.2" = {
      name = "is-windows";
      packageName = "is-windows";
      version = "1.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/is-windows/-/is-windows-1.0.2.tgz";
        sha512 = "eXK1UInq2bPmjyX6e3VHIzMLobc4J94i4AWn+Hpq3OU5KkrRC96OAcR3PRJ/pGu6m8TRnBHP9dkXQVsT/COVIA==";
      };
    };
    "is-wsl-1.1.0" = {
      name = "is-wsl";
      packageName = "is-wsl";
      version = "1.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/is-wsl/-/is-wsl-1.1.0.tgz";
        sha1 = "1f16e4aa22b04d1336b66188a66af3c600c3a66d";
      };
    };
    "isarray-0.0.1" = {
      name = "isarray";
      packageName = "isarray";
      version = "0.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/isarray/-/isarray-0.0.1.tgz";
        sha1 = "8a18acfca9a8f4177e09abfc6038939b05d1eedf";
      };
    };
    "isarray-1.0.0" = {
      name = "isarray";
      packageName = "isarray";
      version = "1.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/isarray/-/isarray-1.0.0.tgz";
        sha1 = "bb935d48582cba168c06834957a54a3e07124f11";
      };
    };
    "isexe-2.0.0" = {
      name = "isexe";
      packageName = "isexe";
      version = "2.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/isexe/-/isexe-2.0.0.tgz";
        sha1 = "e8fbf374dc556ff8947a10dcb0572d633f2cfa10";
      };
    };
    "isobject-2.1.0" = {
      name = "isobject";
      packageName = "isobject";
      version = "2.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/isobject/-/isobject-2.1.0.tgz";
        sha1 = "f065561096a3f1da2ef46272f815c840d87e0c89";
      };
    };
    "isobject-3.0.1" = {
      name = "isobject";
      packageName = "isobject";
      version = "3.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/isobject/-/isobject-3.0.1.tgz";
        sha1 = "4e431e92b11a9731636aa1f9c8d1ccbcfdab78df";
      };
    };
    "isstream-0.1.2" = {
      name = "isstream";
      packageName = "isstream";
      version = "0.1.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/isstream/-/isstream-0.1.2.tgz";
        sha1 = "47e63f7af55afa6f92e1500e690eb8b8529c099a";
      };
    };
    "istanbul-lib-coverage-1.2.1" = {
      name = "istanbul-lib-coverage";
      packageName = "istanbul-lib-coverage";
      version = "1.2.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/istanbul-lib-coverage/-/istanbul-lib-coverage-1.2.1.tgz";
        sha512 = "PzITeunAgyGbtY1ibVIUiV679EFChHjoMNRibEIobvmrCRaIgwLxNucOSimtNWUhEib/oO7QY2imD75JVgCJWQ==";
      };
    };
    "istanbul-lib-instrument-1.10.2" = {
      name = "istanbul-lib-instrument";
      packageName = "istanbul-lib-instrument";
      version = "1.10.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/istanbul-lib-instrument/-/istanbul-lib-instrument-1.10.2.tgz";
        sha512 = "aWHxfxDqvh/ZlxR8BBaEPVSWDPUkGD63VjGQn3jcw8jCp7sHEMKcrj4xfJn/ABzdMEHiQNyvDQhqm5o8+SQg7A==";
      };
    };
    "jquery-3.3.1" = {
      name = "jquery";
      packageName = "jquery";
      version = "3.3.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/jquery/-/jquery-3.3.1.tgz";
        sha512 = "Ubldcmxp5np52/ENotGxlLe6aGMvmF4R8S6tZjsP6Knsaxd/xp3Zrh50cG93lR6nPXyUFwzN3ZSOQI0wRJNdGg==";
      };
    };
    "js-base64-2.5.0" = {
      name = "js-base64";
      packageName = "js-base64";
      version = "2.5.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/js-base64/-/js-base64-2.5.0.tgz";
        sha512 = "wlEBIZ5LP8usDylWbDNhKPEFVFdI5hCHpnVoT/Ysvoi/PRhJENm/Rlh9TvjYB38HFfKZN7OzEbRjmjvLkFw11g==";
      };
    };
    "js-tokens-3.0.2" = {
      name = "js-tokens";
      packageName = "js-tokens";
      version = "3.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/js-tokens/-/js-tokens-3.0.2.tgz";
        sha1 = "9866df395102130e38f7f996bceb65443209c25b";
      };
    };
    "js-yaml-3.7.0" = {
      name = "js-yaml";
      packageName = "js-yaml";
      version = "3.7.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/js-yaml/-/js-yaml-3.7.0.tgz";
        sha1 = "5c967ddd837a9bfdca5f2de84253abe8a1c03b80";
      };
    };
    "jsbn-0.1.1" = {
      name = "jsbn";
      packageName = "jsbn";
      version = "0.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/jsbn/-/jsbn-0.1.1.tgz";
        sha1 = "a5e654c2e5a2deb5f201d96cefbca80c0ef2f513";
      };
    };
    "jsesc-0.5.0" = {
      name = "jsesc";
      packageName = "jsesc";
      version = "0.5.0";
      src = fetchurl {
        url = "http://registry.npmjs.org/jsesc/-/jsesc-0.5.0.tgz";
        sha1 = "e7dee66e35d6fc16f710fe91d5cf69f70f08911d";
      };
    };
    "jsesc-1.3.0" = {
      name = "jsesc";
      packageName = "jsesc";
      version = "1.3.0";
      src = fetchurl {
        url = "http://registry.npmjs.org/jsesc/-/jsesc-1.3.0.tgz";
        sha1 = "46c3fec8c1892b12b0833db9bc7622176dbab34b";
      };
    };
    "jsesc-2.5.2" = {
      name = "jsesc";
      packageName = "jsesc";
      version = "2.5.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/jsesc/-/jsesc-2.5.2.tgz";
        sha512 = "OYu7XEzjkCQ3C5Ps3QIZsQfNpqoJyZZA99wd9aWd05NCtC5pWOkShK2mkL6HXQR6/Cy2lbNdPlZBpuQHXE63gA==";
      };
    };
    "json-buffer-2.0.11" = {
      name = "json-buffer";
      packageName = "json-buffer";
      version = "2.0.11";
      src = fetchurl {
        url = "http://registry.npmjs.org/json-buffer/-/json-buffer-2.0.11.tgz";
        sha1 = "3e441fda3098be8d1e3171ad591bc62a33e2d55f";
      };
    };
    "json-loader-0.5.7" = {
      name = "json-loader";
      packageName = "json-loader";
      version = "0.5.7";
      src = fetchurl {
        url = "https://registry.npmjs.org/json-loader/-/json-loader-0.5.7.tgz";
        sha512 = "QLPs8Dj7lnf3e3QYS1zkCo+4ZwqOiF9d/nZnYozTISxXWCfNs9yuky5rJw4/W34s7POaNlbZmQGaB5NiXCbP4w==";
      };
    };
    "json-schema-0.2.3" = {
      name = "json-schema";
      packageName = "json-schema";
      version = "0.2.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/json-schema/-/json-schema-0.2.3.tgz";
        sha1 = "b480c892e59a2f05954ce727bd3f2a4e882f9e13";
      };
    };
    "json-schema-traverse-0.3.1" = {
      name = "json-schema-traverse";
      packageName = "json-schema-traverse";
      version = "0.3.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/json-schema-traverse/-/json-schema-traverse-0.3.1.tgz";
        sha1 = "349a6d44c53a51de89b40805c5d5e59b417d3340";
      };
    };
    "json-schema-traverse-0.4.1" = {
      name = "json-schema-traverse";
      packageName = "json-schema-traverse";
      version = "0.4.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/json-schema-traverse/-/json-schema-traverse-0.4.1.tgz";
        sha512 = "xbbCH5dCYU5T8LcEhhuh7HJ88HXuW3qsI3Y0zOZFKfZEHcpWiHU/Jxzk629Brsab/mMiHQti9wMP+845RPe3Vg==";
      };
    };
    "json-stringify-safe-5.0.1" = {
      name = "json-stringify-safe";
      packageName = "json-stringify-safe";
      version = "5.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/json-stringify-safe/-/json-stringify-safe-5.0.1.tgz";
        sha1 = "1296a2d58fd45f19a0f6ce01d65701e2c735b6eb";
      };
    };
    "json3-3.3.2" = {
      name = "json3";
      packageName = "json3";
      version = "3.3.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/json3/-/json3-3.3.2.tgz";
        sha1 = "3c0434743df93e2f5c42aee7b19bcb483575f4e1";
      };
    };
    "json5-0.5.1" = {
      name = "json5";
      packageName = "json5";
      version = "0.5.1";
      src = fetchurl {
        url = "http://registry.npmjs.org/json5/-/json5-0.5.1.tgz";
        sha1 = "1eade7acc012034ad84e2396767ead9fa5495821";
      };
    };
    "jsonfile-2.4.0" = {
      name = "jsonfile";
      packageName = "jsonfile";
      version = "2.4.0";
      src = fetchurl {
        url = "http://registry.npmjs.org/jsonfile/-/jsonfile-2.4.0.tgz";
        sha1 = "3736a2b428b87bbda0cc83b53fa3d633a35c2ae8";
      };
    };
    "jsonfile-4.0.0" = {
      name = "jsonfile";
      packageName = "jsonfile";
      version = "4.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/jsonfile/-/jsonfile-4.0.0.tgz";
        sha1 = "8771aae0799b64076b76640fca058f9c10e33ecb";
      };
    };
    "jsonpointer-4.0.1" = {
      name = "jsonpointer";
      packageName = "jsonpointer";
      version = "4.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/jsonpointer/-/jsonpointer-4.0.1.tgz";
        sha1 = "4fd92cb34e0e9db3c89c8622ecf51f9b978c6cb9";
      };
    };
    "jsprim-1.4.1" = {
      name = "jsprim";
      packageName = "jsprim";
      version = "1.4.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/jsprim/-/jsprim-1.4.1.tgz";
        sha1 = "313e66bc1e5cc06e438bc1b7499c2e5c56acb6a2";
      };
    };
    "killable-1.0.1" = {
      name = "killable";
      packageName = "killable";
      version = "1.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/killable/-/killable-1.0.1.tgz";
        sha512 = "LzqtLKlUwirEUyl/nicirVmNiPvYs7l5n8wOPP7fyJVpUPkvCnW/vuiXGpylGUlnPDnB7311rARzAt3Mhswpjg==";
      };
    };
    "kind-of-2.0.1" = {
      name = "kind-of";
      packageName = "kind-of";
      version = "2.0.1";
      src = fetchurl {
        url = "http://registry.npmjs.org/kind-of/-/kind-of-2.0.1.tgz";
        sha1 = "018ec7a4ce7e3a86cb9141be519d24c8faa981b5";
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
    "kind-of-4.0.0" = {
      name = "kind-of";
      packageName = "kind-of";
      version = "4.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/kind-of/-/kind-of-4.0.0.tgz";
        sha1 = "20813df3d712928b207378691a45066fae72dd57";
      };
    };
    "kind-of-5.1.0" = {
      name = "kind-of";
      packageName = "kind-of";
      version = "5.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/kind-of/-/kind-of-5.1.0.tgz";
        sha512 = "NGEErnH6F2vUuXDh+OlbcKW7/wOcfdRHaZ7VWtqCztfHri/++YKmP51OdWeGPuqCOba6kk2OTe5d02VmTB80Pw==";
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
    "layered-graph-1.1.2" = {
      name = "layered-graph";
      packageName = "layered-graph";
      version = "1.1.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/layered-graph/-/layered-graph-1.1.2.tgz";
        sha512 = "OaV2u8eMWxUkVYTGhXKDBjFBVPONubDJfnw6dy6ndZDTANfZeeapq35x3oWnqpW1GxbulXuf7fMhxy97r+k2Sg==";
      };
    };
    "lazy-cache-1.0.4" = {
      name = "lazy-cache";
      packageName = "lazy-cache";
      version = "1.0.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/lazy-cache/-/lazy-cache-1.0.4.tgz";
        sha1 = "a1d78fc3a50474cb80845d3b3b6e1da49a446e8e";
      };
    };
    "lazystream-1.0.0" = {
      name = "lazystream";
      packageName = "lazystream";
      version = "1.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/lazystream/-/lazystream-1.0.0.tgz";
        sha1 = "f6995fe0f820392f61396be89462407bb77168e4";
      };
    };
    "lcid-1.0.0" = {
      name = "lcid";
      packageName = "lcid";
      version = "1.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/lcid/-/lcid-1.0.0.tgz";
        sha1 = "308accafa0bc483a3867b4b6f2b9506251d1b835";
      };
    };
    "level-3.0.2" = {
      name = "level";
      packageName = "level";
      version = "3.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/level/-/level-3.0.2.tgz";
        sha512 = "2qYbbiptPsPWGUI+AgB1gTNXqIjPpALRqrQyNx1zWYNZxhhuzEj/IE4Unu9weEBnsUEocfYe56xOGlAceb8/Fg==";
      };
    };
    "level-4.0.0" = {
      name = "level";
      packageName = "level";
      version = "4.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/level/-/level-4.0.0.tgz";
        sha512 = "4epzCOlEcJ529NOdlAYiuiakS/kZTDdiKSBNJmE1B8bsmA+zEVwcpxyH86qJSQTpOu7SODrlaD9WgPRHLkGutA==";
      };
    };
    "level-codec-6.2.0" = {
      name = "level-codec";
      packageName = "level-codec";
      version = "6.2.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/level-codec/-/level-codec-6.2.0.tgz";
        sha1 = "a4b5244bb6a4c2f723d68a1d64e980c53627d9d4";
      };
    };
    "level-codec-8.0.0" = {
      name = "level-codec";
      packageName = "level-codec";
      version = "8.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/level-codec/-/level-codec-8.0.0.tgz";
        sha512 = "gNZlo1HRHz0BWxzGCyNf7xntAs2HKOPvvRBWtXsoDvEX4vMYnSTBS6ZnxoaiX7nhxSBPpegRa8CQ/hnfGBKk3Q==";
      };
    };
    "level-codec-9.0.0" = {
      name = "level-codec";
      packageName = "level-codec";
      version = "9.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/level-codec/-/level-codec-9.0.0.tgz";
        sha512 = "OIpVvjCcZNP5SdhcNupnsI1zo5Y9Vpm+k/F1gfG5kXrtctlrwanisakweJtE0uA0OpLukRfOQae+Fg0M5Debhg==";
      };
    };
    "level-errors-1.1.2" = {
      name = "level-errors";
      packageName = "level-errors";
      version = "1.1.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/level-errors/-/level-errors-1.1.2.tgz";
        sha512 = "Sw/IJwWbPKF5Ai4Wz60B52yj0zYeqzObLh8k1Tk88jVmD51cJSKWSYpRyhVIvFzZdvsPqlH5wfhp/yxdsaQH4w==";
      };
    };
    "level-errors-2.0.0" = {
      name = "level-errors";
      packageName = "level-errors";
      version = "2.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/level-errors/-/level-errors-2.0.0.tgz";
        sha512 = "AmY4HCp9h3OiU19uG+3YWkdELgy05OTP/r23aNHaQKWv8DO787yZgsEuGVkoph40uwN+YdUKnANlrxSsoOaaxg==";
      };
    };
    "level-iterator-stream-2.0.3" = {
      name = "level-iterator-stream";
      packageName = "level-iterator-stream";
      version = "2.0.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/level-iterator-stream/-/level-iterator-stream-2.0.3.tgz";
        sha512 = "I6Heg70nfF+e5Y3/qfthJFexhRw/Gi3bIymCoXAlijZdAcLaPuWSJs3KXyTYf23ID6g0o2QF62Yh+grOXY3Rig==";
      };
    };
    "level-iterator-stream-3.0.1" = {
      name = "level-iterator-stream";
      packageName = "level-iterator-stream";
      version = "3.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/level-iterator-stream/-/level-iterator-stream-3.0.1.tgz";
        sha512 = "nEIQvxEED9yRThxvOrq8Aqziy4EGzrxSZK+QzEFAVuJvQ8glfyZ96GB6BoI4sBbLfjMXm2w4vu3Tkcm9obcY0g==";
      };
    };
    "level-packager-2.1.1" = {
      name = "level-packager";
      packageName = "level-packager";
      version = "2.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/level-packager/-/level-packager-2.1.1.tgz";
        sha512 = "6l3G6dVkmdvHwOJrEA9d9hL6SSFrzwjQoLP8HsvohOgfY/8Z9LyTKNCM5Gc84wtsUWCuIHu6r+S6WrCtTWUJCw==";
      };
    };
    "level-packager-3.1.0" = {
      name = "level-packager";
      packageName = "level-packager";
      version = "3.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/level-packager/-/level-packager-3.1.0.tgz";
        sha512 = "UxVEfK5WH0u0InR3WxTCSAroiorAGKzXWZT6i+nBjambmvINuXFUsFx2Ai3UIjUUtnyWhluv42jMlzUZCsAk9A==";
      };
    };
    "level-post-1.0.7" = {
      name = "level-post";
      packageName = "level-post";
      version = "1.0.7";
      src = fetchurl {
        url = "https://registry.npmjs.org/level-post/-/level-post-1.0.7.tgz";
        sha512 = "PWYqG4Q00asOrLhX7BejSajByB4EmG2GaKHfj3h5UmmZ2duciXLPGYWIjBzLECFWUGOZWlm5B20h/n3Gs3HKew==";
      };
    };
    "level-sublevel-6.6.5" = {
      name = "level-sublevel";
      packageName = "level-sublevel";
      version = "6.6.5";
      src = fetchurl {
        url = "https://registry.npmjs.org/level-sublevel/-/level-sublevel-6.6.5.tgz";
        sha512 = "SBSR60x+dghhwGUxPKS+BvV1xNqnwsEUBKmnFepPaHJ6VkBXyPK9SImGc3K2BkwBfpxlt7GKkBNlCnrdufsejA==";
      };
    };
    "leveldown-3.0.2" = {
      name = "leveldown";
      packageName = "leveldown";
      version = "3.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/leveldown/-/leveldown-3.0.2.tgz";
        sha512 = "+ANRScj1npQQzv6e4DYAKRjVQZZ+ahMoubKrNP68nIq+l9bYgb+WiXF+14oTcQTg2f7qE9WHGW7rBG9nGSsA+A==";
      };
    };
    "leveldown-4.0.1" = {
      name = "leveldown";
      packageName = "leveldown";
      version = "4.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/leveldown/-/leveldown-4.0.1.tgz";
        sha512 = "ZlBKVSsglPIPJnz4ggB8o2R0bxDxbsMzuQohbfgoFMVApyTE118DK5LNRG0cRju6rt3OkGxe0V6UYACGlq/byg==";
      };
    };
    "levelup-0.19.1" = {
      name = "levelup";
      packageName = "levelup";
      version = "0.19.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/levelup/-/levelup-0.19.1.tgz";
        sha1 = "f3a6a7205272c4b5f35e412ff004a03a0aedf50b";
      };
    };
    "levelup-2.0.2" = {
      name = "levelup";
      packageName = "levelup";
      version = "2.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/levelup/-/levelup-2.0.2.tgz";
        sha512 = "us+nTLUyd/eLnclYYddOCdAVw1hnymGx/9p4Jr5ThohStsjLqMVmbYiz6/SYFZEPXNF+AKQSvh6fA2e2KZpC8w==";
      };
    };
    "levelup-3.1.1" = {
      name = "levelup";
      packageName = "levelup";
      version = "3.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/levelup/-/levelup-3.1.1.tgz";
        sha512 = "9N10xRkUU4dShSRRFTBdNaBxofz+PGaIZO962ckboJZiNmLuhVT6FZ6ZKAsICKfUBO76ySaYU6fJWX/jnj3Lcg==";
      };
    };
    "levn-0.3.0" = {
      name = "levn";
      packageName = "levn";
      version = "0.3.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/levn/-/levn-0.3.0.tgz";
        sha1 = "3b09924edf9f083c0490fdd4c0bc4421e04764ee";
      };
    };
    "libnested-1.4.1" = {
      name = "libnested";
      packageName = "libnested";
      version = "1.4.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/libnested/-/libnested-1.4.1.tgz";
        sha512 = "7fvNHrU8QTep71gIJuz7z6iBAQULEHJOcIA0MKUlwFrSnntvOvnke+/tnR7ZxyRAQQ303UJXNZBSRz3r0N5tqw==";
      };
    };
    "libsodium-0.7.3" = {
      name = "libsodium";
      packageName = "libsodium";
      version = "0.7.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/libsodium/-/libsodium-0.7.3.tgz";
        sha512 = "ld+deUNqSsZYbAobUs63UyduPq8ICp/Ul/5lbvBIYpuSNWpPRU0PIxbW+xXipVZtuopR6fIz9e0tTnNuPMNeqw==";
      };
    };
    "libsodium-wrappers-0.7.3" = {
      name = "libsodium-wrappers";
      packageName = "libsodium-wrappers";
      version = "0.7.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/libsodium-wrappers/-/libsodium-wrappers-0.7.3.tgz";
        sha512 = "dw5Jh6TZ5qc5rQVZe3JrSO/J05CE+DmAPnqD7Q2glBUE969xZ6o3fchnUxyPlp6ss3x0MFxmdJntveFN+XTg1g==";
      };
    };
    "load-json-file-1.1.0" = {
      name = "load-json-file";
      packageName = "load-json-file";
      version = "1.1.0";
      src = fetchurl {
        url = "http://registry.npmjs.org/load-json-file/-/load-json-file-1.1.0.tgz";
        sha1 = "956905708d58b4bab4c2261b04f59f31c99374c0";
      };
    };
    "load-json-file-2.0.0" = {
      name = "load-json-file";
      packageName = "load-json-file";
      version = "2.0.0";
      src = fetchurl {
        url = "http://registry.npmjs.org/load-json-file/-/load-json-file-2.0.0.tgz";
        sha1 = "7947e42149af80d696cbf797bcaabcfe1fe29ca8";
      };
    };
    "loader-runner-2.3.1" = {
      name = "loader-runner";
      packageName = "loader-runner";
      version = "2.3.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/loader-runner/-/loader-runner-2.3.1.tgz";
        sha512 = "By6ZFY7ETWOc9RFaAIb23IjJVcM4dvJC/N57nmdz9RSkMXvAXGI7SyVlAw3v8vjtDRlqThgVDVmTnr9fqMlxkw==";
      };
    };
    "loader-utils-0.2.17" = {
      name = "loader-utils";
      packageName = "loader-utils";
      version = "0.2.17";
      src = fetchurl {
        url = "https://registry.npmjs.org/loader-utils/-/loader-utils-0.2.17.tgz";
        sha1 = "f86e6374d43205a6e6c60e9196f17c0299bfb348";
      };
    };
    "loader-utils-1.1.0" = {
      name = "loader-utils";
      packageName = "loader-utils";
      version = "1.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/loader-utils/-/loader-utils-1.1.0.tgz";
        sha1 = "c98aef488bcceda2ffb5e2de646d6a754429f5cd";
      };
    };
    "locate-path-2.0.0" = {
      name = "locate-path";
      packageName = "locate-path";
      version = "2.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/locate-path/-/locate-path-2.0.0.tgz";
        sha1 = "2b568b265eec944c6d9c0de9c3dbbbca0354cd8e";
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
    "lodash._arraycopy-3.0.0" = {
      name = "lodash._arraycopy";
      packageName = "lodash._arraycopy";
      version = "3.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/lodash._arraycopy/-/lodash._arraycopy-3.0.0.tgz";
        sha1 = "76e7b7c1f1fb92547374878a562ed06a3e50f6e1";
      };
    };
    "lodash._arrayeach-3.0.0" = {
      name = "lodash._arrayeach";
      packageName = "lodash._arrayeach";
      version = "3.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/lodash._arrayeach/-/lodash._arrayeach-3.0.0.tgz";
        sha1 = "bab156b2a90d3f1bbd5c653403349e5e5933ef9e";
      };
    };
    "lodash._baseassign-3.2.0" = {
      name = "lodash._baseassign";
      packageName = "lodash._baseassign";
      version = "3.2.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/lodash._baseassign/-/lodash._baseassign-3.2.0.tgz";
        sha1 = "8c38a099500f215ad09e59f1722fd0c52bfe0a4e";
      };
    };
    "lodash._baseclone-3.3.0" = {
      name = "lodash._baseclone";
      packageName = "lodash._baseclone";
      version = "3.3.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/lodash._baseclone/-/lodash._baseclone-3.3.0.tgz";
        sha1 = "303519bf6393fe7e42f34d8b630ef7794e3542b7";
      };
    };
    "lodash._baseclone-4.5.7" = {
      name = "lodash._baseclone";
      packageName = "lodash._baseclone";
      version = "4.5.7";
      src = fetchurl {
        url = "https://registry.npmjs.org/lodash._baseclone/-/lodash._baseclone-4.5.7.tgz";
        sha1 = "ce42ade08384ef5d62fa77c30f61a46e686f8434";
      };
    };
    "lodash._basecopy-3.0.1" = {
      name = "lodash._basecopy";
      packageName = "lodash._basecopy";
      version = "3.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/lodash._basecopy/-/lodash._basecopy-3.0.1.tgz";
        sha1 = "8da0e6a876cf344c0ad8a54882111dd3c5c7ca36";
      };
    };
    "lodash._basecreate-3.0.3" = {
      name = "lodash._basecreate";
      packageName = "lodash._basecreate";
      version = "3.0.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/lodash._basecreate/-/lodash._basecreate-3.0.3.tgz";
        sha1 = "1bc661614daa7fc311b7d03bf16806a0213cf821";
      };
    };
    "lodash._basefor-3.0.3" = {
      name = "lodash._basefor";
      packageName = "lodash._basefor";
      version = "3.0.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/lodash._basefor/-/lodash._basefor-3.0.3.tgz";
        sha1 = "7550b4e9218ef09fad24343b612021c79b4c20c2";
      };
    };
    "lodash._bindcallback-3.0.1" = {
      name = "lodash._bindcallback";
      packageName = "lodash._bindcallback";
      version = "3.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/lodash._bindcallback/-/lodash._bindcallback-3.0.1.tgz";
        sha1 = "e531c27644cf8b57a99e17ed95b35c748789392e";
      };
    };
    "lodash._createassigner-3.1.1" = {
      name = "lodash._createassigner";
      packageName = "lodash._createassigner";
      version = "3.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/lodash._createassigner/-/lodash._createassigner-3.1.1.tgz";
        sha1 = "838a5bae2fdaca63ac22dee8e19fa4e6d6970b11";
      };
    };
    "lodash._getnative-3.9.1" = {
      name = "lodash._getnative";
      packageName = "lodash._getnative";
      version = "3.9.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/lodash._getnative/-/lodash._getnative-3.9.1.tgz";
        sha1 = "570bc7dede46d61cdcde687d65d3eecbaa3aaff5";
      };
    };
    "lodash._isiterateecall-3.0.9" = {
      name = "lodash._isiterateecall";
      packageName = "lodash._isiterateecall";
      version = "3.0.9";
      src = fetchurl {
        url = "https://registry.npmjs.org/lodash._isiterateecall/-/lodash._isiterateecall-3.0.9.tgz";
        sha1 = "5203ad7ba425fae842460e696db9cf3e6aac057c";
      };
    };
    "lodash._stack-4.1.3" = {
      name = "lodash._stack";
      packageName = "lodash._stack";
      version = "4.1.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/lodash._stack/-/lodash._stack-4.1.3.tgz";
        sha1 = "751aa76c1b964b047e76d14fc72a093fcb5e2dd0";
      };
    };
    "lodash.assign-4.2.0" = {
      name = "lodash.assign";
      packageName = "lodash.assign";
      version = "4.2.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/lodash.assign/-/lodash.assign-4.2.0.tgz";
        sha1 = "0d99f3ccd7a6d261d19bdaeb9245005d285808e7";
      };
    };
    "lodash.camelcase-4.3.0" = {
      name = "lodash.camelcase";
      packageName = "lodash.camelcase";
      version = "4.3.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/lodash.camelcase/-/lodash.camelcase-4.3.0.tgz";
        sha1 = "b28aa6288a2b9fc651035c7711f65ab6190331a6";
      };
    };
    "lodash.clone-3.0.3" = {
      name = "lodash.clone";
      packageName = "lodash.clone";
      version = "3.0.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/lodash.clone/-/lodash.clone-3.0.3.tgz";
        sha1 = "84688c73d32b5a90ca25616963f189252a997043";
      };
    };
    "lodash.clonedeep-3.0.2" = {
      name = "lodash.clonedeep";
      packageName = "lodash.clonedeep";
      version = "3.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/lodash.clonedeep/-/lodash.clonedeep-3.0.2.tgz";
        sha1 = "a0a1e40d82a5ea89ff5b147b8444ed63d92827db";
      };
    };
    "lodash.clonedeep-4.5.0" = {
      name = "lodash.clonedeep";
      packageName = "lodash.clonedeep";
      version = "4.5.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/lodash.clonedeep/-/lodash.clonedeep-4.5.0.tgz";
        sha1 = "e23f3f9c4f8fbdde872529c1071857a086e5ccef";
      };
    };
    "lodash.create-3.1.1" = {
      name = "lodash.create";
      packageName = "lodash.create";
      version = "3.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/lodash.create/-/lodash.create-3.1.1.tgz";
        sha1 = "d7f2849f0dbda7e04682bb8cd72ab022461debe7";
      };
    };
    "lodash.debounce-4.0.8" = {
      name = "lodash.debounce";
      packageName = "lodash.debounce";
      version = "4.0.8";
      src = fetchurl {
        url = "https://registry.npmjs.org/lodash.debounce/-/lodash.debounce-4.0.8.tgz";
        sha1 = "82d79bff30a67c4005ffd5e2515300ad9ca4d7af";
      };
    };
    "lodash.defaultsdeep-4.3.2" = {
      name = "lodash.defaultsdeep";
      packageName = "lodash.defaultsdeep";
      version = "4.3.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/lodash.defaultsdeep/-/lodash.defaultsdeep-4.3.2.tgz";
        sha1 = "6c1a586e6c5647b0e64e2d798141b8836158be8a";
      };
    };
    "lodash.get-4.4.2" = {
      name = "lodash.get";
      packageName = "lodash.get";
      version = "4.4.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/lodash.get/-/lodash.get-4.4.2.tgz";
        sha1 = "2d177f652fa31e939b4438d5341499dfa3825e99";
      };
    };
    "lodash.isarguments-3.1.0" = {
      name = "lodash.isarguments";
      packageName = "lodash.isarguments";
      version = "3.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/lodash.isarguments/-/lodash.isarguments-3.1.0.tgz";
        sha1 = "2f573d85c6a24289ff00663b491c1d338ff3458a";
      };
    };
    "lodash.isarray-3.0.4" = {
      name = "lodash.isarray";
      packageName = "lodash.isarray";
      version = "3.0.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/lodash.isarray/-/lodash.isarray-3.0.4.tgz";
        sha1 = "79e4eb88c36a8122af86f844aa9bcd851b5fbb55";
      };
    };
    "lodash.isplainobject-3.2.0" = {
      name = "lodash.isplainobject";
      packageName = "lodash.isplainobject";
      version = "3.2.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/lodash.isplainobject/-/lodash.isplainobject-3.2.0.tgz";
        sha1 = "9a8238ae16b200432960cd7346512d0123fbf4c5";
      };
    };
    "lodash.isplainobject-4.0.6" = {
      name = "lodash.isplainobject";
      packageName = "lodash.isplainobject";
      version = "4.0.6";
      src = fetchurl {
        url = "https://registry.npmjs.org/lodash.isplainobject/-/lodash.isplainobject-4.0.6.tgz";
        sha1 = "7c526a52d89b45c45cc690b88163be0497f550cb";
      };
    };
    "lodash.istypedarray-3.0.6" = {
      name = "lodash.istypedarray";
      packageName = "lodash.istypedarray";
      version = "3.0.6";
      src = fetchurl {
        url = "https://registry.npmjs.org/lodash.istypedarray/-/lodash.istypedarray-3.0.6.tgz";
        sha1 = "c9a477498607501d8e8494d283b87c39281cef62";
      };
    };
    "lodash.keys-3.1.2" = {
      name = "lodash.keys";
      packageName = "lodash.keys";
      version = "3.1.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/lodash.keys/-/lodash.keys-3.1.2.tgz";
        sha1 = "4dbc0472b156be50a0b286855d1bd0b0c656098a";
      };
    };
    "lodash.keysin-3.0.8" = {
      name = "lodash.keysin";
      packageName = "lodash.keysin";
      version = "3.0.8";
      src = fetchurl {
        url = "https://registry.npmjs.org/lodash.keysin/-/lodash.keysin-3.0.8.tgz";
        sha1 = "22c4493ebbedb1427962a54b445b2c8a767fb47f";
      };
    };
    "lodash.keysin-4.2.0" = {
      name = "lodash.keysin";
      packageName = "lodash.keysin";
      version = "4.2.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/lodash.keysin/-/lodash.keysin-4.2.0.tgz";
        sha1 = "8cc3fb35c2d94acc443a1863e02fa40799ea6f28";
      };
    };
    "lodash.memoize-4.1.2" = {
      name = "lodash.memoize";
      packageName = "lodash.memoize";
      version = "4.1.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/lodash.memoize/-/lodash.memoize-4.1.2.tgz";
        sha1 = "bcc6c49a42a2840ed997f323eada5ecd182e0bfe";
      };
    };
    "lodash.merge-3.3.2" = {
      name = "lodash.merge";
      packageName = "lodash.merge";
      version = "3.3.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/lodash.merge/-/lodash.merge-3.3.2.tgz";
        sha1 = "0d90d93ed637b1878437bb3e21601260d7afe994";
      };
    };
    "lodash.mergewith-4.6.1" = {
      name = "lodash.mergewith";
      packageName = "lodash.mergewith";
      version = "4.6.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/lodash.mergewith/-/lodash.mergewith-4.6.1.tgz";
        sha512 = "eWw5r+PYICtEBgrBE5hhlT6aAa75f411bgDz/ZL2KZqYV03USvucsxcHUIlGTDTECs1eunpI7HOV7U+WLDvNdQ==";
      };
    };
    "lodash.rest-4.0.5" = {
      name = "lodash.rest";
      packageName = "lodash.rest";
      version = "4.0.5";
      src = fetchurl {
        url = "https://registry.npmjs.org/lodash.rest/-/lodash.rest-4.0.5.tgz";
        sha1 = "954ef75049262038c96d1fc98b28fdaf9f0772aa";
      };
    };
    "lodash.restparam-3.6.1" = {
      name = "lodash.restparam";
      packageName = "lodash.restparam";
      version = "3.6.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/lodash.restparam/-/lodash.restparam-3.6.1.tgz";
        sha1 = "936a4e309ef330a7645ed4145986c85ae5b20805";
      };
    };
    "lodash.some-4.6.0" = {
      name = "lodash.some";
      packageName = "lodash.some";
      version = "4.6.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/lodash.some/-/lodash.some-4.6.0.tgz";
        sha1 = "1bb9f314ef6b8baded13b549169b2a945eb68e4d";
      };
    };
    "lodash.startcase-4.4.0" = {
      name = "lodash.startcase";
      packageName = "lodash.startcase";
      version = "4.4.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/lodash.startcase/-/lodash.startcase-4.4.0.tgz";
        sha1 = "9436e34ed26093ed7ffae1936144350915d9add8";
      };
    };
    "lodash.tail-4.1.1" = {
      name = "lodash.tail";
      packageName = "lodash.tail";
      version = "4.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/lodash.tail/-/lodash.tail-4.1.1.tgz";
        sha1 = "d2333a36d9e7717c8ad2f7cacafec7c32b444664";
      };
    };
    "lodash.toplainobject-3.0.0" = {
      name = "lodash.toplainobject";
      packageName = "lodash.toplainobject";
      version = "3.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/lodash.toplainobject/-/lodash.toplainobject-3.0.0.tgz";
        sha1 = "28790ad942d293d78aa663a07ecf7f52ca04198d";
      };
    };
    "lodash.uniq-4.5.0" = {
      name = "lodash.uniq";
      packageName = "lodash.uniq";
      version = "4.5.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/lodash.uniq/-/lodash.uniq-4.5.0.tgz";
        sha1 = "d0225373aeb652adc1bc82e4945339a842754773";
      };
    };
    "log-symbols-1.0.2" = {
      name = "log-symbols";
      packageName = "log-symbols";
      version = "1.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/log-symbols/-/log-symbols-1.0.2.tgz";
        sha1 = "376ff7b58ea3086a0f09facc74617eca501e1a18";
      };
    };
    "log-update-1.0.2" = {
      name = "log-update";
      packageName = "log-update";
      version = "1.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/log-update/-/log-update-1.0.2.tgz";
        sha1 = "19929f64c4093d2d2e7075a1dad8af59c296b8d1";
      };
    };
    "loglevel-1.6.1" = {
      name = "loglevel";
      packageName = "loglevel";
      version = "1.6.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/loglevel/-/loglevel-1.6.1.tgz";
        sha1 = "e0fc95133b6ef276cdc8887cdaf24aa6f156f8fa";
      };
    };
    "longest-1.0.1" = {
      name = "longest";
      packageName = "longest";
      version = "1.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/longest/-/longest-1.0.1.tgz";
        sha1 = "30a0b2da38f73770e8294a0d22e6625ed77d0097";
      };
    };
    "longest-streak-1.0.0" = {
      name = "longest-streak";
      packageName = "longest-streak";
      version = "1.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/longest-streak/-/longest-streak-1.0.0.tgz";
        sha1 = "d06597c4d4c31b52ccb1f5d8f8fe7148eafd6965";
      };
    };
    "looper-2.0.0" = {
      name = "looper";
      packageName = "looper";
      version = "2.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/looper/-/looper-2.0.0.tgz";
        sha1 = "66cd0c774af3d4fedac53794f742db56da8f09ec";
      };
    };
    "looper-3.0.0" = {
      name = "looper";
      packageName = "looper";
      version = "3.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/looper/-/looper-3.0.0.tgz";
        sha1 = "2efa54c3b1cbaba9b94aee2e5914b0be57fbb749";
      };
    };
    "looper-4.0.0" = {
      name = "looper";
      packageName = "looper";
      version = "4.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/looper/-/looper-4.0.0.tgz";
        sha1 = "7706aded59a99edca06e6b54bb86c8ec19c95155";
      };
    };
    "loose-envify-1.4.0" = {
      name = "loose-envify";
      packageName = "loose-envify";
      version = "1.4.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/loose-envify/-/loose-envify-1.4.0.tgz";
        sha512 = "lyuxPGr/Wfhrlem2CL/UcnUc1zcqKAImBDzukY7Y5F/yQiNdko6+fRLevlw1HgMySw7f611UIY408EtxRSoK3Q==";
      };
    };
    "lossy-store-1.2.3" = {
      name = "lossy-store";
      packageName = "lossy-store";
      version = "1.2.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/lossy-store/-/lossy-store-1.2.3.tgz";
        sha1 = "562e2a9203d8661f60e8712de407fbdadf275dc9";
      };
    };
    "loud-rejection-1.6.0" = {
      name = "loud-rejection";
      packageName = "loud-rejection";
      version = "1.6.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/loud-rejection/-/loud-rejection-1.6.0.tgz";
        sha1 = "5b46f80147edee578870f086d04821cf998e551f";
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
    "lru-cache-2.6.5" = {
      name = "lru-cache";
      packageName = "lru-cache";
      version = "2.6.5";
      src = fetchurl {
        url = "http://registry.npmjs.org/lru-cache/-/lru-cache-2.6.5.tgz";
        sha1 = "e56d6354148ede8d7707b58d143220fd08df0fd5";
      };
    };
    "lru-cache-4.1.5" = {
      name = "lru-cache";
      packageName = "lru-cache";
      version = "4.1.5";
      src = fetchurl {
        url = "https://registry.npmjs.org/lru-cache/-/lru-cache-4.1.5.tgz";
        sha512 = "sWZlbEP2OsHNkXrMl5GYk/jKk70MBng6UU4YI/qGDYbgf6YbP4EvmqISbXCoJiRKs+1bSpFHVgQxvJ17F2li5g==";
      };
    };
    "ltgt-2.1.3" = {
      name = "ltgt";
      packageName = "ltgt";
      version = "2.1.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/ltgt/-/ltgt-2.1.3.tgz";
        sha1 = "10851a06d9964b971178441c23c9e52698eece34";
      };
    };
    "ltgt-2.2.1" = {
      name = "ltgt";
      packageName = "ltgt";
      version = "2.2.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/ltgt/-/ltgt-2.2.1.tgz";
        sha1 = "f35ca91c493f7b73da0e07495304f17b31f87ee5";
      };
    };
    "make-dir-1.3.0" = {
      name = "make-dir";
      packageName = "make-dir";
      version = "1.3.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/make-dir/-/make-dir-1.3.0.tgz";
        sha512 = "2w31R7SJtieJJnQtGc7RVL2StM2vGYVfqUOvUDxH6bC6aJTxPxTF0GnIgCyu7tjockiUWAYQRbxa7vKn34s5sQ==";
      };
    };
    "map-cache-0.2.2" = {
      name = "map-cache";
      packageName = "map-cache";
      version = "0.2.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/map-cache/-/map-cache-0.2.2.tgz";
        sha1 = "c32abd0bd6525d9b051645bb4f26ac5dc98a0dbf";
      };
    };
    "map-filter-reduce-2.2.1" = {
      name = "map-filter-reduce";
      packageName = "map-filter-reduce";
      version = "2.2.1";
      src = fetchurl {
        url = "http://registry.npmjs.org/map-filter-reduce/-/map-filter-reduce-2.2.1.tgz";
        sha1 = "632b127c3ae5d6ad9e21cfdd9691b63b8944fcd2";
      };
    };
    "map-filter-reduce-3.2.2" = {
      name = "map-filter-reduce";
      packageName = "map-filter-reduce";
      version = "3.2.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/map-filter-reduce/-/map-filter-reduce-3.2.2.tgz";
        sha512 = "p+NIGQbEBxlw/qWwG+NME98G/9kjOQI70hmaH8QEZtIWfTmfMYLKQW4PJChP4izPHNAxlOfv/qefP0+2ZXn84A==";
      };
    };
    "map-merge-1.1.0" = {
      name = "map-merge";
      packageName = "map-merge";
      version = "1.1.0";
      src = fetchurl {
        url = "http://registry.npmjs.org/map-merge/-/map-merge-1.1.0.tgz";
        sha1 = "6a6fc58c95d8aab46c2bdde44d515b6ee06fce34";
      };
    };
    "map-obj-1.0.1" = {
      name = "map-obj";
      packageName = "map-obj";
      version = "1.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/map-obj/-/map-obj-1.0.1.tgz";
        sha1 = "d933ceb9205d82bdcf4886f6742bdc2b4dea146d";
      };
    };
    "map-visit-1.0.0" = {
      name = "map-visit";
      packageName = "map-visit";
      version = "1.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/map-visit/-/map-visit-1.0.0.tgz";
        sha1 = "ecdca8f13144e660f1b5bd41f12f3479d98dfb8f";
      };
    };
    "markdown-table-0.4.0" = {
      name = "markdown-table";
      packageName = "markdown-table";
      version = "0.4.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/markdown-table/-/markdown-table-0.4.0.tgz";
        sha1 = "890c2c1b3bfe83fb00e4129b8e4cfe645270f9d1";
      };
    };
    "math-expression-evaluator-1.2.17" = {
      name = "math-expression-evaluator";
      packageName = "math-expression-evaluator";
      version = "1.2.17";
      src = fetchurl {
        url = "https://registry.npmjs.org/math-expression-evaluator/-/math-expression-evaluator-1.2.17.tgz";
        sha1 = "de819fdbcd84dccd8fae59c6aeb79615b9d266ac";
      };
    };
    "math-random-1.0.1" = {
      name = "math-random";
      packageName = "math-random";
      version = "1.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/math-random/-/math-random-1.0.1.tgz";
        sha1 = "8b3aac588b8a66e4975e3cdea67f7bb329601fac";
      };
    };
    "mathsass-0.10.1" = {
      name = "mathsass";
      packageName = "mathsass";
      version = "0.10.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/mathsass/-/mathsass-0.10.1.tgz";
        sha1 = "8768fe20210bd5daeab6d645c42c7e69a4c60008";
      };
    };
    "md5.js-1.3.5" = {
      name = "md5.js";
      packageName = "md5.js";
      version = "1.3.5";
      src = fetchurl {
        url = "https://registry.npmjs.org/md5.js/-/md5.js-1.3.5.tgz";
        sha512 = "xitP+WxNPcTTOgnTJcrhM0xvdPepipPSf3I8EIpGKeFLjt3PlJLIDG3u8EX53ZIubkb+5U2+3rELYpEhHhzdkg==";
      };
    };
    "mdmanifest-1.0.8" = {
      name = "mdmanifest";
      packageName = "mdmanifest";
      version = "1.0.8";
      src = fetchurl {
        url = "https://registry.npmjs.org/mdmanifest/-/mdmanifest-1.0.8.tgz";
        sha1 = "c04891883c28c83602e1d06b05a11037e359b4c8";
      };
    };
    "media-typer-0.3.0" = {
      name = "media-typer";
      packageName = "media-typer";
      version = "0.3.0";
      src = fetchurl {
        url = "http://registry.npmjs.org/media-typer/-/media-typer-0.3.0.tgz";
        sha1 = "8710d7af0aa626f8fffa1ce00168545263255748";
      };
    };
    "mem-1.1.0" = {
      name = "mem";
      packageName = "mem";
      version = "1.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/mem/-/mem-1.1.0.tgz";
        sha1 = "5edd52b485ca1d900fe64895505399a0dfa45f76";
      };
    };
    "memory-fs-0.4.1" = {
      name = "memory-fs";
      packageName = "memory-fs";
      version = "0.4.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/memory-fs/-/memory-fs-0.4.1.tgz";
        sha1 = "3a9a20b8462523e447cfbc7e8bb80ed667bfc552";
      };
    };
    "meow-3.7.0" = {
      name = "meow";
      packageName = "meow";
      version = "3.7.0";
      src = fetchurl {
        url = "http://registry.npmjs.org/meow/-/meow-3.7.0.tgz";
        sha1 = "72cb668b425228290abbfa856892587308a801fb";
      };
    };
    "merge-descriptors-1.0.1" = {
      name = "merge-descriptors";
      packageName = "merge-descriptors";
      version = "1.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/merge-descriptors/-/merge-descriptors-1.0.1.tgz";
        sha1 = "b00aaa556dd8b44568150ec9d1b953f3f90cbb61";
      };
    };
    "methods-1.1.2" = {
      name = "methods";
      packageName = "methods";
      version = "1.1.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/methods/-/methods-1.1.2.tgz";
        sha1 = "5529a4d67654134edcc5266656835b0f851afcee";
      };
    };
    "micromatch-2.3.11" = {
      name = "micromatch";
      packageName = "micromatch";
      version = "2.3.11";
      src = fetchurl {
        url = "https://registry.npmjs.org/micromatch/-/micromatch-2.3.11.tgz";
        sha1 = "86677c97d1720b363431d04d0d15293bd38c1565";
      };
    };
    "micromatch-3.1.10" = {
      name = "micromatch";
      packageName = "micromatch";
      version = "3.1.10";
      src = fetchurl {
        url = "https://registry.npmjs.org/micromatch/-/micromatch-3.1.10.tgz";
        sha512 = "MWikgl9n9M3w+bpsY3He8L+w9eF9338xRl8IAO5viDizwSzziFEyUzo2xrrloB64ADbTf8uA8vRqqttDTOmccg==";
      };
    };
    "miller-rabin-4.0.1" = {
      name = "miller-rabin";
      packageName = "miller-rabin";
      version = "4.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/miller-rabin/-/miller-rabin-4.0.1.tgz";
        sha512 = "115fLhvZVqWwHPbClyntxEVfVDfl9DLLTuJvq3g2O/Oxi8AiNouAHvDSzHS0viUJc+V5vm3eq91Xwqn9dp4jRA==";
      };
    };
    "mime-1.4.1" = {
      name = "mime";
      packageName = "mime";
      version = "1.4.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/mime/-/mime-1.4.1.tgz";
        sha512 = "KI1+qOZu5DcW6wayYHSzR/tXKCDC5Om4s1z2QJjDULzLcmf3DvzS7oluY4HCTrc+9FiKmWUgeNLg7W3uIQvxtQ==";
      };
    };
    "mime-1.6.0" = {
      name = "mime";
      packageName = "mime";
      version = "1.6.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/mime/-/mime-1.6.0.tgz";
        sha512 = "x0Vn8spI+wuJ1O6S7gnbaQg8Pxh4NNHb7KSINmEWKiPE4RKOplvijn+NkmYmmRgP68mc70j2EbeTFRsrswaQeg==";
      };
    };
    "mime-db-1.37.0" = {
      name = "mime-db";
      packageName = "mime-db";
      version = "1.37.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/mime-db/-/mime-db-1.37.0.tgz";
        sha512 = "R3C4db6bgQhlIhPU48fUtdVmKnflq+hRdad7IyKhtFj06VPNVdk2RhiYL3UjQIlso8L+YxAtFkobT0VK+S/ybg==";
      };
    };
    "mime-types-2.1.21" = {
      name = "mime-types";
      packageName = "mime-types";
      version = "2.1.21";
      src = fetchurl {
        url = "https://registry.npmjs.org/mime-types/-/mime-types-2.1.21.tgz";
        sha512 = "3iL6DbwpyLzjR3xHSFNFeb9Nz/M8WDkX33t1GFQnFOllWk8pOrh/LSrB5OXlnlW5P9LH73X6loW/eogc+F5lJg==";
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
    "mimic-response-1.0.1" = {
      name = "mimic-response";
      packageName = "mimic-response";
      version = "1.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/mimic-response/-/mimic-response-1.0.1.tgz";
        sha512 = "j5EctnkH7amfV/q5Hgmoal1g2QHFJRraOtmx0JpIqkxhBhI/lJSl1nMpQ45hVarwNETOoWEimndZ4QK0RHxuxQ==";
      };
    };
    "minimalistic-assert-1.0.1" = {
      name = "minimalistic-assert";
      packageName = "minimalistic-assert";
      version = "1.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/minimalistic-assert/-/minimalistic-assert-1.0.1.tgz";
        sha512 = "UtJcAD4yEaGtjPezWuO9wC4nwUnVH/8/Im3yEHQP4b67cXlD/Qr9hdITCU1xDbSEXg2XKNaP8jsReV7vQd00/A==";
      };
    };
    "minimalistic-crypto-utils-1.0.1" = {
      name = "minimalistic-crypto-utils";
      packageName = "minimalistic-crypto-utils";
      version = "1.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/minimalistic-crypto-utils/-/minimalistic-crypto-utils-1.0.1.tgz";
        sha1 = "f6c00c1c0b082246e5c4d99dfb8c7c083b2b582a";
      };
    };
    "minimatch-3.0.3" = {
      name = "minimatch";
      packageName = "minimatch";
      version = "3.0.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/minimatch/-/minimatch-3.0.3.tgz";
        sha1 = "2a4e4090b96b2db06a9d7df01055a62a77c9b774";
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
    "minimist-0.0.10" = {
      name = "minimist";
      packageName = "minimist";
      version = "0.0.10";
      src = fetchurl {
        url = "http://registry.npmjs.org/minimist/-/minimist-0.0.10.tgz";
        sha1 = "de3f98543dbf96082be48ad1a0c7cda836301dcf";
      };
    };
    "minimist-0.0.8" = {
      name = "minimist";
      packageName = "minimist";
      version = "0.0.8";
      src = fetchurl {
        url = "http://registry.npmjs.org/minimist/-/minimist-0.0.8.tgz";
        sha1 = "857fcabfc3397d2625b8228262e86aa7a011b05d";
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
    "mississippi-2.0.0" = {
      name = "mississippi";
      packageName = "mississippi";
      version = "2.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/mississippi/-/mississippi-2.0.0.tgz";
        sha512 = "zHo8v+otD1J10j/tC+VNoGK9keCuByhKovAvdn74dmxJl9+mWHnx6EMsDN4lgRoMI/eYo2nchAxniIbUPb5onw==";
      };
    };
    "mixin-deep-1.3.1" = {
      name = "mixin-deep";
      packageName = "mixin-deep";
      version = "1.3.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/mixin-deep/-/mixin-deep-1.3.1.tgz";
        sha512 = "8ZItLHeEgaqEvd5lYBXfm4EZSFCX29Jb9K+lAHhDKzReKBQKj3R+7NOF6tjqYi9t4oI8VUfaWITJQm86wnXGNQ==";
      };
    };
    "mixin-object-2.0.1" = {
      name = "mixin-object";
      packageName = "mixin-object";
      version = "2.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/mixin-object/-/mixin-object-2.0.1.tgz";
        sha1 = "4fb949441dab182540f1fe035ba60e1947a5e57e";
      };
    };
    "mkdirp-0.5.1" = {
      name = "mkdirp";
      packageName = "mkdirp";
      version = "0.5.1";
      src = fetchurl {
        url = "http://registry.npmjs.org/mkdirp/-/mkdirp-0.5.1.tgz";
        sha1 = "30057438eac6cf7f8c4767f38648d6697d75c903";
      };
    };
    "mkpath-1.0.0" = {
      name = "mkpath";
      packageName = "mkpath";
      version = "1.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/mkpath/-/mkpath-1.0.0.tgz";
        sha1 = "ebb3a977e7af1c683ae6fda12b545a6ba6c5853d";
      };
    };
    "mocha-nightwatch-3.2.2" = {
      name = "mocha-nightwatch";
      packageName = "mocha-nightwatch";
      version = "3.2.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/mocha-nightwatch/-/mocha-nightwatch-3.2.2.tgz";
        sha1 = "91bcb9b3bde057dd7677c78125e491e58d66647c";
      };
    };
    "modify-filename-1.1.0" = {
      name = "modify-filename";
      packageName = "modify-filename";
      version = "1.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/modify-filename/-/modify-filename-1.1.0.tgz";
        sha1 = "9a2dec83806fbb2d975f22beec859ca26b393aa1";
      };
    };
    "monotonic-timestamp-0.0.9" = {
      name = "monotonic-timestamp";
      packageName = "monotonic-timestamp";
      version = "0.0.9";
      src = fetchurl {
        url = "https://registry.npmjs.org/monotonic-timestamp/-/monotonic-timestamp-0.0.9.tgz";
        sha1 = "5ba5adc7aac85e1d7ce77be847161ed246b39603";
      };
    };
    "moo-0.4.3" = {
      name = "moo";
      packageName = "moo";
      version = "0.4.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/moo/-/moo-0.4.3.tgz";
        sha512 = "gFD2xGCl8YFgGHsqJ9NKRVdwlioeW3mI1iqfLNYQOv0+6JRwG58Zk9DIGQgyIaffSYaO1xsKnMaYzzNr1KyIAw==";
      };
    };
    "move-concurrently-1.0.1" = {
      name = "move-concurrently";
      packageName = "move-concurrently";
      version = "1.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/move-concurrently/-/move-concurrently-1.0.1.tgz";
        sha1 = "be2c005fda32e0b29af1f05d7c4b33214c701f92";
      };
    };
    "ms-0.7.1" = {
      name = "ms";
      packageName = "ms";
      version = "0.7.1";
      src = fetchurl {
        url = "http://registry.npmjs.org/ms/-/ms-0.7.1.tgz";
        sha1 = "9cd13c03adbff25b65effde7ce864ee952017098";
      };
    };
    "ms-2.0.0" = {
      name = "ms";
      packageName = "ms";
      version = "2.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/ms/-/ms-2.0.0.tgz";
        sha1 = "5608aeadfc00be6c2901df5f9861788de0d597c8";
      };
    };
    "ms-2.1.1" = {
      name = "ms";
      packageName = "ms";
      version = "2.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/ms/-/ms-2.1.1.tgz";
        sha512 = "tgp+dl5cGk28utYktBsrFqA7HKgrhgPsg6Z/EfhWI4gl1Hwq8B/GmY/0oXZ6nF8hDVesS/FpnYaD/kOWhYQvyg==";
      };
    };
    "multiblob-1.13.2" = {
      name = "multiblob";
      packageName = "multiblob";
      version = "1.13.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/multiblob/-/multiblob-1.13.2.tgz";
        sha512 = "z1nRV/iLDQQ2ih1lkOmOod4OLaaYk1LayU5mUJTGItekthyuWVWT+uuMp7mI1zXczEVuWky4MaDXuekKHkrJUQ==";
      };
    };
    "multiblob-http-0.4.2" = {
      name = "multiblob-http";
      packageName = "multiblob-http";
      version = "0.4.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/multiblob-http/-/multiblob-http-0.4.2.tgz";
        sha512 = "hVaXryaqJ3vvKjRNcOCEadzgO99nR+haxlptswr3vRvgavbK/Y/I7/Nat12WIQno2/A8+nkbE+ZcrsN3UDbtQw==";
      };
    };
    "multicast-dns-6.2.3" = {
      name = "multicast-dns";
      packageName = "multicast-dns";
      version = "6.2.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/multicast-dns/-/multicast-dns-6.2.3.tgz";
        sha512 = "ji6J5enbMyGRHIAkAOu3WdV8nggqviKCEKtXcOqfphZZtQrmHKycfynJ2V7eVPUA4NhJ6V7Wf4TmGbTwKE9B6g==";
      };
    };
    "multicast-dns-service-types-1.1.0" = {
      name = "multicast-dns-service-types";
      packageName = "multicast-dns-service-types";
      version = "1.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/multicast-dns-service-types/-/multicast-dns-service-types-1.1.0.tgz";
        sha1 = "899f11d9686e5e05cb91b35d5f0e63b773cfc901";
      };
    };
    "multicb-1.2.2" = {
      name = "multicb";
      packageName = "multicb";
      version = "1.2.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/multicb/-/multicb-1.2.2.tgz";
        sha512 = "PZM4dhYFmCF6uZGWpEmoPMUqJBywS9IcAgybT2GmSpYI1BvGvoWSdbio+ik+q/YD2vodhvslESWIS3NnkKYdqQ==";
      };
    };
    "multiserver-1.13.7" = {
      name = "multiserver";
      packageName = "multiserver";
      version = "1.13.7";
      src = fetchurl {
        url = "https://registry.npmjs.org/multiserver/-/multiserver-1.13.7.tgz";
        sha512 = "nQKAe6+u7nWJY29pJjegltw0ROj2bDc2bCTm9Bnr4EQrp5H5Tav+ESUjgl3D4vuQgCeveb4h+CtLtjB8QnK1Dw==";
      };
    };
    "multiserver-3.0.2" = {
      name = "multiserver";
      packageName = "multiserver";
      version = "3.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/multiserver/-/multiserver-3.0.2.tgz";
        sha512 = "YCVA+zCtc4xR55CrKIK6pAYPKTDswrlF+bkO9Nyb1osn93AhFGjKnelA38G9mNHeUd/v9/Un3gxpisorouRQfw==";
      };
    };
    "multiserver-address-1.0.1" = {
      name = "multiserver-address";
      packageName = "multiserver-address";
      version = "1.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/multiserver-address/-/multiserver-address-1.0.1.tgz";
        sha512 = "IfZMAGs9onCLkYNSnNBri3JxuvhQYllMyh3W9ry86iEDcfW9uPVsHTHDsjDxQtL+dPq3byshmA+Y4LN2wLHwNw==";
      };
    };
    "multiserver-scopes-1.0.0" = {
      name = "multiserver-scopes";
      packageName = "multiserver-scopes";
      version = "1.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/multiserver-scopes/-/multiserver-scopes-1.0.0.tgz";
        sha512 = "D3q4IujGRUIKETfR5s0kRtvXTjAMhyl7rtLEMXtvkg0lJPJyS5KYsAULFFy+dYv/+RC642aR1zo/RKNp6sdtQg==";
      };
    };
    "multispinner-0.2.1" = {
      name = "multispinner";
      packageName = "multispinner";
      version = "0.2.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/multispinner/-/multispinner-0.2.1.tgz";
        sha1 = "c1cc100cfc40c697b8a12c3a25e81598eccc29f4";
      };
    };
    "mutant-3.22.1" = {
      name = "mutant";
      packageName = "mutant";
      version = "3.22.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/mutant/-/mutant-3.22.1.tgz";
        sha1 = "90487546f700b3c28aa80a43d1cf7d338f307581";
      };
    };
    "mutant-pull-reduce-1.1.0" = {
      name = "mutant-pull-reduce";
      packageName = "mutant-pull-reduce";
      version = "1.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/mutant-pull-reduce/-/mutant-pull-reduce-1.1.0.tgz";
        sha1 = "96f77027b400061364acbf2633be2e82d5440e6a";
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
    "muxrpc-6.4.1" = {
      name = "muxrpc";
      packageName = "muxrpc";
      version = "6.4.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/muxrpc/-/muxrpc-6.4.1.tgz";
        sha512 = "r8+tucKMmQiYd8NWGQqAA5r+SlYuU30D/WbYo7E/PztG/jmizQJY5NfmLIJ+GWo+dEC6kIxkr0eY+U0uZexTNg==";
      };
    };
    "muxrpc-validation-2.0.1" = {
      name = "muxrpc-validation";
      packageName = "muxrpc-validation";
      version = "2.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/muxrpc-validation/-/muxrpc-validation-2.0.1.tgz";
        sha1 = "cd650d172025fe9d064230aab38ca6328dd16f2f";
      };
    };
    "muxrpcli-1.1.0" = {
      name = "muxrpcli";
      packageName = "muxrpcli";
      version = "1.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/muxrpcli/-/muxrpcli-1.1.0.tgz";
        sha1 = "4ae9ba986ab825c4a5c12fcb71c6daa81eab5158";
      };
    };
    "mv-2.1.1" = {
      name = "mv";
      packageName = "mv";
      version = "2.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/mv/-/mv-2.1.1.tgz";
        sha1 = "ae6ce0d6f6d5e0a4f7d893798d03c1ea9559b6a2";
      };
    };
    "nan-2.10.0" = {
      name = "nan";
      packageName = "nan";
      version = "2.10.0";
      src = fetchurl {
        url = "http://registry.npmjs.org/nan/-/nan-2.10.0.tgz";
        sha512 = "bAdJv7fBLhWC+/Bls0Oza+mvTaNQtP+1RyhhhvD95pgUJz6XM5IzgmxOkItJ9tkoCiplvAnXI1tNmmUD/eScyA==";
      };
    };
    "nan-2.12.1" = {
      name = "nan";
      packageName = "nan";
      version = "2.12.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/nan/-/nan-2.12.1.tgz";
        sha512 = "JY7V6lRkStKcKTvHO5NVSQRv+RV+FIL5pvDoLiAtSL9pKlC5x9PKQcZDsq7m4FO4d57mkhC6Z+QhAh3Jdk5JFw==";
      };
    };
    "nanomatch-1.2.13" = {
      name = "nanomatch";
      packageName = "nanomatch";
      version = "1.2.13";
      src = fetchurl {
        url = "https://registry.npmjs.org/nanomatch/-/nanomatch-1.2.13.tgz";
        sha512 = "fpoe2T0RbHwBTBUOftAfBPaDEi06ufaUai0mE6Yn1kacc3SnTErfb/h+X94VXzI64rKFHYImXSvdwGGCmwOqCA==";
      };
    };
    "ncp-1.0.1" = {
      name = "ncp";
      packageName = "ncp";
      version = "1.0.1";
      src = fetchurl {
        url = "http://registry.npmjs.org/ncp/-/ncp-1.0.1.tgz";
        sha1 = "d15367e5cb87432ba117d2bf80fdf45aecfb4246";
      };
    };
    "ncp-2.0.0" = {
      name = "ncp";
      packageName = "ncp";
      version = "2.0.0";
      src = fetchurl {
        url = "http://registry.npmjs.org/ncp/-/ncp-2.0.0.tgz";
        sha1 = "195a21d6c46e361d2fb1281ba38b91e9df7bdbb3";
      };
    };
    "nearley-2.15.1" = {
      name = "nearley";
      packageName = "nearley";
      version = "2.15.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/nearley/-/nearley-2.15.1.tgz";
        sha512 = "8IUY/rUrKz2mIynUGh8k+tul1awMKEjeHHC5G3FHvvyAW6oq4mQfNp2c0BMea+sYZJvYcrrM6GmZVIle/GRXGw==";
      };
    };
    "negotiator-0.6.1" = {
      name = "negotiator";
      packageName = "negotiator";
      version = "0.6.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/negotiator/-/negotiator-0.6.1.tgz";
        sha1 = "2b327184e8992101177b28563fb5e7102acd0ca9";
      };
    };
    "neo-async-2.6.0" = {
      name = "neo-async";
      packageName = "neo-async";
      version = "2.6.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/neo-async/-/neo-async-2.6.0.tgz";
        sha512 = "MFh0d/Wa7vkKO3Y3LlacqAEeHK0mckVqzDieUKTT+KGxi+zIpeVsFxymkIiRpbpDziHc290Xr9A1O4Om7otoRA==";
      };
    };
    "netmask-1.0.6" = {
      name = "netmask";
      packageName = "netmask";
      version = "1.0.6";
      src = fetchurl {
        url = "https://registry.npmjs.org/netmask/-/netmask-1.0.6.tgz";
        sha1 = "20297e89d86f6f6400f250d9f4f6b4c1945fcd35";
      };
    };
    "next-tick-1.0.0" = {
      name = "next-tick";
      packageName = "next-tick";
      version = "1.0.0";
      src = fetchurl {
        url = "http://registry.npmjs.org/next-tick/-/next-tick-1.0.0.tgz";
        sha1 = "ca86d1fe8828169b0120208e3dc8424b9db8342c";
      };
    };
    "nice-try-1.0.5" = {
      name = "nice-try";
      packageName = "nice-try";
      version = "1.0.5";
      src = fetchurl {
        url = "https://registry.npmjs.org/nice-try/-/nice-try-1.0.5.tgz";
        sha512 = "1nh45deeb5olNY7eX82BkPO7SSxR5SSYJiPTrTdFUVYwAl8CKMA5N9PjTYkHiRjisVcxcQ1HXdLhx2qxxJzLNQ==";
      };
    };
    "nightwatch-0.9.21" = {
      name = "nightwatch";
      packageName = "nightwatch";
      version = "0.9.21";
      src = fetchurl {
        url = "https://registry.npmjs.org/nightwatch/-/nightwatch-0.9.21.tgz";
        sha1 = "9e794a7514b4fd5f46602d368e50515232ab9e90";
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
    "node-abi-2.5.0" = {
      name = "node-abi";
      packageName = "node-abi";
      version = "2.5.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/node-abi/-/node-abi-2.5.0.tgz";
        sha512 = "9g2twBGSP6wIR5PW7tXvAWnEWKJDH/VskdXp168xsw9VVxpEGov8K4jsP4/VeoC7b2ZAyzckvMCuQuQlw44lXg==";
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
    "node-forge-0.7.5" = {
      name = "node-forge";
      packageName = "node-forge";
      version = "0.7.5";
      src = fetchurl {
        url = "https://registry.npmjs.org/node-forge/-/node-forge-0.7.5.tgz";
        sha512 = "MmbQJ2MTESTjt3Gi/3yG1wGpIMhUfcIypUCGtTizFR9IiccFwxSpfp0vtIZlkFclEqERemxfnSdZEMR9VqqEFQ==";
      };
    };
    "node-gyp-3.8.0" = {
      name = "node-gyp";
      packageName = "node-gyp";
      version = "3.8.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/node-gyp/-/node-gyp-3.8.0.tgz";
        sha512 = "3g8lYefrRRzvGeSowdJKAKyks8oUpLEd/DyPV4eMhVlhJ0aNaZqIrNUIPuEWWTAoPqyFkfGrM67MC69baqn6vA==";
      };
    };
    "node-gyp-build-3.6.0" = {
      name = "node-gyp-build";
      packageName = "node-gyp-build";
      version = "3.6.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/node-gyp-build/-/node-gyp-build-3.6.0.tgz";
        sha512 = "4yfIUBKGAjjsgRI50D1U5RF8zgOn+xfV8qmP9zQ078erdxIX6dOPCRb37Vj0nm1yaONuWAJJcWwSZqrt+Fq/MA==";
      };
    };
    "node-libs-browser-2.1.0" = {
      name = "node-libs-browser";
      packageName = "node-libs-browser";
      version = "2.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/node-libs-browser/-/node-libs-browser-2.1.0.tgz";
        sha512 = "5AzFzdoIMb89hBGMZglEegffzgRg+ZFoUmisQ8HI4j1KDdpx13J0taNp2y9xPbur6W61gepGDDotGBVQ7mfUCg==";
      };
    };
    "node-loader-0.6.0" = {
      name = "node-loader";
      packageName = "node-loader";
      version = "0.6.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/node-loader/-/node-loader-0.6.0.tgz";
        sha1 = "c797ef51095ed5859902b157f6384f6361e05ae8";
      };
    };
    "node-notifier-5.3.0" = {
      name = "node-notifier";
      packageName = "node-notifier";
      version = "5.3.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/node-notifier/-/node-notifier-5.3.0.tgz";
        sha512 = "AhENzCSGZnZJgBARsUjnQ7DnZbzyP+HxlVXuD0xqAnvL8q+OqtSX7lGg9e8nHzwXkMMXNdVeqq4E2M3EUAqX6Q==";
      };
    };
    "node-sass-4.11.0" = {
      name = "node-sass";
      packageName = "node-sass";
      version = "4.11.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/node-sass/-/node-sass-4.11.0.tgz";
        sha512 = "bHUdHTphgQJZaF1LASx0kAviPH7sGlcyNhWade4eVIpFp6tsn7SV8xNMTbsQFpEV9VXpnwTTnNYlfsZXgGgmkA==";
      };
    };
    "nomnom-1.6.2" = {
      name = "nomnom";
      packageName = "nomnom";
      version = "1.6.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/nomnom/-/nomnom-1.6.2.tgz";
        sha1 = "84a66a260174408fc5b77a18f888eccc44fb6971";
      };
    };
    "non-private-ip-1.4.4" = {
      name = "non-private-ip";
      packageName = "non-private-ip";
      version = "1.4.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/non-private-ip/-/non-private-ip-1.4.4.tgz";
        sha512 = "K9nTVFOGUOYutaG8ywiKpCdVu458RFxSgSJ0rribUxtf5iLM9B2+raFJgkID3p5op0+twmoQqFaPnu9KYz6qzg==";
      };
    };
    "noop-logger-0.1.1" = {
      name = "noop-logger";
      packageName = "noop-logger";
      version = "0.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/noop-logger/-/noop-logger-0.1.1.tgz";
        sha1 = "94a2b1633c4f1317553007d8966fd0e841b6a4c2";
      };
    };
    "nopt-3.0.6" = {
      name = "nopt";
      packageName = "nopt";
      version = "3.0.6";
      src = fetchurl {
        url = "https://registry.npmjs.org/nopt/-/nopt-3.0.6.tgz";
        sha1 = "c6465dbf08abcd4db359317f79ac68a646b28ff9";
      };
    };
    "normalize-package-data-2.4.0" = {
      name = "normalize-package-data";
      packageName = "normalize-package-data";
      version = "2.4.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/normalize-package-data/-/normalize-package-data-2.4.0.tgz";
        sha512 = "9jjUFbTPfEy3R/ad/2oNbKtW9Hgovl5O1FvFWKkKblNXoN/Oou6+9+KKohPK13Yc3/TyunyWhJp6gvRNR/PPAw==";
      };
    };
    "normalize-path-2.1.1" = {
      name = "normalize-path";
      packageName = "normalize-path";
      version = "2.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/normalize-path/-/normalize-path-2.1.1.tgz";
        sha1 = "1ab28b556e198363a8c1a6f7e6fa20137fe6aed9";
      };
    };
    "normalize-range-0.1.2" = {
      name = "normalize-range";
      packageName = "normalize-range";
      version = "0.1.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/normalize-range/-/normalize-range-0.1.2.tgz";
        sha1 = "2d10c06bdfd312ea9777695a4d28439456b75942";
      };
    };
    "normalize-uri-1.1.1" = {
      name = "normalize-uri";
      packageName = "normalize-uri";
      version = "1.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/normalize-uri/-/normalize-uri-1.1.1.tgz";
        sha512 = "bui9/kzRGymbkxJsZEBZgDHK2WJWGOHzR0pCr404EpkpVFTkCOYaRwQTlehUE+7oI70mWNENncCWqUxT/icfHw==";
      };
    };
    "normalize-url-1.9.1" = {
      name = "normalize-url";
      packageName = "normalize-url";
      version = "1.9.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/normalize-url/-/normalize-url-1.9.1.tgz";
        sha1 = "2cc0d66b31ea23036458436e3620d85954c66c3c";
      };
    };
    "npm-install-package-2.1.0" = {
      name = "npm-install-package";
      packageName = "npm-install-package";
      version = "2.1.0";
      src = fetchurl {
        url = "http://registry.npmjs.org/npm-install-package/-/npm-install-package-2.1.0.tgz";
        sha1 = "d7efe3cfcd7ab00614b896ea53119dc9ab259125";
      };
    };
    "npm-prefix-1.2.0" = {
      name = "npm-prefix";
      packageName = "npm-prefix";
      version = "1.2.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/npm-prefix/-/npm-prefix-1.2.0.tgz";
        sha1 = "e619455f7074ba54cc66d6d0d37dd9f1be6bcbc0";
      };
    };
    "npm-run-path-2.0.2" = {
      name = "npm-run-path";
      packageName = "npm-run-path";
      version = "2.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/npm-run-path/-/npm-run-path-2.0.2.tgz";
        sha1 = "35a9232dfa35d7067b4cb2ddf2357b1871536c5f";
      };
    };
    "npmlog-4.1.2" = {
      name = "npmlog";
      packageName = "npmlog";
      version = "4.1.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/npmlog/-/npmlog-4.1.2.tgz";
        sha512 = "2uUqazuKlTaSI/dC8AzicUck7+IrEaOnN/e0jd3Xtt1KcGpwx30v50mL7oPyr/h9bL3E4aZccVwpwP+5W9Vjkg==";
      };
    };
    "nth-check-1.0.2" = {
      name = "nth-check";
      packageName = "nth-check";
      version = "1.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/nth-check/-/nth-check-1.0.2.tgz";
        sha512 = "WeBOdju8SnzPN5vTUJYxYUxLeXpCaVP5i5e0LF8fg7WORF2Wd7wFX/pk0tYZk7s8T+J7VLy0Da6J1+wCT0AtHg==";
      };
    };
    "nugget-2.0.1" = {
      name = "nugget";
      packageName = "nugget";
      version = "2.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/nugget/-/nugget-2.0.1.tgz";
        sha1 = "201095a487e1ad36081b3432fa3cada4f8d071b0";
      };
    };
    "num2fraction-1.2.2" = {
      name = "num2fraction";
      packageName = "num2fraction";
      version = "1.2.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/num2fraction/-/num2fraction-1.2.2.tgz";
        sha1 = "6f682b6a027a4e9ddfa4564cd2589d1d4e669ede";
      };
    };
    "number-is-nan-1.0.1" = {
      name = "number-is-nan";
      packageName = "number-is-nan";
      version = "1.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/number-is-nan/-/number-is-nan-1.0.1.tgz";
        sha1 = "097b602b53422a522c1afb8790318336941a011d";
      };
    };
    "oauth-sign-0.9.0" = {
      name = "oauth-sign";
      packageName = "oauth-sign";
      version = "0.9.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/oauth-sign/-/oauth-sign-0.9.0.tgz";
        sha512 = "fexhUFFPTGV8ybAtSIGbV6gOkSv8UtRbDBnAyLQw4QPKkgNlsH2ByPGtMUqdWkos6YCRmAqViwgZrJc/mRDzZQ==";
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
    "object-copy-0.1.0" = {
      name = "object-copy";
      packageName = "object-copy";
      version = "0.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/object-copy/-/object-copy-0.1.0.tgz";
        sha1 = "7e7d858b781bd7c991a41ba975ed3812754e998c";
      };
    };
    "object-inspect-1.6.0" = {
      name = "object-inspect";
      packageName = "object-inspect";
      version = "1.6.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/object-inspect/-/object-inspect-1.6.0.tgz";
        sha512 = "GJzfBZ6DgDAmnuaM3104jR4s1Myxr3Y3zfIyN4z3UdqN69oSRacNK8UhnobDdC+7J2AHCjGwxQubNJfE70SXXQ==";
      };
    };
    "object-keys-0.4.0" = {
      name = "object-keys";
      packageName = "object-keys";
      version = "0.4.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/object-keys/-/object-keys-0.4.0.tgz";
        sha1 = "28a6aae7428dd2c3a92f3d95f21335dd204e0336";
      };
    };
    "object-keys-1.0.12" = {
      name = "object-keys";
      packageName = "object-keys";
      version = "1.0.12";
      src = fetchurl {
        url = "https://registry.npmjs.org/object-keys/-/object-keys-1.0.12.tgz";
        sha512 = "FTMyFUm2wBcGHnH2eXmz7tC6IwlqQZ6mVZ+6dm6vZ4IQIHjs6FdNsQBuKGPuUUUY6NfJw2PshC08Tn6LzLDOag==";
      };
    };
    "object-visit-1.0.1" = {
      name = "object-visit";
      packageName = "object-visit";
      version = "1.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/object-visit/-/object-visit-1.0.1.tgz";
        sha1 = "f79c4493af0c5377b59fe39d395e41042dd045bb";
      };
    };
    "object.omit-2.0.1" = {
      name = "object.omit";
      packageName = "object.omit";
      version = "2.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/object.omit/-/object.omit-2.0.1.tgz";
        sha1 = "1a9c744829f39dbb858c76ca3579ae2a54ebd1fa";
      };
    };
    "object.pick-1.3.0" = {
      name = "object.pick";
      packageName = "object.pick";
      version = "1.3.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/object.pick/-/object.pick-1.3.0.tgz";
        sha1 = "87a10ac4c1694bd2e1cbf53591a66141fb5dd747";
      };
    };
    "observ-0.2.0" = {
      name = "observ";
      packageName = "observ";
      version = "0.2.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/observ/-/observ-0.2.0.tgz";
        sha1 = "0bc39b3e29faa5f9e6caa5906cb8392df400aa68";
      };
    };
    "observ-debounce-1.1.1" = {
      name = "observ-debounce";
      packageName = "observ-debounce";
      version = "1.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/observ-debounce/-/observ-debounce-1.1.1.tgz";
        sha1 = "304e97c85adda70ecd7f08da450678ef90f0b707";
      };
    };
    "obuf-1.1.2" = {
      name = "obuf";
      packageName = "obuf";
      version = "1.1.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/obuf/-/obuf-1.1.2.tgz";
        sha512 = "PX1wu0AmAdPqOL1mWhqmlOd8kOIZQwGZw6rh7uby9fTc5lhaOWFLX3I6R1hrF9k3zUY40e6igsLGkDXK92LJNg==";
      };
    };
    "obv-0.0.0" = {
      name = "obv";
      packageName = "obv";
      version = "0.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/obv/-/obv-0.0.0.tgz";
        sha1 = "edeab8468f91d4193362ed7f91d0b96dd39a79c1";
      };
    };
    "obv-0.0.1" = {
      name = "obv";
      packageName = "obv";
      version = "0.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/obv/-/obv-0.0.1.tgz";
        sha1 = "cb236106341536f0dac4815e06708221cad7fb5e";
      };
    };
    "on-change-network-0.0.2" = {
      name = "on-change-network";
      packageName = "on-change-network";
      version = "0.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/on-change-network/-/on-change-network-0.0.2.tgz";
        sha1 = "d977249477f91726949d80e82346dab6ef45216b";
      };
    };
    "on-finished-2.3.0" = {
      name = "on-finished";
      packageName = "on-finished";
      version = "2.3.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/on-finished/-/on-finished-2.3.0.tgz";
        sha1 = "20f1336481b083cd75337992a16971aa2d906947";
      };
    };
    "on-headers-1.0.1" = {
      name = "on-headers";
      packageName = "on-headers";
      version = "1.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/on-headers/-/on-headers-1.0.1.tgz";
        sha1 = "928f5d0f470d49342651ea6794b0857c100693f7";
      };
    };
    "on-wakeup-1.0.1" = {
      name = "on-wakeup";
      packageName = "on-wakeup";
      version = "1.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/on-wakeup/-/on-wakeup-1.0.1.tgz";
        sha1 = "00d79d987dde7c8117bee74bb4903f6f6dafa52b";
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
    "onetime-1.1.0" = {
      name = "onetime";
      packageName = "onetime";
      version = "1.1.0";
      src = fetchurl {
        url = "http://registry.npmjs.org/onetime/-/onetime-1.1.0.tgz";
        sha1 = "a1f7838f8314c516f05ecefcbc4ccfe04b4ed789";
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
    "open-0.0.5" = {
      name = "open";
      packageName = "open";
      version = "0.0.5";
      src = fetchurl {
        url = "https://registry.npmjs.org/open/-/open-0.0.5.tgz";
        sha1 = "42c3e18ec95466b6bf0dc42f3a2945c3f0cad8fc";
      };
    };
    "opencollective-1.0.3" = {
      name = "opencollective";
      packageName = "opencollective";
      version = "1.0.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/opencollective/-/opencollective-1.0.3.tgz";
        sha1 = "aee6372bc28144583690c3ca8daecfc120dd0ef1";
      };
    };
    "opencollective-postinstall-2.0.1" = {
      name = "opencollective-postinstall";
      packageName = "opencollective-postinstall";
      version = "2.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/opencollective-postinstall/-/opencollective-postinstall-2.0.1.tgz";
        sha512 = "saQQ9hjLwu/oS0492eyYotoh+bra1819cfAT5rjY/e4REWwuc8IgZ844Oo44SiftWcJuBiqp0SA0BFVbmLX0IQ==";
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
    "opn-5.4.0" = {
      name = "opn";
      packageName = "opn";
      version = "5.4.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/opn/-/opn-5.4.0.tgz";
        sha512 = "YF9MNdVy/0qvJvDtunAOzFw9iasOQHpVthTCvGzxt61Il64AYSGdK+rYwld7NAfk9qJ7dt+hymBNSc9LNYS+Sw==";
      };
    };
    "optimist-0.6.1" = {
      name = "optimist";
      packageName = "optimist";
      version = "0.6.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/optimist/-/optimist-0.6.1.tgz";
        sha1 = "da3ea74686fa21a19a111c326e90eb15a0196686";
      };
    };
    "optionator-0.8.2" = {
      name = "optionator";
      packageName = "optionator";
      version = "0.8.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/optionator/-/optionator-0.8.2.tgz";
        sha1 = "364c5e409d3f4d6301d6c0b4c05bba50180aeb64";
      };
    };
    "options-0.0.6" = {
      name = "options";
      packageName = "options";
      version = "0.0.6";
      src = fetchurl {
        url = "https://registry.npmjs.org/options/-/options-0.0.6.tgz";
        sha1 = "ec22d312806bb53e731773e7cdaefcf1c643128f";
      };
    };
    "original-1.0.2" = {
      name = "original";
      packageName = "original";
      version = "1.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/original/-/original-1.0.2.tgz";
        sha512 = "hyBVl6iqqUOJ8FqRe+l/gS8H+kKYjrEndd5Pm1MfBtsEKA038HkkdbAl/72EAXGyonD/PFsvmVG+EvcIpliMBg==";
      };
    };
    "os-browserify-0.3.0" = {
      name = "os-browserify";
      packageName = "os-browserify";
      version = "0.3.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/os-browserify/-/os-browserify-0.3.0.tgz";
        sha1 = "854373c7f5c2315914fc9bfc6bd8238fdda1ec27";
      };
    };
    "os-homedir-1.0.2" = {
      name = "os-homedir";
      packageName = "os-homedir";
      version = "1.0.2";
      src = fetchurl {
        url = "http://registry.npmjs.org/os-homedir/-/os-homedir-1.0.2.tgz";
        sha1 = "ffbc4988336e0e833de0c168c7ef152121aa7fb3";
      };
    };
    "os-locale-1.4.0" = {
      name = "os-locale";
      packageName = "os-locale";
      version = "1.4.0";
      src = fetchurl {
        url = "http://registry.npmjs.org/os-locale/-/os-locale-1.4.0.tgz";
        sha1 = "20f9f17ae29ed345e8bde583b13d2009803c14d9";
      };
    };
    "os-locale-2.1.0" = {
      name = "os-locale";
      packageName = "os-locale";
      version = "2.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/os-locale/-/os-locale-2.1.0.tgz";
        sha512 = "3sslG3zJbEYcaC4YVAvDorjGxc7tv6KVATnLPZONiljsUncvihe9BQoVCEs0RZ1kmf4Hk9OBqlZfJZWI4GanKA==";
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
    "osenv-0.1.5" = {
      name = "osenv";
      packageName = "osenv";
      version = "0.1.5";
      src = fetchurl {
        url = "https://registry.npmjs.org/osenv/-/osenv-0.1.5.tgz";
        sha512 = "0CWcCECdMVc2Rw3U5w9ZjqX6ga6ubk1xDVKxtBQPK7wis/0F2r9T6k4ydGYhecl7YUBxBVxhL5oisPsNxAPe2g==";
      };
    };
    "p-finally-1.0.0" = {
      name = "p-finally";
      packageName = "p-finally";
      version = "1.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/p-finally/-/p-finally-1.0.0.tgz";
        sha1 = "3fbcfb15b899a44123b34b6dcc18b724336a2cae";
      };
    };
    "p-limit-1.3.0" = {
      name = "p-limit";
      packageName = "p-limit";
      version = "1.3.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/p-limit/-/p-limit-1.3.0.tgz";
        sha512 = "vvcXsLAJ9Dr5rQOPk7toZQZJApBl2K4J6dANSsEuh6QI41JYcsS/qhTGa9ErIUUgK3WNQoJYvylxvjqmiqEA9Q==";
      };
    };
    "p-locate-2.0.0" = {
      name = "p-locate";
      packageName = "p-locate";
      version = "2.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/p-locate/-/p-locate-2.0.0.tgz";
        sha1 = "20a0103b222a70c8fd39cc2e580680f3dde5ec43";
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
    "p-try-1.0.0" = {
      name = "p-try";
      packageName = "p-try";
      version = "1.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/p-try/-/p-try-1.0.0.tgz";
        sha1 = "cbc79cdbaf8fd4228e13f621f2b1a237c1b207b3";
      };
    };
    "pac-proxy-agent-1.1.0" = {
      name = "pac-proxy-agent";
      packageName = "pac-proxy-agent";
      version = "1.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/pac-proxy-agent/-/pac-proxy-agent-1.1.0.tgz";
        sha512 = "QBELCWyLYPgE2Gj+4wUEiMscHrQ8nRPBzYItQNOHWavwBt25ohZHQC4qnd5IszdVVrFbLsQ+dPkm6eqdjJAmwQ==";
      };
    };
    "pac-resolver-2.0.0" = {
      name = "pac-resolver";
      packageName = "pac-resolver";
      version = "2.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/pac-resolver/-/pac-resolver-2.0.0.tgz";
        sha1 = "99b88d2f193fbdeefc1c9a529c1f3260ab5277cd";
      };
    };
    "packet-stream-2.0.4" = {
      name = "packet-stream";
      packageName = "packet-stream";
      version = "2.0.4";
      src = fetchurl {
        url = "http://registry.npmjs.org/packet-stream/-/packet-stream-2.0.4.tgz";
        sha512 = "7+oxHdMMs6VhLvvbrDUc8QNuelE9fPKLDdToXBIKLPKOlnoBeMim+/35edp+AnFTLzk3xcogVvQ/jrZyyGsEiw==";
      };
    };
    "packet-stream-codec-1.1.2" = {
      name = "packet-stream-codec";
      packageName = "packet-stream-codec";
      version = "1.1.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/packet-stream-codec/-/packet-stream-codec-1.1.2.tgz";
        sha1 = "79b302fc144cdfbb4ab6feba7040e6a5d99c79c7";
      };
    };
    "pako-0.2.9" = {
      name = "pako";
      packageName = "pako";
      version = "0.2.9";
      src = fetchurl {
        url = "http://registry.npmjs.org/pako/-/pako-0.2.9.tgz";
        sha1 = "f3f7522f4ef782348da8161bad9ecfd51bf83a75";
      };
    };
    "pako-1.0.7" = {
      name = "pako";
      packageName = "pako";
      version = "1.0.7";
      src = fetchurl {
        url = "https://registry.npmjs.org/pako/-/pako-1.0.7.tgz";
        sha512 = "3HNK5tW4x8o5mO8RuHZp3Ydw9icZXx0RANAOMzlMzx7LVXhMJ4mo3MOBpzyd7r/+RUu8BmndP47LXT+vzjtWcQ==";
      };
    };
    "parallel-transform-1.1.0" = {
      name = "parallel-transform";
      packageName = "parallel-transform";
      version = "1.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/parallel-transform/-/parallel-transform-1.1.0.tgz";
        sha1 = "d410f065b05da23081fcd10f28854c29bda33b06";
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
    "parse-asn1-5.1.1" = {
      name = "parse-asn1";
      packageName = "parse-asn1";
      version = "5.1.1";
      src = fetchurl {
        url = "http://registry.npmjs.org/parse-asn1/-/parse-asn1-5.1.1.tgz";
        sha512 = "KPx7flKXg775zZpnp9SxJlz00gTd4BmJ2yJufSc44gMCRrRQ7NSzAcSJQfifuOLgW6bEi+ftrALtsgALeB2Adw==";
      };
    };
    "parse-entities-1.2.0" = {
      name = "parse-entities";
      packageName = "parse-entities";
      version = "1.2.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/parse-entities/-/parse-entities-1.2.0.tgz";
        sha512 = "XXtDdOPLSB0sHecbEapQi6/58U/ODj/KWfIXmmMCJF/eRn8laX6LZbOyioMoETOOJoWRW8/qTSl5VQkUIfKM5g==";
      };
    };
    "parse-glob-3.0.4" = {
      name = "parse-glob";
      packageName = "parse-glob";
      version = "3.0.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/parse-glob/-/parse-glob-3.0.4.tgz";
        sha1 = "b2c376cfb11f35513badd173ef0bb6e3a388391c";
      };
    };
    "parse-json-2.2.0" = {
      name = "parse-json";
      packageName = "parse-json";
      version = "2.2.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/parse-json/-/parse-json-2.2.0.tgz";
        sha1 = "f480f40434ef80741f8469099f8dea18f55a4dc9";
      };
    };
    "parseurl-1.3.2" = {
      name = "parseurl";
      packageName = "parseurl";
      version = "1.3.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/parseurl/-/parseurl-1.3.2.tgz";
        sha1 = "fc289d4ed8993119460c156253262cdc8de65bf3";
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
    "pascalcase-0.1.1" = {
      name = "pascalcase";
      packageName = "pascalcase";
      version = "0.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/pascalcase/-/pascalcase-0.1.1.tgz";
        sha1 = "b363e55e8006ca6fe21784d2db22bd15d7917f14";
      };
    };
    "path-browserify-0.0.0" = {
      name = "path-browserify";
      packageName = "path-browserify";
      version = "0.0.0";
      src = fetchurl {
        url = "http://registry.npmjs.org/path-browserify/-/path-browserify-0.0.0.tgz";
        sha1 = "a0b870729aae214005b7d5032ec2cbbb0fb4451a";
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
    "path-dirname-1.0.2" = {
      name = "path-dirname";
      packageName = "path-dirname";
      version = "1.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/path-dirname/-/path-dirname-1.0.2.tgz";
        sha1 = "cc33d24d525e099a5388c0336c6e32b9160609e0";
      };
    };
    "path-exists-2.1.0" = {
      name = "path-exists";
      packageName = "path-exists";
      version = "2.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/path-exists/-/path-exists-2.1.0.tgz";
        sha1 = "0feb6c64f0fc518d9a754dd5efb62c7022761f4b";
      };
    };
    "path-exists-3.0.0" = {
      name = "path-exists";
      packageName = "path-exists";
      version = "3.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/path-exists/-/path-exists-3.0.0.tgz";
        sha1 = "ce0ebeaa5f78cb18925ea7d810d7b59b010fd515";
      };
    };
    "path-is-absolute-1.0.1" = {
      name = "path-is-absolute";
      packageName = "path-is-absolute";
      version = "1.0.1";
      src = fetchurl {
        url = "http://registry.npmjs.org/path-is-absolute/-/path-is-absolute-1.0.1.tgz";
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
    "path-key-2.0.1" = {
      name = "path-key";
      packageName = "path-key";
      version = "2.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/path-key/-/path-key-2.0.1.tgz";
        sha1 = "411cadb574c5a140d3a4b1910d40d80cc9f40b40";
      };
    };
    "path-parse-1.0.6" = {
      name = "path-parse";
      packageName = "path-parse";
      version = "1.0.6";
      src = fetchurl {
        url = "https://registry.npmjs.org/path-parse/-/path-parse-1.0.6.tgz";
        sha512 = "GSmOT2EbHrINBf9SR7CDELwlJ8AENk3Qn7OikK4nFYAu3Ote2+JYNVvkpAEQm3/TLNEJFD/xZJjzyxg3KBWOzw==";
      };
    };
    "path-to-regexp-0.1.7" = {
      name = "path-to-regexp";
      packageName = "path-to-regexp";
      version = "0.1.7";
      src = fetchurl {
        url = "https://registry.npmjs.org/path-to-regexp/-/path-to-regexp-0.1.7.tgz";
        sha1 = "df604178005f522f15eb4490e7247a1bfaa67f8c";
      };
    };
    "path-type-1.1.0" = {
      name = "path-type";
      packageName = "path-type";
      version = "1.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/path-type/-/path-type-1.1.0.tgz";
        sha1 = "59c44f7ee491da704da415da5a4070ba4f8fe441";
      };
    };
    "path-type-2.0.0" = {
      name = "path-type";
      packageName = "path-type";
      version = "2.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/path-type/-/path-type-2.0.0.tgz";
        sha1 = "f012ccb8415b7096fc2daa1054c3d72389594c73";
      };
    };
    "path-type-3.0.0" = {
      name = "path-type";
      packageName = "path-type";
      version = "3.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/path-type/-/path-type-3.0.0.tgz";
        sha512 = "T2ZUsdZFHgA3u4e5PfPbjd7HDDpxPnQb5jN0SrDsjNSuVXHJqtwTnWqG0B1jZrgmJ/7lj1EmVIByWt1gxGkWvg==";
      };
    };
    "pathval-1.1.0" = {
      name = "pathval";
      packageName = "pathval";
      version = "1.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/pathval/-/pathval-1.1.0.tgz";
        sha1 = "b942e6d4bde653005ef6b71361def8727d0645e0";
      };
    };
    "pbkdf2-3.0.17" = {
      name = "pbkdf2";
      packageName = "pbkdf2";
      version = "3.0.17";
      src = fetchurl {
        url = "https://registry.npmjs.org/pbkdf2/-/pbkdf2-3.0.17.tgz";
        sha512 = "U/il5MsrZp7mGg3mSQfn742na2T+1/vHDCG5/iTI3X9MKUuYUZVLQhyRsg06mCgDBTd57TxzgZt7P+fYfjRLtA==";
      };
    };
    "peek-stream-1.1.3" = {
      name = "peek-stream";
      packageName = "peek-stream";
      version = "1.1.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/peek-stream/-/peek-stream-1.1.3.tgz";
        sha512 = "FhJ+YbOSBb9/rIl2ZeE/QHEsWn7PqNYt8ARAY3kIgNGOk13g9FGyIY6JIl/xB/3TFRVoTv5as0l11weORrTekA==";
      };
    };
    "pend-1.2.0" = {
      name = "pend";
      packageName = "pend";
      version = "1.2.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/pend/-/pend-1.2.0.tgz";
        sha1 = "7a57eb550a6783f9115331fcf4663d5c8e007a50";
      };
    };
    "performance-now-2.1.0" = {
      name = "performance-now";
      packageName = "performance-now";
      version = "2.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/performance-now/-/performance-now-2.1.0.tgz";
        sha1 = "6309f4e0e5fa913ec1c69307ae364b4b377c9e7b";
      };
    };
    "pify-2.3.0" = {
      name = "pify";
      packageName = "pify";
      version = "2.3.0";
      src = fetchurl {
        url = "http://registry.npmjs.org/pify/-/pify-2.3.0.tgz";
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
    "pkg-dir-2.0.0" = {
      name = "pkg-dir";
      packageName = "pkg-dir";
      version = "2.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/pkg-dir/-/pkg-dir-2.0.0.tgz";
        sha1 = "f6d5d1109e19d63edf428e0bd57e12777615334b";
      };
    };
    "pkginfo-0.3.1" = {
      name = "pkginfo";
      packageName = "pkginfo";
      version = "0.3.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/pkginfo/-/pkginfo-0.3.1.tgz";
        sha1 = "5b29f6a81f70717142e09e765bbeab97b4f81e21";
      };
    };
    "pkginfo-0.4.1" = {
      name = "pkginfo";
      packageName = "pkginfo";
      version = "0.4.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/pkginfo/-/pkginfo-0.4.1.tgz";
        sha1 = "b5418ef0439de5425fc4995042dced14fb2a84ff";
      };
    };
    "plur-2.1.2" = {
      name = "plur";
      packageName = "plur";
      version = "2.1.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/plur/-/plur-2.1.2.tgz";
        sha1 = "7482452c1a0f508e3e344eaec312c91c29dc655a";
      };
    };
    "popper.js-1.14.6" = {
      name = "popper.js";
      packageName = "popper.js";
      version = "1.14.6";
      src = fetchurl {
        url = "https://registry.npmjs.org/popper.js/-/popper.js-1.14.6.tgz";
        sha512 = "AGwHGQBKumlk/MDfrSOf0JHhJCImdDMcGNoqKmKkU+68GFazv3CQ6q9r7Ja1sKDZmYWTckY/uLyEznheTDycnA==";
      };
    };
    "portfinder-1.0.20" = {
      name = "portfinder";
      packageName = "portfinder";
      version = "1.0.20";
      src = fetchurl {
        url = "https://registry.npmjs.org/portfinder/-/portfinder-1.0.20.tgz";
        sha512 = "Yxe4mTyDzTd59PZJY4ojZR8F+E5e97iq2ZOHPz3HDgSvYC5siNad2tLooQ5y5QHyQhc3xVqvyk/eNA3wuoa7Sw==";
      };
    };
    "posix-character-classes-0.1.1" = {
      name = "posix-character-classes";
      packageName = "posix-character-classes";
      version = "0.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/posix-character-classes/-/posix-character-classes-0.1.1.tgz";
        sha1 = "01eac0fe3b5af71a2a6c02feabb8c1fef7e00eab";
      };
    };
    "postcss-5.2.18" = {
      name = "postcss";
      packageName = "postcss";
      version = "5.2.18";
      src = fetchurl {
        url = "https://registry.npmjs.org/postcss/-/postcss-5.2.18.tgz";
        sha512 = "zrUjRRe1bpXKsX1qAJNJjqZViErVuyEkMTRrwu4ud4sbTtIBRmtaYDrHmcGgmrbsW3MHfmtIf+vJumgQn+PrXg==";
      };
    };
    "postcss-6.0.23" = {
      name = "postcss";
      packageName = "postcss";
      version = "6.0.23";
      src = fetchurl {
        url = "https://registry.npmjs.org/postcss/-/postcss-6.0.23.tgz";
        sha512 = "soOk1h6J3VMTZtVeVpv15/Hpdl2cBLX3CAw4TAbkpTJiNPk9YP/zWcD1ND+xEtvyuuvKzbxliTOIyvkSeSJ6ag==";
      };
    };
    "postcss-calc-5.3.1" = {
      name = "postcss-calc";
      packageName = "postcss-calc";
      version = "5.3.1";
      src = fetchurl {
        url = "http://registry.npmjs.org/postcss-calc/-/postcss-calc-5.3.1.tgz";
        sha1 = "77bae7ca928ad85716e2fda42f261bf7c1d65b5e";
      };
    };
    "postcss-colormin-2.2.2" = {
      name = "postcss-colormin";
      packageName = "postcss-colormin";
      version = "2.2.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/postcss-colormin/-/postcss-colormin-2.2.2.tgz";
        sha1 = "6631417d5f0e909a3d7ec26b24c8a8d1e4f96e4b";
      };
    };
    "postcss-convert-values-2.6.1" = {
      name = "postcss-convert-values";
      packageName = "postcss-convert-values";
      version = "2.6.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/postcss-convert-values/-/postcss-convert-values-2.6.1.tgz";
        sha1 = "bbd8593c5c1fd2e3d1c322bb925dcae8dae4d62d";
      };
    };
    "postcss-discard-comments-2.0.4" = {
      name = "postcss-discard-comments";
      packageName = "postcss-discard-comments";
      version = "2.0.4";
      src = fetchurl {
        url = "http://registry.npmjs.org/postcss-discard-comments/-/postcss-discard-comments-2.0.4.tgz";
        sha1 = "befe89fafd5b3dace5ccce51b76b81514be00e3d";
      };
    };
    "postcss-discard-duplicates-2.1.0" = {
      name = "postcss-discard-duplicates";
      packageName = "postcss-discard-duplicates";
      version = "2.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/postcss-discard-duplicates/-/postcss-discard-duplicates-2.1.0.tgz";
        sha1 = "b9abf27b88ac188158a5eb12abcae20263b91932";
      };
    };
    "postcss-discard-empty-2.1.0" = {
      name = "postcss-discard-empty";
      packageName = "postcss-discard-empty";
      version = "2.1.0";
      src = fetchurl {
        url = "http://registry.npmjs.org/postcss-discard-empty/-/postcss-discard-empty-2.1.0.tgz";
        sha1 = "d2b4bd9d5ced5ebd8dcade7640c7d7cd7f4f92b5";
      };
    };
    "postcss-discard-overridden-0.1.1" = {
      name = "postcss-discard-overridden";
      packageName = "postcss-discard-overridden";
      version = "0.1.1";
      src = fetchurl {
        url = "http://registry.npmjs.org/postcss-discard-overridden/-/postcss-discard-overridden-0.1.1.tgz";
        sha1 = "8b1eaf554f686fb288cd874c55667b0aa3668d58";
      };
    };
    "postcss-discard-unused-2.2.3" = {
      name = "postcss-discard-unused";
      packageName = "postcss-discard-unused";
      version = "2.2.3";
      src = fetchurl {
        url = "http://registry.npmjs.org/postcss-discard-unused/-/postcss-discard-unused-2.2.3.tgz";
        sha1 = "bce30b2cc591ffc634322b5fb3464b6d934f4433";
      };
    };
    "postcss-filter-plugins-2.0.3" = {
      name = "postcss-filter-plugins";
      packageName = "postcss-filter-plugins";
      version = "2.0.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/postcss-filter-plugins/-/postcss-filter-plugins-2.0.3.tgz";
        sha512 = "T53GVFsdinJhgwm7rg1BzbeBRomOg9y5MBVhGcsV0CxurUdVj1UlPdKtn7aqYA/c/QVkzKMjq2bSV5dKG5+AwQ==";
      };
    };
    "postcss-load-config-1.2.0" = {
      name = "postcss-load-config";
      packageName = "postcss-load-config";
      version = "1.2.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/postcss-load-config/-/postcss-load-config-1.2.0.tgz";
        sha1 = "539e9afc9ddc8620121ebf9d8c3673e0ce50d28a";
      };
    };
    "postcss-load-options-1.2.0" = {
      name = "postcss-load-options";
      packageName = "postcss-load-options";
      version = "1.2.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/postcss-load-options/-/postcss-load-options-1.2.0.tgz";
        sha1 = "b098b1559ddac2df04bc0bb375f99a5cfe2b6d8c";
      };
    };
    "postcss-load-plugins-2.3.0" = {
      name = "postcss-load-plugins";
      packageName = "postcss-load-plugins";
      version = "2.3.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/postcss-load-plugins/-/postcss-load-plugins-2.3.0.tgz";
        sha1 = "745768116599aca2f009fad426b00175049d8d92";
      };
    };
    "postcss-merge-idents-2.1.7" = {
      name = "postcss-merge-idents";
      packageName = "postcss-merge-idents";
      version = "2.1.7";
      src = fetchurl {
        url = "http://registry.npmjs.org/postcss-merge-idents/-/postcss-merge-idents-2.1.7.tgz";
        sha1 = "4c5530313c08e1d5b3bbf3d2bbc747e278eea270";
      };
    };
    "postcss-merge-longhand-2.0.2" = {
      name = "postcss-merge-longhand";
      packageName = "postcss-merge-longhand";
      version = "2.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/postcss-merge-longhand/-/postcss-merge-longhand-2.0.2.tgz";
        sha1 = "23d90cd127b0a77994915332739034a1a4f3d658";
      };
    };
    "postcss-merge-rules-2.1.2" = {
      name = "postcss-merge-rules";
      packageName = "postcss-merge-rules";
      version = "2.1.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/postcss-merge-rules/-/postcss-merge-rules-2.1.2.tgz";
        sha1 = "d1df5dfaa7b1acc3be553f0e9e10e87c61b5f721";
      };
    };
    "postcss-message-helpers-2.0.0" = {
      name = "postcss-message-helpers";
      packageName = "postcss-message-helpers";
      version = "2.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/postcss-message-helpers/-/postcss-message-helpers-2.0.0.tgz";
        sha1 = "a4f2f4fab6e4fe002f0aed000478cdf52f9ba60e";
      };
    };
    "postcss-minify-font-values-1.0.5" = {
      name = "postcss-minify-font-values";
      packageName = "postcss-minify-font-values";
      version = "1.0.5";
      src = fetchurl {
        url = "http://registry.npmjs.org/postcss-minify-font-values/-/postcss-minify-font-values-1.0.5.tgz";
        sha1 = "4b58edb56641eba7c8474ab3526cafd7bbdecb69";
      };
    };
    "postcss-minify-gradients-1.0.5" = {
      name = "postcss-minify-gradients";
      packageName = "postcss-minify-gradients";
      version = "1.0.5";
      src = fetchurl {
        url = "http://registry.npmjs.org/postcss-minify-gradients/-/postcss-minify-gradients-1.0.5.tgz";
        sha1 = "5dbda11373703f83cfb4a3ea3881d8d75ff5e6e1";
      };
    };
    "postcss-minify-params-1.2.2" = {
      name = "postcss-minify-params";
      packageName = "postcss-minify-params";
      version = "1.2.2";
      src = fetchurl {
        url = "http://registry.npmjs.org/postcss-minify-params/-/postcss-minify-params-1.2.2.tgz";
        sha1 = "ad2ce071373b943b3d930a3fa59a358c28d6f1f3";
      };
    };
    "postcss-minify-selectors-2.1.1" = {
      name = "postcss-minify-selectors";
      packageName = "postcss-minify-selectors";
      version = "2.1.1";
      src = fetchurl {
        url = "http://registry.npmjs.org/postcss-minify-selectors/-/postcss-minify-selectors-2.1.1.tgz";
        sha1 = "b2c6a98c0072cf91b932d1a496508114311735bf";
      };
    };
    "postcss-modules-extract-imports-1.2.1" = {
      name = "postcss-modules-extract-imports";
      packageName = "postcss-modules-extract-imports";
      version = "1.2.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/postcss-modules-extract-imports/-/postcss-modules-extract-imports-1.2.1.tgz";
        sha512 = "6jt9XZwUhwmRUhb/CkyJY020PYaPJsCyt3UjbaWo6XEbH/94Hmv6MP7fG2C5NDU/BcHzyGYxNtHvM+LTf9HrYw==";
      };
    };
    "postcss-modules-local-by-default-1.2.0" = {
      name = "postcss-modules-local-by-default";
      packageName = "postcss-modules-local-by-default";
      version = "1.2.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/postcss-modules-local-by-default/-/postcss-modules-local-by-default-1.2.0.tgz";
        sha1 = "f7d80c398c5a393fa7964466bd19500a7d61c069";
      };
    };
    "postcss-modules-scope-1.1.0" = {
      name = "postcss-modules-scope";
      packageName = "postcss-modules-scope";
      version = "1.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/postcss-modules-scope/-/postcss-modules-scope-1.1.0.tgz";
        sha1 = "d6ea64994c79f97b62a72b426fbe6056a194bb90";
      };
    };
    "postcss-modules-values-1.3.0" = {
      name = "postcss-modules-values";
      packageName = "postcss-modules-values";
      version = "1.3.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/postcss-modules-values/-/postcss-modules-values-1.3.0.tgz";
        sha1 = "ecffa9d7e192518389f42ad0e83f72aec456ea20";
      };
    };
    "postcss-normalize-charset-1.1.1" = {
      name = "postcss-normalize-charset";
      packageName = "postcss-normalize-charset";
      version = "1.1.1";
      src = fetchurl {
        url = "http://registry.npmjs.org/postcss-normalize-charset/-/postcss-normalize-charset-1.1.1.tgz";
        sha1 = "ef9ee71212d7fe759c78ed162f61ed62b5cb93f1";
      };
    };
    "postcss-normalize-url-3.0.8" = {
      name = "postcss-normalize-url";
      packageName = "postcss-normalize-url";
      version = "3.0.8";
      src = fetchurl {
        url = "http://registry.npmjs.org/postcss-normalize-url/-/postcss-normalize-url-3.0.8.tgz";
        sha1 = "108f74b3f2fcdaf891a2ffa3ea4592279fc78222";
      };
    };
    "postcss-ordered-values-2.2.3" = {
      name = "postcss-ordered-values";
      packageName = "postcss-ordered-values";
      version = "2.2.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/postcss-ordered-values/-/postcss-ordered-values-2.2.3.tgz";
        sha1 = "eec6c2a67b6c412a8db2042e77fe8da43f95c11d";
      };
    };
    "postcss-reduce-idents-2.4.0" = {
      name = "postcss-reduce-idents";
      packageName = "postcss-reduce-idents";
      version = "2.4.0";
      src = fetchurl {
        url = "http://registry.npmjs.org/postcss-reduce-idents/-/postcss-reduce-idents-2.4.0.tgz";
        sha1 = "c2c6d20cc958284f6abfbe63f7609bf409059ad3";
      };
    };
    "postcss-reduce-initial-1.0.1" = {
      name = "postcss-reduce-initial";
      packageName = "postcss-reduce-initial";
      version = "1.0.1";
      src = fetchurl {
        url = "http://registry.npmjs.org/postcss-reduce-initial/-/postcss-reduce-initial-1.0.1.tgz";
        sha1 = "68f80695f045d08263a879ad240df8dd64f644ea";
      };
    };
    "postcss-reduce-transforms-1.0.4" = {
      name = "postcss-reduce-transforms";
      packageName = "postcss-reduce-transforms";
      version = "1.0.4";
      src = fetchurl {
        url = "http://registry.npmjs.org/postcss-reduce-transforms/-/postcss-reduce-transforms-1.0.4.tgz";
        sha1 = "ff76f4d8212437b31c298a42d2e1444025771ae1";
      };
    };
    "postcss-selector-parser-2.2.3" = {
      name = "postcss-selector-parser";
      packageName = "postcss-selector-parser";
      version = "2.2.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/postcss-selector-parser/-/postcss-selector-parser-2.2.3.tgz";
        sha1 = "f9437788606c3c9acee16ffe8d8b16297f27bb90";
      };
    };
    "postcss-svgo-2.1.6" = {
      name = "postcss-svgo";
      packageName = "postcss-svgo";
      version = "2.1.6";
      src = fetchurl {
        url = "http://registry.npmjs.org/postcss-svgo/-/postcss-svgo-2.1.6.tgz";
        sha1 = "b6df18aa613b666e133f08adb5219c2684ac108d";
      };
    };
    "postcss-unique-selectors-2.0.2" = {
      name = "postcss-unique-selectors";
      packageName = "postcss-unique-selectors";
      version = "2.0.2";
      src = fetchurl {
        url = "http://registry.npmjs.org/postcss-unique-selectors/-/postcss-unique-selectors-2.0.2.tgz";
        sha1 = "981d57d29ddcb33e7b1dfe1fd43b8649f933ca1d";
      };
    };
    "postcss-value-parser-3.3.1" = {
      name = "postcss-value-parser";
      packageName = "postcss-value-parser";
      version = "3.3.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/postcss-value-parser/-/postcss-value-parser-3.3.1.tgz";
        sha512 = "pISE66AbVkp4fDQ7VHBwRNXzAAKJjw4Vw7nWI/+Q3vuly7SNfgYXvm6i5IgFylHGK5sP/xHAbB7N49OS4gWNyQ==";
      };
    };
    "postcss-zindex-2.2.0" = {
      name = "postcss-zindex";
      packageName = "postcss-zindex";
      version = "2.2.0";
      src = fetchurl {
        url = "http://registry.npmjs.org/postcss-zindex/-/postcss-zindex-2.2.0.tgz";
        sha1 = "d2109ddc055b91af67fc4cb3b025946639d2af22";
      };
    };
    "prebuild-install-4.0.0" = {
      name = "prebuild-install";
      packageName = "prebuild-install";
      version = "4.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/prebuild-install/-/prebuild-install-4.0.0.tgz";
        sha512 = "7tayxeYboJX0RbVzdnKyGl2vhQRWr6qfClEXDhOkXjuaOKCw2q8aiuFhONRYVsG/czia7KhpykIlI2S2VaPunA==";
      };
    };
    "prelude-ls-1.1.2" = {
      name = "prelude-ls";
      packageName = "prelude-ls";
      version = "1.1.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/prelude-ls/-/prelude-ls-1.1.2.tgz";
        sha1 = "21932a549f5e52ffd9a827f570e04be62a97da54";
      };
    };
    "prepend-http-1.0.4" = {
      name = "prepend-http";
      packageName = "prepend-http";
      version = "1.0.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/prepend-http/-/prepend-http-1.0.4.tgz";
        sha1 = "d4f4562b0ce3696e41ac52d0e002e57a635dc6dc";
      };
    };
    "preserve-0.2.0" = {
      name = "preserve";
      packageName = "preserve";
      version = "0.2.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/preserve/-/preserve-0.2.0.tgz";
        sha1 = "815ed1f6ebc65926f865b310c0713bcb3315ce4b";
      };
    };
    "prettier-1.15.3" = {
      name = "prettier";
      packageName = "prettier";
      version = "1.15.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/prettier/-/prettier-1.15.3.tgz";
        sha512 = "gAU9AGAPMaKb3NNSUUuhhFAS7SCO4ALTN4nRIn6PJ075Qd28Yn2Ig2ahEJWdJwJmlEBTUfC7mMUSFy8MwsOCfg==";
      };
    };
    "pretty-bytes-1.0.4" = {
      name = "pretty-bytes";
      packageName = "pretty-bytes";
      version = "1.0.4";
      src = fetchurl {
        url = "http://registry.npmjs.org/pretty-bytes/-/pretty-bytes-1.0.4.tgz";
        sha1 = "0a22e8210609ad35542f8c8d5d2159aff0751c84";
      };
    };
    "pretty-error-2.1.1" = {
      name = "pretty-error";
      packageName = "pretty-error";
      version = "2.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/pretty-error/-/pretty-error-2.1.1.tgz";
        sha1 = "5f4f87c8f91e5ae3f3ba87ab4cf5e03b1a17f1a3";
      };
    };
    "private-0.1.8" = {
      name = "private";
      packageName = "private";
      version = "0.1.8";
      src = fetchurl {
        url = "https://registry.npmjs.org/private/-/private-0.1.8.tgz";
        sha512 = "VvivMrbvd2nKkiG38qjULzlc+4Vx4wm/whI9pQD35YrARNnhxeiRktSOhSukRLFNlzg6Br/cJPet5J/u19r/mg==";
      };
    };
    "private-box-0.3.0" = {
      name = "private-box";
      packageName = "private-box";
      version = "0.3.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/private-box/-/private-box-0.3.0.tgz";
        sha512 = "zsK6DDEC+cnNiunYamcVbx4ZCLbKnzTOZa09K4Pj3/tH3nQFPUO9K2QoYy4kfxLqmoyw6RPDtACN9OYviMQZ2Q==";
      };
    };
    "process-0.11.10" = {
      name = "process";
      packageName = "process";
      version = "0.11.10";
      src = fetchurl {
        url = "https://registry.npmjs.org/process/-/process-0.11.10.tgz";
        sha1 = "7332300e840161bda3e69a1d1d91a7d4bc16f182";
      };
    };
    "process-nextick-args-2.0.0" = {
      name = "process-nextick-args";
      packageName = "process-nextick-args";
      version = "2.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/process-nextick-args/-/process-nextick-args-2.0.0.tgz";
        sha512 = "MtEC1TqN0EU5nephaJ4rAtThHtC86dNN9qCuEhtshvpVBkAW5ZO7BASN9REnF9eoXGcRub+pFuKEpOHE+HbEMw==";
      };
    };
    "progress-2.0.3" = {
      name = "progress";
      packageName = "progress";
      version = "2.0.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/progress/-/progress-2.0.3.tgz";
        sha512 = "7PiHtLll5LdnKIMw100I+8xJXR5gW2QwWYkT6iJva0bXitZKa/XMrSbdmg3r2Xnaidz9Qumd0VPaMrZlF9V9sA==";
      };
    };
    "progress-stream-1.2.0" = {
      name = "progress-stream";
      packageName = "progress-stream";
      version = "1.2.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/progress-stream/-/progress-stream-1.2.0.tgz";
        sha1 = "2cd3cfea33ba3a89c9c121ec3347abe9ab125f77";
      };
    };
    "promise-inflight-1.0.1" = {
      name = "promise-inflight";
      packageName = "promise-inflight";
      version = "1.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/promise-inflight/-/promise-inflight-1.0.1.tgz";
        sha1 = "98472870bf228132fcbdd868129bad12c3c029e3";
      };
    };
    "prompt-1.0.0" = {
      name = "prompt";
      packageName = "prompt";
      version = "1.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/prompt/-/prompt-1.0.0.tgz";
        sha1 = "8e57123c396ab988897fb327fd3aedc3e735e4fe";
      };
    };
    "proxy-addr-2.0.4" = {
      name = "proxy-addr";
      packageName = "proxy-addr";
      version = "2.0.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/proxy-addr/-/proxy-addr-2.0.4.tgz";
        sha512 = "5erio2h9jp5CHGwcybmxmVqHmnCBZeewlfJ0pex+UW7Qny7OOZXTtH56TGNyBizkgiOwhJtMKrVzDTeKcySZwA==";
      };
    };
    "proxy-agent-2.0.0" = {
      name = "proxy-agent";
      packageName = "proxy-agent";
      version = "2.0.0";
      src = fetchurl {
        url = "http://registry.npmjs.org/proxy-agent/-/proxy-agent-2.0.0.tgz";
        sha1 = "57eb5347aa805d74ec681cb25649dba39c933499";
      };
    };
    "prr-0.0.0" = {
      name = "prr";
      packageName = "prr";
      version = "0.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/prr/-/prr-0.0.0.tgz";
        sha1 = "1a84b85908325501411853d0081ee3fa86e2926a";
      };
    };
    "prr-1.0.1" = {
      name = "prr";
      packageName = "prr";
      version = "1.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/prr/-/prr-1.0.1.tgz";
        sha1 = "d3fc114ba06995a45ec6893f484ceb1d78f5f476";
      };
    };
    "pseudomap-1.0.2" = {
      name = "pseudomap";
      packageName = "pseudomap";
      version = "1.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/pseudomap/-/pseudomap-1.0.2.tgz";
        sha1 = "f052a28da70e618917ef0a8ac34c1ae5a68286b3";
      };
    };
    "psl-1.1.31" = {
      name = "psl";
      packageName = "psl";
      version = "1.1.31";
      src = fetchurl {
        url = "https://registry.npmjs.org/psl/-/psl-1.1.31.tgz";
        sha512 = "/6pt4+C+T+wZUieKR620OpzN/LlnNKuWjy1iFLQ/UG35JqHlR/89MP1d96dUfkf6Dne3TuLQzOYEYshJ+Hx8mw==";
      };
    };
    "public-encrypt-4.0.3" = {
      name = "public-encrypt";
      packageName = "public-encrypt";
      version = "4.0.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/public-encrypt/-/public-encrypt-4.0.3.tgz";
        sha512 = "zVpa8oKZSz5bTMTFClc1fQOnyyEzpl5ozpi1B5YcvBrdohMjH2rfsBtyXcuNuwjsDIXmBYlF2N5FlJYhR29t8Q==";
      };
    };
    "pull-abortable-4.0.0" = {
      name = "pull-abortable";
      packageName = "pull-abortable";
      version = "4.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/pull-abortable/-/pull-abortable-4.0.0.tgz";
        sha1 = "7017a984c3b834de77bac38c10b776f22dfc1843";
      };
    };
    "pull-abortable-4.1.1" = {
      name = "pull-abortable";
      packageName = "pull-abortable";
      version = "4.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/pull-abortable/-/pull-abortable-4.1.1.tgz";
        sha1 = "b3ad5aefb4116b25916d26db89393ac98d0dcea1";
      };
    };
    "pull-box-stream-1.0.13" = {
      name = "pull-box-stream";
      packageName = "pull-box-stream";
      version = "1.0.13";
      src = fetchurl {
        url = "https://registry.npmjs.org/pull-box-stream/-/pull-box-stream-1.0.13.tgz";
        sha1 = "c3e240398eab3f5951b2ed1078c5988bf7a0a2b9";
      };
    };
    "pull-cat-1.1.11" = {
      name = "pull-cat";
      packageName = "pull-cat";
      version = "1.1.11";
      src = fetchurl {
        url = "https://registry.npmjs.org/pull-cat/-/pull-cat-1.1.11.tgz";
        sha1 = "b642dd1255da376a706b6db4fa962f5fdb74c31b";
      };
    };
    "pull-catch-1.0.0" = {
      name = "pull-catch";
      packageName = "pull-catch";
      version = "1.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/pull-catch/-/pull-catch-1.0.0.tgz";
        sha1 = "f58037eb5c282ccb506af9f76b0027d33931e48b";
      };
    };
    "pull-cont-0.0.0" = {
      name = "pull-cont";
      packageName = "pull-cont";
      version = "0.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/pull-cont/-/pull-cont-0.0.0.tgz";
        sha1 = "3fac48b81ac97b75ba01332088b0ce7af8c1be0e";
      };
    };
    "pull-cont-0.1.1" = {
      name = "pull-cont";
      packageName = "pull-cont";
      version = "0.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/pull-cont/-/pull-cont-0.1.1.tgz";
        sha1 = "df1d580e271757ba9acbaeba20de2421d660d618";
      };
    };
    "pull-core-1.1.0" = {
      name = "pull-core";
      packageName = "pull-core";
      version = "1.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/pull-core/-/pull-core-1.1.0.tgz";
        sha1 = "3d8127d6dac1475705c9800961f59d66c8046c8a";
      };
    };
    "pull-cursor-3.0.0" = {
      name = "pull-cursor";
      packageName = "pull-cursor";
      version = "3.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/pull-cursor/-/pull-cursor-3.0.0.tgz";
        sha512 = "95lZVSF2eSEdOmUtlOBaD9p5YOvlYeCr5FBv2ySqcj/4rpaXI6d8OH+zPHHjKAf58R8QXJRZuyfHkcCX8TZbAg==";
      };
    };
    "pull-defer-0.2.3" = {
      name = "pull-defer";
      packageName = "pull-defer";
      version = "0.2.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/pull-defer/-/pull-defer-0.2.3.tgz";
        sha512 = "/An3KE7mVjZCqNhZsr22k1Tx8MACnUnHZZNPSJ0S62td8JtYr/AiRG42Vz7Syu31SoTLUzVIe61jtT/pNdjVYA==";
      };
    };
    "pull-file-0.5.0" = {
      name = "pull-file";
      packageName = "pull-file";
      version = "0.5.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/pull-file/-/pull-file-0.5.0.tgz";
        sha1 = "b3ca405306e082f9d4528288933badb2b656365b";
      };
    };
    "pull-file-1.1.0" = {
      name = "pull-file";
      packageName = "pull-file";
      version = "1.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/pull-file/-/pull-file-1.1.0.tgz";
        sha1 = "1dd987605d6357a0d23c1e4b826f7915a215129c";
      };
    };
    "pull-file-reader-1.0.2" = {
      name = "pull-file-reader";
      packageName = "pull-file-reader";
      version = "1.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/pull-file-reader/-/pull-file-reader-1.0.2.tgz";
        sha1 = "d9b0d3d2de56f1a1ebb2ce8d313e79567d92dc48";
      };
    };
    "pull-flatmap-0.0.1" = {
      name = "pull-flatmap";
      packageName = "pull-flatmap";
      version = "0.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/pull-flatmap/-/pull-flatmap-0.0.1.tgz";
        sha1 = "13d494453e8f6d478e7bbfade6f8fe0197fa6bb7";
      };
    };
    "pull-fs-1.1.6" = {
      name = "pull-fs";
      packageName = "pull-fs";
      version = "1.1.6";
      src = fetchurl {
        url = "https://registry.npmjs.org/pull-fs/-/pull-fs-1.1.6.tgz";
        sha1 = "f184f6a7728bb4d95641376bead69f6f66df47cd";
      };
    };
    "pull-glob-1.0.7" = {
      name = "pull-glob";
      packageName = "pull-glob";
      version = "1.0.7";
      src = fetchurl {
        url = "https://registry.npmjs.org/pull-glob/-/pull-glob-1.0.7.tgz";
        sha1 = "eef915dde644bddbea8dd2e0106d544aacbcd5c2";
      };
    };
    "pull-goodbye-0.0.2" = {
      name = "pull-goodbye";
      packageName = "pull-goodbye";
      version = "0.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/pull-goodbye/-/pull-goodbye-0.0.2.tgz";
        sha1 = "8d8357db55e22a710dfff0f16a8c90b45efe4171";
      };
    };
    "pull-handshake-1.1.4" = {
      name = "pull-handshake";
      packageName = "pull-handshake";
      version = "1.1.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/pull-handshake/-/pull-handshake-1.1.4.tgz";
        sha1 = "6000a0fd018884cdfd737254f8cc60ab2a637791";
      };
    };
    "pull-hash-1.0.0" = {
      name = "pull-hash";
      packageName = "pull-hash";
      version = "1.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/pull-hash/-/pull-hash-1.0.0.tgz";
        sha1 = "fcad4d2507bf2c2b3231f653dc9bfb2db4f0d88c";
      };
    };
    "pull-inactivity-2.1.3" = {
      name = "pull-inactivity";
      packageName = "pull-inactivity";
      version = "2.1.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/pull-inactivity/-/pull-inactivity-2.1.3.tgz";
        sha512 = "swJ/jwkIN/O1bQCE3iY7Xy9r3gYuJ50MXaxZilw/HIduAy4tJu+vcz2/If0L+xNK7Ku/FfjtVbTpRTe7sf3hmA==";
      };
    };
    "pull-iterable-0.1.0" = {
      name = "pull-iterable";
      packageName = "pull-iterable";
      version = "0.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/pull-iterable/-/pull-iterable-0.1.0.tgz";
        sha512 = "FjhQ/STYNGwQaBhmuiZspL/+PIj+OHB1lE9OteegEWzciQhkJPx6Fwt+jqcpRDJ3kTzpt/ETSo3M5TFRpZ0pgQ==";
      };
    };
    "pull-level-2.0.4" = {
      name = "pull-level";
      packageName = "pull-level";
      version = "2.0.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/pull-level/-/pull-level-2.0.4.tgz";
        sha512 = "fW6pljDeUThpq5KXwKbRG3X7Ogk3vc75d5OQU/TvXXui65ykm+Bn+fiktg+MOx2jJ85cd+sheufPL+rw9QSVZg==";
      };
    };
    "pull-live-1.0.1" = {
      name = "pull-live";
      packageName = "pull-live";
      version = "1.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/pull-live/-/pull-live-1.0.1.tgz";
        sha1 = "a4ecee01e330155e9124bbbcf4761f21b38f51f5";
      };
    };
    "pull-looper-1.0.0" = {
      name = "pull-looper";
      packageName = "pull-looper";
      version = "1.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/pull-looper/-/pull-looper-1.0.0.tgz";
        sha512 = "djlD60A6NGe5goLdP5pgbqzMEiWmk1bInuAzBp0QOH4vDrVwh05YDz6UP8+pOXveKEk8wHVP+rB2jBrK31QMPA==";
      };
    };
    "pull-many-1.0.8" = {
      name = "pull-many";
      packageName = "pull-many";
      version = "1.0.8";
      src = fetchurl {
        url = "https://registry.npmjs.org/pull-many/-/pull-many-1.0.8.tgz";
        sha1 = "3dadd9b6d156c545721bda8d0003dd8eaa06293e";
      };
    };
    "pull-ndjson-0.1.1" = {
      name = "pull-ndjson";
      packageName = "pull-ndjson";
      version = "0.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/pull-ndjson/-/pull-ndjson-0.1.1.tgz";
        sha1 = "831e06bad9aa6c5c5ebc12a897e3a0e15d49e07e";
      };
    };
    "pull-next-1.0.1" = {
      name = "pull-next";
      packageName = "pull-next";
      version = "1.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/pull-next/-/pull-next-1.0.1.tgz";
        sha1 = "03f4d7d19872fc1114161e88db6ecf4c65e61e56";
      };
    };
    "pull-notify-0.1.1" = {
      name = "pull-notify";
      packageName = "pull-notify";
      version = "0.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/pull-notify/-/pull-notify-0.1.1.tgz";
        sha1 = "6f86ff95d270b89c3ebf255b6031b7032dc99cca";
      };
    };
    "pull-pair-1.1.0" = {
      name = "pull-pair";
      packageName = "pull-pair";
      version = "1.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/pull-pair/-/pull-pair-1.1.0.tgz";
        sha1 = "7ee427263fdf4da825397ac0a05e1ab4b74bd76d";
      };
    };
    "pull-paramap-1.2.2" = {
      name = "pull-paramap";
      packageName = "pull-paramap";
      version = "1.2.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/pull-paramap/-/pull-paramap-1.2.2.tgz";
        sha1 = "51a4193ce9c8d7215d95adad45e2bcdb8493b23a";
      };
    };
    "pull-pause-0.0.0" = {
      name = "pull-pause";
      packageName = "pull-pause";
      version = "0.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/pull-pause/-/pull-pause-0.0.0.tgz";
        sha1 = "101a628d717e19dfbf9800e9dec8f25d30461969";
      };
    };
    "pull-ping-2.0.2" = {
      name = "pull-ping";
      packageName = "pull-ping";
      version = "2.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/pull-ping/-/pull-ping-2.0.2.tgz";
        sha1 = "7bc4a340167dad88f682a196c63485735c7a0894";
      };
    };
    "pull-pushable-2.2.0" = {
      name = "pull-pushable";
      packageName = "pull-pushable";
      version = "2.2.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/pull-pushable/-/pull-pushable-2.2.0.tgz";
        sha1 = "5f2f3aed47ad86919f01b12a2e99d6f1bd776581";
      };
    };
    "pull-rate-1.0.2" = {
      name = "pull-rate";
      packageName = "pull-rate";
      version = "1.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/pull-rate/-/pull-rate-1.0.2.tgz";
        sha1 = "17b231ad5f359f675826670172b0e590c8964e8d";
      };
    };
    "pull-reader-1.3.1" = {
      name = "pull-reader";
      packageName = "pull-reader";
      version = "1.3.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/pull-reader/-/pull-reader-1.3.1.tgz";
        sha512 = "CBkejkE5nX50SiSEzu0Qoz4POTJMS/mw8G6aj3h3M/RJoKgggLxyF0IyTZ0mmpXFlXRcLmLmIEW4xeYn7AeDYw==";
      };
    };
    "pull-sink-through-0.0.0" = {
      name = "pull-sink-through";
      packageName = "pull-sink-through";
      version = "0.0.0";
      src = fetchurl {
        url = "http://registry.npmjs.org/pull-sink-through/-/pull-sink-through-0.0.0.tgz";
        sha1 = "d3c0492f3a80b4ed204af67c4b4f935680fc5b1f";
      };
    };
    "pull-sort-1.0.2" = {
      name = "pull-sort";
      packageName = "pull-sort";
      version = "1.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/pull-sort/-/pull-sort-1.0.2.tgz";
        sha512 = "jGcAHMP+0Le+bEIhSODlbNNd3jW+S6XrXOlhVzfcKU5HQZjP92OzQSgHHSlwvWRsiTWi+UGgbFpL/5gGgmFoVQ==";
      };
    };
    "pull-split-0.2.0" = {
      name = "pull-split";
      packageName = "pull-split";
      version = "0.2.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/pull-split/-/pull-split-0.2.0.tgz";
        sha1 = "996d288531052209a831388ad0d281df3c823796";
      };
    };
    "pull-stream-2.28.4" = {
      name = "pull-stream";
      packageName = "pull-stream";
      version = "2.28.4";
      src = fetchurl {
        url = "http://registry.npmjs.org/pull-stream/-/pull-stream-2.28.4.tgz";
        sha1 = "7ea97413c1619c20bc3bdf9e10e91347b03253e4";
      };
    };
    "pull-stream-3.5.0" = {
      name = "pull-stream";
      packageName = "pull-stream";
      version = "3.5.0";
      src = fetchurl {
        url = "http://registry.npmjs.org/pull-stream/-/pull-stream-3.5.0.tgz";
        sha1 = "1ee5b6f76fd3b3a49a5afb6ded5c0320acb3cfc7";
      };
    };
    "pull-stream-3.6.9" = {
      name = "pull-stream";
      packageName = "pull-stream";
      version = "3.6.9";
      src = fetchurl {
        url = "https://registry.npmjs.org/pull-stream/-/pull-stream-3.6.9.tgz";
        sha512 = "hJn4POeBrkttshdNl0AoSCVjMVSuBwuHocMerUdoZ2+oIUzrWHFTwJMlbHND7OiKLVgvz6TFj8ZUVywUMXccbw==";
      };
    };
    "pull-stringify-1.2.2" = {
      name = "pull-stringify";
      packageName = "pull-stringify";
      version = "1.2.2";
      src = fetchurl {
        url = "http://registry.npmjs.org/pull-stringify/-/pull-stringify-1.2.2.tgz";
        sha1 = "5a1c34e0075faf2f2f6d46004e36dccd33bd7c7c";
      };
    };
    "pull-stringify-2.0.0" = {
      name = "pull-stringify";
      packageName = "pull-stringify";
      version = "2.0.0";
      src = fetchurl {
        url = "http://registry.npmjs.org/pull-stringify/-/pull-stringify-2.0.0.tgz";
        sha1 = "22ba31da95af0888e0fb559238b1fa915a6a5b64";
      };
    };
    "pull-through-1.0.18" = {
      name = "pull-through";
      packageName = "pull-through";
      version = "1.0.18";
      src = fetchurl {
        url = "https://registry.npmjs.org/pull-through/-/pull-through-1.0.18.tgz";
        sha1 = "8dd62314263e59cf5096eafbb127a2b6ef310735";
      };
    };
    "pull-traverse-1.0.3" = {
      name = "pull-traverse";
      packageName = "pull-traverse";
      version = "1.0.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/pull-traverse/-/pull-traverse-1.0.3.tgz";
        sha1 = "74fb5d7be7fa6bd7a78e97933e199b7945866938";
      };
    };
    "pull-utf8-decoder-1.0.2" = {
      name = "pull-utf8-decoder";
      packageName = "pull-utf8-decoder";
      version = "1.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/pull-utf8-decoder/-/pull-utf8-decoder-1.0.2.tgz";
        sha1 = "a7afa2384d1e6415a5d602054126cc8de3bcbce7";
      };
    };
    "pull-window-2.1.4" = {
      name = "pull-window";
      packageName = "pull-window";
      version = "2.1.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/pull-window/-/pull-window-2.1.4.tgz";
        sha1 = "fc3b86feebd1920c7ae297691e23f705f88552f0";
      };
    };
    "pull-write-1.1.4" = {
      name = "pull-write";
      packageName = "pull-write";
      version = "1.1.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/pull-write/-/pull-write-1.1.4.tgz";
        sha1 = "dddea31493b48f6768b84a281d01eb3b531fe0b8";
      };
    };
    "pull-write-file-0.2.4" = {
      name = "pull-write-file";
      packageName = "pull-write-file";
      version = "0.2.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/pull-write-file/-/pull-write-file-0.2.4.tgz";
        sha1 = "437344aeb2189f65e678ed1af37f0f760a5453ef";
      };
    };
    "pull-ws-3.3.1" = {
      name = "pull-ws";
      packageName = "pull-ws";
      version = "3.3.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/pull-ws/-/pull-ws-3.3.1.tgz";
        sha512 = "kJodbLQT+oKjcRIQO+vQNw6xWBuEo7Kxp51VMOvb6cvPvHYA+aNLzm+NmkB/5dZwbuTRYGMal9QPvH52tzM1ZA==";
      };
    };
    "pump-1.0.3" = {
      name = "pump";
      packageName = "pump";
      version = "1.0.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/pump/-/pump-1.0.3.tgz";
        sha512 = "8k0JupWme55+9tCVE+FS5ULT3K6AbgqrGa58lTT49RpyfwwcGedHqaC5LlQNdEAumn/wFsu6aPwkuPMioy8kqw==";
      };
    };
    "pump-2.0.1" = {
      name = "pump";
      packageName = "pump";
      version = "2.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/pump/-/pump-2.0.1.tgz";
        sha512 = "ruPMNRkN3MHP1cWJc9OWr+T/xDP0jhXYCLfJcBuX54hhfIBnaQmAUMfDcG4DM5UMWByBbJY69QSphm3jtDKIkA==";
      };
    };
    "pumpify-1.5.1" = {
      name = "pumpify";
      packageName = "pumpify";
      version = "1.5.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/pumpify/-/pumpify-1.5.1.tgz";
        sha512 = "oClZI37HvuUJJxSKKrC17bZ9Cu0ZYhEAGPsPUy9KlMUmv9dKX2o77RUmq7f3XjIxbwyGwYzbzQ1L2Ks8sIradQ==";
      };
    };
    "punycode-1.3.2" = {
      name = "punycode";
      packageName = "punycode";
      version = "1.3.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/punycode/-/punycode-1.3.2.tgz";
        sha1 = "9653a036fb7c1ee42342f2325cceefea3926c48d";
      };
    };
    "punycode-1.4.1" = {
      name = "punycode";
      packageName = "punycode";
      version = "1.4.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/punycode/-/punycode-1.4.1.tgz";
        sha1 = "c0d5a63b2718800ad8e1eb0fa5269c84dd41845e";
      };
    };
    "punycode-2.1.1" = {
      name = "punycode";
      packageName = "punycode";
      version = "2.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/punycode/-/punycode-2.1.1.tgz";
        sha512 = "XRsRjdf+j5ml+y/6GKHPZbrF/8p2Yga0JPtdqTIY2Xe5ohJPD9saDJJLPvp9+NSBprVvevdXZybnj2cv8OEd0A==";
      };
    };
    "pupa-1.0.0" = {
      name = "pupa";
      packageName = "pupa";
      version = "1.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/pupa/-/pupa-1.0.0.tgz";
        sha1 = "9a9568a5af7e657b8462a6e9d5328743560ceff6";
      };
    };
    "push-stream-10.0.4" = {
      name = "push-stream";
      packageName = "push-stream";
      version = "10.0.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/push-stream/-/push-stream-10.0.4.tgz";
        sha512 = "IrP96RziNzT4UR7ZffM26o2NQ/Dq0dlRi1p8S/HE4+pHF6OaKWS1DyaJevsxJ6Q8bHafLqin6/pwI36FCmiV0w==";
      };
    };
    "push-stream-to-pull-stream-1.0.3" = {
      name = "push-stream-to-pull-stream";
      packageName = "push-stream-to-pull-stream";
      version = "1.0.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/push-stream-to-pull-stream/-/push-stream-to-pull-stream-1.0.3.tgz";
        sha512 = "pdE/OKi/jnp9DqGgNRzLY0oVHffn/8TXJmBPzv+ikdvpkeA0J//l5d7TZk1yWwZj9P0JcOIEVDOuHzhXaeBlmw==";
      };
    };
    "q-1.4.1" = {
      name = "q";
      packageName = "q";
      version = "1.4.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/q/-/q-1.4.1.tgz";
        sha1 = "55705bcd93c5f3673530c2c2cbc0c2b3addc286e";
      };
    };
    "q-1.5.1" = {
      name = "q";
      packageName = "q";
      version = "1.5.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/q/-/q-1.5.1.tgz";
        sha1 = "7e32f75b41381291d04611f1bf14109ac00651d7";
      };
    };
    "qs-6.5.2" = {
      name = "qs";
      packageName = "qs";
      version = "6.5.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/qs/-/qs-6.5.2.tgz";
        sha512 = "N5ZAX4/LxJmF+7wN74pUD6qAh9/wnvdQcjq9TZjevvXzSUo7bfmw91saqMjzGS2xq91/odN2dW/WOl7qQHNDGA==";
      };
    };
    "query-string-4.3.4" = {
      name = "query-string";
      packageName = "query-string";
      version = "4.3.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/query-string/-/query-string-4.3.4.tgz";
        sha1 = "bbb693b9ca915c232515b228b1a02b609043dbeb";
      };
    };
    "querystring-0.2.0" = {
      name = "querystring";
      packageName = "querystring";
      version = "0.2.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/querystring/-/querystring-0.2.0.tgz";
        sha1 = "b209849203bb25df820da756e747005878521620";
      };
    };
    "querystring-es3-0.2.1" = {
      name = "querystring-es3";
      packageName = "querystring-es3";
      version = "0.2.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/querystring-es3/-/querystring-es3-0.2.1.tgz";
        sha1 = "9ec61f79049875707d69414596fd907a4d711e73";
      };
    };
    "querystringify-2.1.0" = {
      name = "querystringify";
      packageName = "querystringify";
      version = "2.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/querystringify/-/querystringify-2.1.0.tgz";
        sha512 = "sluvZZ1YiTLD5jsqZcDmFyV2EwToyXZBfpoVOmktMmW+VEnhgakFHnasVph65fOjGPTWN0Nw3+XQaSeMayr0kg==";
      };
    };
    "quick-lru-1.1.0" = {
      name = "quick-lru";
      packageName = "quick-lru";
      version = "1.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/quick-lru/-/quick-lru-1.1.0.tgz";
        sha1 = "4360b17c61136ad38078397ff11416e186dcfbb8";
      };
    };
    "railroad-diagrams-1.0.0" = {
      name = "railroad-diagrams";
      packageName = "railroad-diagrams";
      version = "1.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/railroad-diagrams/-/railroad-diagrams-1.0.0.tgz";
        sha1 = "eb7e6267548ddedfb899c1b90e57374559cddb7e";
      };
    };
    "randexp-0.4.6" = {
      name = "randexp";
      packageName = "randexp";
      version = "0.4.6";
      src = fetchurl {
        url = "https://registry.npmjs.org/randexp/-/randexp-0.4.6.tgz";
        sha512 = "80WNmd9DA0tmZrw9qQa62GPPWfuXJknrmVmLcxvq4uZBdYqb1wYoKTmnlGUchvVWe0XiLupYkBoXVOxz3C8DYQ==";
      };
    };
    "randomatic-3.1.1" = {
      name = "randomatic";
      packageName = "randomatic";
      version = "3.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/randomatic/-/randomatic-3.1.1.tgz";
        sha512 = "TuDE5KxZ0J461RVjrJZCJc+J+zCkTb1MbH9AQUq68sMhOMcy9jLcb3BrZKgp9q9Ncltdg4QVqWrH02W2EFFVYw==";
      };
    };
    "randombytes-2.0.6" = {
      name = "randombytes";
      packageName = "randombytes";
      version = "2.0.6";
      src = fetchurl {
        url = "https://registry.npmjs.org/randombytes/-/randombytes-2.0.6.tgz";
        sha512 = "CIQ5OFxf4Jou6uOKe9t1AOgqpeU5fd70A8NPdHSGeYXqXsPe6peOwI0cUl88RWZ6sP1vPMV3avd/R6cZ5/sP1A==";
      };
    };
    "randomfill-1.0.4" = {
      name = "randomfill";
      packageName = "randomfill";
      version = "1.0.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/randomfill/-/randomfill-1.0.4.tgz";
        sha512 = "87lcbR8+MhcWcUiQ+9e+Rwx8MyR2P7qnt15ynUlbm3TU/fjbgz4GsvfSUDTemtCCtVCqb4ZcEFlyPNTh9bBTLw==";
      };
    };
    "range-parser-1.2.0" = {
      name = "range-parser";
      packageName = "range-parser";
      version = "1.2.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/range-parser/-/range-parser-1.2.0.tgz";
        sha1 = "f49be6b487894ddc40dcc94a322f611092e00d5e";
      };
    };
    "raw-body-2.3.3" = {
      name = "raw-body";
      packageName = "raw-body";
      version = "2.3.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/raw-body/-/raw-body-2.3.3.tgz";
        sha512 = "9esiElv1BrZoI3rCDuOuKCBRbuApGGaDPQfjSflGxdy4oyzqghxu6klEkkVIvBje+FF0BX9coEv8KqW6X/7njw==";
      };
    };
    "rc-1.2.8" = {
      name = "rc";
      packageName = "rc";
      version = "1.2.8";
      src = fetchurl {
        url = "https://registry.npmjs.org/rc/-/rc-1.2.8.tgz";
        sha512 = "y3bGgqKj3QBdxLbLkomlohkvsA8gdAiUQlSBJnBhfn+BPxg4bc62d8TcBW15wavDfgexCgccckhcZvywyQYPOw==";
      };
    };
    "read-1.0.7" = {
      name = "read";
      packageName = "read";
      version = "1.0.7";
      src = fetchurl {
        url = "https://registry.npmjs.org/read/-/read-1.0.7.tgz";
        sha1 = "b3da19bd052431a97671d44a42634adf710b40c4";
      };
    };
    "read-pkg-1.1.0" = {
      name = "read-pkg";
      packageName = "read-pkg";
      version = "1.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/read-pkg/-/read-pkg-1.1.0.tgz";
        sha1 = "f5ffaa5ecd29cb31c0474bca7d756b6bb29e3f28";
      };
    };
    "read-pkg-2.0.0" = {
      name = "read-pkg";
      packageName = "read-pkg";
      version = "2.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/read-pkg/-/read-pkg-2.0.0.tgz";
        sha1 = "8ef1c0623c6a6db0dc6713c4bfac46332b2368f8";
      };
    };
    "read-pkg-up-1.0.1" = {
      name = "read-pkg-up";
      packageName = "read-pkg-up";
      version = "1.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/read-pkg-up/-/read-pkg-up-1.0.1.tgz";
        sha1 = "9d63c13276c065918d57f002a57f40a1b643fb02";
      };
    };
    "read-pkg-up-2.0.0" = {
      name = "read-pkg-up";
      packageName = "read-pkg-up";
      version = "2.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/read-pkg-up/-/read-pkg-up-2.0.0.tgz";
        sha1 = "6b72a8048984e0c41e79510fd5e9fa99b3b549be";
      };
    };
    "readable-stream-1.0.34" = {
      name = "readable-stream";
      packageName = "readable-stream";
      version = "1.0.34";
      src = fetchurl {
        url = "http://registry.npmjs.org/readable-stream/-/readable-stream-1.0.34.tgz";
        sha1 = "125820e34bc842d2f2aaafafe4c2916ee32c157c";
      };
    };
    "readable-stream-1.1.14" = {
      name = "readable-stream";
      packageName = "readable-stream";
      version = "1.1.14";
      src = fetchurl {
        url = "http://registry.npmjs.org/readable-stream/-/readable-stream-1.1.14.tgz";
        sha1 = "7cf4c54ef648e3813084c636dd2079e166c081d9";
      };
    };
    "readable-stream-2.3.6" = {
      name = "readable-stream";
      packageName = "readable-stream";
      version = "2.3.6";
      src = fetchurl {
        url = "http://registry.npmjs.org/readable-stream/-/readable-stream-2.3.6.tgz";
        sha512 = "tQtKA9WIAhBF3+VLAseyMqZeBjW0AHJoxOtYqSUZNJxauErmLbVm2FW1y+J/YA9dUrAC39ITejlZWhVIwawkKw==";
      };
    };
    "readdirp-2.2.1" = {
      name = "readdirp";
      packageName = "readdirp";
      version = "2.2.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/readdirp/-/readdirp-2.2.1.tgz";
        sha512 = "1JU/8q+VgFZyxwrJ+SVIOsh+KywWGpds3NTqikiKpDMZWScmAYyKIgqkO+ARvNWJfXeXR1zxz7aHF4u4CyH6vQ==";
      };
    };
    "redent-1.0.0" = {
      name = "redent";
      packageName = "redent";
      version = "1.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/redent/-/redent-1.0.0.tgz";
        sha1 = "cf916ab1fd5f1f16dfb20822dd6ec7f730c2afde";
      };
    };
    "reduce-css-calc-1.3.0" = {
      name = "reduce-css-calc";
      packageName = "reduce-css-calc";
      version = "1.3.0";
      src = fetchurl {
        url = "http://registry.npmjs.org/reduce-css-calc/-/reduce-css-calc-1.3.0.tgz";
        sha1 = "747c914e049614a4c9cfbba629871ad1d2927716";
      };
    };
    "reduce-function-call-1.0.2" = {
      name = "reduce-function-call";
      packageName = "reduce-function-call";
      version = "1.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/reduce-function-call/-/reduce-function-call-1.0.2.tgz";
        sha1 = "5a200bf92e0e37751752fe45b0ab330fd4b6be99";
      };
    };
    "regedit-2.2.7" = {
      name = "regedit";
      packageName = "regedit";
      version = "2.2.7";
      src = fetchurl {
        url = "https://registry.npmjs.org/regedit/-/regedit-2.2.7.tgz";
        sha1 = "47028487a471aaa7d62a8d0383cceeedebf3af80";
      };
    };
    "regenerate-1.4.0" = {
      name = "regenerate";
      packageName = "regenerate";
      version = "1.4.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/regenerate/-/regenerate-1.4.0.tgz";
        sha512 = "1G6jJVDWrt0rK99kBjvEtziZNCICAuvIPkSiUFIQxVP06RCVpq3dmDo2oi6ABpYaDYaTRr67BEhL8r1wgEZZKg==";
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
    "regenerator-transform-0.10.1" = {
      name = "regenerator-transform";
      packageName = "regenerator-transform";
      version = "0.10.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/regenerator-transform/-/regenerator-transform-0.10.1.tgz";
        sha512 = "PJepbvDbuK1xgIgnau7Y90cwaAmO/LCLMI2mPvaXq2heGMR3aWW5/BQvYrhJ8jgmQjXewXvBjzfqKcVOmhjZ6Q==";
      };
    };
    "regex-cache-0.4.4" = {
      name = "regex-cache";
      packageName = "regex-cache";
      version = "0.4.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/regex-cache/-/regex-cache-0.4.4.tgz";
        sha512 = "nVIZwtCjkC9YgvWkpM55B5rBhBYRZhAaJbgcFYXXsHnbZ9UZI9nnVWYZpBlCqv9ho2eZryPnWrZGsOdPwVWXWQ==";
      };
    };
    "regex-not-1.0.2" = {
      name = "regex-not";
      packageName = "regex-not";
      version = "1.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/regex-not/-/regex-not-1.0.2.tgz";
        sha512 = "J6SDjUgDxQj5NusnOtdFxDwN/+HWykR8GELwctJ7mdqhcyy1xEc4SRFHUXvxTp661YaVKAjfRLZ9cCqS6tn32A==";
      };
    };
    "regexpu-core-1.0.0" = {
      name = "regexpu-core";
      packageName = "regexpu-core";
      version = "1.0.0";
      src = fetchurl {
        url = "http://registry.npmjs.org/regexpu-core/-/regexpu-core-1.0.0.tgz";
        sha1 = "86a763f58ee4d7c2f6b102e4764050de7ed90c6b";
      };
    };
    "regexpu-core-2.0.0" = {
      name = "regexpu-core";
      packageName = "regexpu-core";
      version = "2.0.0";
      src = fetchurl {
        url = "http://registry.npmjs.org/regexpu-core/-/regexpu-core-2.0.0.tgz";
        sha1 = "49d038837b8dcf8bfa5b9a42139938e6ea2ae240";
      };
    };
    "regjsgen-0.2.0" = {
      name = "regjsgen";
      packageName = "regjsgen";
      version = "0.2.0";
      src = fetchurl {
        url = "http://registry.npmjs.org/regjsgen/-/regjsgen-0.2.0.tgz";
        sha1 = "6c016adeac554f75823fe37ac05b92d5a4edb1f7";
      };
    };
    "regjsparser-0.1.5" = {
      name = "regjsparser";
      packageName = "regjsparser";
      version = "0.1.5";
      src = fetchurl {
        url = "http://registry.npmjs.org/regjsparser/-/regjsparser-0.1.5.tgz";
        sha1 = "7ee8f84dc6fa792d3fd0ae228d24bd949ead205c";
      };
    };
    "relateurl-0.2.7" = {
      name = "relateurl";
      packageName = "relateurl";
      version = "0.2.7";
      src = fetchurl {
        url = "https://registry.npmjs.org/relateurl/-/relateurl-0.2.7.tgz";
        sha1 = "54dbf377e51440aca90a4cd274600d3ff2d888a9";
      };
    };
    "relative-url-1.0.2" = {
      name = "relative-url";
      packageName = "relative-url";
      version = "1.0.2";
      src = fetchurl {
        url = "http://registry.npmjs.org/relative-url/-/relative-url-1.0.2.tgz";
        sha1 = "d21c52a72d6061018bcee9f9c9fc106bf7d65287";
      };
    };
    "remark-3.2.3" = {
      name = "remark";
      packageName = "remark";
      version = "3.2.3";
      src = fetchurl {
        url = "http://registry.npmjs.org/remark/-/remark-3.2.3.tgz";
        sha1 = "802a38c3aa98c9e1e3ea015eeba211d27cb65e1f";
      };
    };
    "remark-html-2.0.2" = {
      name = "remark-html";
      packageName = "remark-html";
      version = "2.0.2";
      src = fetchurl {
        url = "http://registry.npmjs.org/remark-html/-/remark-html-2.0.2.tgz";
        sha1 = "592a347bdd3d5881f4f080c98b5b152fb1407a92";
      };
    };
    "remove-trailing-separator-1.1.0" = {
      name = "remove-trailing-separator";
      packageName = "remove-trailing-separator";
      version = "1.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/remove-trailing-separator/-/remove-trailing-separator-1.1.0.tgz";
        sha1 = "c24bce2a283adad5bc3f58e0d48249b92379d8ef";
      };
    };
    "renderkid-2.0.2" = {
      name = "renderkid";
      packageName = "renderkid";
      version = "2.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/renderkid/-/renderkid-2.0.2.tgz";
        sha512 = "FsygIxevi1jSiPY9h7vZmBFUbAOcbYm9UwyiLNdVsLRs/5We9Ob5NMPbGYUTWiLq5L+ezlVdE0A8bbME5CWTpg==";
      };
    };
    "repeat-element-1.1.3" = {
      name = "repeat-element";
      packageName = "repeat-element";
      version = "1.1.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/repeat-element/-/repeat-element-1.1.3.tgz";
        sha512 = "ahGq0ZnV5m5XtZLMb+vP76kcAM5nkLqk0lpqAuojSKGgQtn4eRi4ZZGm2olo2zKFH+sMsWaqOCW1dqAnOru72g==";
      };
    };
    "repeat-string-1.6.1" = {
      name = "repeat-string";
      packageName = "repeat-string";
      version = "1.6.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/repeat-string/-/repeat-string-1.6.1.tgz";
        sha1 = "8dcae470e1c88abc2d600fff4a776286da75e637";
      };
    };
    "repeating-2.0.1" = {
      name = "repeating";
      packageName = "repeating";
      version = "2.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/repeating/-/repeating-2.0.1.tgz";
        sha1 = "5214c53a926d3552707527fbab415dbc08d06dda";
      };
    };
    "request-2.88.0" = {
      name = "request";
      packageName = "request";
      version = "2.88.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/request/-/request-2.88.0.tgz";
        sha512 = "NAqBSrijGLZdM0WZNsInLJpkJokL72XYjUpnB0iwsRgxh7dB6COrHnTBNwN0E+lHDAJzu7kLAkDeY08z2/A0hg==";
      };
    };
    "require-dir-1.2.0" = {
      name = "require-dir";
      packageName = "require-dir";
      version = "1.2.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/require-dir/-/require-dir-1.2.0.tgz";
        sha512 = "LY85DTSu+heYgDqq/mK+7zFHWkttVNRXC9NKcKGyuGLdlsfbjEPrIEYdCVrx6hqnJb+xSu3Lzaoo8VnmOhhjNA==";
      };
    };
    "require-directory-2.1.1" = {
      name = "require-directory";
      packageName = "require-directory";
      version = "2.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/require-directory/-/require-directory-2.1.1.tgz";
        sha1 = "8c64ad5fd30dab1c976e2344ffe7f792a6a6df42";
      };
    };
    "require-from-string-1.2.1" = {
      name = "require-from-string";
      packageName = "require-from-string";
      version = "1.2.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/require-from-string/-/require-from-string-1.2.1.tgz";
        sha1 = "529c9ccef27380adfec9a2f965b649bbee636418";
      };
    };
    "require-main-filename-1.0.1" = {
      name = "require-main-filename";
      packageName = "require-main-filename";
      version = "1.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/require-main-filename/-/require-main-filename-1.0.1.tgz";
        sha1 = "97f717b69d48784f5f526a6c5aa8ffdda055a4d1";
      };
    };
    "requires-port-1.0.0" = {
      name = "requires-port";
      packageName = "requires-port";
      version = "1.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/requires-port/-/requires-port-1.0.0.tgz";
        sha1 = "925d2601d39ac485e091cf0da5c6e694dc3dcaff";
      };
    };
    "resolve-1.7.1" = {
      name = "resolve";
      packageName = "resolve";
      version = "1.7.1";
      src = fetchurl {
        url = "http://registry.npmjs.org/resolve/-/resolve-1.7.1.tgz";
        sha512 = "c7rwLofp8g1U+h1KNyHL/jicrKg1Ek4q+Lr33AL65uZTinUZHe30D5HlyN5V9NW0JX1D5dXQ4jqW5l7Sy/kGfw==";
      };
    };
    "resolve-cwd-2.0.0" = {
      name = "resolve-cwd";
      packageName = "resolve-cwd";
      version = "2.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/resolve-cwd/-/resolve-cwd-2.0.0.tgz";
        sha1 = "00a9f7387556e27038eae232caa372a6a59b665a";
      };
    };
    "resolve-from-3.0.0" = {
      name = "resolve-from";
      packageName = "resolve-from";
      version = "3.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/resolve-from/-/resolve-from-3.0.0.tgz";
        sha1 = "b22c7af7d9d6881bc8b6e653335eebcb0a188748";
      };
    };
    "resolve-url-0.2.1" = {
      name = "resolve-url";
      packageName = "resolve-url";
      version = "0.2.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/resolve-url/-/resolve-url-0.2.1.tgz";
        sha1 = "2c637fe77c893afd2a663fe21aa9080068e2052a";
      };
    };
    "restore-cursor-1.0.1" = {
      name = "restore-cursor";
      packageName = "restore-cursor";
      version = "1.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/restore-cursor/-/restore-cursor-1.0.1.tgz";
        sha1 = "34661f46886327fed2991479152252df92daa541";
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
    "resumer-0.0.0" = {
      name = "resumer";
      packageName = "resumer";
      version = "0.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/resumer/-/resumer-0.0.0.tgz";
        sha1 = "f1e8f461e4064ba39e82af3cdc2a8c893d076759";
      };
    };
    "ret-0.1.15" = {
      name = "ret";
      packageName = "ret";
      version = "0.1.15";
      src = fetchurl {
        url = "https://registry.npmjs.org/ret/-/ret-0.1.15.tgz";
        sha512 = "TTlYpa+OL+vMMNG24xSlQGEJ3B/RzEfUlLct7b5G/ytav+wPrplCpVMFuwzXbkecJrb6IYo1iFb0S9v37754mg==";
      };
    };
    "revalidator-0.1.8" = {
      name = "revalidator";
      packageName = "revalidator";
      version = "0.1.8";
      src = fetchurl {
        url = "https://registry.npmjs.org/revalidator/-/revalidator-0.1.8.tgz";
        sha1 = "fece61bfa0c1b52a206bd6b18198184bdd523a3b";
      };
    };
    "rgb2hex-0.1.9" = {
      name = "rgb2hex";
      packageName = "rgb2hex";
      version = "0.1.9";
      src = fetchurl {
        url = "https://registry.npmjs.org/rgb2hex/-/rgb2hex-0.1.9.tgz";
        sha512 = "32iuQzhOjyT+cv9aAFRBJ19JgHwzQwbjUhH3Fj2sWW2EEGAW8fpFrDFP5ndoKDxJaLO06x1hE3kyuIFrUQtybQ==";
      };
    };
    "right-align-0.1.3" = {
      name = "right-align";
      packageName = "right-align";
      version = "0.1.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/right-align/-/right-align-0.1.3.tgz";
        sha1 = "61339b722fe6a3515689210d24e14c96148613ef";
      };
    };
    "rimraf-2.2.8" = {
      name = "rimraf";
      packageName = "rimraf";
      version = "2.2.8";
      src = fetchurl {
        url = "http://registry.npmjs.org/rimraf/-/rimraf-2.2.8.tgz";
        sha1 = "e439be2aaee327321952730f99a8929e4fc50582";
      };
    };
    "rimraf-2.4.5" = {
      name = "rimraf";
      packageName = "rimraf";
      version = "2.4.5";
      src = fetchurl {
        url = "http://registry.npmjs.org/rimraf/-/rimraf-2.4.5.tgz";
        sha1 = "ee710ce5d93a8fdb856fb5ea8ff0e2d75934b2da";
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
    "ripemd160-2.0.2" = {
      name = "ripemd160";
      packageName = "ripemd160";
      version = "2.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/ripemd160/-/ripemd160-2.0.2.tgz";
        sha512 = "ii4iagi25WusVoiC4B4lq7pbXfAp3D9v5CwfkY33vffw2+pkDjY1D8GaN7spsxvCSx8dkPqOZCEZyfxcmJG2IA==";
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
    "run-queue-1.0.3" = {
      name = "run-queue";
      packageName = "run-queue";
      version = "1.0.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/run-queue/-/run-queue-1.0.3.tgz";
        sha1 = "e848396f057d223f24386924618e25694161ec47";
      };
    };
    "rw-1.3.3" = {
      name = "rw";
      packageName = "rw";
      version = "1.3.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/rw/-/rw-1.3.3.tgz";
        sha1 = "3f862dfa91ab766b14885ef4d01124bfda074fb4";
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
    "rx-lite-4.0.8" = {
      name = "rx-lite";
      packageName = "rx-lite";
      version = "4.0.8";
      src = fetchurl {
        url = "https://registry.npmjs.org/rx-lite/-/rx-lite-4.0.8.tgz";
        sha1 = "0b1e11af8bc44836f04a6407e92da42467b79444";
      };
    };
    "rx-lite-aggregates-4.0.8" = {
      name = "rx-lite-aggregates";
      packageName = "rx-lite-aggregates";
      version = "4.0.8";
      src = fetchurl {
        url = "https://registry.npmjs.org/rx-lite-aggregates/-/rx-lite-aggregates-4.0.8.tgz";
        sha1 = "753b87a89a11c95467c4ac1626c4efc4e05c67be";
      };
    };
    "safe-buffer-5.1.2" = {
      name = "safe-buffer";
      packageName = "safe-buffer";
      version = "5.1.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/safe-buffer/-/safe-buffer-5.1.2.tgz";
        sha512 = "Gd2UZBJDkXlY7GbJxfsE8/nvKkUEU1G38c1siN6QP6a9PT9MmHB8GnpscSmMJSoF8LOIrt8ud/wPtojys4G6+g==";
      };
    };
    "safe-regex-1.1.0" = {
      name = "safe-regex";
      packageName = "safe-regex";
      version = "1.1.0";
      src = fetchurl {
        url = "http://registry.npmjs.org/safe-regex/-/safe-regex-1.1.0.tgz";
        sha1 = "40a3669f3b077d1e943d44629e157dd48023bf2e";
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
    "sass-graph-2.2.4" = {
      name = "sass-graph";
      packageName = "sass-graph";
      version = "2.2.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/sass-graph/-/sass-graph-2.2.4.tgz";
        sha1 = "13fbd63cd1caf0908b9fd93476ad43a51d1e0b49";
      };
    };
    "sass-loader-6.0.7" = {
      name = "sass-loader";
      packageName = "sass-loader";
      version = "6.0.7";
      src = fetchurl {
        url = "https://registry.npmjs.org/sass-loader/-/sass-loader-6.0.7.tgz";
        sha512 = "JoiyD00Yo1o61OJsoP2s2kb19L1/Y2p3QFcCdWdF6oomBGKVYuZyqHWemRBfQ2uGYsk+CH3eCguXNfpjzlcpaA==";
      };
    };
    "sax-1.2.4" = {
      name = "sax";
      packageName = "sax";
      version = "1.2.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/sax/-/sax-1.2.4.tgz";
        sha512 = "NqVDv9TpANUjFm0N8uM5GxL36UgKi9/atZw+x7YFnQ8ckwFGKrl4xX4yWtrey3UJm5nP1kUbnYgLopqWNSRhWw==";
      };
    };
    "schema-utils-0.3.0" = {
      name = "schema-utils";
      packageName = "schema-utils";
      version = "0.3.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/schema-utils/-/schema-utils-0.3.0.tgz";
        sha1 = "f5877222ce3e931edae039f17eb3716e7137f8cf";
      };
    };
    "schema-utils-0.4.7" = {
      name = "schema-utils";
      packageName = "schema-utils";
      version = "0.4.7";
      src = fetchurl {
        url = "https://registry.npmjs.org/schema-utils/-/schema-utils-0.4.7.tgz";
        sha512 = "v/iwU6wvwGK8HbU9yi3/nhGzP0yGSuhQMzL6ySiec1FSrZZDkhm4noOSWzrNFo/jEc+SJY6jRTwuwbSXJPDUnQ==";
      };
    };
    "scss-tokenizer-0.2.3" = {
      name = "scss-tokenizer";
      packageName = "scss-tokenizer";
      version = "0.2.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/scss-tokenizer/-/scss-tokenizer-0.2.3.tgz";
        sha1 = "8eb06db9a9723333824d3f5530641149847ce5d1";
      };
    };
    "scuttle-shell-0.1.3" = {
      name = "scuttle-shell";
      packageName = "scuttle-shell";
      version = "0.1.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/scuttle-shell/-/scuttle-shell-0.1.3.tgz";
        sha512 = "RUKhQuwwQum2vH6i1kKLWM2VKAC/nf/g3XGAvqqq2N2cJiX2oyoEz/FEEFLBputlLwSzMndxI8CgOcgRiEY90g==";
      };
    };
    "scuttle-tag-0.3.0" = {
      name = "scuttle-tag";
      packageName = "scuttle-tag";
      version = "0.3.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/scuttle-tag/-/scuttle-tag-0.3.0.tgz";
        sha512 = "tNEM6LRQiCpzQPyryWahzvcp7aCkYgVJ7N1MveKIXAJDCCYk2qtLx4ippD4lkIHWuez5f7bTRszAO89g6zSCdg==";
      };
    };
    "scuttlebot-13.2.2" = {
      name = "scuttlebot";
      packageName = "scuttlebot";
      version = "13.2.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/scuttlebot/-/scuttlebot-13.2.2.tgz";
        sha512 = "QRBWq6TSK1Tk2lE978avGJyOgh1Glnru5zR/i6RWmaq3n0rYxFxEslGvpu3TupInCaog98DU1n6nDLszQvvtdA==";
      };
    };
    "secret-handshake-1.1.14" = {
      name = "secret-handshake";
      packageName = "secret-handshake";
      version = "1.1.14";
      src = fetchurl {
        url = "https://registry.npmjs.org/secret-handshake/-/secret-handshake-1.1.14.tgz";
        sha512 = "e4hiMTahaLiN5XKap1YrifoyT8yRu9yQEZrMTglTBgq8Lv8iChFKLpbmXYeNxy2rCnutuWaQDFbp3sBgl4NQ4g==";
      };
    };
    "secret-stack-5.0.0" = {
      name = "secret-stack";
      packageName = "secret-stack";
      version = "5.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/secret-stack/-/secret-stack-5.0.0.tgz";
        sha512 = "kksU6sS9+sm9qKcER39VEEQggObTFJkuVSXHSKxQ+qu3TcqhQnPQT4BY9nmkq7mvMdYOhVWnXsktnIHfSNgfoQ==";
      };
    };
    "select-hose-2.0.0" = {
      name = "select-hose";
      packageName = "select-hose";
      version = "2.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/select-hose/-/select-hose-2.0.0.tgz";
        sha1 = "625d8658f865af43ec962bfc376a37359a4994ca";
      };
    };
    "selfsigned-1.10.4" = {
      name = "selfsigned";
      packageName = "selfsigned";
      version = "1.10.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/selfsigned/-/selfsigned-1.10.4.tgz";
        sha512 = "9AukTiDmHXGXWtWjembZ5NDmVvP2695EtpgbCsxCa68w3c88B+alqbmZ4O3hZ4VWGXeGWzEVdvqgAJD8DQPCDw==";
      };
    };
    "semver-5.0.3" = {
      name = "semver";
      packageName = "semver";
      version = "5.0.3";
      src = fetchurl {
        url = "http://registry.npmjs.org/semver/-/semver-5.0.3.tgz";
        sha1 = "77466de589cd5d3c95f138aa78bc569a3cb5d27a";
      };
    };
    "semver-5.1.1" = {
      name = "semver";
      packageName = "semver";
      version = "5.1.1";
      src = fetchurl {
        url = "http://registry.npmjs.org/semver/-/semver-5.1.1.tgz";
        sha1 = "a3292a373e6f3e0798da0b20641b9a9c5bc47e19";
      };
    };
    "semver-5.3.0" = {
      name = "semver";
      packageName = "semver";
      version = "5.3.0";
      src = fetchurl {
        url = "http://registry.npmjs.org/semver/-/semver-5.3.0.tgz";
        sha1 = "9b2ce5d3de02d17c6012ad326aa6b4d0cf54f94f";
      };
    };
    "semver-5.6.0" = {
      name = "semver";
      packageName = "semver";
      version = "5.6.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/semver/-/semver-5.6.0.tgz";
        sha512 = "RS9R6R35NYgQn++fkDWaOmqGoj4Ek9gGs+DPxNUZKuwE183xjJroKvyo1IzVFeXvUrvmALy6FWD5xrdJT25gMg==";
      };
    };
    "send-0.16.2" = {
      name = "send";
      packageName = "send";
      version = "0.16.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/send/-/send-0.16.2.tgz";
        sha512 = "E64YFPUssFHEFBvpbbjr44NCLtI1AohxQ8ZSiJjQLskAdKuriYEP6VyGEsRDH8ScozGpkaX1BGvhanqCwkcEZw==";
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
    "separator-escape-0.0.0" = {
      name = "separator-escape";
      packageName = "separator-escape";
      version = "0.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/separator-escape/-/separator-escape-0.0.0.tgz";
        sha1 = "e433676932020454e3c14870c517ea1de56c2fa4";
      };
    };
    "serialize-javascript-1.5.0" = {
      name = "serialize-javascript";
      packageName = "serialize-javascript";
      version = "1.5.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/serialize-javascript/-/serialize-javascript-1.5.0.tgz";
        sha512 = "Ga8c8NjAAp46Br4+0oZ2WxJCwIzwP60Gq1YPgU+39PiTVxyed/iKE/zyZI6+UlVYH5Q4PaQdHhcegIFPZTUfoQ==";
      };
    };
    "serve-index-1.9.1" = {
      name = "serve-index";
      packageName = "serve-index";
      version = "1.9.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/serve-index/-/serve-index-1.9.1.tgz";
        sha1 = "d3768d69b1e7d82e5ce050fff5b453bea12a9239";
      };
    };
    "serve-static-1.13.2" = {
      name = "serve-static";
      packageName = "serve-static";
      version = "1.13.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/serve-static/-/serve-static-1.13.2.tgz";
        sha512 = "p/tdJrO4U387R9oMjb1oj7qSMaMfmOyd4j9hOFoxZe2baQszgHcSWjuya/CiT5kgZZKRudHNOA0pYXOl8rQ5nw==";
      };
    };
    "set-blocking-2.0.0" = {
      name = "set-blocking";
      packageName = "set-blocking";
      version = "2.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/set-blocking/-/set-blocking-2.0.0.tgz";
        sha1 = "045f9782d011ae9a6803ddd382b24392b3d890f7";
      };
    };
    "set-value-0.4.3" = {
      name = "set-value";
      packageName = "set-value";
      version = "0.4.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/set-value/-/set-value-0.4.3.tgz";
        sha1 = "7db08f9d3d22dc7f78e53af3c3bf4666ecdfccf1";
      };
    };
    "set-value-2.0.0" = {
      name = "set-value";
      packageName = "set-value";
      version = "2.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/set-value/-/set-value-2.0.0.tgz";
        sha512 = "hw0yxk9GT/Hr5yJEYnHNKYXkIA8mVJgd9ditYZCe16ZczcaELYYcfvaXesNACk2O8O0nTiPQcQhGUQj8JLzeeg==";
      };
    };
    "setimmediate-1.0.5" = {
      name = "setimmediate";
      packageName = "setimmediate";
      version = "1.0.5";
      src = fetchurl {
        url = "https://registry.npmjs.org/setimmediate/-/setimmediate-1.0.5.tgz";
        sha1 = "290cbb232e306942d7d7ea9b83732ab7856f8285";
      };
    };
    "setprototypeof-1.1.0" = {
      name = "setprototypeof";
      packageName = "setprototypeof";
      version = "1.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/setprototypeof/-/setprototypeof-1.1.0.tgz";
        sha512 = "BvE/TwpZX4FXExxOxZyRGQQv651MSwmWKZGqvmPcRIjDqWub67kTKuIMx43cZZrS/cBBzwBcNDWoFxt2XEFIpQ==";
      };
    };
    "sha.js-2.4.11" = {
      name = "sha.js";
      packageName = "sha.js";
      version = "2.4.11";
      src = fetchurl {
        url = "http://registry.npmjs.org/sha.js/-/sha.js-2.4.11.tgz";
        sha512 = "QMEp5B7cftE7APOjk5Y6xgrbWu+WkLVQwk8JNjZ8nKRciZaByEW6MubieAiToS7+dwvrjGhH8jRXz3MVd0AYqQ==";
      };
    };
    "sha.js-2.4.5" = {
      name = "sha.js";
      packageName = "sha.js";
      version = "2.4.5";
      src = fetchurl {
        url = "http://registry.npmjs.org/sha.js/-/sha.js-2.4.5.tgz";
        sha1 = "27d171efcc82a118b99639ff581660242b506e7c";
      };
    };
    "shallow-clone-1.0.0" = {
      name = "shallow-clone";
      packageName = "shallow-clone";
      version = "1.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/shallow-clone/-/shallow-clone-1.0.0.tgz";
        sha512 = "oeXreoKR/SyNJtRJMAKPDSvd28OqEwG4eR/xc856cRGBII7gX9lvAqDxusPm0846z/w/hWYjI1NpKwJ00NHzRA==";
      };
    };
    "shebang-command-1.2.0" = {
      name = "shebang-command";
      packageName = "shebang-command";
      version = "1.2.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/shebang-command/-/shebang-command-1.2.0.tgz";
        sha1 = "44aac65b695b03398968c39f363fee5deafdf1ea";
      };
    };
    "shebang-regex-1.0.0" = {
      name = "shebang-regex";
      packageName = "shebang-regex";
      version = "1.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/shebang-regex/-/shebang-regex-1.0.0.tgz";
        sha1 = "da42f49740c0b42db2ca9728571cb190c98efea3";
      };
    };
    "shell-env-0.3.0" = {
      name = "shell-env";
      packageName = "shell-env";
      version = "0.3.0";
      src = fetchurl {
        url = "http://registry.npmjs.org/shell-env/-/shell-env-0.3.0.tgz";
        sha1 = "2250339022989165bda4eb7bf383afeaaa92dc34";
      };
    };
    "shell-path-2.1.0" = {
      name = "shell-path";
      packageName = "shell-path";
      version = "2.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/shell-path/-/shell-path-2.1.0.tgz";
        sha1 = "ea7d06ae1070874a1bac5c65bb9bdd62e4f67a38";
      };
    };
    "shellsubstitute-1.2.0" = {
      name = "shellsubstitute";
      packageName = "shellsubstitute";
      version = "1.2.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/shellsubstitute/-/shellsubstitute-1.2.0.tgz";
        sha1 = "e4f702a50c518b0f6fe98451890d705af29b6b70";
      };
    };
    "shellwords-0.1.1" = {
      name = "shellwords";
      packageName = "shellwords";
      version = "0.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/shellwords/-/shellwords-0.1.1.tgz";
        sha512 = "vFwSUfQvqybiICwZY5+DAWIPLKsWO31Q91JSKl3UYv+K5c2QRPzn0qzec6QPu1Qc9eHYItiP3NdJqNVqetYAww==";
      };
    };
    "shvl-1.3.1" = {
      name = "shvl";
      packageName = "shvl";
      version = "1.3.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/shvl/-/shvl-1.3.1.tgz";
        sha512 = "+rRPP46hloYUAEImJcqprUgXu+05Ikqr4h4V+w5i2zJy37nAqtkQKufs3+3S2fDq6JNRrHMIQhB/Vaex+jgAAw==";
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
    "simple-concat-1.0.0" = {
      name = "simple-concat";
      packageName = "simple-concat";
      version = "1.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/simple-concat/-/simple-concat-1.0.0.tgz";
        sha1 = "7344cbb8b6e26fb27d66b2fc86f9f6d5997521c6";
      };
    };
    "simple-get-2.8.1" = {
      name = "simple-get";
      packageName = "simple-get";
      version = "2.8.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/simple-get/-/simple-get-2.8.1.tgz";
        sha512 = "lSSHRSw3mQNUGPAYRqo7xy9dhKmxFXIjLjp4KHpf99GEH2VH7C3AM+Qfx6du6jhfUi6Vm7XnbEVEf7Wb6N8jRw==";
      };
    };
    "single-line-log-1.1.2" = {
      name = "single-line-log";
      packageName = "single-line-log";
      version = "1.1.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/single-line-log/-/single-line-log-1.1.2.tgz";
        sha1 = "c2f83f273a3e1a16edb0995661da0ed5ef033364";
      };
    };
    "slash-1.0.0" = {
      name = "slash";
      packageName = "slash";
      version = "1.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/slash/-/slash-1.0.0.tgz";
        sha1 = "c41f2f6c39fc16d1cd17ad4b5d896114ae470d55";
      };
    };
    "smart-buffer-1.1.15" = {
      name = "smart-buffer";
      packageName = "smart-buffer";
      version = "1.1.15";
      src = fetchurl {
        url = "https://registry.npmjs.org/smart-buffer/-/smart-buffer-1.1.15.tgz";
        sha1 = "7f114b5b65fab3e2a35aa775bb12f0d1c649bf16";
      };
    };
    "smart-buffer-4.0.1" = {
      name = "smart-buffer";
      packageName = "smart-buffer";
      version = "4.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/smart-buffer/-/smart-buffer-4.0.1.tgz";
        sha512 = "RFqinRVJVcCAL9Uh1oVqE6FZkqsyLiVOYEZ20TqIOjuX7iFVJ+zsbs4RIghnw/pTs7mZvt8ZHhvm1ZUrR4fykg==";
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
    "snapdragon-0.8.2" = {
      name = "snapdragon";
      packageName = "snapdragon";
      version = "0.8.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/snapdragon/-/snapdragon-0.8.2.tgz";
        sha512 = "FtyOnWN/wCHTVXOMwvSv26d+ko5vWlIDD6zoUJ7LW8vh+ZBC8QdljveRP+crNrtBwioEUWy/4dMtbBjA4ioNlg==";
      };
    };
    "snapdragon-node-2.1.1" = {
      name = "snapdragon-node";
      packageName = "snapdragon-node";
      version = "2.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/snapdragon-node/-/snapdragon-node-2.1.1.tgz";
        sha512 = "O27l4xaMYt/RSQ5TR3vpWCAB5Kb/czIcqUFOM/C4fYcLnbZUc1PkjTAMjof2pBWaSTwOUd6qUHcFGVGj7aIwnw==";
      };
    };
    "snapdragon-util-3.0.1" = {
      name = "snapdragon-util";
      packageName = "snapdragon-util";
      version = "3.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/snapdragon-util/-/snapdragon-util-3.0.1.tgz";
        sha512 = "mbKkMdQKsjX4BAL4bRYTj21edOf8cN7XHdYUJEe+Zn99hVEYcMvKPct1IqNe7+AZPirn8BCDOQBHQZknqmKlZQ==";
      };
    };
    "sockjs-0.3.19" = {
      name = "sockjs";
      packageName = "sockjs";
      version = "0.3.19";
      src = fetchurl {
        url = "https://registry.npmjs.org/sockjs/-/sockjs-0.3.19.tgz";
        sha512 = "V48klKZl8T6MzatbLlzzRNhMepEys9Y4oGFpypBFFn1gLI/QQ9HtLLyWJNbPlwGLelOVOEijUbTTJeLLI59jLw==";
      };
    };
    "sockjs-client-1.1.5" = {
      name = "sockjs-client";
      packageName = "sockjs-client";
      version = "1.1.5";
      src = fetchurl {
        url = "https://registry.npmjs.org/sockjs-client/-/sockjs-client-1.1.5.tgz";
        sha1 = "1bb7c0f7222c40f42adf14f4442cbd1269771a83";
      };
    };
    "socks-1.1.10" = {
      name = "socks";
      packageName = "socks";
      version = "1.1.10";
      src = fetchurl {
        url = "https://registry.npmjs.org/socks/-/socks-1.1.10.tgz";
        sha1 = "5b8b7fc7c8f341c53ed056e929b7bf4de8ba7b5a";
      };
    };
    "socks-2.2.1" = {
      name = "socks";
      packageName = "socks";
      version = "2.2.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/socks/-/socks-2.2.1.tgz";
        sha512 = "0GabKw7n9mI46vcNrVfs0o6XzWzjVa3h6GaSo2UPxtWAROXUWavfJWh1M4PR5tnE0dcnQXZIDFP4yrAysLze/w==";
      };
    };
    "socks-proxy-agent-2.1.1" = {
      name = "socks-proxy-agent";
      packageName = "socks-proxy-agent";
      version = "2.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/socks-proxy-agent/-/socks-proxy-agent-2.1.1.tgz";
        sha512 = "sFtmYqdUK5dAMh85H0LEVFUCO7OhJJe1/z2x/Z6mxp3s7/QPf1RkZmpZy+BpuU0bEjcV9npqKjq9Y3kwFUjnxw==";
      };
    };
    "sodium-browserify-1.2.4" = {
      name = "sodium-browserify";
      packageName = "sodium-browserify";
      version = "1.2.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/sodium-browserify/-/sodium-browserify-1.2.4.tgz";
        sha512 = "IYcxKje/uf/c3a7VhZYJLlUxWMcktfbD4AjqHjUD1/VWKjj0Oq5wNbX8wjJOWVO9UhUMqJQiOn2xFbzKWBmy5w==";
      };
    };
    "sodium-browserify-tweetnacl-0.2.3" = {
      name = "sodium-browserify-tweetnacl";
      packageName = "sodium-browserify-tweetnacl";
      version = "0.2.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/sodium-browserify-tweetnacl/-/sodium-browserify-tweetnacl-0.2.3.tgz";
        sha1 = "b5537ffcbb9f74ebc443b8b6a211b291e8fcbc8e";
      };
    };
    "sodium-chloride-1.1.2" = {
      name = "sodium-chloride";
      packageName = "sodium-chloride";
      version = "1.1.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/sodium-chloride/-/sodium-chloride-1.1.2.tgz";
        sha512 = "8AVzr9VHueXqfzfkzUA0aXe/Q4XG3UTmhlP6Pt+HQc5bbAPIJFo7ZIMh9tvn+99QuiMcyDJdYumegGAczl0N+g==";
      };
    };
    "sodium-native-2.2.3" = {
      name = "sodium-native";
      packageName = "sodium-native";
      version = "2.2.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/sodium-native/-/sodium-native-2.2.3.tgz";
        sha512 = "0rQvKwlWW86YmmAhosnJ6/2PR3mdAtfuWW147L4x3/gwfL7XiJ7mf2BPvBwU16vsYQNY1yxOQg9YT/MN6qoZOA==";
      };
    };
    "sort-keys-1.1.2" = {
      name = "sort-keys";
      packageName = "sort-keys";
      version = "1.1.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/sort-keys/-/sort-keys-1.1.2.tgz";
        sha1 = "441b6d4d346798f1b4e49e8920adfba0e543f9ad";
      };
    };
    "sort-keys-length-1.0.1" = {
      name = "sort-keys-length";
      packageName = "sort-keys-length";
      version = "1.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/sort-keys-length/-/sort-keys-length-1.0.1.tgz";
        sha1 = "9cb6f4f4e9e48155a6aa0671edd336ff1479a188";
      };
    };
    "source-list-map-2.0.1" = {
      name = "source-list-map";
      packageName = "source-list-map";
      version = "2.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/source-list-map/-/source-list-map-2.0.1.tgz";
        sha512 = "qnQ7gVMxGNxsiL4lEuJwe/To8UnK7fAnmbGEEH8RpLouuKbeEm0lhbQVFIrNSuB+G7tVrAlVsZgETT5nljf+Iw==";
      };
    };
    "source-map-0.4.4" = {
      name = "source-map";
      packageName = "source-map";
      version = "0.4.4";
      src = fetchurl {
        url = "http://registry.npmjs.org/source-map/-/source-map-0.4.4.tgz";
        sha1 = "eba4f5da9c0dc999de68032d8b4f76173652036b";
      };
    };
    "source-map-0.5.7" = {
      name = "source-map";
      packageName = "source-map";
      version = "0.5.7";
      src = fetchurl {
        url = "https://registry.npmjs.org/source-map/-/source-map-0.5.7.tgz";
        sha1 = "8a039d2d1021d22d1ea14c80d8ea468ba2ef3fcc";
      };
    };
    "source-map-0.6.1" = {
      name = "source-map";
      packageName = "source-map";
      version = "0.6.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/source-map/-/source-map-0.6.1.tgz";
        sha512 = "UjgapumWlbMhkBgzT7Ykc5YXUT46F0iKu8SGXq0bcwP5dz/h0Plj6enJqjz1Zbq2l5WaqYnrVbwWOWMyF3F47g==";
      };
    };
    "source-map-resolve-0.5.2" = {
      name = "source-map-resolve";
      packageName = "source-map-resolve";
      version = "0.5.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/source-map-resolve/-/source-map-resolve-0.5.2.tgz";
        sha512 = "MjqsvNwyz1s0k81Goz/9vRBe9SZdB09Bdw+/zYyO+3CuPk6fouTaxscHkgtE8jKvf01kVfl8riHzERQ/kefaSA==";
      };
    };
    "source-map-support-0.4.18" = {
      name = "source-map-support";
      packageName = "source-map-support";
      version = "0.4.18";
      src = fetchurl {
        url = "https://registry.npmjs.org/source-map-support/-/source-map-support-0.4.18.tgz";
        sha512 = "try0/JqxPLF9nOjvSta7tVondkP5dwgyLDjVoyMDlmjugT2lRZ1OfsrYTkCd2hkDnJTKRbO/Rl3orm8vlsUzbA==";
      };
    };
    "source-map-url-0.4.0" = {
      name = "source-map-url";
      packageName = "source-map-url";
      version = "0.4.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/source-map-url/-/source-map-url-0.4.0.tgz";
        sha1 = "3e935d7ddd73631b97659956d55128e87b5084a3";
      };
    };
    "spdx-correct-3.1.0" = {
      name = "spdx-correct";
      packageName = "spdx-correct";
      version = "3.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/spdx-correct/-/spdx-correct-3.1.0.tgz";
        sha512 = "lr2EZCctC2BNR7j7WzJ2FpDznxky1sjfxvvYEyzxNyb6lZXHODmEoJeFu4JupYlkfha1KZpJyoqiJ7pgA1qq8Q==";
      };
    };
    "spdx-exceptions-2.2.0" = {
      name = "spdx-exceptions";
      packageName = "spdx-exceptions";
      version = "2.2.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/spdx-exceptions/-/spdx-exceptions-2.2.0.tgz";
        sha512 = "2XQACfElKi9SlVb1CYadKDXvoajPgBVPn/gOQLrTvHdElaVhr7ZEbqJaRnJLVNeaI4cMEAgVCeBMKF6MWRDCRA==";
      };
    };
    "spdx-expression-parse-3.0.0" = {
      name = "spdx-expression-parse";
      packageName = "spdx-expression-parse";
      version = "3.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/spdx-expression-parse/-/spdx-expression-parse-3.0.0.tgz";
        sha512 = "Yg6D3XpRD4kkOmTpdgbUiEJFKghJH03fiC1OPll5h/0sO6neh2jqRDVHOQ4o/LMea0tgCkbMgea5ip/e+MkWyg==";
      };
    };
    "spdx-license-ids-3.0.2" = {
      name = "spdx-license-ids";
      packageName = "spdx-license-ids";
      version = "3.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/spdx-license-ids/-/spdx-license-ids-3.0.2.tgz";
        sha512 = "qky9CVt0lVIECkEsYbNILVnPvycuEBkXoMFLRWsREkomQLevYhtRKC+R91a5TOAQ3bCMjikRwhyaRqj1VYatYg==";
      };
    };
    "spdy-3.4.7" = {
      name = "spdy";
      packageName = "spdy";
      version = "3.4.7";
      src = fetchurl {
        url = "https://registry.npmjs.org/spdy/-/spdy-3.4.7.tgz";
        sha1 = "42ff41ece5cc0f99a3a6c28aabb73f5c3b03acbc";
      };
    };
    "spdy-transport-2.1.1" = {
      name = "spdy-transport";
      packageName = "spdy-transport";
      version = "2.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/spdy-transport/-/spdy-transport-2.1.1.tgz";
        sha512 = "q7D8c148escoB3Z7ySCASadkegMmUZW8Wb/Q1u0/XBgDKMO880rLQDj8Twiew/tYi7ghemKUi/whSYOwE17f5Q==";
      };
    };
    "spectron-3.8.0" = {
      name = "spectron";
      packageName = "spectron";
      version = "3.8.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/spectron/-/spectron-3.8.0.tgz";
        sha512 = "fQ7gFp6UuEaONjXFLifLeIUI022pOsm3b+NFAm696r2umUkSZ9IbnEgHwrvBX+pJ3QUDyCEs5bPHUieYU7FvaQ==";
      };
    };
    "speedometer-0.1.4" = {
      name = "speedometer";
      packageName = "speedometer";
      version = "0.1.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/speedometer/-/speedometer-0.1.4.tgz";
        sha1 = "9876dbd2a169d3115402d48e6ea6329c8816a50d";
      };
    };
    "split-1.0.1" = {
      name = "split";
      packageName = "split";
      version = "1.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/split/-/split-1.0.1.tgz";
        sha512 = "mTyOoPbrivtXnwnIxZRFYRrPNtEFKlpB2fvjSnCQUiAA6qAZzqwna5envK4uk6OIeP17CsdF3rSBGYVBsU0Tkg==";
      };
    };
    "split-buffer-1.0.0" = {
      name = "split-buffer";
      packageName = "split-buffer";
      version = "1.0.0";
      src = fetchurl {
        url = "http://registry.npmjs.org/split-buffer/-/split-buffer-1.0.0.tgz";
        sha1 = "b7e8e0ab51345158b72c1f6dbef2406d51f1d027";
      };
    };
    "split-string-3.1.0" = {
      name = "split-string";
      packageName = "split-string";
      version = "3.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/split-string/-/split-string-3.1.0.tgz";
        sha512 = "NzNVhJDYpwceVVii8/Hu6DKfD2G+NrQHlS/V/qgv763EYudVwEcMQNxd2lh+0VrUByXN/oJkl5grOhYWvQUYiw==";
      };
    };
    "sprintf-js-1.0.3" = {
      name = "sprintf-js";
      packageName = "sprintf-js";
      version = "1.0.3";
      src = fetchurl {
        url = "http://registry.npmjs.org/sprintf-js/-/sprintf-js-1.0.3.tgz";
        sha1 = "04e6926f662895354f3dd015203633b857297e2c";
      };
    };
    "ssb-about-2.0.0" = {
      name = "ssb-about";
      packageName = "ssb-about";
      version = "2.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/ssb-about/-/ssb-about-2.0.0.tgz";
        sha512 = "H8iNK86AQBnIUyxBcx22M5p2Vq8zQgTzPCS2Pw/7W57uH0BgDUAQe1DiTW6T8kEsg5+2GMaCXLH+gEXufcIgnw==";
      };
    };
    "ssb-backlinks-0.7.3" = {
      name = "ssb-backlinks";
      packageName = "ssb-backlinks";
      version = "0.7.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/ssb-backlinks/-/ssb-backlinks-0.7.3.tgz";
        sha512 = "84s5phSVyZsYV0FTmBJvICPgOMuu8ouzukG8Gz2XtuOui95GBP/G7UIBURgYVS82XA6g9xPA/jf38fsMxid38Q==";
      };
    };
    "ssb-blobs-1.1.7" = {
      name = "ssb-blobs";
      packageName = "ssb-blobs";
      version = "1.1.7";
      src = fetchurl {
        url = "https://registry.npmjs.org/ssb-blobs/-/ssb-blobs-1.1.7.tgz";
        sha512 = "y2GP3xIyGPbRYvpwUgA/U8QaCE2y+7cT22/yN6PcoMqbZOPI7qNP7eFzCXa/HYa7LuIczyID5/25UFkP84rrig==";
      };
    };
    "ssb-chess-db-1.0.5" = {
      name = "ssb-chess-db";
      packageName = "ssb-chess-db";
      version = "1.0.5";
      src = fetchurl {
        url = "https://registry.npmjs.org/ssb-chess-db/-/ssb-chess-db-1.0.5.tgz";
        sha512 = "TiUPqIWY7TqSQyqDidl152TEqSEMqv3G9UZe6WY4tdmRUgfVPpMigWp6hAKKOCt3X+BqLSknk5X/mW8wTm754g==";
      };
    };
    "ssb-client-4.6.0" = {
      name = "ssb-client";
      packageName = "ssb-client";
      version = "4.6.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/ssb-client/-/ssb-client-4.6.0.tgz";
        sha512 = "LyH5Y/U7xvafmAuG1puyhNv4G3Ew9xC67dYgRX0wwbUf5iT422WB1Cvat9qGFAu3/BQbdctXtdEQPxaAn0+hYA==";
      };
    };
    "ssb-config-2.3.7" = {
      name = "ssb-config";
      packageName = "ssb-config";
      version = "2.3.7";
      src = fetchurl {
        url = "https://registry.npmjs.org/ssb-config/-/ssb-config-2.3.7.tgz";
        sha512 = "djjLoNpDlE0K/UfhU1mNuJqOy8oJsv/6Q8RLDTHdby2Z+r2MxKRaACH3R9DMZyzgnd3wLjXba5ntNvsuabjx5g==";
      };
    };
    "ssb-db-18.6.2" = {
      name = "ssb-db";
      packageName = "ssb-db";
      version = "18.6.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/ssb-db/-/ssb-db-18.6.2.tgz";
        sha512 = "7Z/d9c+qGp/7Sg5RsqHwviOzUoOK52KlFbt+4GR8a95/b9KW9EO9nRDdOYXwa+hY+D0SZe8HMW3Qb/0NNga3uQ==";
      };
    };
    "ssb-ebt-5.2.7" = {
      name = "ssb-ebt";
      packageName = "ssb-ebt";
      version = "5.2.7";
      src = fetchurl {
        url = "https://registry.npmjs.org/ssb-ebt/-/ssb-ebt-5.2.7.tgz";
        sha512 = "dLiLRtGMagSKRuOIBQzPDfAQf7LNFR8+g91tKxMPbV6WMENF2bojz3POd75i6BhXJhJx1A6zpO6IrMz3StmtbA==";
      };
    };
    "ssb-friends-3.1.7" = {
      name = "ssb-friends";
      packageName = "ssb-friends";
      version = "3.1.7";
      src = fetchurl {
        url = "https://registry.npmjs.org/ssb-friends/-/ssb-friends-3.1.7.tgz";
        sha512 = "3ph/L8m6zqNC1CX9BhCLqgDO227CVb86Mx7yHgSK6vilc9iby612VGsrRbAQaNiSRDPoBhLNOQLrQWaTkn7LBw==";
      };
    };
    "ssb-keys-7.1.3" = {
      name = "ssb-keys";
      packageName = "ssb-keys";
      version = "7.1.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/ssb-keys/-/ssb-keys-7.1.3.tgz";
        sha512 = "f66vIZ3LkeMx73enLTkPC9ecTUcUrjtVHvRt45nDmubGMom21Z82JQLWYbQ++09v3JG3B4XEir8inhv6AAISSQ==";
      };
    };
    "ssb-links-3.0.3" = {
      name = "ssb-links";
      packageName = "ssb-links";
      version = "3.0.3";
      src = fetchurl {
        url = "http://registry.npmjs.org/ssb-links/-/ssb-links-3.0.3.tgz";
        sha512 = "x09ShIMjwvdZI7aDZm8kc1v5YCGZa9ulCOoxrf/RYJ98s5gbTfO9CBCzeMBAeQ5kRwSuKjiOxJHdeEBkj4Y6hw==";
      };
    };
    "ssb-marked-0.7.4" = {
      name = "ssb-marked";
      packageName = "ssb-marked";
      version = "0.7.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/ssb-marked/-/ssb-marked-0.7.4.tgz";
        sha1 = "31714f16548531c99a03a24e22c7e1ebbbce7875";
      };
    };
    "ssb-meme-1.0.4" = {
      name = "ssb-meme";
      packageName = "ssb-meme";
      version = "1.0.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/ssb-meme/-/ssb-meme-1.0.4.tgz";
        sha512 = "r4JAfdCY7tnRzMQNETdWfcm54FOe6bJMbpanp+9dQA76daLu1Jg3EijQ4jNtnDtv1WDMq1XcDTQyEtzVICrKBg==";
      };
    };
    "ssb-msg-content-1.0.1" = {
      name = "ssb-msg-content";
      packageName = "ssb-msg-content";
      version = "1.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/ssb-msg-content/-/ssb-msg-content-1.0.1.tgz";
        sha512 = "M6W0Ef+jif829USmGvh6XeS4lYb/F2lgFhfEoCE/md7ESILNOGidp8frJE2uVOzSr2wVRA265tPrnVb7rYHkug==";
      };
    };
    "ssb-msgs-5.2.0" = {
      name = "ssb-msgs";
      packageName = "ssb-msgs";
      version = "5.2.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/ssb-msgs/-/ssb-msgs-5.2.0.tgz";
        sha1 = "c681da5cd70c574c922dca4f03c521538135c243";
      };
    };
    "ssb-names-3.1.4" = {
      name = "ssb-names";
      packageName = "ssb-names";
      version = "3.1.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/ssb-names/-/ssb-names-3.1.4.tgz";
        sha512 = "fAMJSl3aBUErruIfVcBFX5iTV4Vlq/TFuu4budxR45zNiM+0+ErP8itZEDgGKWFbEmTKwIVtW6Gf4QWSApeWeQ==";
      };
    };
    "ssb-ooo-1.1.0" = {
      name = "ssb-ooo";
      packageName = "ssb-ooo";
      version = "1.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/ssb-ooo/-/ssb-ooo-1.1.0.tgz";
        sha512 = "zYVfLuI6krIxB23ApT1V2KlePtazApU0afbdqyG6L8Iggcvb5QPUXFzPjv0qEmnAWzvOM4FQ78hyWhCf1504Cg==";
      };
    };
    "ssb-private-0.2.3" = {
      name = "ssb-private";
      packageName = "ssb-private";
      version = "0.2.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/ssb-private/-/ssb-private-0.2.3.tgz";
        sha512 = "SiLBKOB1hxkrohzOrRWURlzj6HvPFvr9LLd5P5I5C5KU/RtaWe79nYuFgjUFJFnjWw7X4szCy32/EZMihV1l/Q==";
      };
    };
    "ssb-query-2.3.0" = {
      name = "ssb-query";
      packageName = "ssb-query";
      version = "2.3.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/ssb-query/-/ssb-query-2.3.0.tgz";
        sha512 = "y4OA2MvGl1jU7bUTYsTmMNSqlPt4eh9401THUW1DO4aFyBFEWvpa3eKJHc8aTmaph2hutPPbdKgEFsWDzw26uw==";
      };
    };
    "ssb-ref-2.13.9" = {
      name = "ssb-ref";
      packageName = "ssb-ref";
      version = "2.13.9";
      src = fetchurl {
        url = "https://registry.npmjs.org/ssb-ref/-/ssb-ref-2.13.9.tgz";
        sha512 = "TfatNqLvoP+eW/pMIbCmNcaoDq4R2k8jCtWkwDKx4AtluN/LwtyP931d5Mh+2gmzA04W7kxkr6f5ENGgdadMYg==";
      };
    };
    "ssb-search-1.1.2" = {
      name = "ssb-search";
      packageName = "ssb-search";
      version = "1.1.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/ssb-search/-/ssb-search-1.1.2.tgz";
        sha512 = "k7CCfdugGYvNMZekGJXcCYuCdf7MEP+bBZr+AsZO5KqaNb4K9CuP6W1wGoKH6vkparhaCKc85jO46EbWsEoVDQ==";
      };
    };
    "ssb-sort-1.1.3" = {
      name = "ssb-sort";
      packageName = "ssb-sort";
      version = "1.1.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/ssb-sort/-/ssb-sort-1.1.3.tgz";
        sha512 = "oPsF8lGgcHcIb4F1GddV3CbZTJZ0OzxI9fHXH0Zc7ZjqjFlYdqMDxFSuvqJnmtDydJcswyGANiziP1ghd69jOw==";
      };
    };
    "ssb-tags-0.2.0" = {
      name = "ssb-tags";
      packageName = "ssb-tags";
      version = "0.2.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/ssb-tags/-/ssb-tags-0.2.0.tgz";
        sha512 = "17bI/59xSmaqlJXYYjYqfKi/Px7yYB0nKlPeFgKae5t2Rultp7VVXNj833HK5iXnv6J7lTpSzxgA/Jp9Jaj7Xg==";
      };
    };
    "ssb-talequery-2.0.1" = {
      name = "ssb-talequery";
      packageName = "ssb-talequery";
      version = "2.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/ssb-talequery/-/ssb-talequery-2.0.1.tgz";
        sha512 = "3Y8W6pi4W6pXW8qsGM+Kbc/5A4kQBlx6itUCdbMKsO3v1NdmpldsA/4GaXKWg+8vzXjEiRL451WLpZwYhtax+w==";
      };
    };
    "ssb-threads-3.2.1" = {
      name = "ssb-threads";
      packageName = "ssb-threads";
      version = "3.2.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/ssb-threads/-/ssb-threads-3.2.1.tgz";
        sha512 = "kYjPej71PH1iu5ISkNoNpujm5sreZwrkQgRUFPyoAf/QNXLO5CxP625NBCu8iCwRVOXXhn+H1KGTLwomte2Whg==";
      };
    };
    "ssb-typescript-1.3.0" = {
      name = "ssb-typescript";
      packageName = "ssb-typescript";
      version = "1.3.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/ssb-typescript/-/ssb-typescript-1.3.0.tgz";
        sha512 = "iS7QDG2Jn/o9jK8LzxmmxOfwx87e5HWP7IYVqn7I+YZxIAWOXl0Vn2c6A8/N9VkWGF/g1sO874nDpncnquUR1A==";
      };
    };
    "ssb-unread-1.0.2" = {
      name = "ssb-unread";
      packageName = "ssb-unread";
      version = "1.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/ssb-unread/-/ssb-unread-1.0.2.tgz";
        sha512 = "OPEOHf+qOTZ4i0oO/SLlM09ms6dHXTam/qMdYMp85DkEjupcbxwZeg7RN/bcVgWjnvYui0qhYxJYa32FDNjhyQ==";
      };
    };
    "ssb-validate-4.0.4" = {
      name = "ssb-validate";
      packageName = "ssb-validate";
      version = "4.0.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/ssb-validate/-/ssb-validate-4.0.4.tgz";
        sha512 = "MojZCR1qgZHdO4pnh4Loiqxj7fxP3w+MrA/4smXoKD46ReEnOjt/8Vm2sq3qpqPmUBU2GbEoDlgw7OKy0mWJBw==";
      };
    };
    "ssb-web-resolver-1.1.2" = {
      name = "ssb-web-resolver";
      packageName = "ssb-web-resolver";
      version = "1.1.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/ssb-web-resolver/-/ssb-web-resolver-1.1.2.tgz";
        sha1 = "0a997480d58c9120a885463aa1c8b11e89efe15e";
      };
    };
    "ssb-ws-2.1.1" = {
      name = "ssb-ws";
      packageName = "ssb-ws";
      version = "2.1.1";
      src = fetchurl {
        url = "http://registry.npmjs.org/ssb-ws/-/ssb-ws-2.1.1.tgz";
        sha512 = "1fK/jXI6lKZadRJDr49t+6yMmWynp6PFrADs3Whmy8IslnYGl83ujhlpRIBvCn1EuVHjV7yLsIiJ8a0X2Kg0DQ==";
      };
    };
    "ssb-ws-5.1.1" = {
      name = "ssb-ws";
      packageName = "ssb-ws";
      version = "5.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/ssb-ws/-/ssb-ws-5.1.1.tgz";
        sha512 = "Wbttwlr+wVqcoxGsn+WoiBbSI9UMqgL/DZU6Pjm/KQ61LO7jaxV4hGw3+H4uRBtgtOE4pidvHeCk7jUuoXWZfQ==";
      };
    };
    "sshpk-1.15.2" = {
      name = "sshpk";
      packageName = "sshpk";
      version = "1.15.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/sshpk/-/sshpk-1.15.2.tgz";
        sha512 = "Ra/OXQtuh0/enyl4ETZAfTaeksa6BXks5ZcjpSUNrjBr0DvrJKX+1fsKDPpT9TBXgHAFsa4510aNVgI8g/+SzA==";
      };
    };
    "ssri-5.3.0" = {
      name = "ssri";
      packageName = "ssri";
      version = "5.3.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/ssri/-/ssri-5.3.0.tgz";
        sha512 = "XRSIPqLij52MtgoQavH/x/dU1qVKtWUAAZeOHsR9c2Ddi4XerFy3mc1alf+dLJKl9EUIm/Ht+EowFkTUOA6GAQ==";
      };
    };
    "stack-0.1.0" = {
      name = "stack";
      packageName = "stack";
      version = "0.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/stack/-/stack-0.1.0.tgz";
        sha1 = "e923598a9be51e617682cb21cf1b2818a449ada2";
      };
    };
    "stack-trace-0.0.10" = {
      name = "stack-trace";
      packageName = "stack-trace";
      version = "0.0.10";
      src = fetchurl {
        url = "https://registry.npmjs.org/stack-trace/-/stack-trace-0.0.10.tgz";
        sha1 = "547c70b347e8d32b4e108ea1a2a159e5fdde19c0";
      };
    };
    "static-extend-0.1.2" = {
      name = "static-extend";
      packageName = "static-extend";
      version = "0.1.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/static-extend/-/static-extend-0.1.2.tgz";
        sha1 = "60809c39cbff55337226fd5e0b520f341f1fb5c6";
      };
    };
    "statistics-3.3.0" = {
      name = "statistics";
      packageName = "statistics";
      version = "3.3.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/statistics/-/statistics-3.3.0.tgz";
        sha1 = "ec7b4750ff03ab24a64dd9b357a78316bead78aa";
      };
    };
    "statuses-1.4.0" = {
      name = "statuses";
      packageName = "statuses";
      version = "1.4.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/statuses/-/statuses-1.4.0.tgz";
        sha512 = "zhSCtt8v2NDrRlPQpCNtw/heZLtfUDqxBM1udqikb/Hbk52LK4nQSwr10u77iopCW5LsyHpuXS0GnEc48mLeew==";
      };
    };
    "statuses-1.5.0" = {
      name = "statuses";
      packageName = "statuses";
      version = "1.5.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/statuses/-/statuses-1.5.0.tgz";
        sha1 = "161c7dac177659fd9811f43771fa99381478628c";
      };
    };
    "stdout-stream-1.4.1" = {
      name = "stdout-stream";
      packageName = "stdout-stream";
      version = "1.4.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/stdout-stream/-/stdout-stream-1.4.1.tgz";
        sha512 = "j4emi03KXqJWcIeF8eIXkjMFN1Cmb8gUlDYGeBALLPo5qdyTfA9bOtl8m33lRoC+vFMkP3gl0WsDr6+gzxbbTA==";
      };
    };
    "stream-browserify-2.0.1" = {
      name = "stream-browserify";
      packageName = "stream-browserify";
      version = "2.0.1";
      src = fetchurl {
        url = "http://registry.npmjs.org/stream-browserify/-/stream-browserify-2.0.1.tgz";
        sha1 = "66266ee5f9bdb9940a4e4514cafb43bb71e5c9db";
      };
    };
    "stream-each-1.2.3" = {
      name = "stream-each";
      packageName = "stream-each";
      version = "1.2.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/stream-each/-/stream-each-1.2.3.tgz";
        sha512 = "vlMC2f8I2u/bZGqkdfLQW/13Zihpej/7PmSiMQsbYddxuTsJp8vRe2x2FvVExZg7FaOds43ROAuFJwPR4MTZLw==";
      };
    };
    "stream-http-2.8.3" = {
      name = "stream-http";
      packageName = "stream-http";
      version = "2.8.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/stream-http/-/stream-http-2.8.3.tgz";
        sha512 = "+TSkfINHDo4J+ZobQLWiMouQYB+UVYFttRA94FpEzzJ7ZdqcL4uUUQ7WkdkI4DSozGmgBUE/a47L+38PenXhUw==";
      };
    };
    "stream-progressbar-1.1.1" = {
      name = "stream-progressbar";
      packageName = "stream-progressbar";
      version = "1.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/stream-progressbar/-/stream-progressbar-1.1.1.tgz";
        sha512 = "2O227sBklxd5d7I2pqWBBr1gwWe37dPE4ml2pr2t0dfQ0TGxaAvO4U7RwQD21nbYGrWQa+Sd5ciKnwqssAmpog==";
      };
    };
    "stream-shift-1.0.0" = {
      name = "stream-shift";
      packageName = "stream-shift";
      version = "1.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/stream-shift/-/stream-shift-1.0.0.tgz";
        sha1 = "d5c752825e5367e786f78e18e445ea223a155952";
      };
    };
    "stream-slicer-0.0.6" = {
      name = "stream-slicer";
      packageName = "stream-slicer";
      version = "0.0.6";
      src = fetchurl {
        url = "https://registry.npmjs.org/stream-slicer/-/stream-slicer-0.0.6.tgz";
        sha1 = "f86b2ac5c2440b7a0a87b71f33665c0788046138";
      };
    };
    "stream-to-pull-stream-1.7.2" = {
      name = "stream-to-pull-stream";
      packageName = "stream-to-pull-stream";
      version = "1.7.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/stream-to-pull-stream/-/stream-to-pull-stream-1.7.2.tgz";
        sha1 = "757609ae1cebd33c7432d4afbe31ff78650b9dde";
      };
    };
    "strict-uri-encode-1.1.0" = {
      name = "strict-uri-encode";
      packageName = "strict-uri-encode";
      version = "1.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/strict-uri-encode/-/strict-uri-encode-1.1.0.tgz";
        sha1 = "279b225df1d582b1f54e65addd4352e18faa0713";
      };
    };
    "string-width-1.0.2" = {
      name = "string-width";
      packageName = "string-width";
      version = "1.0.2";
      src = fetchurl {
        url = "http://registry.npmjs.org/string-width/-/string-width-1.0.2.tgz";
        sha1 = "118bdf5b8cdc51a2a7e70d211e07e2b0b9b107d3";
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
    "string.prototype.trim-1.1.2" = {
      name = "string.prototype.trim";
      packageName = "string.prototype.trim";
      version = "1.1.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/string.prototype.trim/-/string.prototype.trim-1.1.2.tgz";
        sha1 = "d04de2c89e137f4d7d206f086b5ed2fae6be8cea";
      };
    };
    "string_decoder-0.10.31" = {
      name = "string_decoder";
      packageName = "string_decoder";
      version = "0.10.31";
      src = fetchurl {
        url = "http://registry.npmjs.org/string_decoder/-/string_decoder-0.10.31.tgz";
        sha1 = "62e203bc41766c6c28c9fc84301dab1c5310fa94";
      };
    };
    "string_decoder-1.1.1" = {
      name = "string_decoder";
      packageName = "string_decoder";
      version = "1.1.1";
      src = fetchurl {
        url = "http://registry.npmjs.org/string_decoder/-/string_decoder-1.1.1.tgz";
        sha512 = "n/ShnvDi6FHbbVfviro+WojiFzv+s8MPMHBczVePfUpDJLwoLT0ht1l4YwBCbi8pJAveEEdnkHyPyTP/mzRfwg==";
      };
    };
    "stringify-entities-1.3.2" = {
      name = "stringify-entities";
      packageName = "stringify-entities";
      version = "1.3.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/stringify-entities/-/stringify-entities-1.3.2.tgz";
        sha512 = "nrBAQClJAPN2p+uGCVJRPIPakKeKWZ9GtBCmormE7pWOSlHat7+x5A8gx85M7HM5Dt0BP3pP5RhVW77WdbJJ3A==";
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
    "strip-bom-2.0.0" = {
      name = "strip-bom";
      packageName = "strip-bom";
      version = "2.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/strip-bom/-/strip-bom-2.0.0.tgz";
        sha1 = "6219a85616520491f35788bdbf1447a99c7e6b0e";
      };
    };
    "strip-bom-3.0.0" = {
      name = "strip-bom";
      packageName = "strip-bom";
      version = "3.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/strip-bom/-/strip-bom-3.0.0.tgz";
        sha1 = "2334c18e9c759f7bdd56fdef7e9ae3d588e68ed3";
      };
    };
    "strip-eof-1.0.0" = {
      name = "strip-eof";
      packageName = "strip-eof";
      version = "1.0.0";
      src = fetchurl {
        url = "http://registry.npmjs.org/strip-eof/-/strip-eof-1.0.0.tgz";
        sha1 = "bb43ff5598a6eb05d89b59fcd129c983313606bf";
      };
    };
    "strip-indent-1.0.1" = {
      name = "strip-indent";
      packageName = "strip-indent";
      version = "1.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/strip-indent/-/strip-indent-1.0.1.tgz";
        sha1 = "0c7962a6adefa7bbd4ac366460a638552ae1a0a2";
      };
    };
    "strip-json-comments-2.0.1" = {
      name = "strip-json-comments";
      packageName = "strip-json-comments";
      version = "2.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/strip-json-comments/-/strip-json-comments-2.0.1.tgz";
        sha1 = "3c531942e908c2697c0ec344858c286c7ca0a60a";
      };
    };
    "style-loader-0.20.3" = {
      name = "style-loader";
      packageName = "style-loader";
      version = "0.20.3";
      src = fetchurl {
        url = "http://registry.npmjs.org/style-loader/-/style-loader-0.20.3.tgz";
        sha512 = "2I7AVP73MvK33U7B9TKlYZAqdROyMXDYSMvHLX43qy3GCOaJNiV6i0v/sv9idWIaQ42Yn2dNv79Q5mKXbKhAZg==";
      };
    };
    "sumchecker-2.0.2" = {
      name = "sumchecker";
      packageName = "sumchecker";
      version = "2.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/sumchecker/-/sumchecker-2.0.2.tgz";
        sha1 = "0f42c10e5d05da5d42eea3e56c3399a37d6c5b3e";
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
    "supports-color-3.1.2" = {
      name = "supports-color";
      packageName = "supports-color";
      version = "3.1.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/supports-color/-/supports-color-3.1.2.tgz";
        sha1 = "72a262894d9d408b956ca05ff37b2ed8a6e2a2d5";
      };
    };
    "supports-color-3.2.3" = {
      name = "supports-color";
      packageName = "supports-color";
      version = "3.2.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/supports-color/-/supports-color-3.2.3.tgz";
        sha1 = "65ac0504b3954171d8a64946b2ae3cbb8a5f54f6";
      };
    };
    "supports-color-4.5.0" = {
      name = "supports-color";
      packageName = "supports-color";
      version = "4.5.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/supports-color/-/supports-color-4.5.0.tgz";
        sha1 = "be7a0de484dec5c5cddf8b3d59125044912f635b";
      };
    };
    "supports-color-5.0.1" = {
      name = "supports-color";
      packageName = "supports-color";
      version = "5.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/supports-color/-/supports-color-5.0.1.tgz";
        sha512 = "7FQGOlSQ+AQxBNXJpVDj8efTA/FtyB5wcNE1omXXJ0cq6jm1jjDwuROlYDbnzHqdNPqliWFhcioCWSyav+xBnA==";
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
    "svgo-0.7.2" = {
      name = "svgo";
      packageName = "svgo";
      version = "0.7.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/svgo/-/svgo-0.7.2.tgz";
        sha1 = "9f5772413952135c6fefbf40afe6a4faa88b4bb5";
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
    "tapable-0.2.9" = {
      name = "tapable";
      packageName = "tapable";
      version = "0.2.9";
      src = fetchurl {
        url = "https://registry.npmjs.org/tapable/-/tapable-0.2.9.tgz";
        sha512 = "2wsvQ+4GwBvLPLWsNfLCDYGsW6xb7aeC6utq2Qh0PFwgEy7K7dsma9Jsmb2zSQj7GvYAyUGSntLtsv++GmgL1A==";
      };
    };
    "tape-4.9.1" = {
      name = "tape";
      packageName = "tape";
      version = "4.9.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/tape/-/tape-4.9.1.tgz";
        sha512 = "6fKIXknLpoe/Jp4rzHKFPpJUHDHDqn8jus99IfPnHIjyz78HYlefTGD3b5EkbQzuLfaEvmfPK3IolLgq2xT3kw==";
      };
    };
    "tar-2.2.1" = {
      name = "tar";
      packageName = "tar";
      version = "2.2.1";
      src = fetchurl {
        url = "http://registry.npmjs.org/tar/-/tar-2.2.1.tgz";
        sha1 = "8e4d2a256c0e2185c6b18ad694aec968b83cb1d1";
      };
    };
    "tar-fs-1.16.3" = {
      name = "tar-fs";
      packageName = "tar-fs";
      version = "1.16.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/tar-fs/-/tar-fs-1.16.3.tgz";
        sha512 = "NvCeXpYx7OsmOh8zIOP/ebG55zZmxLE0etfWRbWok+q2Qo8x/vOR/IJT1taADXPe+jsiu9axDb3X4B+iIgNlKw==";
      };
    };
    "tar-stream-1.6.2" = {
      name = "tar-stream";
      packageName = "tar-stream";
      version = "1.6.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/tar-stream/-/tar-stream-1.6.2.tgz";
        sha512 = "rzS0heiNf8Xn7/mpdSVVSMAWAoy9bfb1WOTYC78Z0UQKeKa/CWS8FOq0lKGNa8DWKAn9gxjCvMLYc5PGXYlK2A==";
      };
    };
    "test-exclude-4.2.3" = {
      name = "test-exclude";
      packageName = "test-exclude";
      version = "4.2.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/test-exclude/-/test-exclude-4.2.3.tgz";
        sha512 = "SYbXgY64PT+4GAL2ocI3HwPa4Q4TBKm0cwAVeKOt/Aoc0gSpNRjJX8w0pA1LMKZ3LBmd8pYBqApFNQLII9kavA==";
      };
    };
    "text-table-0.2.0" = {
      name = "text-table";
      packageName = "text-table";
      version = "0.2.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/text-table/-/text-table-0.2.0.tgz";
        sha1 = "7f5ee823ae805207c00af2df4a84ec3fcfa570b4";
      };
    };
    "throttleit-0.0.2" = {
      name = "throttleit";
      packageName = "throttleit";
      version = "0.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/throttleit/-/throttleit-0.0.2.tgz";
        sha1 = "cfedf88e60c00dd9697b61fdd2a8343a9b680eaf";
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
    "through2-0.2.3" = {
      name = "through2";
      packageName = "through2";
      version = "0.2.3";
      src = fetchurl {
        url = "http://registry.npmjs.org/through2/-/through2-0.2.3.tgz";
        sha1 = "eb3284da4ea311b6cc8ace3653748a52abf25a3f";
      };
    };
    "through2-0.6.5" = {
      name = "through2";
      packageName = "through2";
      version = "0.6.5";
      src = fetchurl {
        url = "http://registry.npmjs.org/through2/-/through2-0.6.5.tgz";
        sha1 = "41ab9c67b29d57209071410e1d7a7a968cd3ad48";
      };
    };
    "through2-2.0.5" = {
      name = "through2";
      packageName = "through2";
      version = "2.0.5";
      src = fetchurl {
        url = "https://registry.npmjs.org/through2/-/through2-2.0.5.tgz";
        sha512 = "/mrRod8xqpA+IHSLyGCQ2s8SPHiCDEeQJSep1jqLYeEUClOFG2Qsh+4FU6G9VeqpZnGW/Su8LQGc4YKni5rYSQ==";
      };
    };
    "thunkify-2.1.2" = {
      name = "thunkify";
      packageName = "thunkify";
      version = "2.1.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/thunkify/-/thunkify-2.1.2.tgz";
        sha1 = "faa0e9d230c51acc95ca13a361ac05ca7e04553d";
      };
    };
    "thunky-1.0.3" = {
      name = "thunky";
      packageName = "thunky";
      version = "1.0.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/thunky/-/thunky-1.0.3.tgz";
        sha512 = "YwT8pjmNcAXBZqrubu22P4FYsh2D4dxRmnWBOL8Jk8bUcRUtc5326kx32tuTmFDAZtLOGEVNl8POAR8j896Iow==";
      };
    };
    "time-stamp-2.2.0" = {
      name = "time-stamp";
      packageName = "time-stamp";
      version = "2.2.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/time-stamp/-/time-stamp-2.2.0.tgz";
        sha512 = "zxke8goJQpBeEgD82CXABeMh0LSJcj7CXEd0OHOg45HgcofF7pxNwZm9+RknpxpDhwN4gFpySkApKfFYfRQnUA==";
      };
    };
    "timers-browserify-2.0.10" = {
      name = "timers-browserify";
      packageName = "timers-browserify";
      version = "2.0.10";
      src = fetchurl {
        url = "https://registry.npmjs.org/timers-browserify/-/timers-browserify-2.0.10.tgz";
        sha512 = "YvC1SV1XdOUaL6gx5CoGroT3Gu49pK9+TZ38ErPldOWW4j49GI1HKs9DV+KGq/w6y+LZ72W1c8cKz2vzY+qpzg==";
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
    "to-arraybuffer-1.0.1" = {
      name = "to-arraybuffer";
      packageName = "to-arraybuffer";
      version = "1.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/to-arraybuffer/-/to-arraybuffer-1.0.1.tgz";
        sha1 = "7d229b1fcc637e466ca081180836a7aabff83f43";
      };
    };
    "to-buffer-1.1.1" = {
      name = "to-buffer";
      packageName = "to-buffer";
      version = "1.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/to-buffer/-/to-buffer-1.1.1.tgz";
        sha512 = "lx9B5iv7msuFYE3dytT+KE5tap+rNYw+K4jVkb9R/asAb+pbBSM17jtunHplhBe6RRJdZx3Pn2Jph24O32mOVg==";
      };
    };
    "to-camel-case-1.0.0" = {
      name = "to-camel-case";
      packageName = "to-camel-case";
      version = "1.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/to-camel-case/-/to-camel-case-1.0.0.tgz";
        sha1 = "1a56054b2f9d696298ce66a60897322b6f423e46";
      };
    };
    "to-fast-properties-1.0.3" = {
      name = "to-fast-properties";
      packageName = "to-fast-properties";
      version = "1.0.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/to-fast-properties/-/to-fast-properties-1.0.3.tgz";
        sha1 = "b83571fa4d8c25b82e231b06e3a3055de4ca1a47";
      };
    };
    "to-fast-properties-2.0.0" = {
      name = "to-fast-properties";
      packageName = "to-fast-properties";
      version = "2.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/to-fast-properties/-/to-fast-properties-2.0.0.tgz";
        sha1 = "dc5e698cbd079265bc73e0377681a4e4e83f616e";
      };
    };
    "to-no-case-1.0.2" = {
      name = "to-no-case";
      packageName = "to-no-case";
      version = "1.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/to-no-case/-/to-no-case-1.0.2.tgz";
        sha1 = "c722907164ef6b178132c8e69930212d1b4aa16a";
      };
    };
    "to-object-path-0.3.0" = {
      name = "to-object-path";
      packageName = "to-object-path";
      version = "0.3.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/to-object-path/-/to-object-path-0.3.0.tgz";
        sha1 = "297588b7b0e7e0ac08e04e672f85c1f4999e17af";
      };
    };
    "to-regex-3.0.2" = {
      name = "to-regex";
      packageName = "to-regex";
      version = "3.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/to-regex/-/to-regex-3.0.2.tgz";
        sha512 = "FWtleNAtZ/Ki2qtqej2CXTOayOH9bHDQF+Q48VpWyDXjbYxA4Yz8iDB31zXOBUlOHHKidDbqGVrTUvQMPmBGBw==";
      };
    };
    "to-regex-range-2.1.1" = {
      name = "to-regex-range";
      packageName = "to-regex-range";
      version = "2.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/to-regex-range/-/to-regex-range-2.1.1.tgz";
        sha1 = "7c80c17b9dfebe599e27367e0d4dd5590141db38";
      };
    };
    "to-space-case-1.0.0" = {
      name = "to-space-case";
      packageName = "to-space-case";
      version = "1.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/to-space-case/-/to-space-case-1.0.0.tgz";
        sha1 = "b052daafb1b2b29dc770cea0163e5ec0ebc9fc17";
      };
    };
    "to-vfile-1.0.0" = {
      name = "to-vfile";
      packageName = "to-vfile";
      version = "1.0.0";
      src = fetchurl {
        url = "http://registry.npmjs.org/to-vfile/-/to-vfile-1.0.0.tgz";
        sha1 = "88defecd43adb2ef598625f0e3d59f7f342941ba";
      };
    };
    "toposort-1.0.7" = {
      name = "toposort";
      packageName = "toposort";
      version = "1.0.7";
      src = fetchurl {
        url = "https://registry.npmjs.org/toposort/-/toposort-1.0.7.tgz";
        sha1 = "2e68442d9f64ec720b8cc89e6443ac6caa950029";
      };
    };
    "tough-cookie-2.4.3" = {
      name = "tough-cookie";
      packageName = "tough-cookie";
      version = "2.4.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/tough-cookie/-/tough-cookie-2.4.3.tgz";
        sha512 = "Q5srk/4vDM54WJsJio3XNn6K2sCG+CQ8G5Wz6bZhRZoAe/+TxjWB/GlFAnYEbkYVlON9FMk/fE3h2RLpPXo4lQ==";
      };
    };
    "trim-0.0.1" = {
      name = "trim";
      packageName = "trim";
      version = "0.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/trim/-/trim-0.0.1.tgz";
        sha1 = "5858547f6b290757ee95cccc666fb50084c460dd";
      };
    };
    "trim-lines-1.1.1" = {
      name = "trim-lines";
      packageName = "trim-lines";
      version = "1.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/trim-lines/-/trim-lines-1.1.1.tgz";
        sha512 = "X+eloHbgJGxczUk1WSjIvn7aC9oN3jVE3rQfRVKcgpavi3jxtCn0VVKtjOBj64Yop96UYn/ujJRpTbCdAF1vyg==";
      };
    };
    "trim-newlines-1.0.0" = {
      name = "trim-newlines";
      packageName = "trim-newlines";
      version = "1.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/trim-newlines/-/trim-newlines-1.0.0.tgz";
        sha1 = "5887966bb582a4503a41eb524f7d35011815a613";
      };
    };
    "trim-right-1.0.1" = {
      name = "trim-right";
      packageName = "trim-right";
      version = "1.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/trim-right/-/trim-right-1.0.1.tgz";
        sha1 = "cb2e1203067e0c8de1f614094b9fe45704ea6003";
      };
    };
    "trim-trailing-lines-1.1.1" = {
      name = "trim-trailing-lines";
      packageName = "trim-trailing-lines";
      version = "1.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/trim-trailing-lines/-/trim-trailing-lines-1.1.1.tgz";
        sha512 = "bWLv9BbWbbd7mlqqs2oQYnLD/U/ZqeJeJwbO0FG2zA1aTq+HTvxfHNKFa/HGCVyJpDiioUYaBhfiT6rgk+l4mg==";
      };
    };
    "true-case-path-1.0.3" = {
      name = "true-case-path";
      packageName = "true-case-path";
      version = "1.0.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/true-case-path/-/true-case-path-1.0.3.tgz";
        sha512 = "m6s2OdQe5wgpFMC+pAJ+q9djG82O2jcHPOI6RNg1yy9rCYR+WD6Nbpl32fDpfC56nirdRy+opFa/Vk7HYhqaew==";
      };
    };
    "tty-browserify-0.0.0" = {
      name = "tty-browserify";
      packageName = "tty-browserify";
      version = "0.0.0";
      src = fetchurl {
        url = "http://registry.npmjs.org/tty-browserify/-/tty-browserify-0.0.0.tgz";
        sha1 = "a157ba402da24e9bf957f9aa69d524eed42901a6";
      };
    };
    "tunnel-agent-0.6.0" = {
      name = "tunnel-agent";
      packageName = "tunnel-agent";
      version = "0.6.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/tunnel-agent/-/tunnel-agent-0.6.0.tgz";
        sha1 = "27a5dea06b36b04a0a9966774b290868f0fc40fd";
      };
    };
    "tweetnacl-0.14.5" = {
      name = "tweetnacl";
      packageName = "tweetnacl";
      version = "0.14.5";
      src = fetchurl {
        url = "https://registry.npmjs.org/tweetnacl/-/tweetnacl-0.14.5.tgz";
        sha1 = "5ae68177f192d4456269d108afa93ff8743f4f64";
      };
    };
    "tweetnacl-auth-0.3.1" = {
      name = "tweetnacl-auth";
      packageName = "tweetnacl-auth";
      version = "0.3.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/tweetnacl-auth/-/tweetnacl-auth-0.3.1.tgz";
        sha1 = "b75bc2df15649bb84e8b9aa3c0669c6c4bce0d25";
      };
    };
    "type-check-0.3.2" = {
      name = "type-check";
      packageName = "type-check";
      version = "0.3.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/type-check/-/type-check-0.3.2.tgz";
        sha1 = "5884cab512cf1d355e3fb784f30804b2b520db72";
      };
    };
    "type-detect-0.1.1" = {
      name = "type-detect";
      packageName = "type-detect";
      version = "0.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/type-detect/-/type-detect-0.1.1.tgz";
        sha1 = "0ba5ec2a885640e470ea4e8505971900dac58822";
      };
    };
    "type-detect-4.0.8" = {
      name = "type-detect";
      packageName = "type-detect";
      version = "4.0.8";
      src = fetchurl {
        url = "https://registry.npmjs.org/type-detect/-/type-detect-4.0.8.tgz";
        sha512 = "0fr/mIH1dlO+x7TlcMy+bIDqKPsw/70tVyeHW787goQjhmqaZe10uwLujubK9q9Lg6Fiho1KUKDYz0Z7k7g5/g==";
      };
    };
    "type-is-1.6.16" = {
      name = "type-is";
      packageName = "type-is";
      version = "1.6.16";
      src = fetchurl {
        url = "https://registry.npmjs.org/type-is/-/type-is-1.6.16.tgz";
        sha512 = "HRkVv/5qY2G6I8iab9cI7v1bOIdhm94dVjQCPFElW9W+3GeDOSHmy2EBYe4VTApuzolPcmgFTN3ftVJRKR2J9Q==";
      };
    };
    "typedarray-0.0.6" = {
      name = "typedarray";
      packageName = "typedarray";
      version = "0.0.6";
      src = fetchurl {
        url = "https://registry.npmjs.org/typedarray/-/typedarray-0.0.6.tgz";
        sha1 = "867ac74e3864187b1d3d47d996a78ec5c8830777";
      };
    };
    "typedarray-to-buffer-3.1.5" = {
      name = "typedarray-to-buffer";
      packageName = "typedarray-to-buffer";
      version = "3.1.5";
      src = fetchurl {
        url = "https://registry.npmjs.org/typedarray-to-buffer/-/typedarray-to-buffer-3.1.5.tgz";
        sha512 = "zdu8XMNEDepKKR+XYOXAVPtWui0ly0NtohUscw+UmaHiAWT8hrV1rr//H6V+0DvJ3OQ19S979M0laLfX8rm82Q==";
      };
    };
    "typewise-1.0.3" = {
      name = "typewise";
      packageName = "typewise";
      version = "1.0.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/typewise/-/typewise-1.0.3.tgz";
        sha1 = "1067936540af97937cc5dcf9922486e9fa284651";
      };
    };
    "typewise-core-1.2.0" = {
      name = "typewise-core";
      packageName = "typewise-core";
      version = "1.2.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/typewise-core/-/typewise-core-1.2.0.tgz";
        sha1 = "97eb91805c7f55d2f941748fa50d315d991ef195";
      };
    };
    "typewiselite-1.0.0" = {
      name = "typewiselite";
      packageName = "typewiselite";
      version = "1.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/typewiselite/-/typewiselite-1.0.0.tgz";
        sha1 = "c8882fa1bb1092c06005a97f34ef5c8508e3664e";
      };
    };
    "uglify-js-2.8.29" = {
      name = "uglify-js";
      packageName = "uglify-js";
      version = "2.8.29";
      src = fetchurl {
        url = "https://registry.npmjs.org/uglify-js/-/uglify-js-2.8.29.tgz";
        sha1 = "29c5733148057bb4e1f75df35b7a9cb72e6a59dd";
      };
    };
    "uglify-js-3.4.9" = {
      name = "uglify-js";
      packageName = "uglify-js";
      version = "3.4.9";
      src = fetchurl {
        url = "https://registry.npmjs.org/uglify-js/-/uglify-js-3.4.9.tgz";
        sha512 = "8CJsbKOtEbnJsTyv6LE6m6ZKniqMiFWmm9sRbopbkGs3gMPPfd3Fh8iIA4Ykv5MgaTbqHr4BaoGLJLZNhsrW1Q==";
      };
    };
    "uglify-to-browserify-1.0.2" = {
      name = "uglify-to-browserify";
      packageName = "uglify-to-browserify";
      version = "1.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/uglify-to-browserify/-/uglify-to-browserify-1.0.2.tgz";
        sha1 = "6e0924d6bda6b5afe349e39a6d632850a0f882b7";
      };
    };
    "uglifyjs-webpack-plugin-0.4.6" = {
      name = "uglifyjs-webpack-plugin";
      packageName = "uglifyjs-webpack-plugin";
      version = "0.4.6";
      src = fetchurl {
        url = "https://registry.npmjs.org/uglifyjs-webpack-plugin/-/uglifyjs-webpack-plugin-0.4.6.tgz";
        sha1 = "b951f4abb6bd617e66f63eb891498e391763e309";
      };
    };
    "uint48be-1.0.2" = {
      name = "uint48be";
      packageName = "uint48be";
      version = "1.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/uint48be/-/uint48be-1.0.2.tgz";
        sha512 = "jNn1eEi81BLiZfJkjbiAKPDMj7iFrturKazqpBu0aJYLr6evgkn+9rgkX/gUwPBj5j2Ri5oUelsqC/S1zmpWBA==";
      };
    };
    "ultron-1.0.2" = {
      name = "ultron";
      packageName = "ultron";
      version = "1.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/ultron/-/ultron-1.0.2.tgz";
        sha1 = "ace116ab557cd197386a4e88f4685378c8b2e4fa";
      };
    };
    "underscore-1.4.4" = {
      name = "underscore";
      packageName = "underscore";
      version = "1.4.4";
      src = fetchurl {
        url = "http://registry.npmjs.org/underscore/-/underscore-1.4.4.tgz";
        sha1 = "61a6a32010622afa07963bf325203cf12239d604";
      };
    };
    "unherit-1.1.1" = {
      name = "unherit";
      packageName = "unherit";
      version = "1.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/unherit/-/unherit-1.1.1.tgz";
        sha512 = "+XZuV691Cn4zHsK0vkKYwBEwB74T3IZIcxrgn2E4rKwTfFyI1zCh7X7grwh9Re08fdPlarIdyWgI8aVB3F5A5g==";
      };
    };
    "unified-2.1.4" = {
      name = "unified";
      packageName = "unified";
      version = "2.1.4";
      src = fetchurl {
        url = "http://registry.npmjs.org/unified/-/unified-2.1.4.tgz";
        sha1 = "14bc6cd40d98ffff75b405506bad873ecbbac3ba";
      };
    };
    "union-value-1.0.0" = {
      name = "union-value";
      packageName = "union-value";
      version = "1.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/union-value/-/union-value-1.0.0.tgz";
        sha1 = "5c71c34cb5bad5dcebe3ea0cd08207ba5aa1aea4";
      };
    };
    "uniq-1.0.1" = {
      name = "uniq";
      packageName = "uniq";
      version = "1.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/uniq/-/uniq-1.0.1.tgz";
        sha1 = "b31c5ae8254844a3a8281541ce2b04b865a734ff";
      };
    };
    "uniqs-2.0.0" = {
      name = "uniqs";
      packageName = "uniqs";
      version = "2.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/uniqs/-/uniqs-2.0.0.tgz";
        sha1 = "ffede4b36b25290696e6e165d4a59edb998e6b02";
      };
    };
    "unique-filename-1.1.1" = {
      name = "unique-filename";
      packageName = "unique-filename";
      version = "1.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/unique-filename/-/unique-filename-1.1.1.tgz";
        sha512 = "Vmp0jIp2ln35UTXuryvjzkjGdRyf9b2lTXuSYUiPmzRcl3FDtYqAwOnTJkAngD9SWhnoJzDbTKwaOrZ+STtxNQ==";
      };
    };
    "unique-slug-2.0.1" = {
      name = "unique-slug";
      packageName = "unique-slug";
      version = "2.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/unique-slug/-/unique-slug-2.0.1.tgz";
        sha512 = "n9cU6+gITaVu7VGj1Z8feKMmfAjEAQGhwD9fE3zvpRRa0wEIx8ODYkVGfSc94M2OX00tUFV8wH3zYbm1I8mxFg==";
      };
    };
    "unist-util-is-2.1.2" = {
      name = "unist-util-is";
      packageName = "unist-util-is";
      version = "2.1.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/unist-util-is/-/unist-util-is-2.1.2.tgz";
        sha512 = "YkXBK/H9raAmG7KXck+UUpnKiNmUdB+aBGrknfQ4EreE1banuzrKABx3jP6Z5Z3fMSPMQQmeXBlKpCbMwBkxVw==";
      };
    };
    "unist-util-visit-1.4.0" = {
      name = "unist-util-visit";
      packageName = "unist-util-visit";
      version = "1.4.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/unist-util-visit/-/unist-util-visit-1.4.0.tgz";
        sha512 = "FiGu34ziNsZA3ZUteZxSFaczIjGmksfSgdKqBfOejrrfzyUy5b7YrlzT1Bcvi+djkYDituJDy2XB7tGTeBieKw==";
      };
    };
    "unist-util-visit-parents-2.0.1" = {
      name = "unist-util-visit-parents";
      packageName = "unist-util-visit-parents";
      version = "2.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/unist-util-visit-parents/-/unist-util-visit-parents-2.0.1.tgz";
        sha512 = "6B0UTiMfdWql4cQ03gDTCSns+64Zkfo2OCbK31Ov0uMizEz+CJeAp0cgZVb5Fhmcd7Bct2iRNywejT0orpbqUA==";
      };
    };
    "universalify-0.1.2" = {
      name = "universalify";
      packageName = "universalify";
      version = "0.1.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/universalify/-/universalify-0.1.2.tgz";
        sha512 = "rBJeI5CXAlmy1pV+617WB9J63U6XcazHHF2f2dbJix4XzpUF0RS3Zbj0FGIOCAva5P/d/GBOYaACQ1w+0azUkg==";
      };
    };
    "unpipe-1.0.0" = {
      name = "unpipe";
      packageName = "unpipe";
      version = "1.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/unpipe/-/unpipe-1.0.0.tgz";
        sha1 = "b2bf4ee8514aae6165b4817829d21b2ef49904ec";
      };
    };
    "unset-value-1.0.0" = {
      name = "unset-value";
      packageName = "unset-value";
      version = "1.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/unset-value/-/unset-value-1.0.0.tgz";
        sha1 = "8376873f7d2335179ffb1e6fc3a8ed0dfc8ab559";
      };
    };
    "untildify-2.1.0" = {
      name = "untildify";
      packageName = "untildify";
      version = "2.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/untildify/-/untildify-2.1.0.tgz";
        sha1 = "17eb2807987f76952e9c0485fc311d06a826a2e0";
      };
    };
    "unused-filename-1.0.0" = {
      name = "unused-filename";
      packageName = "unused-filename";
      version = "1.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/unused-filename/-/unused-filename-1.0.0.tgz";
        sha1 = "d340880f71ae2115ebaa1325bef05cc6684469c6";
      };
    };
    "upath-1.1.0" = {
      name = "upath";
      packageName = "upath";
      version = "1.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/upath/-/upath-1.1.0.tgz";
        sha512 = "bzpH/oBhoS/QI/YtbkqCg6VEiPYjSZtrHQM6/QnJS6OL9pKUFLqb3aFh4Scvwm45+7iAgiMkLhSbaZxUqmrprw==";
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
    "uri-js-4.2.2" = {
      name = "uri-js";
      packageName = "uri-js";
      version = "4.2.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/uri-js/-/uri-js-4.2.2.tgz";
        sha512 = "KY9Frmirql91X2Qgjry0Wd4Y+YTdrdZheS8TFwvkbLWf/G5KNJDCh6pKL5OZctEW4+0Baa5idK2ZQuELRwPznQ==";
      };
    };
    "urix-0.1.0" = {
      name = "urix";
      packageName = "urix";
      version = "0.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/urix/-/urix-0.1.0.tgz";
        sha1 = "da937f7a62e21fec1fd18d49b35c2935067a6c72";
      };
    };
    "url-0.11.0" = {
      name = "url";
      packageName = "url";
      version = "0.11.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/url/-/url-0.11.0.tgz";
        sha1 = "3838e97cfc60521eb73c525a8e55bfdd9e2e28f1";
      };
    };
    "url-join-2.0.5" = {
      name = "url-join";
      packageName = "url-join";
      version = "2.0.5";
      src = fetchurl {
        url = "https://registry.npmjs.org/url-join/-/url-join-2.0.5.tgz";
        sha1 = "5af22f18c052a000a48d7b82c5e9c2e2feeda728";
      };
    };
    "url-loader-0.6.2" = {
      name = "url-loader";
      packageName = "url-loader";
      version = "0.6.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/url-loader/-/url-loader-0.6.2.tgz";
        sha512 = "h3qf9TNn53BpuXTTcpC+UehiRrl0Cv45Yr/xWayApjw6G8Bg2dGke7rIwDQ39piciWCWrC+WiqLjOh3SUp9n0Q==";
      };
    };
    "url-parse-1.4.4" = {
      name = "url-parse";
      packageName = "url-parse";
      version = "1.4.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/url-parse/-/url-parse-1.4.4.tgz";
        sha512 = "/92DTTorg4JjktLNLe6GPS2/RvAd/RGr6LuktmWSMLEOa6rjnlrFXNgSbSmkNvCoL2T028A0a1JaJLzRMlFoHg==";
      };
    };
    "use-3.1.1" = {
      name = "use";
      packageName = "use";
      version = "3.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/use/-/use-3.1.1.tgz";
        sha512 = "cwESVXlO3url9YWlFW/TA9cshCEhtu7IKJ/p5soJ/gGpj7vbvFrAY/eIioQ6Dw23KjZhYgiIo8HOs1nQ2vr/oQ==";
      };
    };
    "user-home-2.0.0" = {
      name = "user-home";
      packageName = "user-home";
      version = "2.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/user-home/-/user-home-2.0.0.tgz";
        sha1 = "9c70bfd8169bc1dcbf48604e0f04b8b49cde9e9f";
      };
    };
    "util-0.10.3" = {
      name = "util";
      packageName = "util";
      version = "0.10.3";
      src = fetchurl {
        url = "http://registry.npmjs.org/util/-/util-0.10.3.tgz";
        sha1 = "7afb1afe50805246489e3db7fe0ed379336ac0f9";
      };
    };
    "util-0.10.4" = {
      name = "util";
      packageName = "util";
      version = "0.10.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/util/-/util-0.10.4.tgz";
        sha512 = "0Pm9hTQ3se5ll1XihRic3FDIku70C+iHUdT/W926rSgHV5QgXsYbKZN8MSC3tJtSkhuROzvsQjAaFENRXr+19A==";
      };
    };
    "util-deprecate-1.0.2" = {
      name = "util-deprecate";
      packageName = "util-deprecate";
      version = "1.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/util-deprecate/-/util-deprecate-1.0.2.tgz";
        sha1 = "450d4dc9fa70de732762fbd2d4a28981419a0ccf";
      };
    };
    "utila-0.4.0" = {
      name = "utila";
      packageName = "utila";
      version = "0.4.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/utila/-/utila-0.4.0.tgz";
        sha1 = "8a16a05d445657a3aea5eecc5b12a4fa5379772c";
      };
    };
    "utile-0.3.0" = {
      name = "utile";
      packageName = "utile";
      version = "0.3.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/utile/-/utile-0.3.0.tgz";
        sha1 = "1352c340eb820e4d8ddba039a4fbfaa32ed4ef3a";
      };
    };
    "utils-merge-1.0.1" = {
      name = "utils-merge";
      packageName = "utils-merge";
      version = "1.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/utils-merge/-/utils-merge-1.0.1.tgz";
        sha1 = "9f95710f50a267947b2ccc124741c1028427e713";
      };
    };
    "uuid-3.3.2" = {
      name = "uuid";
      packageName = "uuid";
      version = "3.3.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/uuid/-/uuid-3.3.2.tgz";
        sha512 = "yXJmeNaw3DnnKAOKJE51sL/ZaYfWJRl1pK9dr19YFCu0ObS231AB1/LbqTKRAQ5kw8A90rA6fr4riOUpTZvQZA==";
      };
    };
    "validate-npm-package-license-3.0.4" = {
      name = "validate-npm-package-license";
      packageName = "validate-npm-package-license";
      version = "3.0.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/validate-npm-package-license/-/validate-npm-package-license-3.0.4.tgz";
        sha512 = "DpKm2Ui/xN7/HQKCtpZxoRWBhZ9Z0kqtygG8XCgNQ8ZlDnxuQmWhj566j8fN4Cu3/JmbhsDo7fcAJq4s9h27Ew==";
      };
    };
    "vary-1.1.2" = {
      name = "vary";
      packageName = "vary";
      version = "1.1.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/vary/-/vary-1.1.2.tgz";
        sha1 = "2299f02c6ded30d4a5961b0b9f74524a18f634fc";
      };
    };
    "vee-validate-2.1.4" = {
      name = "vee-validate";
      packageName = "vee-validate";
      version = "2.1.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/vee-validate/-/vee-validate-2.1.4.tgz";
        sha512 = "71yu8floUnMEdkwswaF9WJc5Xubc5dhIG6MRc/H0egQnP34Y14WwNweK9z31Nf2Zi6JB2H/36EKt0Mqco8R/Nw==";
      };
    };
    "vendors-1.0.2" = {
      name = "vendors";
      packageName = "vendors";
      version = "1.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/vendors/-/vendors-1.0.2.tgz";
        sha512 = "w/hry/368nO21AN9QljsaIhb9ZiZtZARoVH5f3CsFbawdLdayCgKRPup7CggujvySMxx0I91NOyxdVENohprLQ==";
      };
    };
    "verror-1.10.0" = {
      name = "verror";
      packageName = "verror";
      version = "1.10.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/verror/-/verror-1.10.0.tgz";
        sha1 = "3a105ca17053af55d6e270c1f8288682e18da400";
      };
    };
    "vfile-1.4.0" = {
      name = "vfile";
      packageName = "vfile";
      version = "1.4.0";
      src = fetchurl {
        url = "http://registry.npmjs.org/vfile/-/vfile-1.4.0.tgz";
        sha1 = "c0fd6fa484f8debdb771f68c31ed75d88da97fe7";
      };
    };
    "vfile-find-down-1.0.0" = {
      name = "vfile-find-down";
      packageName = "vfile-find-down";
      version = "1.0.0";
      src = fetchurl {
        url = "http://registry.npmjs.org/vfile-find-down/-/vfile-find-down-1.0.0.tgz";
        sha1 = "84a4d66d03513f6140a84e0776ef0848d4f0ad95";
      };
    };
    "vfile-find-up-1.0.0" = {
      name = "vfile-find-up";
      packageName = "vfile-find-up";
      version = "1.0.0";
      src = fetchurl {
        url = "http://registry.npmjs.org/vfile-find-up/-/vfile-find-up-1.0.0.tgz";
        sha1 = "5604da6fe453b34350637984eb5fe4909e280390";
      };
    };
    "vfile-reporter-1.5.0" = {
      name = "vfile-reporter";
      packageName = "vfile-reporter";
      version = "1.5.0";
      src = fetchurl {
        url = "http://registry.npmjs.org/vfile-reporter/-/vfile-reporter-1.5.0.tgz";
        sha1 = "21a7009bfe55e24df8ff432aa5bf6f6efa74e418";
      };
    };
    "vfile-sort-1.0.0" = {
      name = "vfile-sort";
      packageName = "vfile-sort";
      version = "1.0.0";
      src = fetchurl {
        url = "http://registry.npmjs.org/vfile-sort/-/vfile-sort-1.0.0.tgz";
        sha1 = "17ee491ba43e8951bb22913fcff32a7dc4d234d4";
      };
    };
    "vm-browserify-0.0.4" = {
      name = "vm-browserify";
      packageName = "vm-browserify";
      version = "0.0.4";
      src = fetchurl {
        url = "http://registry.npmjs.org/vm-browserify/-/vm-browserify-0.0.4.tgz";
        sha1 = "5d7ea45bbef9e4a6ff65f95438e0a87c357d5a73";
      };
    };
    "vue-2.5.21" = {
      name = "vue";
      packageName = "vue";
      version = "2.5.21";
      src = fetchurl {
        url = "https://registry.npmjs.org/vue/-/vue-2.5.21.tgz";
        sha512 = "Aejvyyfhn0zjVeLvXd70h4hrE4zZDx1wfZqia6ekkobLmUZ+vNFQer53B4fu0EjWBSiqApxPejzkO1Znt3joxQ==";
      };
    };
    "vue-add-globals-2.0.1" = {
      name = "vue-add-globals";
      packageName = "vue-add-globals";
      version = "2.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/vue-add-globals/-/vue-add-globals-2.0.1.tgz";
        sha512 = "NvpO+te1DsZfZq9ecPR6lJrsVm+d+R2yTgQZUEme9zS23Q+wfGYojIPgBkr7Z0ZCv3OpbEG+xd/3KSiB856QOg==";
      };
    };
    "vue-electron-1.0.6" = {
      name = "vue-electron";
      packageName = "vue-electron";
      version = "1.0.6";
      src = fetchurl {
        url = "https://registry.npmjs.org/vue-electron/-/vue-electron-1.0.6.tgz";
        sha1 = "e798e03180b8933539defe31f92e53b9242b9406";
      };
    };
    "vue-functional-data-merge-2.0.7" = {
      name = "vue-functional-data-merge";
      packageName = "vue-functional-data-merge";
      version = "2.0.7";
      src = fetchurl {
        url = "https://registry.npmjs.org/vue-functional-data-merge/-/vue-functional-data-merge-2.0.7.tgz";
        sha512 = "pvLc+H+x2prwBj/uSEIITyxjz/7ZUVVK8uYbrYMmhDvMXnzh9OvQvVEwcOSBQjsubd4Eq41/CSJaWzy4hemMNQ==";
      };
    };
    "vue-hot-reload-api-2.3.1" = {
      name = "vue-hot-reload-api";
      packageName = "vue-hot-reload-api";
      version = "2.3.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/vue-hot-reload-api/-/vue-hot-reload-api-2.3.1.tgz";
        sha512 = "AA86yKZ5uOKz87/q1UpngEXhbRkaYg1b7HMMVRobNV1IVKqZe8oLIzo6iMocVwZXnYitlGwf2k4ZRLOZlS8oPQ==";
      };
    };
    "vue-i18n-7.8.1" = {
      name = "vue-i18n";
      packageName = "vue-i18n";
      version = "7.8.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/vue-i18n/-/vue-i18n-7.8.1.tgz";
        sha512 = "BzB+EAPo/iFyFn/GXd/qVdDe67jfk+gmQaWUKD5BANhUclGrFxzRExzW2pYEAbhNm2pg0F12Oo+gL2IMLDcTAw==";
      };
    };
    "vue-loader-14.2.3" = {
      name = "vue-loader";
      packageName = "vue-loader";
      version = "14.2.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/vue-loader/-/vue-loader-14.2.3.tgz";
        sha512 = "mEd2/14gNCVVpKU/44lVDoMDoAteM8PkvaVjzZ4KHyRKtry3pifSh9UMFsjoPBMeVYs9jTEDyT8UKmgPpnP8Yw==";
      };
    };
    "vue-router-3.0.2" = {
      name = "vue-router";
      packageName = "vue-router";
      version = "3.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/vue-router/-/vue-router-3.0.2.tgz";
        sha512 = "opKtsxjp9eOcFWdp6xLQPLmRGgfM932Tl56U9chYTnoWqKxQ8M20N7AkdEbM5beUh6wICoFGYugAX9vQjyJLFg==";
      };
    };
    "vue-slider-component-2.8.3" = {
      name = "vue-slider-component";
      packageName = "vue-slider-component";
      version = "2.8.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/vue-slider-component/-/vue-slider-component-2.8.3.tgz";
        sha512 = "oKHuBlM+3cmuCiZWHOuBxEqwWmjKuspt+xsYtzShHmdekPIduZ8yUOQuT3QkFvDjhvq5vo71EvRy+LzaRoaNhg==";
      };
    };
    "vue-style-loader-3.1.2" = {
      name = "vue-style-loader";
      packageName = "vue-style-loader";
      version = "3.1.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/vue-style-loader/-/vue-style-loader-3.1.2.tgz";
        sha512 = "ICtVdK/p+qXWpdSs2alWtsXt9YnDoYjQe0w5616j9+/EhjoxZkbun34uWgsMFnC1MhrMMwaWiImz3K2jK1Yp2Q==";
      };
    };
    "vue-style-loader-4.1.2" = {
      name = "vue-style-loader";
      packageName = "vue-style-loader";
      version = "4.1.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/vue-style-loader/-/vue-style-loader-4.1.2.tgz";
        sha512 = "0ip8ge6Gzz/Bk0iHovU9XAUQaFt/G2B61bnWa2tCcqqdgfHs1lF9xXorFbE55Gmy92okFT+8bfmySuUOu13vxQ==";
      };
    };
    "vue-template-compiler-2.5.21" = {
      name = "vue-template-compiler";
      packageName = "vue-template-compiler";
      version = "2.5.21";
      src = fetchurl {
        url = "https://registry.npmjs.org/vue-template-compiler/-/vue-template-compiler-2.5.21.tgz";
        sha512 = "Vmk5Cv7UcmI99B9nXJEkaK262IQNnHp5rJYo+EwYpe2epTAXqcVyExhV6pk8jTkxQK2vRc8v8KmZBAwdmUZvvw==";
      };
    };
    "vue-template-es2015-compiler-1.6.0" = {
      name = "vue-template-es2015-compiler";
      packageName = "vue-template-es2015-compiler";
      version = "1.6.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/vue-template-es2015-compiler/-/vue-template-es2015-compiler-1.6.0.tgz";
        sha512 = "x3LV3wdmmERhVCYy3quqA57NJW7F3i6faas++pJQWtknWT+n7k30F4TVdHvCLn48peTJFRvCpxs3UuFPqgeELg==";
      };
    };
    "vuex-3.0.1" = {
      name = "vuex";
      packageName = "vuex";
      version = "3.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/vuex/-/vuex-3.0.1.tgz";
        sha512 = "wLoqz0B7DSZtgbWL1ShIBBCjv22GV5U+vcBFox658g6V0s4wZV9P4YjCNyoHSyIBpj1f29JBoNQIqD82cR4O3w==";
      };
    };
    "vuex-persistedstate-2.5.4" = {
      name = "vuex-persistedstate";
      packageName = "vuex-persistedstate";
      version = "2.5.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/vuex-persistedstate/-/vuex-persistedstate-2.5.4.tgz";
        sha512 = "XYJhKIwO+ZVlTaXyxKxnplrJ88Fnvk5aDw753bxzRw5/yMKLQ6lq9CDCBex2fwZaQcLibhtgJOxGCHjy9GLSlQ==";
      };
    };
    "ware-1.3.0" = {
      name = "ware";
      packageName = "ware";
      version = "1.3.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/ware/-/ware-1.3.0.tgz";
        sha1 = "d1b14f39d2e2cb4ab8c4098f756fe4b164e473d4";
      };
    };
    "watchpack-1.6.0" = {
      name = "watchpack";
      packageName = "watchpack";
      version = "1.6.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/watchpack/-/watchpack-1.6.0.tgz";
        sha512 = "i6dHe3EyLjMmDlU1/bGQpEw25XSjkJULPuAVKCbNRefQVq48yXKUpwg538F7AZTf9kyr57zj++pQFltUa5H7yA==";
      };
    };
    "wbuf-1.7.3" = {
      name = "wbuf";
      packageName = "wbuf";
      version = "1.7.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/wbuf/-/wbuf-1.7.3.tgz";
        sha512 = "O84QOnr0icsbFGLS0O3bI5FswxzRr8/gHwWkDlQFskhSPryQXvrTMxjxGP4+iWYoauLoBvfDpkrOauZ+0iZpDA==";
      };
    };
    "wdio-dot-reporter-0.0.10" = {
      name = "wdio-dot-reporter";
      packageName = "wdio-dot-reporter";
      version = "0.0.10";
      src = fetchurl {
        url = "https://registry.npmjs.org/wdio-dot-reporter/-/wdio-dot-reporter-0.0.10.tgz";
        sha512 = "A0TCk2JdZEn3M1DSG9YYbNRcGdx/YRw19lTiRpgwzH4qqWkO/oRDZRmi3Snn4L2j54KKTfPalBhlOtc8fojVgg==";
      };
    };
    "webdriverio-4.14.1" = {
      name = "webdriverio";
      packageName = "webdriverio";
      version = "4.14.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/webdriverio/-/webdriverio-4.14.1.tgz";
        sha512 = "Gjb5ft6JtO7WdoZifedeM6U941UZi03IlG0t3Xq9M9SxSm6FuyqMEmNZ4HI3UcBRkSbWxdOWGAvpFShYxVr7iA==";
      };
    };
    "webpack-3.12.0" = {
      name = "webpack";
      packageName = "webpack";
      version = "3.12.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/webpack/-/webpack-3.12.0.tgz";
        sha512 = "Sw7MdIIOv/nkzPzee4o0EdvCuPmxT98+vVpIvwtcwcF1Q4SDSNp92vwcKc4REe7NItH9f1S4ra9FuQ7yuYZ8bQ==";
      };
    };
    "webpack-dev-middleware-1.12.2" = {
      name = "webpack-dev-middleware";
      packageName = "webpack-dev-middleware";
      version = "1.12.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/webpack-dev-middleware/-/webpack-dev-middleware-1.12.2.tgz";
        sha512 = "FCrqPy1yy/sN6U/SaEZcHKRXGlqU0DUaEBL45jkUYoB8foVb6wCnbIJ1HKIx+qUFTW+3JpVcCJCxZ8VATL4e+A==";
      };
    };
    "webpack-dev-server-2.11.3" = {
      name = "webpack-dev-server";
      packageName = "webpack-dev-server";
      version = "2.11.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/webpack-dev-server/-/webpack-dev-server-2.11.3.tgz";
        sha512 = "Qz22YEFhWx+M2vvJ+rQppRv39JA0h5NNbOOdODApdX6iZ52Diz7vTPXjF7kJlfn+Uc24Qr48I3SZ9yncQwRycg==";
      };
    };
    "webpack-hot-middleware-2.24.3" = {
      name = "webpack-hot-middleware";
      packageName = "webpack-hot-middleware";
      version = "2.24.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/webpack-hot-middleware/-/webpack-hot-middleware-2.24.3.tgz";
        sha512 = "pPlmcdoR2Fn6UhYjAhp1g/IJy1Yc9hD+T6O9mjRcWV2pFbBjIFoJXhP0CoD0xPOhWJuWXuZXGBga9ybbOdzXpg==";
      };
    };
    "webpack-merge-4.1.5" = {
      name = "webpack-merge";
      packageName = "webpack-merge";
      version = "4.1.5";
      src = fetchurl {
        url = "https://registry.npmjs.org/webpack-merge/-/webpack-merge-4.1.5.tgz";
        sha512 = "sVcM+MMJv6DO0C0GLLltx8mUlGMKXE0zBsuMqZ9jz2X9gsekALw6Rs0cAfTWc97VuWS6NpVUa78959zANnMMLQ==";
      };
    };
    "webpack-sources-1.3.0" = {
      name = "webpack-sources";
      packageName = "webpack-sources";
      version = "1.3.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/webpack-sources/-/webpack-sources-1.3.0.tgz";
        sha512 = "OiVgSrbGu7NEnEvQJJgdSFPl2qWKkWq5lHMhgiToIiN9w34EBnjYzSYs+VbL5KoYiLNtFFa7BZIKxRED3I32pA==";
      };
    };
    "websocket-driver-0.7.0" = {
      name = "websocket-driver";
      packageName = "websocket-driver";
      version = "0.7.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/websocket-driver/-/websocket-driver-0.7.0.tgz";
        sha1 = "0caf9d2d755d93aee049d4bdd0d3fe2cca2a24eb";
      };
    };
    "websocket-extensions-0.1.3" = {
      name = "websocket-extensions";
      packageName = "websocket-extensions";
      version = "0.1.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/websocket-extensions/-/websocket-extensions-0.1.3.tgz";
        sha512 = "nqHUnMXmBzT0w570r2JpJxfiSD1IzoI+HGVdd3aZ0yNi3ngvQ4jv1dtHt5VGxfI2yj5yqImPhOK4vmIh2xMbGg==";
      };
    };
    "wgxpath-1.0.0" = {
      name = "wgxpath";
      packageName = "wgxpath";
      version = "1.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/wgxpath/-/wgxpath-1.0.0.tgz";
        sha1 = "eef8a4b9d558cc495ad3a9a2b751597ecd9af690";
      };
    };
    "whet.extend-0.9.9" = {
      name = "whet.extend";
      packageName = "whet.extend";
      version = "0.9.9";
      src = fetchurl {
        url = "https://registry.npmjs.org/whet.extend/-/whet.extend-0.9.9.tgz";
        sha1 = "f877d5bf648c97e5aa542fadc16d6a259b9c11a1";
      };
    };
    "which-1.3.1" = {
      name = "which";
      packageName = "which";
      version = "1.3.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/which/-/which-1.3.1.tgz";
        sha512 = "HxJdYWq1MTIQbJ3nw0cqssHoTNU267KlrDuGZ1WYlxDStUtKUhOaJmh112/TZmHxxUfuJqPXSOm7tDyas0OSIQ==";
      };
    };
    "which-module-1.0.0" = {
      name = "which-module";
      packageName = "which-module";
      version = "1.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/which-module/-/which-module-1.0.0.tgz";
        sha1 = "bba63ca861948994ff307736089e3b96026c2a4f";
      };
    };
    "which-module-2.0.0" = {
      name = "which-module";
      packageName = "which-module";
      version = "2.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/which-module/-/which-module-2.0.0.tgz";
        sha1 = "d9ef07dce77b9902b8a3a8fa4b31c3e3f7e6e87a";
      };
    };
    "which-pm-runs-1.0.0" = {
      name = "which-pm-runs";
      packageName = "which-pm-runs";
      version = "1.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/which-pm-runs/-/which-pm-runs-1.0.0.tgz";
        sha1 = "670b3afbc552e0b55df6b7780ca74615f23ad1cb";
      };
    };
    "wide-align-1.1.3" = {
      name = "wide-align";
      packageName = "wide-align";
      version = "1.1.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/wide-align/-/wide-align-1.1.3.tgz";
        sha512 = "QGkOQc8XL6Bt5PwnsExKBPuMKBxnGxWWW3fU55Xt4feHozMUhdUMaBCk290qpm/wG5u/RSKzwdAC4i51YigihA==";
      };
    };
    "window-size-0.1.0" = {
      name = "window-size";
      packageName = "window-size";
      version = "0.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/window-size/-/window-size-0.1.0.tgz";
        sha1 = "5438cd2ea93b202efa3a19fe8887aee7c94f9c9d";
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
    "winston-2.1.1" = {
      name = "winston";
      packageName = "winston";
      version = "2.1.1";
      src = fetchurl {
        url = "http://registry.npmjs.org/winston/-/winston-2.1.1.tgz";
        sha1 = "3c9349d196207fd1bdff9d4bc43ef72510e3a12e";
      };
    };
    "word-wrap-1.2.3" = {
      name = "word-wrap";
      packageName = "word-wrap";
      version = "1.2.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/word-wrap/-/word-wrap-1.2.3.tgz";
        sha512 = "Hz/mrNwitNRh/HUAtM/VT/5VH+ygD6DV7mYKZAtHOrbs8U7lvPS6xf7EJKMF0uW1KJCl0H701g3ZGus+muE5vQ==";
      };
    };
    "wordwrap-0.0.2" = {
      name = "wordwrap";
      packageName = "wordwrap";
      version = "0.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/wordwrap/-/wordwrap-0.0.2.tgz";
        sha1 = "b79669bb42ecb409f83d583cad52ca17eaa1643f";
      };
    };
    "wordwrap-0.0.3" = {
      name = "wordwrap";
      packageName = "wordwrap";
      version = "0.0.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/wordwrap/-/wordwrap-0.0.3.tgz";
        sha1 = "a3d5da6cd5c0bc0008d37234bbaf1bed63059107";
      };
    };
    "wordwrap-1.0.0" = {
      name = "wordwrap";
      packageName = "wordwrap";
      version = "1.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/wordwrap/-/wordwrap-1.0.0.tgz";
        sha1 = "27584810891456a4171c8d0226441ade90cbcaeb";
      };
    };
    "wrap-ansi-2.1.0" = {
      name = "wrap-ansi";
      packageName = "wrap-ansi";
      version = "2.1.0";
      src = fetchurl {
        url = "http://registry.npmjs.org/wrap-ansi/-/wrap-ansi-2.1.0.tgz";
        sha1 = "d8fc3d284dd05794fe84973caecdd1cf824fdd85";
      };
    };
    "wrap-fn-0.1.5" = {
      name = "wrap-fn";
      packageName = "wrap-fn";
      version = "0.1.5";
      src = fetchurl {
        url = "https://registry.npmjs.org/wrap-fn/-/wrap-fn-0.1.5.tgz";
        sha1 = "f21b6e41016ff4a7e31720dbc63a09016bdf9845";
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
    "ws-1.1.5" = {
      name = "ws";
      packageName = "ws";
      version = "1.1.5";
      src = fetchurl {
        url = "https://registry.npmjs.org/ws/-/ws-1.1.5.tgz";
        sha512 = "o3KqipXNUdS7wpQzBHSe180lBGO60SoK0yVo3CYJgb2MkobuWuBX6dhkYP5ORCLd55y+SaflMOV5fqAB53ux4w==";
      };
    };
    "xregexp-2.0.0" = {
      name = "xregexp";
      packageName = "xregexp";
      version = "2.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/xregexp/-/xregexp-2.0.0.tgz";
        sha1 = "52a63e56ca0b84a7f3a5f3d61872f126ad7a5943";
      };
    };
    "xtend-2.1.2" = {
      name = "xtend";
      packageName = "xtend";
      version = "2.1.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/xtend/-/xtend-2.1.2.tgz";
        sha1 = "6efecc2a4dad8e6962c4901b337ce7ba87b5d28b";
      };
    };
    "xtend-3.0.0" = {
      name = "xtend";
      packageName = "xtend";
      version = "3.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/xtend/-/xtend-3.0.0.tgz";
        sha1 = "5cce7407baf642cba7becda568111c493f59665a";
      };
    };
    "xtend-4.0.1" = {
      name = "xtend";
      packageName = "xtend";
      version = "4.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/xtend/-/xtend-4.0.1.tgz";
        sha1 = "a5c6d532be656e23db820efb943a1f04998d63af";
      };
    };
    "y18n-3.2.1" = {
      name = "y18n";
      packageName = "y18n";
      version = "3.2.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/y18n/-/y18n-3.2.1.tgz";
        sha1 = "6d15fba884c08679c0d77e88e7759e811e07fa41";
      };
    };
    "y18n-4.0.0" = {
      name = "y18n";
      packageName = "y18n";
      version = "4.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/y18n/-/y18n-4.0.0.tgz";
        sha512 = "r9S/ZyXu/Xu9q1tYlpsLIsa3EeLXXk0VwlxqTcFRfg9EhMW+17kbt9G0NrgCmhGb5vT2hyhJZLfDGx+7+5Uj/w==";
      };
    };
    "yallist-2.1.2" = {
      name = "yallist";
      packageName = "yallist";
      version = "2.1.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/yallist/-/yallist-2.1.2.tgz";
        sha1 = "1c11f9218f076089a47dd512f93c6699a6a81d52";
      };
    };
    "yargs-3.10.0" = {
      name = "yargs";
      packageName = "yargs";
      version = "3.10.0";
      src = fetchurl {
        url = "http://registry.npmjs.org/yargs/-/yargs-3.10.0.tgz";
        sha1 = "f7ee7bd857dd7c1d2d38c0e74efbd681d1431fd1";
      };
    };
    "yargs-6.6.0" = {
      name = "yargs";
      packageName = "yargs";
      version = "6.6.0";
      src = fetchurl {
        url = "http://registry.npmjs.org/yargs/-/yargs-6.6.0.tgz";
        sha1 = "782ec21ef403345f830a808ca3d513af56065208";
      };
    };
    "yargs-7.1.0" = {
      name = "yargs";
      packageName = "yargs";
      version = "7.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/yargs/-/yargs-7.1.0.tgz";
        sha1 = "6ba318eb16961727f5d284f8ea003e8d6154d0c8";
      };
    };
    "yargs-8.0.2" = {
      name = "yargs";
      packageName = "yargs";
      version = "8.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/yargs/-/yargs-8.0.2.tgz";
        sha1 = "6299a9055b1cefc969ff7e79c1d918dceb22c360";
      };
    };
    "yargs-parser-4.2.1" = {
      name = "yargs-parser";
      packageName = "yargs-parser";
      version = "4.2.1";
      src = fetchurl {
        url = "http://registry.npmjs.org/yargs-parser/-/yargs-parser-4.2.1.tgz";
        sha1 = "29cceac0dc4f03c6c87b4a9f217dd18c9f74871c";
      };
    };
    "yargs-parser-5.0.0" = {
      name = "yargs-parser";
      packageName = "yargs-parser";
      version = "5.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/yargs-parser/-/yargs-parser-5.0.0.tgz";
        sha1 = "275ecf0d7ffe05c77e64e7c86e4cd94bf0e1228a";
      };
    };
    "yargs-parser-7.0.0" = {
      name = "yargs-parser";
      packageName = "yargs-parser";
      version = "7.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/yargs-parser/-/yargs-parser-7.0.0.tgz";
        sha1 = "8d0ac42f16ea55debd332caf4c4038b3e3f5dfd9";
      };
    };
    "yauzl-2.4.1" = {
      name = "yauzl";
      packageName = "yauzl";
      version = "2.4.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/yauzl/-/yauzl-2.4.1.tgz";
        sha1 = "9528f442dab1b2284e58b4379bb194e22e0c4005";
      };
    };
    "zerr-1.0.4" = {
      name = "zerr";
      packageName = "zerr";
      version = "1.0.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/zerr/-/zerr-1.0.4.tgz";
        sha1 = "62814dd799eff8361f2a228f41f705c5e19de4c9";
      };
    };
    "zip-stream-1.2.0" = {
      name = "zip-stream";
      packageName = "zip-stream";
      version = "1.2.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/zip-stream/-/zip-stream-1.2.0.tgz";
        sha1 = "a8bc45f4c1b49699c6b90198baacaacdbcd4ba04";
      };
    };
  };
  args = {
    name = "talenet";
    packageName = "talenet";
    version = "0.9.0-SNAPSHOT";
    src = ./.;
    dependencies = [
      sources."@babel/code-frame-7.0.0-beta.44"
      (sources."@babel/generator-7.0.0-beta.44" // {
        dependencies = [
          sources."jsesc-2.5.2"
        ];
      })
      sources."@babel/helper-function-name-7.0.0-beta.44"
      sources."@babel/helper-get-function-arity-7.0.0-beta.44"
      sources."@babel/helper-split-export-declaration-7.0.0-beta.44"
      sources."@babel/highlight-7.0.0-beta.44"
      (sources."@babel/template-7.0.0-beta.44" // {
        dependencies = [
          sources."babylon-7.0.0-beta.44"
        ];
      })
      (sources."@babel/traverse-7.0.0-beta.44" // {
        dependencies = [
          sources."babylon-7.0.0-beta.44"
          sources."debug-3.2.6"
          sources."globals-11.9.0"
          sources."ms-2.1.1"
        ];
      })
      (sources."@babel/types-7.0.0-beta.44" // {
        dependencies = [
          sources."to-fast-properties-2.0.0"
        ];
      })
      sources."abbrev-1.1.1"
      sources."abstract-leveldown-4.0.3"
      sources."accepts-1.3.5"
      sources."acorn-5.7.3"
      (sources."acorn-dynamic-import-2.0.2" // {
        dependencies = [
          sources."acorn-4.0.13"
        ];
      })
      sources."adm-zip-0.4.13"
      (sources."agent-base-2.1.1" // {
        dependencies = [
          sources."semver-5.0.3"
        ];
      })
      sources."ajv-6.6.2"
      sources."ajv-keywords-3.2.0"
      sources."align-text-0.1.4"
      (sources."aligned-block-file-1.1.4" // {
        dependencies = [
          sources."obv-0.0.0"
        ];
      })
      sources."alphanum-sort-1.0.2"
      sources."amdefine-1.0.1"
      sources."ansi-escapes-1.4.0"
      sources."ansi-html-0.0.7"
      sources."ansi-regex-2.1.1"
      sources."ansi-styles-2.2.1"
      sources."anymatch-1.3.2"
      sources."append-batch-0.0.1"
      sources."aproba-1.2.0"
      sources."archiver-2.1.1"
      sources."archiver-utils-1.3.0"
      sources."are-we-there-yet-1.1.5"
      sources."argparse-1.0.10"
      sources."arr-diff-2.0.0"
      sources."arr-flatten-1.1.0"
      sources."arr-union-3.1.0"
      sources."array-find-index-1.0.2"
      sources."array-flatten-2.1.2"
      sources."array-includes-3.0.3"
      sources."array-union-1.0.2"
      sources."array-uniq-1.0.3"
      sources."array-unique-0.2.1"
      sources."arrify-1.0.1"
      sources."asn1-0.2.4"
      sources."asn1.js-4.10.1"
      (sources."assert-1.4.1" // {
        dependencies = [
          sources."inherits-2.0.1"
          sources."util-0.10.3"
        ];
      })
      sources."assert-plus-1.0.0"
      sources."assertion-error-1.1.0"
      sources."assign-symbols-1.0.0"
      sources."ast-types-0.11.7"
      sources."async-2.6.1"
      sources."async-each-1.0.1"
      sources."async-foreach-0.1.3"
      sources."async-single-1.0.5"
      sources."async-write-2.1.0"
      sources."asynckit-0.4.0"
      sources."atob-2.1.2"
      sources."atomic-file-1.1.5"
      sources."attach-ware-1.1.1"
      sources."autoprefixer-8.6.5"
      sources."avoriaz-6.3.0"
      sources."aws-sign2-0.7.0"
      sources."aws4-1.8.0"
      (sources."babel-code-frame-6.26.0" // {
        dependencies = [
          sources."chalk-1.1.3"
        ];
      })
      sources."babel-core-6.26.3"
      (sources."babel-eslint-8.2.6" // {
        dependencies = [
          sources."babylon-7.0.0-beta.44"
        ];
      })
      sources."babel-generator-6.26.1"
      sources."babel-helper-bindify-decorators-6.24.1"
      sources."babel-helper-builder-binary-assignment-operator-visitor-6.24.1"
      sources."babel-helper-call-delegate-6.24.1"
      sources."babel-helper-define-map-6.26.0"
      sources."babel-helper-evaluate-path-0.1.0"
      sources."babel-helper-explode-assignable-expression-6.24.1"
      sources."babel-helper-explode-class-6.24.1"
      sources."babel-helper-flip-expressions-0.1.2"
      sources."babel-helper-function-name-6.24.1"
      sources."babel-helper-get-function-arity-6.24.1"
      sources."babel-helper-hoist-variables-6.24.1"
      sources."babel-helper-is-nodes-equiv-0.0.1"
      sources."babel-helper-is-void-0-0.1.1"
      sources."babel-helper-mark-eval-scopes-0.1.1"
      sources."babel-helper-optimise-call-expression-6.24.1"
      sources."babel-helper-regex-6.26.0"
      sources."babel-helper-remap-async-to-generator-6.24.1"
      sources."babel-helper-remove-or-void-0.1.1"
      sources."babel-helper-replace-supers-6.24.1"
      sources."babel-helper-to-multiple-sequence-expressions-0.1.1"
      sources."babel-helpers-6.24.1"
      sources."babel-loader-7.1.5"
      sources."babel-messages-6.23.0"
      sources."babel-plugin-check-es2015-constants-6.22.0"
      sources."babel-plugin-istanbul-4.1.6"
      sources."babel-plugin-minify-builtins-0.1.3"
      sources."babel-plugin-minify-constant-folding-0.1.3"
      sources."babel-plugin-minify-dead-code-elimination-0.1.7"
      sources."babel-plugin-minify-flip-comparisons-0.1.2"
      sources."babel-plugin-minify-guarded-expressions-0.1.2"
      sources."babel-plugin-minify-infinity-0.1.2"
      sources."babel-plugin-minify-mangle-names-0.1.3"
      sources."babel-plugin-minify-numeric-literals-0.1.1"
      sources."babel-plugin-minify-replace-0.1.2"
      sources."babel-plugin-minify-simplify-0.1.2"
      sources."babel-plugin-minify-type-constructors-0.1.2"
      sources."babel-plugin-syntax-async-functions-6.13.0"
      sources."babel-plugin-syntax-async-generators-6.13.0"
      sources."babel-plugin-syntax-class-constructor-call-6.18.0"
      sources."babel-plugin-syntax-class-properties-6.13.0"
      sources."babel-plugin-syntax-decorators-6.13.0"
      sources."babel-plugin-syntax-do-expressions-6.13.0"
      sources."babel-plugin-syntax-dynamic-import-6.18.0"
      sources."babel-plugin-syntax-exponentiation-operator-6.13.0"
      sources."babel-plugin-syntax-export-extensions-6.13.0"
      sources."babel-plugin-syntax-function-bind-6.13.0"
      sources."babel-plugin-syntax-object-rest-spread-6.13.0"
      sources."babel-plugin-syntax-trailing-function-commas-6.22.0"
      sources."babel-plugin-transform-async-generator-functions-6.24.1"
      sources."babel-plugin-transform-async-to-generator-6.24.1"
      sources."babel-plugin-transform-class-constructor-call-6.24.1"
      sources."babel-plugin-transform-class-properties-6.24.1"
      sources."babel-plugin-transform-decorators-6.24.1"
      sources."babel-plugin-transform-do-expressions-6.22.0"
      sources."babel-plugin-transform-es2015-arrow-functions-6.22.0"
      sources."babel-plugin-transform-es2015-block-scoped-functions-6.22.0"
      sources."babel-plugin-transform-es2015-block-scoping-6.26.0"
      sources."babel-plugin-transform-es2015-classes-6.24.1"
      sources."babel-plugin-transform-es2015-computed-properties-6.24.1"
      sources."babel-plugin-transform-es2015-destructuring-6.23.0"
      sources."babel-plugin-transform-es2015-duplicate-keys-6.24.1"
      sources."babel-plugin-transform-es2015-for-of-6.23.0"
      sources."babel-plugin-transform-es2015-function-name-6.24.1"
      sources."babel-plugin-transform-es2015-literals-6.22.0"
      sources."babel-plugin-transform-es2015-modules-amd-6.24.1"
      sources."babel-plugin-transform-es2015-modules-commonjs-6.26.2"
      sources."babel-plugin-transform-es2015-modules-systemjs-6.24.1"
      sources."babel-plugin-transform-es2015-modules-umd-6.24.1"
      sources."babel-plugin-transform-es2015-object-super-6.24.1"
      sources."babel-plugin-transform-es2015-parameters-6.24.1"
      sources."babel-plugin-transform-es2015-shorthand-properties-6.24.1"
      sources."babel-plugin-transform-es2015-spread-6.22.0"
      sources."babel-plugin-transform-es2015-sticky-regex-6.24.1"
      sources."babel-plugin-transform-es2015-template-literals-6.22.0"
      sources."babel-plugin-transform-es2015-typeof-symbol-6.23.0"
      sources."babel-plugin-transform-es2015-unicode-regex-6.24.1"
      sources."babel-plugin-transform-exponentiation-operator-6.24.1"
      sources."babel-plugin-transform-export-extensions-6.22.0"
      sources."babel-plugin-transform-function-bind-6.22.0"
      sources."babel-plugin-transform-inline-consecutive-adds-0.1.2"
      sources."babel-plugin-transform-member-expression-literals-6.9.4"
      sources."babel-plugin-transform-merge-sibling-variables-6.9.4"
      sources."babel-plugin-transform-minify-booleans-6.9.4"
      sources."babel-plugin-transform-object-rest-spread-6.26.0"
      sources."babel-plugin-transform-property-literals-6.9.4"
      sources."babel-plugin-transform-regenerator-6.26.0"
      sources."babel-plugin-transform-regexp-constructors-0.1.1"
      sources."babel-plugin-transform-remove-console-6.9.4"
      sources."babel-plugin-transform-remove-debugger-6.9.4"
      sources."babel-plugin-transform-remove-undefined-0.1.2"
      sources."babel-plugin-transform-runtime-6.23.0"
      sources."babel-plugin-transform-simplify-comparison-operators-6.9.4"
      sources."babel-plugin-transform-strict-mode-6.24.1"
      sources."babel-plugin-transform-undefined-to-void-6.9.4"
      sources."babel-polyfill-6.26.0"
      sources."babel-preset-babili-0.1.4"
      sources."babel-preset-env-1.7.0"
      sources."babel-preset-es2040-1.1.1"
      sources."babel-preset-stage-0-6.24.1"
      sources."babel-preset-stage-1-6.24.1"
      sources."babel-preset-stage-2-6.24.1"
      sources."babel-preset-stage-3-6.24.1"
      sources."babel-register-6.26.0"
      (sources."babel-runtime-6.26.0" // {
        dependencies = [
          sources."regenerator-runtime-0.11.1"
        ];
      })
      sources."babel-template-6.26.0"
      sources."babel-traverse-6.26.0"
      sources."babel-types-6.26.0"
      sources."babili-webpack-plugin-0.1.2"
      sources."babylon-6.18.0"
      sources."bail-1.0.3"
      sources."balanced-match-1.0.0"
      (sources."base-0.11.2" // {
        dependencies = [
          sources."define-property-1.0.0"
          sources."isobject-3.0.1"
        ];
      })
      sources."base64-js-1.3.0"
      sources."base64-url-2.2.0"
      sources."bash-color-0.0.4"
      sources."batch-0.6.1"
      sources."bcrypt-pbkdf-1.0.2"
      sources."big.js-3.2.0"
      sources."binary-extensions-1.12.0"
      sources."binary-search-1.3.4"
      sources."bindings-1.3.1"
      sources."bl-1.2.2"
      sources."blake2s-1.0.1"
      sources."block-stream-0.0.9"
      sources."bluebird-3.5.3"
      sources."bn.js-4.11.8"
      (sources."body-parser-1.18.3" // {
        dependencies = [
          sources."iconv-lite-0.4.23"
        ];
      })
      sources."bonjour-3.5.0"
      sources."boolbase-1.0.0"
      sources."bootstrap-4.1.3"
      sources."bootstrap-vue-2.0.0-rc.11"
      sources."brace-expansion-1.1.11"
      sources."braces-1.8.5"
      sources."broadcast-stream-0.2.2"
      sources."brorand-1.1.0"
      sources."browser-split-0.0.1"
      sources."browser-stdout-1.3.0"
      sources."browserify-aes-1.2.0"
      sources."browserify-cipher-1.0.1"
      sources."browserify-des-1.0.2"
      sources."browserify-rsa-4.0.1"
      sources."browserify-sign-4.0.4"
      sources."browserify-zlib-0.1.4"
      sources."browserslist-3.2.8"
      sources."buffer-5.2.1"
      sources."buffer-alloc-1.2.0"
      sources."buffer-alloc-unsafe-1.1.0"
      sources."buffer-crc32-0.2.13"
      sources."buffer-fill-1.0.0"
      sources."buffer-from-1.1.1"
      sources."buffer-indexof-1.1.1"
      sources."buffer-xor-1.0.3"
      sources."builtin-modules-1.1.1"
      sources."builtin-status-codes-3.0.0"
      sources."bytes-3.0.0"
      sources."bytewise-1.1.0"
      sources."bytewise-core-1.2.3"
      sources."cacache-10.0.4"
      (sources."cache-base-1.0.1" // {
        dependencies = [
          sources."isobject-3.0.1"
        ];
      })
      sources."camel-case-3.0.0"
      sources."camelcase-2.1.1"
      sources."camelcase-keys-2.1.0"
      (sources."caniuse-api-1.6.1" // {
        dependencies = [
          sources."browserslist-1.7.7"
        ];
      })
      sources."caniuse-db-1.0.30000923"
      sources."caniuse-lite-1.0.30000923"
      sources."caseless-0.12.0"
      sources."ccount-1.0.3"
      sources."center-align-0.1.3"
      (sources."cfonts-1.2.0" // {
        dependencies = [
          sources."ansi-styles-3.2.1"
        ];
      })
      sources."chai-4.2.0"
      (sources."chai-nightwatch-0.1.1" // {
        dependencies = [
          sources."assertion-error-1.0.0"
          sources."deep-eql-0.1.3"
          sources."type-detect-0.1.1"
        ];
      })
      (sources."chalk-2.4.1" // {
        dependencies = [
          sources."ansi-styles-3.2.1"
          sources."supports-color-5.5.0"
        ];
      })
      sources."change-case-3.0.2"
      sources."character-entities-1.2.2"
      sources."character-entities-html4-1.1.2"
      sources."character-entities-legacy-1.1.2"
      sources."character-reference-invalid-1.1.2"
      sources."chardet-0.4.2"
      sources."charwise-3.0.1"
      sources."check-error-1.0.2"
      sources."chloride-2.2.10"
      sources."chloride-test-1.2.2"
      sources."chokidar-1.7.0"
      sources."chownr-1.1.1"
      sources."chrome-native-messaging-0.2.0"
      sources."cipher-base-1.0.4"
      (sources."clap-1.2.3" // {
        dependencies = [
          sources."chalk-1.1.3"
        ];
      })
      (sources."class-utils-0.3.6" // {
        dependencies = [
          sources."define-property-0.2.5"
          (sources."is-accessor-descriptor-0.1.6" // {
            dependencies = [
              sources."kind-of-3.2.2"
            ];
          })
          (sources."is-data-descriptor-0.1.4" // {
            dependencies = [
              sources."kind-of-3.2.2"
            ];
          })
          sources."is-descriptor-0.1.6"
          sources."isobject-3.0.1"
          sources."kind-of-5.1.0"
        ];
      })
      (sources."clean-css-4.2.1" // {
        dependencies = [
          sources."source-map-0.6.1"
        ];
      })
      sources."cli-cursor-2.1.0"
      sources."cli-width-2.2.0"
      (sources."cliui-3.2.0" // {
        dependencies = [
          sources."is-fullwidth-code-point-1.0.0"
          sources."string-width-1.0.2"
        ];
      })
      sources."clone-1.0.4"
      (sources."clone-deep-2.0.2" // {
        dependencies = [
          sources."for-own-1.0.0"
          sources."kind-of-6.0.2"
        ];
      })
      sources."co-3.1.0"
      sources."coa-1.0.4"
      sources."code-point-at-1.1.0"
      sources."collapse-white-space-1.0.4"
      sources."collection-visit-1.0.0"
      sources."color-0.11.4"
      sources."color-convert-1.9.3"
      sources."color-name-1.1.3"
      sources."color-string-0.3.0"
      sources."colormin-1.1.2"
      sources."colors-1.3.3"
      sources."combined-stream-1.0.7"
      sources."commander-2.19.0"
      sources."commondir-1.0.1"
      sources."compare-at-paths-1.0.0"
      sources."component-emitter-1.2.1"
      sources."compress-commons-1.2.2"
      sources."compressible-2.0.15"
      sources."compression-1.7.3"
      sources."concat-map-0.0.1"
      sources."concat-stream-1.6.2"
      sources."connect-history-api-fallback-1.5.0"
      sources."console-browserify-1.1.0"
      sources."console-control-strings-1.1.0"
      sources."consolidate-0.14.5"
      sources."constant-case-2.0.0"
      sources."constants-browserify-1.0.0"
      sources."cont-1.0.3"
      sources."content-disposition-0.5.2"
      sources."content-type-1.0.4"
      sources."continuable-1.2.0"
      (sources."continuable-hash-0.1.4" // {
        dependencies = [
          sources."continuable-1.1.8"
        ];
      })
      (sources."continuable-list-0.1.6" // {
        dependencies = [
          sources."continuable-1.1.8"
        ];
      })
      sources."continuable-para-1.2.0"
      sources."continuable-series-1.2.0"
      sources."convert-source-map-1.6.0"
      sources."cookie-0.3.1"
      sources."cookie-signature-1.0.6"
      sources."copy-concurrently-1.0.5"
      sources."copy-descriptor-0.1.1"
      (sources."copy-webpack-plugin-4.6.0" // {
        dependencies = [
          sources."globby-7.1.1"
          sources."is-extglob-2.1.1"
          sources."is-glob-4.0.0"
          sources."pify-3.0.0"
        ];
      })
      sources."core-js-2.6.1"
      sources."core-util-is-1.0.2"
      sources."cosmiconfig-2.2.2"
      sources."crc-3.8.0"
      sources."crc32-stream-2.0.0"
      sources."create-ecdh-4.0.3"
      sources."create-hash-1.2.0"
      (sources."create-hmac-1.1.7" // {
        dependencies = [
          sources."sha.js-2.4.11"
        ];
      })
      (sources."cross-env-5.2.0" // {
        dependencies = [
          sources."cross-spawn-6.0.5"
        ];
      })
      sources."cross-spawn-4.0.2"
      sources."crypto-browserify-3.12.0"
      (sources."css-2.2.4" // {
        dependencies = [
          sources."source-map-0.6.1"
        ];
      })
      sources."css-color-names-0.0.4"
      (sources."css-loader-0.28.11" // {
        dependencies = [
          (sources."chalk-1.1.3" // {
            dependencies = [
              sources."supports-color-2.0.0"
            ];
          })
          sources."has-flag-1.0.0"
          sources."postcss-5.2.18"
          sources."supports-color-3.2.3"
        ];
      })
      sources."css-parse-2.0.0"
      sources."css-select-1.2.0"
      (sources."css-selector-tokenizer-0.7.1" // {
        dependencies = [
          sources."regexpu-core-1.0.0"
        ];
      })
      sources."css-value-0.0.1"
      sources."css-what-2.1.2"
      sources."cssesc-0.1.0"
      (sources."cssnano-3.10.0" // {
        dependencies = [
          sources."autoprefixer-6.7.7"
          sources."browserslist-1.7.7"
          (sources."chalk-1.1.3" // {
            dependencies = [
              sources."supports-color-2.0.0"
            ];
          })
          sources."has-flag-1.0.0"
          sources."postcss-5.2.18"
          sources."supports-color-3.2.3"
        ];
      })
      sources."csso-2.3.2"
      sources."currently-unhandled-0.4.1"
      sources."cycle-1.0.3"
      sources."cyclist-0.2.2"
      sources."d-1.0.0"
      sources."d3-5.7.0"
      sources."d3-array-1.2.4"
      sources."d3-axis-1.0.12"
      sources."d3-brush-1.0.6"
      sources."d3-chord-1.0.6"
      sources."d3-collection-1.0.7"
      sources."d3-color-1.2.3"
      sources."d3-contour-1.3.2"
      sources."d3-dispatch-1.0.5"
      sources."d3-drag-1.2.3"
      sources."d3-dsv-1.0.10"
      sources."d3-ease-1.0.5"
      sources."d3-fetch-1.1.2"
      sources."d3-force-1.1.2"
      sources."d3-format-1.3.2"
      sources."d3-geo-1.11.3"
      sources."d3-hierarchy-1.1.8"
      sources."d3-interpolate-1.3.2"
      sources."d3-path-1.0.7"
      sources."d3-polygon-1.0.5"
      sources."d3-quadtree-1.0.5"
      sources."d3-random-1.1.2"
      sources."d3-scale-2.1.2"
      sources."d3-scale-chromatic-1.3.3"
      sources."d3-selection-1.3.2"
      sources."d3-shape-1.2.2"
      sources."d3-time-1.0.10"
      sources."d3-time-format-2.1.3"
      sources."d3-timer-1.0.9"
      sources."d3-transition-1.1.3"
      sources."d3-voronoi-1.1.4"
      sources."d3-zoom-1.7.3"
      sources."dashdash-1.14.1"
      sources."data-uri-to-buffer-1.2.0"
      sources."date-now-0.1.4"
      sources."de-indent-1.0.2"
      sources."debug-2.6.9"
      sources."decamelize-1.2.0"
      sources."decode-uri-component-0.2.0"
      sources."decompress-response-3.3.0"
      sources."deep-eql-3.0.1"
      sources."deep-equal-1.0.1"
      sources."deep-extend-0.6.0"
      sources."deep-is-0.1.3"
      sources."deepmerge-2.2.1"
      sources."default-shell-1.0.1"
      sources."deferred-leveldown-3.0.0"
      sources."define-properties-1.1.3"
      (sources."define-property-2.0.2" // {
        dependencies = [
          sources."isobject-3.0.1"
        ];
      })
      sources."defined-1.0.0"
      (sources."degenerator-1.0.4" // {
        dependencies = [
          sources."esprima-3.1.3"
        ];
      })
      (sources."del-3.0.0" // {
        dependencies = [
          (sources."globby-6.1.0" // {
            dependencies = [
              sources."pify-2.3.0"
            ];
          })
          sources."pify-3.0.0"
        ];
      })
      sources."delayed-stream-1.0.0"
      sources."delegates-1.0.0"
      sources."depd-1.1.2"
      sources."depnest-1.3.0"
      sources."des.js-1.0.0"
      sources."destroy-1.0.4"
      sources."detab-1.0.2"
      sources."detect-indent-4.0.0"
      sources."detect-libc-1.0.3"
      sources."detect-node-2.0.4"
      sources."dev-null-0.1.1"
      sources."diff-1.4.0"
      sources."diffie-hellman-5.0.3"
      (sources."dir-glob-2.0.0" // {
        dependencies = [
          sources."path-type-3.0.0"
          sources."pify-3.0.0"
        ];
      })
      sources."discontinuous-range-1.0.0"
      sources."dns-equal-1.0.0"
      sources."dns-packet-1.3.1"
      sources."dns-txt-2.0.2"
      sources."dom-converter-0.2.0"
      (sources."dom-serializer-0.1.0" // {
        dependencies = [
          sources."domelementtype-1.1.3"
        ];
      })
      sources."domain-browser-1.2.0"
      sources."domelementtype-1.3.1"
      sources."domhandler-2.1.0"
      sources."domutils-1.5.1"
      sources."dot-case-2.1.1"
      sources."duplexify-3.6.1"
      sources."dynamic-dijkstra-1.0.0"
      sources."ecc-jsbn-0.1.2"
      sources."ecstatic-3.3.0"
      sources."ed2curve-0.1.4"
      sources."ee-first-1.1.1"
      sources."ejs-2.5.7"
      sources."electron-chromedriver-1.8.0"
      sources."electron-context-menu-0.9.1"
      sources."electron-default-menu-1.0.1"
      sources."electron-dl-1.12.0"
      (sources."electron-download-4.1.1" // {
        dependencies = [
          sources."debug-3.2.6"
          sources."ms-2.1.1"
        ];
      })
      sources."electron-is-dev-0.1.2"
      sources."electron-to-chromium-1.3.95"
      sources."electron-window-state-4.1.1"
      sources."elegant-spinner-1.0.1"
      sources."elliptic-6.4.1"
      sources."emoji-named-characters-1.0.2"
      sources."emoji-server-1.0.0"
      sources."emojis-list-2.1.0"
      sources."encodeurl-1.0.2"
      sources."encoding-0.1.12"
      sources."encoding-down-4.0.1"
      sources."end-of-stream-1.4.1"
      sources."enhanced-resolve-3.4.1"
      sources."entities-1.1.2"
      sources."env-paths-1.0.0"
      sources."epidemic-broadcast-trees-6.3.5"
      sources."errno-0.1.7"
      sources."error-ex-1.3.2"
      sources."es-abstract-1.12.0"
      sources."es-to-primitive-1.2.0"
      sources."es2040-1.2.6"
      sources."es5-ext-0.10.46"
      sources."es6-iterator-2.0.3"
      sources."es6-map-0.1.5"
      sources."es6-set-0.1.5"
      sources."es6-symbol-3.1.1"
      sources."es6-weak-map-2.0.2"
      sources."escape-html-1.0.3"
      sources."escape-string-regexp-1.0.5"
      (sources."escodegen-1.11.0" // {
        dependencies = [
          sources."esprima-3.1.3"
          sources."source-map-0.6.1"
        ];
      })
      sources."escope-3.6.0"
      sources."eslint-scope-3.7.1"
      sources."eslint-visitor-keys-1.0.0"
      sources."esprima-2.7.3"
      sources."esrecurse-4.2.1"
      sources."estraverse-4.2.0"
      sources."esutils-2.0.2"
      sources."etag-1.8.1"
      sources."event-emitter-0.3.5"
      sources."eventemitter3-3.1.0"
      sources."events-1.1.1"
      sources."eventsource-0.1.6"
      sources."evp_bytestokey-1.0.3"
      sources."execa-0.5.1"
      sources."exit-hook-1.1.1"
      sources."expand-brackets-0.1.5"
      sources."expand-range-1.8.2"
      sources."expand-template-1.1.1"
      sources."explain-error-1.0.4"
      (sources."express-4.16.4" // {
        dependencies = [
          sources."array-flatten-1.1.1"
          sources."statuses-1.4.0"
        ];
      })
      sources."ext-list-2.2.2"
      sources."ext-name-5.0.0"
      sources."extend-3.0.2"
      (sources."extend-shallow-3.0.2" // {
        dependencies = [
          sources."is-extendable-1.0.1"
        ];
      })
      sources."extend.js-0.0.2"
      sources."external-editor-2.2.0"
      sources."extglob-0.3.2"
      sources."extract-text-webpack-plugin-3.0.2"
      sources."extract-zip-1.6.7"
      sources."extsprintf-1.3.0"
      sources."eyes-0.1.8"
      sources."fast-deep-equal-2.0.1"
      sources."fast-future-1.0.2"
      sources."fast-json-stable-stringify-2.0.0"
      sources."fast-levenshtein-2.0.6"
      sources."fastparse-1.1.2"
      sources."faye-websocket-0.10.0"
      sources."fd-slicer-1.0.1"
      sources."figures-2.0.0"
      (sources."file-loader-1.1.11" // {
        dependencies = [
          sources."schema-utils-0.4.7"
        ];
      })
      sources."file-saver-1.3.8"
      sources."file-uri-to-path-1.0.0"
      sources."filename-regex-2.0.1"
      sources."fill-range-2.2.4"
      (sources."finalhandler-1.1.1" // {
        dependencies = [
          sources."statuses-1.4.0"
        ];
      })
      sources."find-cache-dir-1.0.0"
      sources."find-up-2.1.0"
      sources."fix-path-2.1.0"
      sources."flatten-1.0.2"
      (sources."flumecodec-0.0.0" // {
        dependencies = [
          sources."level-codec-6.2.0"
        ];
      })
      (sources."flumedb-1.0.1" // {
        dependencies = [
          sources."pull-cont-0.0.0"
        ];
      })
      sources."flumelog-offset-3.3.2"
      sources."flumeview-hashtable-1.0.4"
      (sources."flumeview-level-3.0.6" // {
        dependencies = [
          sources."level-3.0.2"
          sources."obv-0.0.0"
        ];
      })
      sources."flumeview-query-6.3.0"
      (sources."flumeview-reduce-1.3.14" // {
        dependencies = [
          sources."obv-0.0.0"
        ];
      })
      sources."flumeview-search-1.0.6"
      sources."flush-write-stream-1.0.3"
      (sources."follow-redirects-1.5.10" // {
        dependencies = [
          sources."debug-3.1.0"
        ];
      })
      sources."for-each-0.3.3"
      sources."for-in-1.0.2"
      sources."for-own-0.1.5"
      sources."forever-agent-0.6.1"
      sources."forked-systray-3.0.10"
      sources."form-data-2.3.3"
      sources."forwarded-0.1.2"
      sources."fragment-cache-0.2.1"
      sources."fresh-0.5.2"
      sources."from2-2.3.0"
      sources."fs-constants-1.0.0"
      (sources."fs-extra-4.0.3" // {
        dependencies = [
          sources."jsonfile-4.0.0"
        ];
      })
      sources."fs-write-stream-atomic-1.0.10"
      sources."fs.realpath-1.0.0"
      sources."fsevents-1.2.4"
      sources."fstream-1.0.11"
      (sources."ftp-0.3.10" // {
        dependencies = [
          sources."isarray-0.0.1"
          sources."readable-stream-1.1.14"
          sources."string_decoder-0.10.31"
        ];
      })
      sources."function-bind-1.1.1"
      (sources."gauge-2.7.4" // {
        dependencies = [
          sources."is-fullwidth-code-point-1.0.0"
          sources."string-width-1.0.2"
        ];
      })
      sources."gaze-1.1.3"
      sources."generate-function-2.3.1"
      sources."generate-object-property-1.2.0"
      sources."get-caller-file-1.0.3"
      sources."get-func-name-2.0.0"
      sources."get-stdin-4.0.1"
      sources."get-stream-2.3.1"
      sources."get-uri-2.0.2"
      sources."get-value-2.0.6"
      sources."getpass-0.1.7"
      sources."github-from-package-0.0.0"
      sources."glob-7.1.3"
      sources."glob-base-0.3.0"
      sources."glob-parent-2.0.0"
      sources."globals-9.18.0"
      (sources."globby-4.1.0" // {
        dependencies = [
          sources."glob-6.0.4"
        ];
      })
      sources."globule-1.2.1"
      sources."gossip-query-0.2.3"
      sources."graceful-fs-4.1.15"
      sources."graceful-readlink-1.0.1"
      sources."grapheme-splitter-1.0.4"
      sources."graphlib-2.1.7"
      sources."graphreduce-3.0.4"
      sources."growl-1.9.2"
      sources."growly-1.3.0"
      sources."gunzip-maybe-1.4.1"
      sources."handle-thing-1.2.5"
      sources."har-schema-2.0.0"
      sources."har-validator-5.1.3"
      sources."has-1.0.3"
      sources."has-ansi-2.0.0"
      sources."has-flag-3.0.0"
      sources."has-network-0.0.1"
      sources."has-symbols-1.0.0"
      sources."has-unicode-2.0.1"
      (sources."has-value-1.0.0" // {
        dependencies = [
          sources."isobject-3.0.1"
        ];
      })
      (sources."has-values-1.0.0" // {
        dependencies = [
          (sources."is-number-3.0.0" // {
            dependencies = [
              sources."kind-of-3.2.2"
            ];
          })
          sources."kind-of-4.0.0"
        ];
      })
      sources."hash-base-3.0.4"
      sources."hash-sum-1.0.2"
      sources."hash.js-1.1.7"
      sources."hashlru-2.3.0"
      sources."he-1.2.0"
      sources."header-case-1.0.1"
      sources."heap-0.2.6"
      sources."highlight.js-9.13.1"
      sources."hmac-drbg-1.0.1"
      sources."home-or-tmp-2.0.0"
      sources."hoox-0.0.1"
      sources."hosted-git-info-2.7.1"
      sources."hpack.js-2.1.6"
      sources."html-comment-regex-1.1.2"
      sources."html-entities-1.2.1"
      (sources."html-minifier-3.5.21" // {
        dependencies = [
          sources."commander-2.17.1"
        ];
      })
      (sources."html-webpack-plugin-2.30.1" // {
        dependencies = [
          sources."loader-utils-0.2.17"
        ];
      })
      (sources."htmlparser2-3.3.0" // {
        dependencies = [
          sources."domutils-1.1.6"
          sources."isarray-0.0.1"
          sources."readable-stream-1.0.34"
          sources."string_decoder-0.10.31"
        ];
      })
      sources."http-deceiver-1.2.7"
      sources."http-errors-1.6.3"
      sources."http-parser-js-0.5.0"
      sources."http-proxy-1.17.0"
      sources."http-proxy-agent-1.0.0"
      (sources."http-proxy-middleware-0.17.4" // {
        dependencies = [
          sources."is-extglob-2.1.1"
          sources."is-glob-3.1.0"
        ];
      })
      sources."http-signature-1.2.0"
      sources."https-browserify-1.0.0"
      sources."https-proxy-agent-1.0.0"
      sources."i-0.3.6"
      sources."iconv-lite-0.4.24"
      sources."icss-replace-symbols-1.1.0"
      sources."icss-utils-2.1.0"
      sources."ieee754-1.1.12"
      sources."if-async-3.7.4"
      sources."iferr-0.1.5"
      sources."ignore-3.3.10"
      sources."import-local-1.0.0"
      sources."imurmurhash-0.1.4"
      sources."in-publish-2.0.0"
      sources."increment-buffer-1.0.1"
      sources."indent-string-2.1.0"
      sources."indexes-of-1.0.1"
      sources."indexof-0.0.1"
      sources."inflight-1.0.6"
      sources."inherits-2.0.3"
      sources."ini-1.3.5"
      sources."inject-loader-3.0.1"
      (sources."inquirer-3.0.6" // {
        dependencies = [
          sources."chalk-1.1.3"
        ];
      })
      sources."int53-0.2.4"
      sources."internal-ip-1.2.0"
      sources."interpret-1.1.0"
      sources."invariant-2.2.4"
      sources."invert-kv-1.0.0"
      sources."ip-1.1.5"
      sources."ipaddr.js-1.8.0"
      sources."irregular-plurals-1.4.0"
      sources."is-absolute-url-2.1.0"
      (sources."is-accessor-descriptor-1.0.0" // {
        dependencies = [
          sources."kind-of-6.0.2"
        ];
      })
      sources."is-alphabetical-1.0.2"
      sources."is-alphanumerical-1.0.2"
      sources."is-arrayish-0.2.1"
      sources."is-binary-path-1.0.1"
      sources."is-buffer-1.1.6"
      sources."is-builtin-module-1.0.0"
      sources."is-callable-1.1.4"
      sources."is-canonical-base64-1.1.1"
      (sources."is-data-descriptor-1.0.0" // {
        dependencies = [
          sources."kind-of-6.0.2"
        ];
      })
      sources."is-date-object-1.0.1"
      sources."is-decimal-1.0.2"
      sources."is-deflate-1.0.0"
      (sources."is-descriptor-1.0.2" // {
        dependencies = [
          sources."kind-of-6.0.2"
        ];
      })
      sources."is-directory-0.3.1"
      sources."is-dotfile-1.0.3"
      sources."is-electron-2.2.0"
      sources."is-equal-shallow-0.1.3"
      sources."is-extendable-0.1.1"
      sources."is-extglob-1.0.0"
      sources."is-finite-1.0.2"
      sources."is-fullwidth-code-point-2.0.0"
      sources."is-glob-2.0.1"
      sources."is-gzip-1.0.0"
      sources."is-hexadecimal-1.0.2"
      sources."is-lower-case-1.1.3"
      sources."is-my-ip-valid-1.0.0"
      sources."is-my-json-valid-2.19.0"
      sources."is-number-2.1.0"
      sources."is-path-cwd-1.0.0"
      sources."is-path-in-cwd-1.0.1"
      sources."is-path-inside-1.0.1"
      sources."is-plain-obj-1.1.0"
      (sources."is-plain-object-2.0.4" // {
        dependencies = [
          sources."isobject-3.0.1"
        ];
      })
      sources."is-posix-bracket-0.1.1"
      sources."is-primitive-2.0.0"
      sources."is-promise-2.1.0"
      sources."is-property-1.0.2"
      sources."is-regex-1.0.4"
      sources."is-stream-1.1.0"
      sources."is-svg-2.1.0"
      sources."is-symbol-1.0.2"
      sources."is-typedarray-1.0.0"
      sources."is-upper-case-1.1.2"
      sources."is-utf8-0.2.1"
      sources."is-valid-domain-0.0.6"
      sources."is-windows-1.0.2"
      sources."is-wsl-1.1.0"
      sources."isarray-1.0.0"
      sources."isexe-2.0.0"
      sources."isobject-2.1.0"
      sources."isstream-0.1.2"
      sources."istanbul-lib-coverage-1.2.1"
      sources."istanbul-lib-instrument-1.10.2"
      sources."jquery-3.3.1"
      sources."js-base64-2.5.0"
      sources."js-tokens-3.0.2"
      sources."js-yaml-3.7.0"
      sources."jsbn-0.1.1"
      sources."jsesc-1.3.0"
      sources."json-buffer-2.0.11"
      sources."json-loader-0.5.7"
      sources."json-schema-0.2.3"
      sources."json-schema-traverse-0.4.1"
      sources."json-stringify-safe-5.0.1"
      sources."json3-3.3.2"
      sources."json5-0.5.1"
      sources."jsonfile-2.4.0"
      sources."jsonpointer-4.0.1"
      sources."jsprim-1.4.1"
      sources."killable-1.0.1"
      sources."kind-of-3.2.2"
      sources."layered-graph-1.1.2"
      sources."lazy-cache-1.0.4"
      sources."lazystream-1.0.0"
      sources."lcid-1.0.0"
      (sources."level-4.0.0" // {
        dependencies = [
          sources."abstract-leveldown-5.0.0"
          sources."deferred-leveldown-4.0.2"
          sources."encoding-down-5.0.4"
          sources."level-codec-9.0.0"
          sources."level-errors-2.0.0"
          sources."level-iterator-stream-3.0.1"
          sources."level-packager-3.1.0"
          sources."leveldown-4.0.1"
          sources."levelup-3.1.1"
          sources."nan-2.10.0"
        ];
      })
      sources."level-codec-8.0.0"
      sources."level-errors-1.1.2"
      sources."level-iterator-stream-2.0.3"
      sources."level-packager-2.1.1"
      sources."level-post-1.0.7"
      (sources."level-sublevel-6.6.5" // {
        dependencies = [
          (sources."abstract-leveldown-0.12.4" // {
            dependencies = [
              sources."xtend-3.0.0"
            ];
          })
          sources."bl-0.8.2"
          sources."deferred-leveldown-0.2.0"
          sources."isarray-0.0.1"
          (sources."levelup-0.19.1" // {
            dependencies = [
              sources."xtend-3.0.0"
            ];
          })
          sources."ltgt-2.1.3"
          sources."prr-0.0.0"
          sources."readable-stream-1.0.34"
          sources."semver-5.1.1"
          sources."string_decoder-0.10.31"
        ];
      })
      (sources."leveldown-3.0.2" // {
        dependencies = [
          sources."nan-2.10.0"
        ];
      })
      sources."levelup-2.0.2"
      sources."levn-0.3.0"
      sources."libnested-1.4.1"
      sources."libsodium-0.7.3"
      sources."libsodium-wrappers-0.7.3"
      sources."load-json-file-1.1.0"
      sources."loader-runner-2.3.1"
      sources."loader-utils-1.1.0"
      sources."locate-path-2.0.0"
      sources."lodash-4.17.11"
      sources."lodash._arraycopy-3.0.0"
      sources."lodash._arrayeach-3.0.0"
      sources."lodash._baseassign-3.2.0"
      sources."lodash._baseclone-3.3.0"
      sources."lodash._basecopy-3.0.1"
      sources."lodash._basecreate-3.0.3"
      sources."lodash._basefor-3.0.3"
      sources."lodash._bindcallback-3.0.1"
      sources."lodash._createassigner-3.1.1"
      sources."lodash._getnative-3.9.1"
      sources."lodash._isiterateecall-3.0.9"
      sources."lodash._stack-4.1.3"
      sources."lodash.assign-4.2.0"
      sources."lodash.camelcase-4.3.0"
      sources."lodash.clone-3.0.3"
      sources."lodash.clonedeep-3.0.2"
      sources."lodash.create-3.1.1"
      sources."lodash.debounce-4.0.8"
      (sources."lodash.defaultsdeep-4.3.2" // {
        dependencies = [
          sources."lodash._baseclone-4.5.7"
          sources."lodash.keysin-4.2.0"
        ];
      })
      sources."lodash.get-4.4.2"
      sources."lodash.isarguments-3.1.0"
      sources."lodash.isarray-3.0.4"
      sources."lodash.isplainobject-4.0.6"
      sources."lodash.istypedarray-3.0.6"
      sources."lodash.keys-3.1.2"
      sources."lodash.keysin-3.0.8"
      sources."lodash.memoize-4.1.2"
      (sources."lodash.merge-3.3.2" // {
        dependencies = [
          sources."lodash.isplainobject-3.2.0"
        ];
      })
      sources."lodash.mergewith-4.6.1"
      sources."lodash.rest-4.0.5"
      sources."lodash.restparam-3.6.1"
      sources."lodash.some-4.6.0"
      sources."lodash.startcase-4.4.0"
      sources."lodash.tail-4.1.1"
      sources."lodash.toplainobject-3.0.0"
      sources."lodash.uniq-4.5.0"
      (sources."log-symbols-1.0.2" // {
        dependencies = [
          sources."chalk-1.1.3"
        ];
      })
      (sources."log-update-1.0.2" // {
        dependencies = [
          sources."cli-cursor-1.0.2"
          sources."onetime-1.1.0"
          sources."restore-cursor-1.0.1"
        ];
      })
      sources."loglevel-1.6.1"
      sources."longest-1.0.1"
      sources."longest-streak-1.0.0"
      sources."looper-4.0.0"
      sources."loose-envify-1.4.0"
      sources."lossy-store-1.2.3"
      sources."loud-rejection-1.6.0"
      sources."lower-case-1.1.4"
      sources."lower-case-first-1.0.2"
      sources."lru-cache-4.1.5"
      sources."ltgt-2.2.1"
      (sources."make-dir-1.3.0" // {
        dependencies = [
          sources."pify-3.0.0"
        ];
      })
      sources."map-cache-0.2.2"
      sources."map-filter-reduce-3.2.2"
      sources."map-merge-1.1.0"
      sources."map-obj-1.0.1"
      sources."map-visit-1.0.0"
      sources."markdown-table-0.4.0"
      sources."math-expression-evaluator-1.2.17"
      sources."math-random-1.0.1"
      sources."mathsass-0.10.1"
      sources."md5.js-1.3.5"
      sources."mdmanifest-1.0.8"
      sources."media-typer-0.3.0"
      sources."mem-1.1.0"
      sources."memory-fs-0.4.1"
      sources."meow-3.7.0"
      sources."merge-descriptors-1.0.1"
      sources."methods-1.1.2"
      sources."micromatch-2.3.11"
      sources."miller-rabin-4.0.1"
      sources."mime-1.6.0"
      sources."mime-db-1.37.0"
      sources."mime-types-2.1.21"
      sources."mimic-fn-1.2.0"
      sources."mimic-response-1.0.1"
      sources."minimalistic-assert-1.0.1"
      sources."minimalistic-crypto-utils-1.0.1"
      sources."minimatch-3.0.4"
      sources."minimist-1.2.0"
      sources."mississippi-2.0.0"
      (sources."mixin-deep-1.3.1" // {
        dependencies = [
          sources."is-extendable-1.0.1"
        ];
      })
      (sources."mixin-object-2.0.1" // {
        dependencies = [
          sources."for-in-0.1.8"
        ];
      })
      (sources."mkdirp-0.5.1" // {
        dependencies = [
          sources."minimist-0.0.8"
        ];
      })
      sources."mkpath-1.0.0"
      (sources."mocha-nightwatch-3.2.2" // {
        dependencies = [
          sources."commander-2.9.0"
          sources."debug-2.2.0"
          sources."glob-7.0.5"
          sources."has-flag-1.0.0"
          sources."ms-0.7.1"
          sources."supports-color-3.1.2"
        ];
      })
      sources."modify-filename-1.1.0"
      sources."monotonic-timestamp-0.0.9"
      sources."moo-0.4.3"
      sources."move-concurrently-1.0.1"
      sources."ms-2.0.0"
      (sources."multiblob-1.13.2" // {
        dependencies = [
          sources."pull-file-0.5.0"
          sources."rimraf-2.2.8"
        ];
      })
      sources."multiblob-http-0.4.2"
      sources."multicast-dns-6.2.3"
      sources."multicast-dns-service-types-1.1.0"
      sources."multicb-1.2.2"
      sources."multiserver-3.0.2"
      sources."multiserver-address-1.0.1"
      sources."multiserver-scopes-1.0.0"
      (sources."multispinner-0.2.1" // {
        dependencies = [
          sources."chalk-1.1.3"
          sources."figures-1.7.0"
          sources."kind-of-2.0.1"
        ];
      })
      sources."mutant-3.22.1"
      sources."mutant-pull-reduce-1.1.0"
      sources."mute-stream-0.0.7"
      sources."muxrpc-6.4.1"
      (sources."muxrpc-validation-2.0.1" // {
        dependencies = [
          sources."pull-stream-2.28.4"
        ];
      })
      (sources."muxrpcli-1.1.0" // {
        dependencies = [
          sources."pull-stream-2.28.4"
        ];
      })
      (sources."mv-2.1.1" // {
        dependencies = [
          sources."glob-6.0.4"
          sources."ncp-2.0.0"
          sources."rimraf-2.4.5"
        ];
      })
      sources."nan-2.12.1"
      (sources."nanomatch-1.2.13" // {
        dependencies = [
          sources."arr-diff-4.0.0"
          sources."array-unique-0.3.2"
          sources."kind-of-6.0.2"
        ];
      })
      sources."ncp-1.0.1"
      sources."nearley-2.15.1"
      sources."negotiator-0.6.1"
      sources."neo-async-2.6.0"
      sources."netmask-1.0.6"
      sources."next-tick-1.0.0"
      sources."nice-try-1.0.5"
      (sources."nightwatch-0.9.21" // {
        dependencies = [
          sources."minimatch-3.0.3"
          sources."q-1.4.1"
        ];
      })
      sources."no-case-2.3.2"
      sources."node-abi-2.5.0"
      sources."node-fetch-1.6.3"
      sources."node-forge-0.7.5"
      (sources."node-gyp-3.8.0" // {
        dependencies = [
          sources."semver-5.3.0"
        ];
      })
      sources."node-gyp-build-3.6.0"
      (sources."node-libs-browser-2.1.0" // {
        dependencies = [
          sources."browserify-zlib-0.2.0"
          sources."buffer-4.9.1"
          sources."pako-1.0.7"
          sources."punycode-1.4.1"
        ];
      })
      sources."node-loader-0.6.0"
      sources."node-notifier-5.3.0"
      (sources."node-sass-4.11.0" // {
        dependencies = [
          sources."chalk-1.1.3"
          sources."cross-spawn-3.0.1"
          sources."lodash.clonedeep-4.5.0"
        ];
      })
      (sources."nomnom-1.6.2" // {
        dependencies = [
          sources."colors-0.5.1"
        ];
      })
      sources."non-private-ip-1.4.4"
      sources."noop-logger-0.1.1"
      sources."nopt-3.0.6"
      sources."normalize-package-data-2.4.0"
      sources."normalize-path-2.1.1"
      sources."normalize-range-0.1.2"
      sources."normalize-uri-1.1.1"
      sources."normalize-url-1.9.1"
      sources."npm-install-package-2.1.0"
      sources."npm-prefix-1.2.0"
      sources."npm-run-path-2.0.2"
      sources."npmlog-4.1.2"
      sources."nth-check-1.0.2"
      sources."nugget-2.0.1"
      sources."num2fraction-1.2.2"
      sources."number-is-nan-1.0.1"
      sources."oauth-sign-0.9.0"
      sources."object-assign-4.1.1"
      (sources."object-copy-0.1.0" // {
        dependencies = [
          sources."define-property-0.2.5"
          sources."is-accessor-descriptor-0.1.6"
          sources."is-data-descriptor-0.1.4"
          (sources."is-descriptor-0.1.6" // {
            dependencies = [
              sources."kind-of-5.1.0"
            ];
          })
        ];
      })
      sources."object-inspect-1.6.0"
      sources."object-keys-1.0.12"
      (sources."object-visit-1.0.1" // {
        dependencies = [
          sources."isobject-3.0.1"
        ];
      })
      sources."object.omit-2.0.1"
      (sources."object.pick-1.3.0" // {
        dependencies = [
          sources."isobject-3.0.1"
        ];
      })
      sources."observ-0.2.0"
      sources."observ-debounce-1.1.1"
      sources."obuf-1.1.2"
      sources."obv-0.0.1"
      sources."on-change-network-0.0.2"
      sources."on-finished-2.3.0"
      sources."on-headers-1.0.1"
      sources."on-wakeup-1.0.1"
      sources."once-1.4.0"
      sources."onetime-2.0.1"
      sources."open-0.0.5"
      (sources."opencollective-1.0.3" // {
        dependencies = [
          sources."babel-polyfill-6.23.0"
          sources."chalk-1.1.3"
        ];
      })
      sources."opencollective-postinstall-2.0.1"
      sources."opn-4.0.2"
      (sources."optimist-0.6.1" // {
        dependencies = [
          sources."minimist-0.0.10"
        ];
      })
      (sources."optionator-0.8.2" // {
        dependencies = [
          sources."wordwrap-1.0.0"
        ];
      })
      sources."options-0.0.6"
      sources."original-1.0.2"
      sources."os-browserify-0.3.0"
      sources."os-homedir-1.0.2"
      sources."os-locale-1.4.0"
      sources."os-tmpdir-1.0.2"
      sources."osenv-0.1.5"
      sources."p-finally-1.0.0"
      sources."p-limit-1.3.0"
      sources."p-locate-2.0.0"
      sources."p-map-1.2.0"
      sources."p-try-1.0.0"
      sources."pac-proxy-agent-1.1.0"
      (sources."pac-resolver-2.0.0" // {
        dependencies = [
          sources."co-3.0.6"
          sources."ip-1.0.1"
        ];
      })
      sources."packet-stream-2.0.4"
      sources."packet-stream-codec-1.1.2"
      sources."pako-0.2.9"
      sources."parallel-transform-1.1.0"
      sources."param-case-2.1.1"
      sources."parse-asn1-5.1.1"
      sources."parse-entities-1.2.0"
      sources."parse-glob-3.0.4"
      sources."parse-json-2.2.0"
      sources."parseurl-1.3.2"
      sources."pascal-case-2.0.1"
      sources."pascalcase-0.1.1"
      sources."path-browserify-0.0.0"
      sources."path-case-2.1.1"
      sources."path-dirname-1.0.2"
      sources."path-exists-3.0.0"
      sources."path-is-absolute-1.0.1"
      sources."path-is-inside-1.0.2"
      sources."path-key-2.0.1"
      sources."path-parse-1.0.6"
      sources."path-to-regexp-0.1.7"
      sources."path-type-1.1.0"
      sources."pathval-1.1.0"
      (sources."pbkdf2-3.0.17" // {
        dependencies = [
          sources."sha.js-2.4.11"
        ];
      })
      sources."peek-stream-1.1.3"
      sources."pend-1.2.0"
      sources."performance-now-2.1.0"
      sources."pify-2.3.0"
      sources."pinkie-2.0.4"
      sources."pinkie-promise-2.0.1"
      sources."pkg-dir-2.0.0"
      sources."pkginfo-0.4.1"
      sources."plur-2.1.2"
      sources."popper.js-1.14.6"
      (sources."portfinder-1.0.20" // {
        dependencies = [
          sources."async-1.5.2"
        ];
      })
      sources."posix-character-classes-0.1.1"
      (sources."postcss-6.0.23" // {
        dependencies = [
          sources."source-map-0.6.1"
          sources."supports-color-5.5.0"
        ];
      })
      (sources."postcss-calc-5.3.1" // {
        dependencies = [
          (sources."chalk-1.1.3" // {
            dependencies = [
              sources."supports-color-2.0.0"
            ];
          })
          sources."has-flag-1.0.0"
          sources."postcss-5.2.18"
          sources."supports-color-3.2.3"
        ];
      })
      (sources."postcss-colormin-2.2.2" // {
        dependencies = [
          (sources."chalk-1.1.3" // {
            dependencies = [
              sources."supports-color-2.0.0"
            ];
          })
          sources."has-flag-1.0.0"
          sources."postcss-5.2.18"
          sources."supports-color-3.2.3"
        ];
      })
      (sources."postcss-convert-values-2.6.1" // {
        dependencies = [
          (sources."chalk-1.1.3" // {
            dependencies = [
              sources."supports-color-2.0.0"
            ];
          })
          sources."has-flag-1.0.0"
          sources."postcss-5.2.18"
          sources."supports-color-3.2.3"
        ];
      })
      (sources."postcss-discard-comments-2.0.4" // {
        dependencies = [
          (sources."chalk-1.1.3" // {
            dependencies = [
              sources."supports-color-2.0.0"
            ];
          })
          sources."has-flag-1.0.0"
          sources."postcss-5.2.18"
          sources."supports-color-3.2.3"
        ];
      })
      (sources."postcss-discard-duplicates-2.1.0" // {
        dependencies = [
          (sources."chalk-1.1.3" // {
            dependencies = [
              sources."supports-color-2.0.0"
            ];
          })
          sources."has-flag-1.0.0"
          sources."postcss-5.2.18"
          sources."supports-color-3.2.3"
        ];
      })
      (sources."postcss-discard-empty-2.1.0" // {
        dependencies = [
          (sources."chalk-1.1.3" // {
            dependencies = [
              sources."supports-color-2.0.0"
            ];
          })
          sources."has-flag-1.0.0"
          sources."postcss-5.2.18"
          sources."supports-color-3.2.3"
        ];
      })
      (sources."postcss-discard-overridden-0.1.1" // {
        dependencies = [
          (sources."chalk-1.1.3" // {
            dependencies = [
              sources."supports-color-2.0.0"
            ];
          })
          sources."has-flag-1.0.0"
          sources."postcss-5.2.18"
          sources."supports-color-3.2.3"
        ];
      })
      (sources."postcss-discard-unused-2.2.3" // {
        dependencies = [
          (sources."chalk-1.1.3" // {
            dependencies = [
              sources."supports-color-2.0.0"
            ];
          })
          sources."has-flag-1.0.0"
          sources."postcss-5.2.18"
          sources."supports-color-3.2.3"
        ];
      })
      (sources."postcss-filter-plugins-2.0.3" // {
        dependencies = [
          (sources."chalk-1.1.3" // {
            dependencies = [
              sources."supports-color-2.0.0"
            ];
          })
          sources."has-flag-1.0.0"
          sources."postcss-5.2.18"
          sources."supports-color-3.2.3"
        ];
      })
      sources."postcss-load-config-1.2.0"
      sources."postcss-load-options-1.2.0"
      sources."postcss-load-plugins-2.3.0"
      (sources."postcss-merge-idents-2.1.7" // {
        dependencies = [
          (sources."chalk-1.1.3" // {
            dependencies = [
              sources."supports-color-2.0.0"
            ];
          })
          sources."has-flag-1.0.0"
          sources."postcss-5.2.18"
          sources."supports-color-3.2.3"
        ];
      })
      (sources."postcss-merge-longhand-2.0.2" // {
        dependencies = [
          (sources."chalk-1.1.3" // {
            dependencies = [
              sources."supports-color-2.0.0"
            ];
          })
          sources."has-flag-1.0.0"
          sources."postcss-5.2.18"
          sources."supports-color-3.2.3"
        ];
      })
      (sources."postcss-merge-rules-2.1.2" // {
        dependencies = [
          sources."browserslist-1.7.7"
          (sources."chalk-1.1.3" // {
            dependencies = [
              sources."supports-color-2.0.0"
            ];
          })
          sources."has-flag-1.0.0"
          sources."postcss-5.2.18"
          sources."supports-color-3.2.3"
        ];
      })
      sources."postcss-message-helpers-2.0.0"
      (sources."postcss-minify-font-values-1.0.5" // {
        dependencies = [
          (sources."chalk-1.1.3" // {
            dependencies = [
              sources."supports-color-2.0.0"
            ];
          })
          sources."has-flag-1.0.0"
          sources."postcss-5.2.18"
          sources."supports-color-3.2.3"
        ];
      })
      (sources."postcss-minify-gradients-1.0.5" // {
        dependencies = [
          (sources."chalk-1.1.3" // {
            dependencies = [
              sources."supports-color-2.0.0"
            ];
          })
          sources."has-flag-1.0.0"
          sources."postcss-5.2.18"
          sources."supports-color-3.2.3"
        ];
      })
      (sources."postcss-minify-params-1.2.2" // {
        dependencies = [
          (sources."chalk-1.1.3" // {
            dependencies = [
              sources."supports-color-2.0.0"
            ];
          })
          sources."has-flag-1.0.0"
          sources."postcss-5.2.18"
          sources."supports-color-3.2.3"
        ];
      })
      (sources."postcss-minify-selectors-2.1.1" // {
        dependencies = [
          (sources."chalk-1.1.3" // {
            dependencies = [
              sources."supports-color-2.0.0"
            ];
          })
          sources."has-flag-1.0.0"
          sources."postcss-5.2.18"
          sources."supports-color-3.2.3"
        ];
      })
      sources."postcss-modules-extract-imports-1.2.1"
      sources."postcss-modules-local-by-default-1.2.0"
      sources."postcss-modules-scope-1.1.0"
      sources."postcss-modules-values-1.3.0"
      (sources."postcss-normalize-charset-1.1.1" // {
        dependencies = [
          (sources."chalk-1.1.3" // {
            dependencies = [
              sources."supports-color-2.0.0"
            ];
          })
          sources."has-flag-1.0.0"
          sources."postcss-5.2.18"
          sources."supports-color-3.2.3"
        ];
      })
      (sources."postcss-normalize-url-3.0.8" // {
        dependencies = [
          (sources."chalk-1.1.3" // {
            dependencies = [
              sources."supports-color-2.0.0"
            ];
          })
          sources."has-flag-1.0.0"
          sources."postcss-5.2.18"
          sources."supports-color-3.2.3"
        ];
      })
      (sources."postcss-ordered-values-2.2.3" // {
        dependencies = [
          (sources."chalk-1.1.3" // {
            dependencies = [
              sources."supports-color-2.0.0"
            ];
          })
          sources."has-flag-1.0.0"
          sources."postcss-5.2.18"
          sources."supports-color-3.2.3"
        ];
      })
      (sources."postcss-reduce-idents-2.4.0" // {
        dependencies = [
          (sources."chalk-1.1.3" // {
            dependencies = [
              sources."supports-color-2.0.0"
            ];
          })
          sources."has-flag-1.0.0"
          sources."postcss-5.2.18"
          sources."supports-color-3.2.3"
        ];
      })
      (sources."postcss-reduce-initial-1.0.1" // {
        dependencies = [
          (sources."chalk-1.1.3" // {
            dependencies = [
              sources."supports-color-2.0.0"
            ];
          })
          sources."has-flag-1.0.0"
          sources."postcss-5.2.18"
          sources."supports-color-3.2.3"
        ];
      })
      (sources."postcss-reduce-transforms-1.0.4" // {
        dependencies = [
          (sources."chalk-1.1.3" // {
            dependencies = [
              sources."supports-color-2.0.0"
            ];
          })
          sources."has-flag-1.0.0"
          sources."postcss-5.2.18"
          sources."supports-color-3.2.3"
        ];
      })
      sources."postcss-selector-parser-2.2.3"
      (sources."postcss-svgo-2.1.6" // {
        dependencies = [
          (sources."chalk-1.1.3" // {
            dependencies = [
              sources."supports-color-2.0.0"
            ];
          })
          sources."has-flag-1.0.0"
          sources."postcss-5.2.18"
          sources."supports-color-3.2.3"
        ];
      })
      (sources."postcss-unique-selectors-2.0.2" // {
        dependencies = [
          (sources."chalk-1.1.3" // {
            dependencies = [
              sources."supports-color-2.0.0"
            ];
          })
          sources."has-flag-1.0.0"
          sources."postcss-5.2.18"
          sources."supports-color-3.2.3"
        ];
      })
      sources."postcss-value-parser-3.3.1"
      (sources."postcss-zindex-2.2.0" // {
        dependencies = [
          (sources."chalk-1.1.3" // {
            dependencies = [
              sources."supports-color-2.0.0"
            ];
          })
          sources."has-flag-1.0.0"
          sources."postcss-5.2.18"
          sources."supports-color-3.2.3"
        ];
      })
      sources."prebuild-install-4.0.0"
      sources."prelude-ls-1.1.2"
      sources."prepend-http-1.0.4"
      sources."preserve-0.2.0"
      sources."prettier-1.15.3"
      sources."pretty-bytes-1.0.4"
      sources."pretty-error-2.1.1"
      sources."private-0.1.8"
      sources."private-box-0.3.0"
      sources."process-0.11.10"
      sources."process-nextick-args-2.0.0"
      sources."progress-2.0.3"
      (sources."progress-stream-1.2.0" // {
        dependencies = [
          sources."isarray-0.0.1"
          sources."object-keys-0.4.0"
          sources."readable-stream-1.1.14"
          sources."string_decoder-0.10.31"
          sources."through2-0.2.3"
          sources."xtend-2.1.2"
        ];
      })
      sources."promise-inflight-1.0.1"
      sources."prompt-1.0.0"
      sources."proxy-addr-2.0.4"
      (sources."proxy-agent-2.0.0" // {
        dependencies = [
          sources."lru-cache-2.6.5"
        ];
      })
      sources."prr-1.0.1"
      sources."pseudomap-1.0.2"
      sources."psl-1.1.31"
      sources."public-encrypt-4.0.3"
      sources."pull-abortable-4.1.1"
      sources."pull-box-stream-1.0.13"
      sources."pull-cat-1.1.11"
      sources."pull-catch-1.0.0"
      sources."pull-cont-0.1.1"
      sources."pull-core-1.1.0"
      sources."pull-cursor-3.0.0"
      sources."pull-defer-0.2.3"
      sources."pull-file-1.1.0"
      sources."pull-file-reader-1.0.2"
      sources."pull-flatmap-0.0.1"
      (sources."pull-fs-1.1.6" // {
        dependencies = [
          sources."pull-file-0.5.0"
        ];
      })
      sources."pull-glob-1.0.7"
      (sources."pull-goodbye-0.0.2" // {
        dependencies = [
          sources."pull-stream-3.5.0"
        ];
      })
      sources."pull-handshake-1.1.4"
      sources."pull-hash-1.0.0"
      (sources."pull-inactivity-2.1.3" // {
        dependencies = [
          sources."pull-abortable-4.0.0"
        ];
      })
      sources."pull-iterable-0.1.0"
      sources."pull-level-2.0.4"
      sources."pull-live-1.0.1"
      sources."pull-looper-1.0.0"
      sources."pull-many-1.0.8"
      sources."pull-ndjson-0.1.1"
      sources."pull-next-1.0.1"
      sources."pull-notify-0.1.1"
      sources."pull-pair-1.1.0"
      sources."pull-paramap-1.2.2"
      sources."pull-pause-0.0.0"
      sources."pull-ping-2.0.2"
      sources."pull-pushable-2.2.0"
      sources."pull-rate-1.0.2"
      sources."pull-reader-1.3.1"
      sources."pull-sink-through-0.0.0"
      sources."pull-sort-1.0.2"
      sources."pull-split-0.2.0"
      sources."pull-stream-3.6.9"
      sources."pull-stringify-1.2.2"
      (sources."pull-through-1.0.18" // {
        dependencies = [
          sources."looper-3.0.0"
        ];
      })
      sources."pull-traverse-1.0.3"
      sources."pull-utf8-decoder-1.0.2"
      (sources."pull-window-2.1.4" // {
        dependencies = [
          sources."looper-2.0.0"
        ];
      })
      sources."pull-write-1.1.4"
      sources."pull-write-file-0.2.4"
      sources."pull-ws-3.3.1"
      sources."pump-2.0.1"
      sources."pumpify-1.5.1"
      sources."punycode-2.1.1"
      sources."pupa-1.0.0"
      sources."push-stream-10.0.4"
      sources."push-stream-to-pull-stream-1.0.3"
      sources."q-1.5.1"
      sources."qs-6.5.2"
      sources."query-string-4.3.4"
      sources."querystring-0.2.0"
      sources."querystring-es3-0.2.1"
      sources."querystringify-2.1.0"
      sources."quick-lru-1.1.0"
      sources."railroad-diagrams-1.0.0"
      sources."randexp-0.4.6"
      (sources."randomatic-3.1.1" // {
        dependencies = [
          sources."is-number-4.0.0"
          sources."kind-of-6.0.2"
        ];
      })
      sources."randombytes-2.0.6"
      sources."randomfill-1.0.4"
      sources."range-parser-1.2.0"
      (sources."raw-body-2.3.3" // {
        dependencies = [
          sources."iconv-lite-0.4.23"
        ];
      })
      sources."rc-1.2.8"
      sources."read-1.0.7"
      sources."read-pkg-1.1.0"
      (sources."read-pkg-up-1.0.1" // {
        dependencies = [
          sources."find-up-1.1.2"
          sources."path-exists-2.1.0"
        ];
      })
      sources."readable-stream-2.3.6"
      (sources."readdirp-2.2.1" // {
        dependencies = [
          sources."arr-diff-4.0.0"
          sources."array-unique-0.3.2"
          (sources."braces-2.3.2" // {
            dependencies = [
              sources."extend-shallow-2.0.1"
            ];
          })
          (sources."expand-brackets-2.1.4" // {
            dependencies = [
              sources."define-property-0.2.5"
              sources."extend-shallow-2.0.1"
            ];
          })
          (sources."extglob-2.0.4" // {
            dependencies = [
              sources."define-property-1.0.0"
              sources."extend-shallow-2.0.1"
            ];
          })
          (sources."fill-range-4.0.0" // {
            dependencies = [
              sources."extend-shallow-2.0.1"
            ];
          })
          (sources."is-accessor-descriptor-0.1.6" // {
            dependencies = [
              sources."kind-of-3.2.2"
            ];
          })
          (sources."is-data-descriptor-0.1.4" // {
            dependencies = [
              sources."kind-of-3.2.2"
            ];
          })
          (sources."is-descriptor-0.1.6" // {
            dependencies = [
              sources."kind-of-5.1.0"
            ];
          })
          (sources."is-number-3.0.0" // {
            dependencies = [
              sources."kind-of-3.2.2"
            ];
          })
          sources."isobject-3.0.1"
          sources."kind-of-6.0.2"
          sources."micromatch-3.1.10"
        ];
      })
      sources."redent-1.0.0"
      (sources."reduce-css-calc-1.3.0" // {
        dependencies = [
          sources."balanced-match-0.4.2"
        ];
      })
      (sources."reduce-function-call-1.0.2" // {
        dependencies = [
          sources."balanced-match-0.4.2"
        ];
      })
      (sources."regedit-2.2.7" // {
        dependencies = [
          sources."isarray-0.0.1"
          sources."readable-stream-1.0.34"
          sources."string_decoder-0.10.31"
          sources."through2-0.6.5"
        ];
      })
      sources."regenerate-1.4.0"
      sources."regenerator-runtime-0.10.5"
      sources."regenerator-transform-0.10.1"
      sources."regex-cache-0.4.4"
      sources."regex-not-1.0.2"
      sources."regexpu-core-2.0.0"
      sources."regjsgen-0.2.0"
      (sources."regjsparser-0.1.5" // {
        dependencies = [
          sources."jsesc-0.5.0"
        ];
      })
      sources."relateurl-0.2.7"
      sources."relative-url-1.0.2"
      (sources."remark-3.2.3" // {
        dependencies = [
          sources."chalk-1.1.3"
          sources."glob-6.0.4"
          sources."he-0.5.0"
        ];
      })
      sources."remark-html-2.0.2"
      sources."remove-trailing-separator-1.1.0"
      sources."renderkid-2.0.2"
      sources."repeat-element-1.1.3"
      sources."repeat-string-1.6.1"
      sources."repeating-2.0.1"
      sources."request-2.88.0"
      sources."require-dir-1.2.0"
      sources."require-directory-2.1.1"
      sources."require-from-string-1.2.1"
      sources."require-main-filename-1.0.1"
      sources."requires-port-1.0.0"
      sources."resolve-1.7.1"
      sources."resolve-cwd-2.0.0"
      sources."resolve-from-3.0.0"
      sources."resolve-url-0.2.1"
      sources."restore-cursor-2.0.0"
      sources."resumer-0.0.0"
      sources."ret-0.1.15"
      sources."revalidator-0.1.8"
      sources."rgb2hex-0.1.9"
      sources."right-align-0.1.3"
      sources."rimraf-2.6.2"
      sources."ripemd160-2.0.2"
      sources."run-async-2.3.0"
      sources."run-queue-1.0.3"
      sources."rw-1.3.3"
      sources."rx-4.1.0"
      sources."rx-lite-4.0.8"
      sources."rx-lite-aggregates-4.0.8"
      sources."safe-buffer-5.1.2"
      sources."safe-regex-1.1.0"
      sources."safer-buffer-2.1.2"
      sources."sass-graph-2.2.4"
      (sources."sass-loader-6.0.7" // {
        dependencies = [
          sources."pify-3.0.0"
        ];
      })
      sources."sax-1.2.4"
      (sources."schema-utils-0.3.0" // {
        dependencies = [
          sources."ajv-5.5.2"
          sources."co-4.6.0"
          sources."fast-deep-equal-1.1.0"
          sources."json-schema-traverse-0.3.1"
        ];
      })
      (sources."scss-tokenizer-0.2.3" // {
        dependencies = [
          sources."source-map-0.4.4"
        ];
      })
      sources."scuttle-shell-0.1.3"
      sources."scuttle-tag-0.3.0"
      (sources."scuttlebot-13.2.2" // {
        dependencies = [
          sources."cross-spawn-6.0.5"
          sources."pull-stringify-2.0.0"
          sources."ssb-ws-5.1.1"
        ];
      })
      sources."secret-handshake-1.1.14"
      (sources."secret-stack-5.0.0" // {
        dependencies = [
          sources."debug-4.1.0"
          sources."ms-2.1.1"
        ];
      })
      sources."select-hose-2.0.0"
      sources."selfsigned-1.10.4"
      sources."semver-5.6.0"
      (sources."send-0.16.2" // {
        dependencies = [
          sources."mime-1.4.1"
          sources."statuses-1.4.0"
        ];
      })
      sources."sentence-case-2.1.1"
      sources."separator-escape-0.0.0"
      sources."serialize-javascript-1.5.0"
      sources."serve-index-1.9.1"
      sources."serve-static-1.13.2"
      sources."set-blocking-2.0.0"
      (sources."set-value-2.0.0" // {
        dependencies = [
          sources."extend-shallow-2.0.1"
        ];
      })
      sources."setimmediate-1.0.5"
      sources."setprototypeof-1.1.0"
      sources."sha.js-2.4.5"
      (sources."shallow-clone-1.0.0" // {
        dependencies = [
          sources."kind-of-5.1.0"
        ];
      })
      sources."shebang-command-1.2.0"
      sources."shebang-regex-1.0.0"
      sources."shell-env-0.3.0"
      sources."shell-path-2.1.0"
      sources."shellsubstitute-1.2.0"
      sources."shellwords-0.1.1"
      sources."shvl-1.3.1"
      sources."signal-exit-3.0.2"
      sources."simple-concat-1.0.0"
      sources."simple-get-2.8.1"
      (sources."single-line-log-1.1.2" // {
        dependencies = [
          sources."is-fullwidth-code-point-1.0.0"
          sources."string-width-1.0.2"
        ];
      })
      sources."slash-1.0.0"
      sources."smart-buffer-4.0.1"
      sources."snake-case-2.1.0"
      (sources."snapdragon-0.8.2" // {
        dependencies = [
          sources."define-property-0.2.5"
          sources."extend-shallow-2.0.1"
          (sources."is-accessor-descriptor-0.1.6" // {
            dependencies = [
              sources."kind-of-3.2.2"
            ];
          })
          (sources."is-data-descriptor-0.1.4" // {
            dependencies = [
              sources."kind-of-3.2.2"
            ];
          })
          sources."is-descriptor-0.1.6"
          sources."kind-of-5.1.0"
        ];
      })
      (sources."snapdragon-node-2.1.1" // {
        dependencies = [
          sources."define-property-1.0.0"
          sources."isobject-3.0.1"
        ];
      })
      sources."snapdragon-util-3.0.1"
      sources."sockjs-0.3.19"
      (sources."sockjs-client-1.1.5" // {
        dependencies = [
          sources."faye-websocket-0.11.1"
        ];
      })
      sources."socks-2.2.1"
      (sources."socks-proxy-agent-2.1.1" // {
        dependencies = [
          sources."smart-buffer-1.1.15"
          sources."socks-1.1.10"
        ];
      })
      sources."sodium-browserify-1.2.4"
      (sources."sodium-browserify-tweetnacl-0.2.3" // {
        dependencies = [
          sources."sha.js-2.4.11"
        ];
      })
      sources."sodium-chloride-1.1.2"
      sources."sodium-native-2.2.3"
      sources."sort-keys-1.1.2"
      sources."sort-keys-length-1.0.1"
      sources."source-list-map-2.0.1"
      sources."source-map-0.5.7"
      sources."source-map-resolve-0.5.2"
      sources."source-map-support-0.4.18"
      sources."source-map-url-0.4.0"
      sources."spdx-correct-3.1.0"
      sources."spdx-exceptions-2.2.0"
      sources."spdx-expression-parse-3.0.0"
      sources."spdx-license-ids-3.0.2"
      sources."spdy-3.4.7"
      sources."spdy-transport-2.1.1"
      sources."spectron-3.8.0"
      sources."speedometer-0.1.4"
      sources."split-1.0.1"
      sources."split-buffer-1.0.0"
      sources."split-string-3.1.0"
      sources."sprintf-js-1.0.3"
      sources."ssb-about-2.0.0"
      sources."ssb-backlinks-0.7.3"
      sources."ssb-blobs-1.1.7"
      sources."ssb-chess-db-1.0.5"
      (sources."ssb-client-4.6.0" // {
        dependencies = [
          sources."multiserver-1.13.7"
        ];
      })
      sources."ssb-config-2.3.7"
      sources."ssb-db-18.6.2"
      sources."ssb-ebt-5.2.7"
      sources."ssb-friends-3.1.7"
      sources."ssb-keys-7.1.3"
      (sources."ssb-links-3.0.3" // {
        dependencies = [
          sources."map-filter-reduce-2.2.1"
        ];
      })
      sources."ssb-marked-0.7.4"
      sources."ssb-meme-1.0.4"
      sources."ssb-msg-content-1.0.1"
      sources."ssb-msgs-5.2.0"
      sources."ssb-names-3.1.4"
      (sources."ssb-ooo-1.1.0" // {
        dependencies = [
          sources."flumecodec-0.0.1"
          sources."level-codec-6.2.0"
        ];
      })
      sources."ssb-private-0.2.3"
      (sources."ssb-query-2.3.0" // {
        dependencies = [
          sources."flumeview-query-7.1.1"
        ];
      })
      sources."ssb-ref-2.13.9"
      sources."ssb-search-1.1.2"
      sources."ssb-sort-1.1.3"
      sources."ssb-tags-0.2.0"
      sources."ssb-talequery-2.0.1"
      (sources."ssb-threads-3.2.1" // {
        dependencies = [
          sources."abstract-leveldown-5.0.0"
          sources."encoding-down-5.0.4"
          sources."level-codec-9.0.0"
          sources."level-errors-2.0.0"
        ];
      })
      sources."ssb-typescript-1.3.0"
      sources."ssb-unread-1.0.2"
      sources."ssb-validate-4.0.4"
      sources."ssb-web-resolver-1.1.2"
      (sources."ssb-ws-2.1.1" // {
        dependencies = [
          sources."multiserver-1.13.7"
        ];
      })
      sources."sshpk-1.15.2"
      sources."ssri-5.3.0"
      sources."stack-0.1.0"
      sources."stack-trace-0.0.10"
      (sources."static-extend-0.1.2" // {
        dependencies = [
          sources."define-property-0.2.5"
          (sources."is-accessor-descriptor-0.1.6" // {
            dependencies = [
              sources."kind-of-3.2.2"
            ];
          })
          (sources."is-data-descriptor-0.1.4" // {
            dependencies = [
              sources."kind-of-3.2.2"
            ];
          })
          sources."is-descriptor-0.1.6"
          sources."kind-of-5.1.0"
        ];
      })
      sources."statistics-3.3.0"
      sources."statuses-1.5.0"
      sources."stdout-stream-1.4.1"
      sources."stream-browserify-2.0.1"
      sources."stream-each-1.2.3"
      sources."stream-http-2.8.3"
      sources."stream-progressbar-1.1.1"
      sources."stream-shift-1.0.0"
      sources."stream-slicer-0.0.6"
      (sources."stream-to-pull-stream-1.7.2" // {
        dependencies = [
          sources."looper-3.0.0"
        ];
      })
      sources."strict-uri-encode-1.1.0"
      (sources."string-width-2.1.1" // {
        dependencies = [
          sources."ansi-regex-3.0.0"
          sources."strip-ansi-4.0.0"
        ];
      })
      sources."string.prototype.trim-1.1.2"
      sources."string_decoder-1.1.1"
      sources."stringify-entities-1.3.2"
      sources."strip-ansi-3.0.1"
      sources."strip-bom-2.0.0"
      sources."strip-eof-1.0.0"
      sources."strip-indent-1.0.1"
      sources."strip-json-comments-2.0.1"
      (sources."style-loader-0.20.3" // {
        dependencies = [
          sources."schema-utils-0.4.7"
        ];
      })
      sources."sumchecker-2.0.2"
      sources."supports-color-2.0.0"
      (sources."svgo-0.7.2" // {
        dependencies = [
          sources."colors-1.1.2"
        ];
      })
      sources."swap-case-1.1.2"
      sources."tapable-0.2.9"
      sources."tape-4.9.1"
      sources."tar-2.2.1"
      (sources."tar-fs-1.16.3" // {
        dependencies = [
          sources."pump-1.0.3"
        ];
      })
      sources."tar-stream-1.6.2"
      sources."test-exclude-4.2.3"
      sources."text-table-0.2.0"
      sources."throttleit-0.0.2"
      sources."through-2.3.8"
      sources."through2-2.0.5"
      sources."thunkify-2.1.2"
      sources."thunky-1.0.3"
      sources."time-stamp-2.2.0"
      sources."timers-browserify-2.0.10"
      sources."title-case-2.1.1"
      sources."tmp-0.0.33"
      sources."to-arraybuffer-1.0.1"
      sources."to-buffer-1.1.1"
      sources."to-camel-case-1.0.0"
      sources."to-fast-properties-1.0.3"
      sources."to-no-case-1.0.2"
      sources."to-object-path-0.3.0"
      sources."to-regex-3.0.2"
      (sources."to-regex-range-2.1.1" // {
        dependencies = [
          sources."is-number-3.0.0"
        ];
      })
      sources."to-space-case-1.0.0"
      sources."to-vfile-1.0.0"
      sources."toposort-1.0.7"
      (sources."tough-cookie-2.4.3" // {
        dependencies = [
          sources."punycode-1.4.1"
        ];
      })
      sources."trim-0.0.1"
      sources."trim-lines-1.1.1"
      sources."trim-newlines-1.0.0"
      sources."trim-right-1.0.1"
      sources."trim-trailing-lines-1.1.1"
      sources."true-case-path-1.0.3"
      sources."tty-browserify-0.0.0"
      sources."tunnel-agent-0.6.0"
      sources."tweetnacl-0.14.5"
      sources."tweetnacl-auth-0.3.1"
      sources."type-check-0.3.2"
      sources."type-detect-4.0.8"
      sources."type-is-1.6.16"
      sources."typedarray-0.0.6"
      sources."typedarray-to-buffer-3.1.5"
      sources."typewise-1.0.3"
      sources."typewise-core-1.2.0"
      sources."typewiselite-1.0.0"
      (sources."uglify-js-3.4.9" // {
        dependencies = [
          sources."commander-2.17.1"
          sources."source-map-0.6.1"
        ];
      })
      sources."uglify-to-browserify-1.0.2"
      (sources."uglifyjs-webpack-plugin-0.4.6" // {
        dependencies = [
          sources."camelcase-1.2.1"
          sources."cliui-2.1.0"
          sources."uglify-js-2.8.29"
          sources."window-size-0.1.0"
          sources."wordwrap-0.0.2"
          sources."yargs-3.10.0"
        ];
      })
      sources."uint48be-1.0.2"
      sources."ultron-1.0.2"
      sources."underscore-1.4.4"
      sources."unherit-1.1.1"
      sources."unified-2.1.4"
      (sources."union-value-1.0.0" // {
        dependencies = [
          sources."extend-shallow-2.0.1"
          sources."set-value-0.4.3"
        ];
      })
      sources."uniq-1.0.1"
      sources."uniqs-2.0.0"
      sources."unique-filename-1.1.1"
      sources."unique-slug-2.0.1"
      sources."unist-util-is-2.1.2"
      sources."unist-util-visit-1.4.0"
      sources."unist-util-visit-parents-2.0.1"
      sources."universalify-0.1.2"
      sources."unpipe-1.0.0"
      (sources."unset-value-1.0.0" // {
        dependencies = [
          (sources."has-value-0.3.1" // {
            dependencies = [
              sources."isobject-2.1.0"
            ];
          })
          sources."has-values-0.1.4"
          sources."isobject-3.0.1"
        ];
      })
      sources."untildify-2.1.0"
      sources."unused-filename-1.0.0"
      sources."upath-1.1.0"
      sources."upper-case-1.1.3"
      sources."upper-case-first-1.1.2"
      sources."uri-js-4.2.2"
      sources."urix-0.1.0"
      (sources."url-0.11.0" // {
        dependencies = [
          sources."punycode-1.3.2"
        ];
      })
      sources."url-join-2.0.5"
      sources."url-loader-0.6.2"
      sources."url-parse-1.4.4"
      sources."use-3.1.1"
      sources."user-home-2.0.0"
      sources."util-0.10.4"
      sources."util-deprecate-1.0.2"
      sources."utila-0.4.0"
      (sources."utile-0.3.0" // {
        dependencies = [
          sources."async-0.9.2"
          sources."deep-equal-0.2.2"
        ];
      })
      sources."utils-merge-1.0.1"
      sources."uuid-3.3.2"
      sources."validate-npm-package-license-3.0.4"
      sources."vary-1.1.2"
      sources."vee-validate-2.1.4"
      sources."vendors-1.0.2"
      sources."verror-1.10.0"
      sources."vfile-1.4.0"
      sources."vfile-find-down-1.0.0"
      sources."vfile-find-up-1.0.0"
      (sources."vfile-reporter-1.5.0" // {
        dependencies = [
          sources."chalk-1.1.3"
          sources."is-fullwidth-code-point-1.0.0"
          sources."string-width-1.0.2"
        ];
      })
      sources."vfile-sort-1.0.0"
      sources."vm-browserify-0.0.4"
      sources."vue-2.5.21"
      sources."vue-add-globals-2.0.1"
      sources."vue-electron-1.0.6"
      sources."vue-functional-data-merge-2.0.7"
      sources."vue-hot-reload-api-2.3.1"
      sources."vue-i18n-7.8.1"
      (sources."vue-loader-14.2.3" // {
        dependencies = [
          sources."source-map-0.6.1"
          sources."vue-style-loader-4.1.2"
        ];
      })
      sources."vue-router-3.0.2"
      sources."vue-slider-component-2.8.3"
      sources."vue-style-loader-3.1.2"
      sources."vue-template-compiler-2.5.21"
      sources."vue-template-es2015-compiler-1.6.0"
      sources."vuex-3.0.1"
      sources."vuex-persistedstate-2.5.4"
      sources."ware-1.3.0"
      (sources."watchpack-1.6.0" // {
        dependencies = [
          sources."anymatch-2.0.0"
          sources."arr-diff-4.0.0"
          sources."array-unique-0.3.2"
          sources."braces-2.3.2"
          sources."chokidar-2.0.4"
          sources."define-property-1.0.0"
          (sources."expand-brackets-2.1.4" // {
            dependencies = [
              sources."define-property-0.2.5"
            ];
          })
          sources."extend-shallow-2.0.1"
          sources."extglob-2.0.4"
          sources."fill-range-4.0.0"
          (sources."glob-parent-3.1.0" // {
            dependencies = [
              sources."is-glob-3.1.0"
            ];
          })
          (sources."is-accessor-descriptor-0.1.6" // {
            dependencies = [
              sources."kind-of-3.2.2"
            ];
          })
          (sources."is-data-descriptor-0.1.4" // {
            dependencies = [
              sources."kind-of-3.2.2"
            ];
          })
          (sources."is-descriptor-0.1.6" // {
            dependencies = [
              sources."kind-of-5.1.0"
            ];
          })
          sources."is-extglob-2.1.1"
          sources."is-glob-4.0.0"
          (sources."is-number-3.0.0" // {
            dependencies = [
              sources."kind-of-3.2.2"
            ];
          })
          sources."isobject-3.0.1"
          sources."kind-of-6.0.2"
          sources."micromatch-3.1.10"
        ];
      })
      sources."wbuf-1.7.3"
      sources."wdio-dot-reporter-0.0.10"
      (sources."webdriverio-4.14.1" // {
        dependencies = [
          sources."ansi-escapes-3.1.0"
          sources."ansi-regex-3.0.0"
          sources."deepmerge-2.0.1"
          sources."has-flag-2.0.0"
          sources."inquirer-3.3.0"
          sources."strip-ansi-4.0.0"
          sources."supports-color-5.0.1"
        ];
      })
      (sources."webpack-3.12.0" // {
        dependencies = [
          sources."camelcase-4.1.0"
          sources."cross-spawn-5.1.0"
          sources."execa-0.7.0"
          sources."get-stream-3.0.0"
          sources."has-flag-2.0.0"
          sources."load-json-file-2.0.0"
          sources."os-locale-2.1.0"
          sources."path-type-2.0.0"
          sources."read-pkg-2.0.0"
          sources."read-pkg-up-2.0.0"
          sources."strip-bom-3.0.0"
          sources."supports-color-4.5.0"
          sources."which-module-2.0.0"
          sources."y18n-3.2.1"
          sources."yargs-8.0.2"
          sources."yargs-parser-7.0.0"
        ];
      })
      sources."webpack-dev-middleware-1.12.2"
      (sources."webpack-dev-server-2.11.3" // {
        dependencies = [
          sources."anymatch-2.0.0"
          sources."arr-diff-4.0.0"
          sources."array-unique-0.3.2"
          sources."braces-2.3.2"
          sources."camelcase-3.0.0"
          sources."chokidar-2.0.4"
          sources."debug-3.2.6"
          sources."define-property-1.0.0"
          (sources."expand-brackets-2.1.4" // {
            dependencies = [
              sources."debug-2.6.9"
              sources."define-property-0.2.5"
            ];
          })
          sources."extend-shallow-2.0.1"
          sources."extglob-2.0.4"
          sources."fill-range-4.0.0"
          (sources."glob-parent-3.1.0" // {
            dependencies = [
              sources."is-glob-3.1.0"
            ];
          })
          (sources."is-accessor-descriptor-0.1.6" // {
            dependencies = [
              sources."kind-of-3.2.2"
            ];
          })
          (sources."is-data-descriptor-0.1.4" // {
            dependencies = [
              sources."kind-of-3.2.2"
            ];
          })
          (sources."is-descriptor-0.1.6" // {
            dependencies = [
              sources."kind-of-5.1.0"
            ];
          })
          sources."is-extglob-2.1.1"
          sources."is-fullwidth-code-point-1.0.0"
          sources."is-glob-4.0.0"
          (sources."is-number-3.0.0" // {
            dependencies = [
              sources."kind-of-3.2.2"
            ];
          })
          sources."isobject-3.0.1"
          sources."kind-of-6.0.2"
          sources."micromatch-3.1.10"
          sources."ms-2.1.1"
          sources."opn-5.4.0"
          sources."string-width-1.0.2"
          sources."supports-color-5.5.0"
          sources."y18n-3.2.1"
          sources."yargs-6.6.0"
          sources."yargs-parser-4.2.1"
        ];
      })
      sources."webpack-hot-middleware-2.24.3"
      sources."webpack-merge-4.1.5"
      (sources."webpack-sources-1.3.0" // {
        dependencies = [
          sources."source-map-0.6.1"
        ];
      })
      sources."websocket-driver-0.7.0"
      sources."websocket-extensions-0.1.3"
      sources."wgxpath-1.0.0"
      sources."whet.extend-0.9.9"
      sources."which-1.3.1"
      sources."which-module-1.0.0"
      sources."which-pm-runs-1.0.0"
      sources."wide-align-1.1.3"
      (sources."window-size-1.1.1" // {
        dependencies = [
          sources."define-property-1.0.0"
          sources."is-number-3.0.0"
        ];
      })
      (sources."winston-2.1.1" // {
        dependencies = [
          sources."async-1.0.0"
          sources."colors-1.0.3"
          sources."pkginfo-0.3.1"
        ];
      })
      sources."word-wrap-1.2.3"
      sources."wordwrap-0.0.3"
      (sources."wrap-ansi-2.1.0" // {
        dependencies = [
          sources."is-fullwidth-code-point-1.0.0"
          sources."string-width-1.0.2"
        ];
      })
      sources."wrap-fn-0.1.5"
      sources."wrappy-1.0.2"
      sources."ws-1.1.5"
      sources."xregexp-2.0.0"
      sources."xtend-4.0.1"
      sources."y18n-4.0.0"
      sources."yallist-2.1.2"
      (sources."yargs-7.1.0" // {
        dependencies = [
          sources."camelcase-3.0.0"
          sources."is-fullwidth-code-point-1.0.0"
          sources."string-width-1.0.2"
          sources."y18n-3.2.1"
        ];
      })
      (sources."yargs-parser-5.0.0" // {
        dependencies = [
          sources."camelcase-3.0.0"
        ];
      })
      sources."yauzl-2.4.1"
      sources."zerr-1.0.4"
      sources."zip-stream-1.2.0"
    ];
    buildInputs = globalBuildInputs;
    inherit propagatedBuildInputs;
    meta = {
      description = "tale:net - intergalactic skill & idea sharing community";
      homepage = https://blog.t4l3.net/;
    };
    production = true;
    bypassCache = true;
    reconstructLock = true;
  };
in
{
  tarball = nodeEnv.buildNodeSourceDist args;
  package = nodeEnv.buildNodePackage args;
  shell = nodeEnv.buildNodeShell args;
}