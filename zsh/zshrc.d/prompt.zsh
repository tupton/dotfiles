# %                - the escape character
# %f%k%b           - resets coloring/bolding
# %F{COLOR}        - sets a color
# %B%F{COLOR}      - sets a bold color (solarized uses some of these for grays)

# %n               - user
# @                - literal @
# %m               - short hostname
# %~               - path (truncated when in home dir)
# %E               - clear till end of line
# %(?.$1.$2)       - $1 if exit code was successful, $2 if not
# %(!.$1.$2)       - $1 if root, $2 if normal user

function user_name() {
    [[ -n "$SSH_CONNECTION" ]] && echo "%F{yellow}%n%f%F{gray}@%f%F{blue}%m%f " || echo ""
}

function compact_path() {
    local cp="$HOME/.local/bin/compact_path"
    if [[ -e "$cp" ]]; then
        local pwd="${PWD/#$HOME/~}"
        echo $("$cp" --trigger=20 "$pwd")
    else
        echo "%~"
    fi
}

function prompt_char() {
    local char
    char="○"
    git rev-parse >/dev/null 2>&1 && char="±"
    echo "%(1j.%{%F{magenta}%}.%{%F{cyan}%})$char%f"
}

setopt prompt_subst
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git

() {
  local formats="%b %c%u"
  zstyle ':vcs_info:git*' formats "$formats%m "
  zstyle ':vcs_info:git*' actionformats "${formats} %F{white}%a%f "
  zstyle ':vcs_info:git*' stagedstr "%F{green}+%f"
  zstyle ':vcs_info:git*' unstagedstr "%F{red}*%f"
  zstyle ':vcs_info:git*' check-for-changes true
  zstyle ':vcs_info:git*+set-message:*' hooks git-untracked git-aheadbehind git-remotebranch git-tagname
}

function +vi-git-untracked() {
    if [[ $(git rev-parse --is-inside-work-tree 2>/dev/null) == 'true' && \
            -n $(git ls-files --others --exclude-standard | sed q) ]]; then
        hook_com[unstaged]+="%F{yellow}?%f"
    fi
}

function +vi-git-aheadbehind() {
    local ahead behind branch_name
    local -a gitstatus

    branch_name=${$(git symbolic-ref --short HEAD 2>/dev/null)}

    # for git prior to 1.7
    # ahead=$(git rev-list origin/${branch_name}..HEAD | wc -l)
    ahead=${$(git rev-list ${branch_name}@{upstream}..HEAD 2>/dev/null | wc -l)// /}
    (( $ahead )) && gitstatus+=( "%B%F{magenta}↑${ahead}%f%b" )

    # for git prior to 1.7
    # behind=$(git rev-list HEAD..origin/${branch_name} | wc -l)
    behind=${$(git rev-list HEAD..${branch_name}@{upstream} 2>/dev/null | wc -l)// /}
    (( $behind )) && gitstatus+=( "%F{magenta}↓${behind}%f" )

    hook_com[misc]+=${(j::)gitstatus}
}

function +vi-git-remotebranch() {
    local remote branch_name

    # Are we on a remote-tracking branch?
    remote=${$(git rev-parse --verify HEAD@{upstream} --symbolic-full-name 2>/dev/null)/refs\/(remotes|heads)\/}
    branch_name=${$(git symbolic-ref --short HEAD 2>/dev/null)}

    hook_com[branch]="%F{cyan}${hook_com[branch]}%f"
    # Always show the remote
    #if [[ -n ${remote} ]] ; then
    # Only show the remote if it differs from the local
    if [[ -n ${remote} && ${remote#*/} != ${branch_name} ]] ; then
        hook_com[branch]+="%B%F{red}→%f%b%B%F{cyan}${remote}%f%b"
    fi
}

function +vi-git-tagname() {
    local tag

    tag=$(git describe --tags --exact-match HEAD 2>/dev/null)
    [[ -n ${tag} ]] && hook_com[branch]="%B%F{red}${tag}%f%b"
}

precmd() { vcs_info }

prompt_leader='%(?.%F{blue}.%F{red})%(!.#.❯)%f '

__prompt='$(prompt_char) $(user_name)%f%B%F{green}$(compact_path)%f%b ${vcs_info_msg_0_}%E
${prompt_leader}'

function prompt_simple() {
    PROMPT=$prompt_leader
}

function prompt_reset() {
    PROMPT=$__prompt
}

function prompt!() {
    if [[ $PROMPT == $__prompt ]]; then
        prompt_simple
    else
        prompt_reset
    fi
}

prompt_reset
