# Move to the "top" of a git repository
gt() {
    cd $(git rev-parse --show-toplevel)
}

gfco() {
    local branch
    branch=$(git branch | sed "s/^[\* ] //" | fzf -1 -q "$1")
    [ -n "$branch" ] && git checkout "$branch"
}
