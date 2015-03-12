# Return appropriate options for ls
lsopts() {

    local lshelp lsopts colors

    # Snarf the output of `ls --help` into a variable
    lshelp=$(ls --help 2>/dev/null)

    # Start collecting available options
    lsopts=()

    # Use file type indicators
    lsopts+=(-F)

    # If the --color option is available and we have a terminal that supports
    # at least eight colors, add --color=auto to the options
    colors=$(tput colors)
    if ((colors >= 8)); then
        if [[ $lshelp == *--color* ]]; then
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
