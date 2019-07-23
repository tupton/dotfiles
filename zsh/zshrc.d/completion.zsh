# Homebrew doesn't write anything outside of `brew --prefix`
hash brew 2>/dev/null && [ -d /usr/local/share/zsh-completions ] && fpath=(/usr/local/share/zsh-completions $fpath)
