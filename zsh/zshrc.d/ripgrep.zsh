#!/usr/bin/env zsh

function rg() {
    local -a rgopts
    zparseopts -M -E -A opts -- l -files-with-matches=l
    rgopts=(--heading --line-number --color=auto --smart-case --type-add='clj:include:clojure' --type-add='edn:*.edn' --type-add='gradle:*.gradle')
    (( ${+opts[-l]} )) || rgopts+=(--context=3)
    command rg "$rgopts[@]" "$@"
}
