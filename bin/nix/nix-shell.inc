function run() {
    exec nix-shell "$DIR/../../shell.nix" <<<"source $DIR/../../.ssb_config; export DEV_TOOLS=$DEV_TOOLS; $@"
}

function runWithoutAppName() {
    exec nix-shell "$DIR/../../shell.nix" <<<"export DEV_TOOLS=$DEV_TOOLS; $@"
}

function runForServer() {
    exec nix-shell "$DIR/../../shell.nix" <<<"export ssb_appname=talenet-dev-server; $@ --host=localhost --port=9009 --ws.port=9999 --allowPrivate=true"
}

