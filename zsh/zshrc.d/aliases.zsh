alias reload!="source "$HOME"/.zshrc"

[[ -x /Applications/Tailscale.app/Contents/MacOS/Tailscale ]] && alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"

command -v nvim &>/dev/null && alias vim=nvim

command -v rg &>/dev/null && alias hl="rg --no-config --passthru"
