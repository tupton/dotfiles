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
