# Homebrew doesn't write anything outside of `brew --prefix`
# https://github.com/Homebrew/homebrew/blob/master/share/doc/homebrew/Homebrew-and-Python.md#site-packages-and-the-pythonpath
hash brew 2>/dev/null && export PYTHONPATH="$(brew --prefix)/lib/python2.7/site-packages:$PYTHONPATH"
