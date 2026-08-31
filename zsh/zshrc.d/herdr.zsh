if [[ -n "$HERDR_PANE_ID" && -n "$HERDR_TAB_ID" ]] && command -v herdr &>/dev/null; then
    autoload -Uz add-zsh-hook

    function _herdr_rename_terminal() {
        local name=$1
        local pane

        command herdr pane rename "$HERDR_PANE_ID" "$name" &>/dev/null

        # A tab can contain multiple shells, so only its focused pane owns its name.
        pane=$(command herdr pane current --current 2>/dev/null) || return
        [[ $pane == *'"focused":true'* ]] || return
        command herdr tab rename "$HERDR_TAB_ID" "$name" &>/dev/null
    }

    function _herdr_preexec() {
        local name=${${1%% *}:t}
        [[ -n $name ]] && _herdr_rename_terminal "$name"
    }

    function _herdr_precmd() {
        _herdr_rename_terminal "${SHELL:t}"
    }

    add-zsh-hook preexec _herdr_preexec
    add-zsh-hook precmd _herdr_precmd
fi
