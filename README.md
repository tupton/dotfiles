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

## Tests

There is a `test` target in the Makefile. Not everything is tested, but I've attempted to verify the files that can be tested. If you know of a way to verify or test other dotfiles, please open an issue or let me know.

- All `zsh` and `bash` config files and scripts are parsed by their respective shells. This includes all the `zsh` installation script helpers.
- All `vim` config files are linted by [vim-vint].
- All [dotjs] files are linted by [eslint] and [jscs].

  [vim-vint]: https://github.com/Kuniwak/vint
  [dotjs]: https://github.com/tupton/dotjs
  [eslint]: http://eslint.org/
  [jscs]: http://jscs.info/

## Inspiration and Thanks

https://github.com/tejr/dotfiles - Makefile and overall project structure

https://github.com/holman/dotfiles - Interactive, templated gitconfig
