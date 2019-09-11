if hash go 2>/dev/null; then
    GOPATH=$HOME/go
    PATH=$GOPATH/bin:"$PATH"
    export GOPATH
    export PATH
fi
