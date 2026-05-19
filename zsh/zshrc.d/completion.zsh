# Homebrew doesn't write anything outside of `brew --prefix`
# Add known homebrew prefix zsh completion directories.
command -v brew &>/dev/null && fpath=("$(brew --prefix)"/share/zsh-completions "$(brew --prefix)"/share/zsh/site-functions $fpath)
