# https://github.com/junegunn/fzf
if [ -f "$HOME"/.fzf.zsh ]; then
    source "$HOME"/.fzf.zsh
    export FZF_DEFAULT_COMMAND='(git ls-tree -r --name-only HEAD || command find -L . -mindepth 1 \( -path "*/\.*" -o -fstype "sysfs" -o -fstype "devfs" -o -fstype "devtmpfs" -o -fstype "proc" \) -prune -o -type f -print -o -type l -print | cut -b3- ) 2> /dev/null'
    export FZF_DEFAULT_OPTS="--extended"
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi
