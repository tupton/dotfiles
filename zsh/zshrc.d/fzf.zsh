# https://github.com/junegunn/fzf
if [ -f "$HOME"/.fzf.zsh ]; then
    source "$HOME"/.fzf.zsh
    export FZF_DEFAULT_COMMAND='git ls-tree -r --name-only HEAD || set -o pipefail; (command find -L . -mindepth 1 \( -path "*/\.*" -o -fstype "sysfs" -o -fstype "devfs" -o -fstype "devtmpfs" -o -fstype "proc" \) -prune -o -type f -print -o -type l -print || command find -L . -mindepth 1 -path "*/\.*" -prune -o -type f -print -o -type l -print) 2> /dev/null | cut -b3- 2> /dev/null'
    export FZF_DEFAULT_OPTS='--extended --preview="head -$LINES {}"'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_CTRL_R_OPTS='--no-preview'
fi
