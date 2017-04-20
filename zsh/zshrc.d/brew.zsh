if hash brew 2>/dev/null; then
    path+=("$(brew --prefix)"/bin)
    hash node 2>/dev/null || path+=("$(brew --prefix)"/opt/node@6/bin)
    hash thrift 2>/dev/null || path+=("$(brew --prefix)"/opt/thrift@0.90/bin)
    export PATH
fi

# Homebrew doesn't write anything outside of `brew --prefix`
# https://github.com/Homebrew/brew/blob/master/docs/Homebrew-and-Python.md#site-packages-and-the-pythonpath
hash brew 2>/dev/null && export PYTHONPATH="$(brew --prefix)/lib/python2.7/site-packages:$PYTHONPATH"
export PYTHONPATH
