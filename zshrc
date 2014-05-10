# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="upton/upton"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Highlight all available matches
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor root)

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(brew git github lein node npm osx python rake rvm zsh-syntax-highlighting history-substring-search ant command-not-found pip gitignore)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export EDITOR="vim"

# vi style incremental search
bindkey '^R' history-incremental-search-backward
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

# `cd command` if no other match; e.g. > code => > cd code
setopt AUTO_CD

# allow comments in interactive mode, i.e. on the command line
setopt INTERACTIVE_COMMENTS

# aliases
[[ -e "/Users/tupton/code/automaton/bin/ctool" ]] && alias ctool="/Users/tupton/code/automaton/bin/ctool"
[[ -e "/usr/local/bin/mvim" ]] && alias vim="/usr/local/bin/mvim -v"
[[ -e "/usr/local/bin/terminal-notifier" ]] && alias n="/usr/local/bin/terminal-notifier -activate com.googlecode.iterm2 -message"
alias ls="ls -FG"

# Load RVM into a shell session as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

PATH=".:/usr/local/share/npm/bin:/usr/local/lib/python2.7/site-packages:/usr/local/opt/ruby/bin:/usr/local/bin:/usr/local/sbin:$HOME/.rvm/bin:$PATH"

[[ -e "/usr/local/bin/brew" ]] && export PYTHONPATH="$(/usr/local/bin/brew --prefix)/lib/python2.7/site-packages:$PYTHONPATH"

[[ -d /usr/local/share/zsh-completions ]] && fpath=(/usr/local/share/zsh-completions $fpath)

# -R -- properly display color escape sequences (was on by default; necessary to include when changing)
# -s -- squeeze consecutive blank lines into one line
# -X -- don't clear the screen on exit
# -F -- immediately quit if the output fits on one screen; useful for `git diff` and short man pages
export LESS="-R -s -X -F"
