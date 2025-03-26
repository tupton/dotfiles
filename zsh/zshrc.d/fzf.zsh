# https://github.com/junegunn/fzf
if hash 2>/dev/null fzf; then
  export FZF_DEFAULT_COMMAND="fd --hidden --type file --color=always"
  export FZF_DEFAULT_OPTS="--ansi"

  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  # CTRL-/ to toggle preview window position
  export FZF_CTRL_T_OPTS="
    --preview='(bat --color=always --style=header,grid,numbers --line-range :300 {} || cat {} || tree -C {}) 2>/dev/null | head -300'
    --preview-window=right:50%:border-left
    --bind='ctrl-/:change-preview-window(down|hidden|)'
    --layout=reverse
    --multi"

  # CTRL-/ to toggle small preview window to see the full command
  # CTRL-Y to copy the command into clipboard using pbcopy
  export FZF_CTRL_R_OPTS="
    --preview='echo {}' --preview-window=up:3:hidden:wrap
    --bind='ctrl-/:toggle-preview'
    --bind='ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'"

  export FZF_ALT_C_COMMAND='fd --hidden --type directory --color=always'
  export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"

  export FZF_TMUX=1
  export FZF_TMUX_OPTS="-p80%,60%"

  # Explicitly enable the  fzf-tab oh-my-zsh extension if it is loaded
  typeset -f enable-fzf-tab >/dev/null && enable-fzf-tab

  source <(fzf --zsh)
fi
