# Homebrew doesn't write anything outside of `brew --prefix`
hash brew 2>/dev/null && [ -d "$(brew --prefix)"/share/zsh-completions ] && fpath=("$(brew --prefix)"/share/zsh-completions $fpath)
