#!/usr/bin/env zsh

zstyle :omz:plugins:jj ignore-working-copy yes

export fpath=("${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"/plugins/jj-zsh-vcs-info/ $fpath)
