# Make a gif from an input movie
gif() {
    local input="$1"
    local width="${2:-1000}"

    local output="${input:t:r}.gif"
    ffmpeg -i "$input" -filter_complex "[0:v] palettegen" palette.png
    ffmpeg -i "$input" -i palette.png -filter_complex "[0:v] fps=15,scale=w=${width}:h=-1,split [a][b];[a] palettegen [p];[b][p] paletteuse" "$output"
    rm palette.png
}

pjq() {
    pbpaste | jq '.' --color-output | less
}

hexdec() {
  local input="${(U)1}"
  bc <<< "ibase=16; $input"
}

base64dec() {
  local input="${1}"
  echo "$input" | base64 --decode -i -
}

sesh-connect() {
  hash sesh 2>/dev/null || return
  sesh connect "$(
    sesh list | fzf-tmux -p 55%,60% \
      --no-sort --ansi --border-label ' sesh ' --prompt '⚡  ' \
      --header '  ^a all ^t tmux ^g configs ^x zoxide ^d tmux kill ^f find' \
      --bind 'tab:down,btab:up' \
      --bind 'ctrl-a:change-prompt(⚡  )+reload(sesh list)' \
      --bind 'ctrl-t:change-prompt(🪟  )+reload(sesh list -t)' \
      --bind 'ctrl-g:change-prompt(⚙️  )+reload(sesh list -c)' \
      --bind 'ctrl-x:change-prompt(📁  )+reload(sesh list -z)' \
      --bind 'ctrl-f:change-prompt(🔎  )+reload(fd -H -d 2 -t d -E .Trash . ~)' \
      --bind 'ctrl-d:execute(tmux kill-session -t {})+change-prompt(⚡  )+reload(sesh list)'
  )"
}
