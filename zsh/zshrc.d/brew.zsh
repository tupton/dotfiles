if hash brew 2>/dev/null; then
    path=( /usr/local/opt/ipython@5/bin \
        /usr/local/opt/node@10/bin \
        /usr/local/opt/ruby/bin \
        /usr/local/lib/ruby/gems/2.7.0/bin \
        /usr/local/opt/perl/bin \
        /usr/local/opt/php/bin \
        /usr/local/opt/python/libexec/bin \
        "$path[@]")
    hash thrift 2>/dev/null || path=(/usr/local/opt/thrift@0.9/bin "$path[@]")
    export PATH

    unset PYTHONPATH
fi
