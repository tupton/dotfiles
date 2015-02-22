# Move to the "top" of a git repository
gt() {
    cd $(git rev-parse --show-toplevel)
}
