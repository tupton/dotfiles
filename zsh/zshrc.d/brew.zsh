if hash brew 2>/dev/null; then
    PATH="$(brew --prefix)"/opt/ipython@5/bin:"$PATH"
    hash node 2>/dev/null || PATH="$(brew --prefix)"/opt/node@6/bin:"$PATH"
    hash thrift 2>/dev/null || PATH="$(brew --prefix)"/opt/thrift@0.9/bin:"$PATH"
    PATH="$PATH":"$(brew --prefix)"/bin
    export PATH

    unset PYTHONPATH
fi
