with import ~/nixpkgs {};
with pkgs;

let taleEnv = buildEnv {
  name = "TALEenv";
  paths = [
    alsaLib
    atk
    at-spi2-atk
    binutils
    bzip2
    cairo
    cups
    dbus.lib
    expat
    fontconfig
    freetype
    fuse
    gcc
    gdk_pixbuf
    glib
    glibc
    gtk3-x11
    gnumake
    libcap
    libgnome_keyring3
    libgpgerror
    libnotify
    libsodium
    libappindicator-gtk3
    nspr
    nss
    pango
    python
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
    nodejs-10_x
    xvfb_run
    git
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

