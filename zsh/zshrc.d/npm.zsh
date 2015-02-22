npm-exec() {
    if hash npm 2>/dev/null; then
        local bin="$1"
        shift
        "$(npm bin)"/"$bin" "$@"
    fi
}
