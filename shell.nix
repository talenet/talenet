with import <nixpkgs> {};
with pkgs;

let taleEnv = buildEnv {
  name = "TALEenv";
  paths = [
    alsaLib
    atk
    binutils
    bzip2
    cairo
    cups
    dbus.lib
    expat
    firefox
    fontconfig
    freetype
    fuse
    gcc
    gdk_pixbuf
    glib
    glibc
    gnome2.gtk
    gnome3.gconf
    gnumake
    libcap
    libgnome_keyring3
    libgpgerror
    libnotify
    libsodium
    nspr
    nss
    pango
    readline
    systemd
    udev
    xdg_utils
    xorg.libX11
    xorg.libXScrnSaver
    xorg.libXcomposite
    xorg.libXcursor
    xorg.libXdamage
    xorg.libXext
    xorg.libXfixes
    xorg.libXi
    xorg.libXrandr
    xorg.libXrender
    xorg.libXtst
    xorg.libxcb
    zlib
  ];
  extraOutputsToInstall = [ "lib" "dev" "out" ];
}; in

(pkgs.buildFHSUserEnv {
  name = "TALEnet";

  targetPkgs = pkgs: (with pkgs; [
    nodejs-8_x
    xvfb_run
    unzip
    taleEnv
  ]);

  extraOutputsToInstall = [ "lib" "dev" "out" ];

  extraBuildCommands = ''
    (cd usr/lib64 && ln -sv libbz2.so.1.0.* libbz2.so.1.0)
  '';

  profile = ''
    export npm_config_cache="/tmp/talenet-npm-cache/"
    export npm_config_devdir="/tmp/talenet-gyp/"
    export ELECTRON_CACHE="/tmp/talenet-electron-cache/"

    export CFLAGS="$NIX_CFLAGS_COMPILE"
    export CXXFLAGS="$NIX_CFLAGS_COMPILE"
    export LDFLAGS="$NIX_LDFLAGS_BEFORE"
  '';
}).env

