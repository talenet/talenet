with import <nixpkgs> {};
with pkgs;

let taleEnv = buildEnv {
  name = "TALEenv";
  paths = [
    stdenv.cc.cc.lib zlib glib dbus.lib gnome2.gtk atk pango.out freetype libgnome_keyring3
    fontconfig.lib gdk_pixbuf cairo cups expat libgpgerror alsaLib nspr gnome3.gconf nss
    xorg.libXrender xorg.libX11 xorg.libXext xorg.libXdamage xorg.libXtst
    xorg.libXcomposite xorg.libXi xorg.libXfixes xorg.libXrandr
    xorg.libXcursor libcap systemd libnotify udev udev.lib bzip2 readline xorg.libxcb
    xorg.libXScrnSaver fuse
  ];
}; in

(pkgs.buildFHSUserEnv {
  name = "TALEnet";

  targetPkgs = pkgs: (with pkgs; [
    nodejs
    xvfb_run
    unzip
    taleEnv
  ]);

  extraBuildCommands = ''
    (cd usr/lib64 && ln -sv libbz2.so.1.0.* libbz2.so.1.0)
  '';

  profile = ''
    export npm_config_cache="/tmp/talenet-npm-cache/"
    export ELECTRON_CACHE="/tmp/talenet-electron-cache/"
  '';
}).env

