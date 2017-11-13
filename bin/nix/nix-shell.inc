function run() {
    exec nix-shell "$DIR/../../shell.nix" <<<"source $DIR/../../.ssb_config; $@"
}
