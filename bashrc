# .bashrc

# Setup {{{
# Enable vi control mode
set -o vi

# Terminal
export TERM=xterm-256color
# }}}
# History {{{
export HISTCONTROL=erasedups
export HISTSIZE=10000
shopt -s histappend
# }}}
# Aliases {{{
alias ls='ls -FG'
alias ll='ls -al'
alias rm='rm -i'
alias grep='grep -nI --color=always'
alias ngrep='grep -I'
# }}}
# Prompt {{{
#export PS1='\e]2;\u@\h\a\[\e[1;m\]\t\[\e[0m\] [\[\e[32m\]\u\[\e[0m\]\[\e[33m\]@\h\[\e[0m\]] [\!] [\[\e[36m\]\w\[\e[0m\]]\n\[\e[35m\]\$\[\e[0m\] '
#export SUDO_PS1='\[\h:\w\] \u\$ '
prompt_command () {
    if [ "\$(type -t __git_ps1)" ]; then # if we're in a Git repo, show current branch
        BRANCH="\$(__git_ps1 '[ %s ] ')"
    fi
    local TIME=`fmt_time` # format time for prompt string
    local LOAD=`uptime|awk '{min=NF-2;print $min}'`
    local HIST="\!"

    local BLACK="\[\033[0;30m\]"
    local RED="\[\033[0;31m\]"
    local GREEN="\[\033[0;32m\]"
    local YELLOW="\[\033[0;33m\]"
    local BLUE="\[\033[0;34m\]"
    local MAGENTA="\[\033[0;35m\]"
    local CYAN="\[\033[0;36m\]"
    local WHITE="\[\033[0;37m\]"
    local BBLACK="\[\033[1;30m\]"
    local BGREEN="\[\033[1;32m\]"
    local BMAGENTA="\[\033[1;35m\]"
    local BCYAN="\[\033[1;36m\]"
    local BWHITE="\[\033[1;37m\]"

    # return color to Terminal setting for text color
    local DEFAULT="\[\033[0;39m\]"

    # set the titlebar to the last 2 fields of pwd
    local TITLEBAR='\[\e]2;\u@\h `pwdtail`\a'

    export PS1="\[${TITLEBAR}\]${BBLACK}[ ${BGREEN}\u${YELLOW}@\h\
${BBLACK}(${LOAD}) ${BWHITE}${TIME} ${MAGENTA}!${HIST} ${BBLACK}] ${CYAN}\w\n\
${GREEN}${BRANCH}${BMAGENTA}$ ${DEFAULT}"
    export SUDO_PS1='\[\h:\w\] \u\$ '
}
PROMPT_COMMAND=prompt_command
 
fmt_time () {
    date +"%T"
}
pwdtail () { #returns the last 2 fields of the working directory
    pwd|awk -F/ '{nlast = NF -1;print $nlast"/"$NF}'
}
# }}}
# {{{ Path
# set PATH so it includes user's private bin if it exists
if [ -d ~/bin ] ; then
 PATH=~/bin:"${PATH}"
fi
export PATH=.:/usr/local/share/python:/usr/local/bin:$PATH
# }}}
# {{{ Utility
# Homebrew bash completion
if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
fi
# }}}
# {{{ External Functions and Scripts
# Set the editor variable to use vim
export EDITOR=vim

# Let less handle 'raw' input
export LESS="-R"

# Use .pythonrc if it exists
if [ -f ~/.pythonrc ]; then
  export PYTHONSTARTUP=~/.pythonrc
fi

# Directory jumping
if [ -f /usr/local/bin/z ]; then
  . /usr/local/bin/z
fi
# }}}

# vim: fdm=marker
