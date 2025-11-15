# AGENTS.md

## Build/Lint/Test Commands

- `make test` - Run all tests (zsh/bash syntax, vim linting, eslint)
- `make test-zsh` - Test zsh config syntax only
- `make test-bash` - Test bash config syntax only
- `make test-vimrc` - Lint vim config files with vint
- `make test-dotjs` - Lint JavaScript files with eslint
- `yarn test` - Run eslint on dotjs files
- `yarn test-eslint` - Direct eslint command for dotjs

## Code Style Guidelines

### JavaScript (dotjs/)
- Use ESLint config in `eslint/eslintrc.js`
- ES6+ features allowed (arrow functions, destructuring, template strings)
- No semicolons, flexible quotes, no strict indentation rules
- Use `@babel/eslint-parser` with ecmaVersion 8
- Prefer dot notation over bracket notation
- No eval, no extending native prototypes

### Shell Scripts (zsh/bash)
- All scripts must parse with `zsh --no-exec` or `bash -n`
- Follow existing naming conventions in git/ scripts
- Use functions for reusable code blocks

### Vim/Neovim
- Vim configs linted with vint
- Neovim uses Lua (Kickstart.nvim based)
- Keep configurations modular and readable

### General
- No trailing whitespace in most files
- Use existing file structure and naming patterns
- Test changes with relevant `make test-*` commands
