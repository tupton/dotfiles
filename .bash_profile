# .bash_profile

#include .bashrc if it exists
if [ -f ~/.bashrc ]; then
 . ~/.bashrc
fi

# set PATH so it includes user's private bin if it exists
if [ -d ~/bin ] ; then
 PATH=~/bin:"${PATH}"
fi

