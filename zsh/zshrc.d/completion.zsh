# Homebrew doesn't write anything outside of `brew --prefix`
# Add known homebrew prefix zsh completion directories.
command -v brew &>/dev/null && fpath=(/usr/local/share/zsh-completions /usr/local/share/zsh/site-functions $fpath)
