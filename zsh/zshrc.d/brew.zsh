#! /usr/bin/env zsh

if [ -e /usr/local/bin/brew ]; then
  eval $(/usr/local/bin/brew shellenv)
fi

if [ -e /opt/homebrew/bin/brew ]; then
  eval $(/opt/homebrew/bin/brew shellenv)
fi

if hash brew 2>/dev/null; then
    prefix="$(brew --prefix)"
    path=( "$prefix"/opt/ruby/bin \
        "$prefix"/opt/perl/bin \
        "$prefix"/opt/php/bin \
        "$prefix"/opt/gnu-sed/libexec/gnubin \
        "$path[@]")

    if [ -z "$CFG_EXCLUDE_HOMEBREW_PYTHON" ]; then
        path=( "$prefix"/opt/python/bin \
          "$prefix"/opt/python/libexec/bin \
          "$path[@]")
    fi

    export PATH


    unset PYTHONPATH
fi
