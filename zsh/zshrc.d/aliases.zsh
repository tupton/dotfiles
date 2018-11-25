alias reload!="source ~/.zshrc"

# If we're on Ubuntu, the name of the binary is ack-grep.
hash ack-grep 2>/dev/null && alias ack=ack-grep

unalias gr
alias gr='"$(git rev-parse --show-toplevel)"/gradlew'
