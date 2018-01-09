function run() {
    exec nix-shell "$DIR/../../shell.nix" <<<"source $DIR/../../.ssb_config; export DEV_TOOLS=$DEV_TOOLS; $@"
}

function runWithoutAppName() {
    exec nix-shell "$DIR/../../shell.nix" <<<"export DEV_TOOLS=$DEV_TOOLS; $@"
}

