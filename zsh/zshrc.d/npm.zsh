# Use the closest node_modules/.bin to execute npm package binaries
npm-exec() {
    if hash npm 2>/dev/null; then
        local bin="$1"
        shift
        "$(npm bin)"/"$bin" "$@"
    fi
}
