# Homebrew doesn't write anything outside of `brew --prefix`
if hash brew 2>/dev/null && [[ -d "$(brew --prefix)"/share/zsh-completions ]]; then
    fpath=("$(brew --prefix)"share/zsh-completions $fpath)
fi
