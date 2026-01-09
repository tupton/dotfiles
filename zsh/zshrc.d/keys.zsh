# vi style incremental search
bindkey '^H' history-incremental-search-backward
bindkey '^S' history-incremental-search-forward
bindkey '^P' history-search-backward
bindkey '^N' history-search-forward

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

bindkey '^r' atuin-search

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
  bindkey -r '^G'
  local c
  for c in $@; do
    eval "fzf-g$c-widget() { local result=\$(_g$c | join-lines); zle reset-prompt; LBUFFER+=\$result }"
    eval "zle -N fzf-g$c-widget"
    eval "bindkey '^g^$c' fzf-g$c-widget"
  done
}

FZF_GIT_SH="${FZF_GIT_SH:-"$HOME"/.local/bin/fzf-git.sh}"
if [[ -f "$FZF_GIT_SH" ]]; then
  bindkey -r '^G'
  source "$FZF_GIT_SH"
else
  bind-git-helper f b t h r s
fi

unset -f bind-git-helper

function sesh-sessions() {
  {
    exec </dev/tty
    exec <&1
    local session
    session=$(sesh list -H -i -d | fzf-tmux -p 75%,60% \
      --no-sort --ansi --border-label ' sesh ' --prompt '⚡  ' \
      --header '  ^a all ^t tmux ^g configs ^x zoxide ^f find' \
      --bind 'tab:down,btab:up' \
      --bind 'ctrl-a:change-prompt(⚡  )+reload(sesh list -H -i -d)' \
      --bind 'ctrl-t:change-prompt(🪟  )+reload(sesh list -H -i -d -t)' \
      --bind 'ctrl-g:change-prompt(⚙️  )+reload(sesh list -H -i -d -c)' \
      --bind 'ctrl-x:change-prompt(📁  )+reload(sesh list -H -i -d -z)' \
      --bind 'ctrl-f:change-prompt(🔎  )+reload(fd -H -d 2 -t d -E .Trash . ~)' \
      --preview-window 'right:55%' \
      --preview 'sesh preview {}' \
    )
    zle reset-prompt > /dev/null 2>&1 || true
    [[ -z "$session" ]] && return
    sesh connect $session
  }
}

zle     -N             sesh-sessions
bindkey -M emacs '\es' sesh-sessions
bindkey -M vicmd '\es' sesh-sessions
bindkey -M viins '\es' sesh-sessions
