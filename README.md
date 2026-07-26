# Dotfiles

[![CircleCI Build Status](https://dl.circleci.com/status-badge/img/gh/tupton/dotfiles/tree/main.svg?style=svg)](https://dl.circleci.com/status-badge/redirect/gh/tupton/dotfiles/tree/main)

A collection of config files that I use.

## Installation

Installing will overwrite anything in the way. Run `make -n` first. If you are happy with that output, you can test the dotfile environment with


    TMP=$(mktemp -d -t HOME); HOME=$TMP make install && ls -al $TMP && unset TMP

Install common, cross-platform dotfiles to `$HOME` with

    make install

Install individual dotfiles with, e.g.

    make install-git

or

    make install-vim-config

and so forth.

Look at the `Makefile` to see which dotfiles are installed by default and which require running a separate task. For example, tarsnap configs only really apply to my local machine, so they are not installed by default.

Use `make list` to see a list of all targets, including the test targets and any auxiliary helper targets. More on test targets follows.

## Tests

There is a `test` target in the Makefile. Not everything is tested, but I've attempted to verify the files that can be tested. If you know of a way to verify or test other dotfiles, please open an issue or let me know.

- All `zsh` and `bash` config files and scripts are parsed by their respective shells. This includes all the `zsh` installation script helpers.

You need `bash` and `zsh` installed to check the syntax of some installation files. Presumably, if you are using these dotfiles, you have at least those two shells installed.

## Inspiration and Thanks

<https://sanctum.geek.nz/cgit/dotfiles.git/about/> - Makefile and overall project structure

<https://github.com/holman/dotfiles> - Interactive, templated gitconfig
