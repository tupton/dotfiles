alias reload!="source ~/.zshrc"

# If we're on Ubuntu, the name of the binary is ack-grep.
hash ack-grep 2>/dev/null && alias ack=ack-grep

hash brew 2>/dev/null && alias http='PYTHONPATH="/usr/local/lib/python3.6/site-packages" http'
