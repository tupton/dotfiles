# https://github.com/junegunn/fzf
if [ -f "$HOME"/.fzf.zsh ]; then
    source "$HOME"/.fzf.zsh
    export FZF_DEFAULT_COMMAND='git ls-tree -r --name-only HEAD || fd --hidden --no-ignore --type f'
    export FZF_DEFAULT_OPTS='--extended --preview="head -$LINES {}"'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_CTRL_R_OPTS='--no-preview'
fi
