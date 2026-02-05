# AGENTS.md

Instructions for AI agents working with this dotfiles repository.

## Repository Overview

This is a personal dotfiles collection for macOS/Linux. Configs are organized by tool in subdirectories (`zsh/`, `vim/`, `git/`, etc.) and installed via Makefile targets that copy files to `$HOME`.

## Quick Reference

| Task | Command |
|------|---------|
| Run all tests | `make test` |
| Test zsh/bash syntax | `make test-zsh` / `make test-bash` |
| Lint vim configs | `make test-vimrc` |
| Lint JavaScript | `make test-dotjs` or `yarn test` |
| List all targets | `make list` |
| Install all defaults | `make install` |
| Install specific tool | `make install-<tool>` (e.g., `make install-git`) |

## Build & Test Requirements

### Dependencies for Testing
- **zsh** and **bash** - for syntax checking shell configs
- **vint** - for linting vim configs (`pip install -r test-requirements.txt`)
- **eslint** - for JavaScript linting (`yarn install`)

### What Gets Tested
1. **Shell scripts** - Parsed with `zsh --no-exec` and `bash -n` for syntax errors
2. **Vim configs** - Linted with [vint](https://github.com/Kuniwak/vint) for style/correctness
3. **JavaScript (dotjs/)** - Linted with eslint using `eslint/eslintrc.js`
4. **Setup scripts** - All install/update scripts validated for shell syntax

### CI
CircleCI runs `make test` against zsh 5.8.1 and 5.9. See `.circleci/config.yml`.

## Directory Structure

| Directory | Purpose |
|-----------|---------|
| `zsh/` | Zsh config, oh-my-zsh setup, modular configs in `zshrc.d/` |
| `bash/` | Bash config (bashrc, bash_profile) |
| `vim/` | Vim config with vim-plug, CoC.nvim plugins |
| `nvim/` | Neovim Lua config (Kickstart.nvim-based) |
| `git/` | Git config template, global ignore, and `git-*` scripts |
| `gh/` | GitHub CLI config |
| `dotjs/` | Browser JavaScript injection scripts |
| `eslint/` | ESLint configuration |
| `tmux/` | tmux config and TPM installer |
| `Karabiner-Elements/` | Keyboard remapping (goku edn format) |
| `tarsnap/` | Backup configuration (not installed by default) |
| `system/` | macOS system-level fixes |

## Code Style Guidelines

### Shell Scripts (zsh/bash)
- **Must parse cleanly** - `zsh --no-exec <file>` or `bash -n <file>`
- Scripts go in appropriate directory (`git/` for git extensions, `zsh/zshrc.d/` for modular zsh config)
- Git helper scripts use `git-<name>` naming convention (callable as `git <name>`)
- Use `#!/usr/bin/env zsh` or `#!/usr/bin/env bash` shebang
- Functions for reusable blocks in `zsh/zshrc.d/functions.zsh`
- Aliases in `zsh/zshrc.d/aliases.zsh`

### Zsh Specifics
- Modular configs go in `zsh/zshrc.d/*.zsh` (auto-sourced)
- Use `$HOME` instead of `~` for portability in quoted strings
- Check for command availability with `hash <cmd> 2>/dev/null` before using

### Vim/Neovim
- **Vim** (`vim/vimrc`): Uses vim-plug, must pass vint linting
- **Neovim** (`nvim/init.lua`): Lua-based, Kickstart.nvim structure with lazy.nvim
- Keep plugins organized by category with comments
- Use folding markers (`{{{` / `}}}`) for vim config sections

### JavaScript (dotjs/)
- ESLint config: `eslint/eslintrc.js`
- Parser: `@babel/eslint-parser` with ES6+ features
- Key rules:
  - No semicolons required (`semi: 0`)
  - Flexible quotes (`quotes: 0`)
  - No strict indentation (`indent: 0`)
  - Prefer dot notation (`dot-notation: 2`)
  - No eval or extending native prototypes
  - Wrap IIFEs (`wrap-iife: 2`)
  - Use curly braces (`curly: 2`)

### Git Scripts
- Named `git-<action>` in `git/` directory
- Installed to `~/.local/bin/` for git subcommand access
- Many use fzf for interactive selection (see `git-fuzzy-*` scripts)
- Must parse with zsh

### General
- No trailing whitespace
- Match existing naming conventions
- Test changes with appropriate `make test-*` command
- Templated configs (like `git/gitconfig.template`) use `{PLACEHOLDER}` syntax

## Making Changes

### Adding a New Tool Config
1. Create directory: `<tool>/`
2. Add config files
3. Add Makefile target: `install-<tool>`
4. If applicable, add to `install` target dependencies
5. Add tests if shell scripts are involved

### Modifying Existing Configs
1. Read the existing file to understand structure
2. Make changes following existing patterns
3. Run relevant tests: `make test-<type>`
4. If git config, update template and regenerate with `git/setup`

### Adding Git Scripts
1. Create `git/git-<name>` with `#!/usr/bin/env zsh`
2. Make executable: `chmod +x git/git-<name>`
3. Run `make test-zsh` to verify syntax
4. Installed via `make install-git` to `~/.local/bin/`

### Adding Zsh Functions/Aliases
- Functions: Add to `zsh/zshrc.d/functions.zsh`
- Aliases: Add to `zsh/zshrc.d/aliases.zsh`
- Tool-specific: Create `zsh/zshrc.d/<tool>.zsh`

## Common Patterns

### Checking Command Availability
```zsh
hash nvim 2>/dev/null && alias vim=nvim
```

### Cross-Platform Detection
```zsh
local uname=$(uname)
if [[ "$uname" == "Darwin" ]]; then
    # macOS
elif [[ "$uname" == "Linux" ]]; then
    # Linux
fi
```

### Path Manipulation (zsh)
```zsh
typeset -U path  # unique entries only
path=(/new/path "${path[@]}")
```

### Conditional Homebrew Integration
```zsh
if hash brew 2>/dev/null; then
    prefix="$(brew --prefix)"
    # use $prefix for paths
fi
```

## Warnings

- **Never commit secrets** - Git config uses templates with placeholders
- **Test before installing** - `make -n install` shows what will happen
- **Configs are copied, not linked** - Changes to installed files won't sync back
- **Some targets require sudo** - tarsnap, system launchd configs

## Debugging

- Shell syntax errors: Check line numbers in test output
- Vint errors: Follow vint suggestions, use `--style-problem` flag
- ESLint errors: Run `yarn test-eslint` directly for details
- Installation issues: Run `make -n install-<tool>` to see what will be copied
