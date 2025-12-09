alias reload!="source ~/.zshrc"

[[ -x /Applications/Tailscale.app/Contents/MacOS/Tailscale ]] && alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"

hash nvim 2>/dev/null && alias vim=nvim

hash rg 2>/dev/null && alias hl="rg --no-config --passthru"
