with import <nixpkgs> {};
with pkgs;

stdenv.mkDerivation rec {
  name = "TALEnet";
  version = "dev";

  buildInputs = [
    nodejs
  ];
}

