# vi style incremental search
bindkey '^H' history-incremental-search-backward
bindkey '^S' history-incremental-search-forward
bindkey '^P' history-search-backward
bindkey '^N' history-search-forward

# history substring search
# bind UP and DOWN arrow keys
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

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

# https://gist.github.com/junegunn/8b572b8d4b5eddd8b85e5f4d40f17236
is_in_git_repo() {
  git rev-parse HEAD > /dev/null 2>&1
}

_gf() {
  is_in_git_repo || return
  git fuzzy-files
}

_gb() {
  is_in_git_repo || return
  git fuzzy-branch
}

_gt() {
  is_in_git_repo || return
  git fuzzy-tag
}

_gh() {
  is_in_git_repo || return
  git fuzzy-hash
}

_gr() {
  is_in_git_repo || return
  git fuzzy-remote
}

_gs() {
  is_in_git_repo || return
  git fuzzy-stash
}

join-lines() {
  local item
  while read item; do
    echo -n "${(q)item} "
  done
}

bind-git-helper() {
  local c
  for c in $@; do
    eval "fzf-g$c-widget() { local result=\$(_g$c | join-lines); zle reset-prompt; LBUFFER+=\$result }"
    eval "zle -N fzf-g$c-widget"
    eval "bindkey '^g^$c' fzf-g$c-widget"
  done
}
bind-git-helper f b t h r s
unset -f bind-git-helper
