# Move to the "top" of a git repository
gt() {
    cd $(git rev-parse --show-toplevel)
}

# edit files changed in the working tree
vimtree() {
    ${EDITOR:-vim} $(git fuzzy-files)
}

# switch to a branch that tracks a remote branch
# Used to create a branch from a Linear ticket branch name
# [g]it [s][w]itch with [t]racking
gswt() {
    local local_branch=${1:-$(pbpaste | tr -d '\n')}
    local remote_tracking_branch=${2:-origin/main}
    git switch -c ${local_branch} ${remote_tracking_branch}
}
# Alias with co for any lingering shell history
# [g]it [c]heck[o]ut with [t]racking
alias gcot=gswt
