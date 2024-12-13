I have hesitated to migrate to neovim for a while, but after discussing with a coworker last week I
decided to check it out more in depth yesterday. I have migrated maybe 90% of my vim config to
neovim, and I wanted to share some highlights of the process.

- First-class LSP support. I had LSP support in vim via coc.nvim, but it always felt bolted on and
  not really seamless or well integrated. With neovim, there's a ton of built-in LSP functionality,
  plus even more support from plugins. Mason provides a great UI to manage LSP tools and servers.
- Tree-sitter support. Again, I had a taste of this with vim, but in neovim it's first-class. I
  also migrated a bunch of plugins to use the `mini.nvim` modules, which are mostly TS-aware.
- Supermaven. I really wanted a chance to use a Copilote alternative, but Supermaven is neovim-only.
  It was a breeze to set up and integrate with the cmp support in neovim.
- kickstart.nvim is a great starting point. It's not a plugin, but it's an actually config file that
  you copy and use as a starting point. It's a bit daunting at nearly 1k lines, but there are a ton
  of comments.
- lazy.nvim plugin management. It's simple, but it makes so much more sense to tie config/init to
  the plugin spec itself rather than to set a bunch of globals before loading plugins.

All that's left is for me to start using this new setup and find the edge cases. I have a few
vim-specific settings and autocommands that I haven't tested out (or missed) yet. Plus I need to
fold my neovim config into my existing dotfiles repo and installation process.

Some of this feels pretty far away from "the vim way" but I'm trying to be open-minded.

I also used this article as a reference for minimizing config and trying to be more vim-like, which
is ironic because this article centers around making neovim feel like Helix. But both have strong
opinions and conventions, and leaning into those feels right.
