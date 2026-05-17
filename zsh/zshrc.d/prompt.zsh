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

# SSH_CONNECTION doesn't change during a session, so evaluate once at startup
if [[ -n "$SSH_CONNECTION" ]]; then
    _user_name=" %F{yellow}%n%f%F{gray}@%f%F{blue}%m%f "
else
    _user_name=""
fi

function __compact_path() {
    if command -v compact-path &>/dev/null; then
        local pwd="${PWD/#$HOME/~}"
        compact-path --trigger=20 "$pwd"
    else
        echo "%~"
    fi
}

setopt prompt_subst

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable jj git

() {
    local formats="%b %c%u"
    zstyle ':vcs_info:git*' formats "$formats%m "
    zstyle ':vcs_info:git*' actionformats "${formats} %F{white}%a%f "
    zstyle ':vcs_info:git*' stagedstr "%F{green}+%f"
    zstyle ':vcs_info:git*' unstagedstr "%F{red}*%f"
    zstyle ':vcs_info:git*' check-for-changes true
    zstyle ':vcs_info:git*+set-message:*' hooks git-untracked git-aheadbehind git-remotebranch git-tagname

    zstyle ':vcs_info:jj:*' formats "%F{yellow}%i%f" "%F{blue}%b%f"
    zstyle ':vcs_info:jj:*' actionformats "%F{yellow}%i%f %F{brightblack}%a%f" "%F{blue}%b%f"
}

function +vi-git-untracked() {
    if [[ -n $(git ls-files --others --exclude-standard | sed q) ]]; then
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
    (($ahead)) && gitstatus+=("%B%F{magenta}↑${ahead}%f%b")

    # for git prior to 1.7
    # behind=$(git rev-list HEAD..origin/${branch_name} | wc -l)
    behind=${$(git rev-list HEAD..${branch_name}@{upstream} 2>/dev/null | wc -l)// /}
    (($behind)) && gitstatus+=("%F{magenta}↓${behind}%f")

    hook_com[misc]+=${(j::)gitstatus}
}

function +vi-git-remotebranch() {
    local remote branch_name

    # Are we on a remote-tracking branch?
    remote=${$(git rev-parse --verify HEAD@{upstream} --symbolic-full-name 2>/dev/null)/refs\/(remotes|heads)\//}
    branch_name=${$(git symbolic-ref --short HEAD 2>/dev/null)}

    hook_com[branch]="%F{cyan}${hook_com[branch]}%f"
    # Always show the remote
    #if [[ -n ${remote} ]] ; then
    # Only show the remote if it differs from the local
    if [[ -n ${remote} && ${remote#*/} != ${branch_name} ]]; then
        hook_com[branch]+="%B%F{red}→%f%b%B%F{cyan}${remote}%f%b"
    fi
}

function +vi-git-tagname() {
    local tag

    tag=$(git describe --tags --exact-match HEAD 2>/dev/null)
    [[ -n ${tag} ]] && hook_com[branch]="%B%F{red}${tag}%f%b"
}

add-zsh-hook precmd vcs_info

# Runs after vcs_info; pre-computes prompt segments to avoid subshells at render time
function _prompt_precmd() {
    local char="○"
    [[ -n $vcs_info_msg_0_ ]] && char="±"
    _prompt_char="%(1j.%{%F{magenta}%}.%{%F{cyan}%})${char}%f "
    _prompt_path=$(__compact_path)
    _vcs_info=""
    if [[ -n $vcs_info_msg_0_ ]]; then
        _vcs_info=" ${vcs_info_msg_0_}"
        [[ -n $vcs_info_msg_1_ ]] && _vcs_info+=" ${vcs_info_msg_1_}"
    fi
}
add-zsh-hook precmd _prompt_precmd

prompt_leader='%(?.%F{blue}.%F{red})%(!.#.❯)%f '

__prompt='${_prompt_char}${_user_name}%B%F{green}${_prompt_path}%f%b${_vcs_info}%E
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
