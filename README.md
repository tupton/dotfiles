# Dotfiles

[![Build Status](https://travis-ci.org/tupton/dotfiles.svg?branch=master)](https://travis-ci.org/tupton/dotfiles)

A collection of config files that I use.

## Installation

Installing will overwrite anything in the way. Run `make -n` first. If you are happy with that
output, you can test the dotfile environment with

    ❯ TMP=$(mktemp -d /tmp/tmp.XXXXX)
    ❯ HOME=$TMP make install
    ❯ ls -al $TMP

Install common, cross-platform dotfiles to `$HOME` with

    ❯ make install

Install individual dotfiles with, e.g.

    ❯ make install-git

or

    ❯ make install-vim-config

and so forth.

Look at the `Makefile` to see which dotfiles are installed by default and which require running a
separate task. For example, TextMate and tarsnap configs only really apply to my local machine, so
they are not installed by default.

## Inspiration and Thanks

https://github.com/tejr/dotfiles - Makefile and overall project structure

https://github.com/holman/dotfiles - Interactive, templated gitconfig
