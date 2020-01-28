if hash brew 2>/dev/null; then
    PATH=/usr/local/opt/ipython@5/bin:"$PATH"
    PATH=/usr/local/opt/node@10/bin:"$PATH"
    PATH=/usr/local/opt/ruby/bin:"$PATH"
    PATH=/usr/local/lib/ruby/gems/2.6.0//bin:"$PATH"
    PATH=/usr/local/Cellar/perl/5.30.1/bin/:"$PATH"
    hash thrift 2>/dev/null || PATH=/usr/local/opt/thrift@0.9/bin:"$PATH"
    export PATH

    unset PYTHONPATH
fi
