# .bashrc

# Enable vi control mode
# set -o vi

# History
export HISTCONTROL=erasedups
export HISTSIZE=10000
shopt -s histappend

alias ls='ls -FG'
alias apinfo='/System/Library/PrivateFrameworks/Apple80211.framework/Versions/A/Resources/airport'
alias rm='rm -i'
alias grep='grep -nI --color=always'

# Custom colorized prompt
export PS1='\e]2;\u@\h\a\[\e[1;m\]\t\[\e[0m\] [\[\e[32m\]\u\[\e[0m\]\[\e[33m\]@\h\[\e[0m\]] [\!] [\[\e[36m\]\w\[\e[0m\]]\n\[\e[35m\]\$\[\e[0m\] '
export SUDO_PS1='\[\h:\w\] \u\$ '

# Add the current directory and MacPorts to the path
export PATH=./:~/code/bin/:~/code/script/:/opt/local/bin:/opt/local/sbin:opt/local/bin:/opt/local/sbin:/usr/local/mysql/bin:$PATH

# Use .pythonrc if it exists
if [ -f ~/.pythonrc ]; then
  export PYTHONSTARTUP=~/.pythonrc
fi

