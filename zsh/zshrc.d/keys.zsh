# vi style incremental search
bindkey '^H' history-incremental-search-backward
bindkey '^S' history-incremental-search-forward
bindkey '^P' history-search-backward
bindkey '^N' history-search-forward

# history with up/down arrows
bindkey "$terminfo[kcuu1]" up-line-or-search      # start typing + [Up-Arrow] - fuzzy find history forward
bindkey "$terminfo[kcud1]" down-line-or-search    # start typing + [Down-Arrow] - fuzzy find history backward

# history substring search
# bind UP and DOWN arrow keys
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

# bind P and N for EMACS mode
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down

# bind k and j for VI mode
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# push current command to stack, run a different command, pop from stack
bindkey '^Q' push-input

# edit command in EDITOR
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^X^E' edit-command-line

# home, end, delete, backspace
bindkey '^[[1~' beginning-of-line
bindkey '^[[4~' end-of-line
bindkey '^[[3~' delete-char
bindkey '^?' backward-delete-char
