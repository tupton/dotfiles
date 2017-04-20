# Use the closest node_modules/.bin to execute npm package binaries
npm-exec() {
    if ! hash npm 2>/dev/null; then
        return;
    fi

    local bin="$1"
    shift
    "$(npm bin)"/"$bin" "$@"
}

hash npm 2>/dev/null && path+=("$(npm bin -g)")
export PATH
