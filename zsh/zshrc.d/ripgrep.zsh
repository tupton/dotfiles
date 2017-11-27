#!/usr/bin/env zsh

# rg --context=3 -l still outputs the context separator (default "--") between file names. In order
# to list files so that we can pass from a subshell to vim, we need to get rid of that context
# separator. So, default to adding --context=3 to the list of options unless -l/--files-with-matches
# is present.
function rg() {
    local -a rgopts
    zparseopts -M -E -A opts -- l -files-with-matches=l
    rgopts=(--heading --line-number --color=auto --smart-case --type-add='clj:include:clojure' --type-add='edn:*.edn' --type-add='gradle:*.gradle')
    (( ${+opts[-l]} )) || rgopts+=(--context=3)
    command rg "$rgopts[@]" "$@"
}
