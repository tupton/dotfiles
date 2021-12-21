if hash brew 2>/dev/null; then
    path=( /usr/local/opt/ipython@5/bin \
        /usr/local/opt/ruby/bin \
        /usr/local/lib/ruby/gems/2.7.0/bin \
        /usr/local/opt/perl/bin \
        /usr/local/opt/php/bin \
        /usr/local/opt/python/libexec/bin \
        /usr/local/opt/node@16/bin \
        "$path[@]")
    export PATH

    unset PYTHONPATH
fi
