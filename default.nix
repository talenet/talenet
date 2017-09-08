with import <nixpkgs> {};
with pkgs;

stdenv.mkDerivation rec {
  name = "TALEnet";
  version = "dev";

  buildInputs = [
    nodejs
    phantomjs
  ];

  shellHook = ''
    echo
    echo "========================"
    echo "Setting up node modules."
    echo "========================"
    echo

    npm install

    echo
    echo "================="
    echo "Fixing phantomjs."
    echo "================="
    echo

    rm -f node_modules/phantomjs-prebuilt/lib/phantom/bin/phantomjs
    ln -s ${phantomjs}/bin/phantomjs node_modules/phantomjs-prebuilt/lib/phantom/bin/phantomjs

    echo
  '';
}

