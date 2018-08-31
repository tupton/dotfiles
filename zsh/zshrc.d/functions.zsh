# Start vim with codi, the interactive code scratchpad
codi() {
  local syntax="${1:-python}"
  [[ $# -gt 0 ]] && shift
  vim -c "let g:startify_disable_at_vimenter = 1 |\
    set bt=nofile ls=0 noru nonu nornu |\
    hi ColorColumn ctermbg=NONE |\
    hi VertSplit ctermbg=NONE |\
    hi NonText ctermfg=0 |\
    Codi $syntax" "$@"
}

# Make a gif from an input movie
gif() {
    local input="$1"
    local width="${2:-1000}"

    local output="${input:t:r}.gif"
    ffmpeg -i "$input" -filter_complex "[0:v] palettegen" palette.png
    ffmpeg -i "$input" -i palette.png -filter_complex "[0:v] fps=15,scale=w=${width}:h=-1,split [a][b];[a] palettegen [p];[b][p] paletteuse" "$output"
    rm palette.png
}
