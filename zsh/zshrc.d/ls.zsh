# Return appropriate options for ls
lsopts() {

    local lsopts colors

    # Start collecting available options
    lsopts=()

    # Use file type indicators
    lsopts+=(-F)

    # If the --color option is available and we have a terminal that supports
    # at least eight colors, add platform-specific option for color
    colors=$(tput colors)
    if ((colors >= 8)); then
        if command ls --help |& grep "\-\-color" 2>&1 >/dev/null; then
            lsopts+=(--color=auto)
        else
            lsopts+=(-G)
        fi
    fi

    # Print the options as a single string, space-delimited
    echo -n "${lsopts[*]}"
}

# Alias ls with these options
alias ls="ls $(lsopts)"

export CLICOLOR=true
export LSCOLORS="exfxcxdxbxegedabagacad"

# Unset helper function
unset -f lsopts
