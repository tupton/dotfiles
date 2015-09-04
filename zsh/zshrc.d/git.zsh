# Move to the "top" of a git repository
gt() {
    cd $(git rev-parse --show-toplevel)
}

# edit files changed in the working tree
vt() {
    ${EDITOR:-vim} $(git pick-tree)
}
