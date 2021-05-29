# https://github.com/junegunn/fzf
if [ -f "$HOME"/.fzf.zsh ]; then
    source "$HOME"/.fzf.zsh
fi

if hash 2>/dev/null fzf; then
    export FZF_DEFAULT_COMMAND="fd --hidden --type file --color=always"
    export FZF_DEFAULT_OPTS="--ansi"

    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_CTRL_T_OPTS="--preview-window right:60% --preview '(bat --color=always --style=header,grid --line-range :300 {} || cat {} || tree -C {}) 2>/dev/null | head -300'"

    export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"

    export FZF_ALT_C_COMMAND='fd --hidden --type directory --color=always'
    export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"

    export FZF_TMUX=1

    # Explicitly enable the  fzf-tab oh-my-zsh extension if it is loaded
    typeset -f enable-fzf-tab >/dev/null && enable-fzf-tab
fi
