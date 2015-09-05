# Move to the "top" of a git repository
gt() {
    cd $(git rev-parse --show-toplevel)
}

# edit files changed in the working tree
vimtree() {
    ${EDITOR:-vim} $(git pick-tree)
}
