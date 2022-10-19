#! /usr/bin/env zsh

export PYENV_ROOT="$HOME"/.pyenv
if ! hash pyenv >/dev/null; then
  path=("$PYENV_ROOT"/bin "$path[@]")
  export PATH
fi
eval "$(pyenv init -)"
