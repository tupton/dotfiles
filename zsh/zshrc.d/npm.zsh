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

# set a dummy NPM_TOKEN so that .npmrc files with ${NPM_TOKEN} don't fail on commands that don't need authentication.
# this means that e.g. NPM_TOKEN=real-token-here npm install is necessary for commands that _do_ need authentication.
export NPM_TOKEN=1
