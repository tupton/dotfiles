if hash brew 2>/dev/null; then
    path=( /usr/local/opt/ipython@5/bin \
        /usr/local/opt/node@10/bin \
        /usr/local/opt/ruby/bin \
        /usr/local/lib/ruby/gems/2.6.0//bin \
        /usr/local/Cellar/perl/5.30.1/bin/ \
        "$path[@]")
    hash thrift 2>/dev/null || path=(/usr/local/opt/thrift@0.9/bin "$path[@]")
    export PATH

    unset PYTHONPATH
fi
