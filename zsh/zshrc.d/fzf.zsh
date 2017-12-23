# https://github.com/junegunn/fzf
if [ -f "$HOME"/.fzf.zsh ]; then
    source "$HOME"/.fzf.zsh
    export FZF_DEFAULT_COMMAND='git ls-tree -r --name-only HEAD 2>/dev/null || fd --hidden --no-ignore --type f 2>/dev/null'
    export FZF_DEFAULT_OPTS='--extended --preview="head -$LINES {}"'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_CTRL_R_OPTS='--no-preview'
    export FZF_ALT_C_COMMAND='fd --hidden --no-ignore --type d'
    export FZF_ALT_C_OPTS='--preview="command ls -al {}"'
fi
