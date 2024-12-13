--[[

=====================================================================
==================== READ THIS BEFORE CONTINUING ====================
=====================================================================
========                                    .-----.          ========
========         .----------------------.   | === |          ========
========         |.-""""""""""""""""""-.|   |-----|          ========
========         ||                    ||   | === |          ========
========         ||   KICKSTART.NVIM   ||   |-----|          ========
========         ||                    ||   | === |          ========
========         ||                    ||   |-----|          ========
========         ||:Tutor              ||   |:::::|          ========
========         |'-..................-'|   |____o|          ========
========         `"")----------------(""`   ___________      ========
========        /::::::::::|  |::::::::::\  \ no mouse \     ========
========       /:::========|  |==hjkl==:::\  \ required \    ========
========      '""""""""""""'  '""""""""""""'  '""""""""""'   ========
========                                                     ========
=====================================================================
=====================================================================

What is Kickstart?

  Kickstart.nvim is *not* a distribution.

  Kickstart.nvim is a starting point for your own configuration.
    The goal is that you can read every line of code, top-to-bottom, understand
    what your configuration is doing, and modify it to suit your needs.

    Once you've done that, you can start exploring, configuring and tinkering to
    make Neovim your own! That might mean leaving Kickstart just the way it is for a while
    or immediately breaking it into modular pieces. It's up to you!

    If you don't know anything about Lua, I recommend taking some time to read through
    a guide. One possible example which will only take 10-15 minutes:
      - https://learnxinyminutes.com/docs/lua/

    After understanding a bit more about Lua, you can use `:help lua-guide` as a
    reference for how Neovim integrates Lua.
    - :help lua-guide
    - (or HTML version): https://neovim.io/doc/user/lua-guide.html

Kickstart Guide:

  TODO: The very first thing you should do is to run the command `:Tutor` in Neovim.

    If you don't know what this means, type the following:
      - <escape key>
      - :
      - Tutor
      - <enter key>

    (If you already know the Neovim basics, you can skip this step.)

  Once you've completed that, you can continue working through **AND READING** the rest
  of the kickstart init.lua.

  Next, run AND READ `:help`.
    This will open up a help window with some basic information
    about reading, navigating and searching the builtin help documentation.

    This should be the first place you go to look when you're stuck or confused
    with something. It's one of my favorite Neovim features.

    MOST IMPORTANTLY, we provide a keymap "<space>sh" to [s]earch the [h]elp documentation,
    which is very useful when you're not exactly sure of what you're looking for.

  I have left several `:help X` comments throughout the init.lua
    These are hints about where to find more information about the relevant settings,
    plugins or Neovim features used in Kickstart.

   NOTE: Look for lines like this

    Throughout the file. These are for you, the reader, to help you understand what is happening.
    Feel free to delete them once you know what you're doing, but they should serve as a guide
    for when you are first encountering a few different constructs in your Neovim config.

If you experience any errors while trying to install kickstart, run `:checkhealth` for more info.

I hope you enjoy your Neovim journey,
- TJ

P.S. You can delete this when you're done too. It's your config now! :)
--]]

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Make line numbers default
vim.opt.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = false
vim.opt.listchars = { tab = '⇥ ', trail = '·', nbsp = '␣', eol = '¬', extends = '❯', precedes = '❮' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 5

-- Don't wrap
vim.opt.wrap = false

-- Set text width
vim.opt.textwidth = 100
vim.opt.colorcolumn = '+1'

-- From the Vim docs:
-- t   Auto-wrap text using textwidth
--
-- c   Auto-wrap comments using textwidth, inserting the current comment
--     leader automatically.
--
-- r   Automatically insert the current comment leader after hitting
--     <Enter> in Insert mode.
--
-- o   Automatically insert the current comment leader after hitting 'o' or
--     'O' in Normal mode.
--
-- n   When formatting text, recognize numbered lists.  This actually uses
--     the 'formatlistpat' option, thus any kind of list can be used.  The
--     indent of the text after the number is used for the next line.  The
--     default is to find a number, optionally followed by '.', ':', ')',
--     ']' or '}'.  Note that 'autoindent' must be set too.  Doesn't work
--     well together with --2--.
--     Example:
--         1. the first item
--            wraps
vim.opt.formatoptions:append { t = true, c = true, r = true, o = true, n = true }

-- Keep window sizes when closing others
vim.opt.equalalways = false

-- Enable spell checking
vim.opt.spell = true
vim.opt.spelllang = 'en_us'

-- Less busy diff views
vim.opt.diffopt:append { vertical = true, algorithm = 'histogram', ['indent-heuristic'] = true }
vim.opt.fillchars:append { diff = ' ' }

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setqflist, { desc = 'Open diagnostic [Q]uickfix list' })

-- TIP: Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<nop>')
vim.keymap.set('n', '<right>', '<nop>')
vim.keymap.set('n', '<up>', '<nop>')
vim.keymap.set('n', '<down>', '<nop>')

-- Scroll more lines at a time
vim.keymap.set('n', '<C-e>', '5<C-e>')
vim.keymap.set('n', '<C-y>', '5<C-y>')

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
-- vim.api.nvim_create_autocmd('TextYankPost', {
--   desc = 'Highlight when yanking (copying) text',
--   group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
--   callback = function()
--     vim.highlight.on_yank()
--   end,
-- })
vim.api.nvim_create_autocmd('BufReadPost', {
  desc = 'Jump to last cursor position',
  group = vim.api.nvim_create_augroup('last-cursor-position', { clear = true }),
  callback = function()
    if vim.bo.filetype:sub(1, 3) ~= 'git' and vim.fn.line '\'"' > 0 and vim.fn.line '\'"' <= vim.fn.line '$' then
      vim.cmd 'normal! g`"'
    end
  end,
})

vim.api.nvim_create_user_command('E', 'e<bang>', { bang = true, desc = 'Reload current buffer' })
vim.api.nvim_create_user_command('W', 'w<bang>', { bang = true, desc = 'Write current buffer' })
vim.api.nvim_create_user_command('Q', 'q<bang>', { bang = true, desc = 'Quit current buffer' })
vim.api.nvim_create_user_command('WQ', 'wq<bang>', { bang = true, desc = 'Write and quit current buffer' })
vim.api.nvim_create_user_command('Wq', 'wq<bang>', { bang = true, desc = 'Write and quit current buffer' })
vim.api.nvim_create_user_command('WA', 'wa<bang>', { bang = true, desc = 'Write all buffers' })
vim.api.nvim_create_user_command('Wa', 'wa<bang>', { bang = true, desc = 'Write all buffers' })
vim.api.nvim_create_user_command('QA', 'qa<bang>', { bang = true, desc = 'Quit all buffers' })
vim.api.nvim_create_user_command('Qa', 'qa<bang>', { bang = true, desc = 'Quit all buffers' })

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
require('lazy').setup({
  -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  --:Gdiff, :Gcommit, etc.
  'tpope/vim-fugitive',

  -- Javascript syntax
  {
    'othree/yajs.vim',
    ft = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
  },
  {
    'maxmellon/vim-jsx-pretty',
    ft = { 'javascriptreact', 'typescriptreact' },
  },

  -- JSON syntax
  {
    'elzr/vim-json',
    ft = 'json',
  },

  -- JSON formatting with gqaj
  {
    'tpope/vim-jdaddy',
    ft = 'json',
  },

  -- Rainbow parens, brackets, etc. Also affects JSX/HTML nesting
  {
    'hiphish/rainbow-delimiters.nvim',
    config = function()
      require('rainbow-delimiters.setup').setup {
        highlight = {
          'RainbowDelimiterCyan',
          'RainbowDelimiterViolet',
          'RainbowDelimiterYellow',
          'RainbowDelimiterGreen',
          'RainbowDelimiterOrange',
          'RainbowDelimiterBlue',
          'RainbowDelimiterRed',
        },
      }
    end,
  },

  -- Prefer two-way merge with conflicts pre-resolved
  -- Requires gitconfig changes to use as git mergetool
  'samoshkin/vim-mergetool',

  {
    'christoomey/vim-tmux-navigator',
    cmd = {
      'TmuxNavigateLeft',
      'TmuxNavigateDown',
      'TmuxNavigateUp',
      'TmuxNavigateRight',
      'TmuxNavigatePrevious',
    },
    keys = {
      { '<c-h>', '<cmd><C-U>TmuxNavigateLeft<cr>' },
      { '<c-j>', '<cmd><C-U>TmuxNavigateDown<cr>' },
      { '<c-k>', '<cmd><C-U>TmuxNavigateUp<cr>' },
      { '<c-l>', '<cmd><C-U>TmuxNavigateRight<cr>' },
      { '<c-\\>', '<cmd><C-U>TmuxNavigatePrevious<cr>' },
    },
  },

  -- NOTE: Plugins can also be added by using a table,
  -- with the first argument being the link and the following
  -- keys can be used to configure plugin behavior/loading/etc.
  --
  -- Use `opts = {}` to force a plugin to be loaded.
  --

  {
    'ibhagwan/fzf-lua',
    event = 'VimEnter',
    config = function()
      require('fzf-lua').setup { { 'fzf-native' }, fzf_colors = true }

      local fzf = require 'fzf-lua'
      vim.keymap.set('n', '<leader><leader>', fzf.files, { desc = '[ ] Search files' })
      vim.keymap.set('n', '<leader><Left>', fzf.buffers, { desc = '[←] Search buffers' })
      vim.keymap.set('n', 'z=', fzf.spell_suggest, { desc = 'Select suggested spelling' })
    end,
  },

  -- NOTE: Plugins can also be configured to run Lua code when they are loaded.
  --
  -- This is often very useful to both group configuration, as well as handle
  -- lazy loading plugins that don't need to be loaded immediately at startup.
  --
  -- For example, the following:
  --  event = 'VimEnter'
  --
  -- loads the plugin before all the UI elements are loaded. Events can be
  -- normal autocommands events (`:help autocmd-events`).
  --
  -- Then, because we use the `config` key, the configuration only runs
  -- after the plugin has been loaded:
  --  config = function() ... end

  -- NOTE: Plugins can specify dependencies.
  --
  -- The dependencies are proper plugin specifications as well - anything
  -- you do for a plugin at the top level, you can do for a dependency.
  --
  -- Use the `dependencies` key to specify the dependencies of a particular plugin

  -- LSP Plugins
  {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
      },
    },
  },
  { 'Bilal2453/luvit-meta', lazy = true },
  {
    -- Main LSP Configuration
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      { 'williamboman/mason.nvim', config = true }, -- NOTE: Must be loaded before dependents
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Useful status updates for LSP.
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', opts = {} },

      -- Allows extra capabilities provided by nvim-cmp
      'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
      -- Brief aside: **What is LSP?**
      --
      -- LSP is an initialism you've probably heard, but might not understand what it is.
      --
      -- LSP stands for Language Server Protocol. It's a protocol that helps editors
      -- and language tooling communicate in a standardized fashion.
      --
      -- In general, you have a "server" which is some tool built to understand a particular
      -- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc.). These Language Servers
      -- (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
      -- processes that communicate with some "client" - in this case, Neovim!
      --
      -- LSP provides Neovim with features like:
      --  - Go to definition
      --  - Find references
      --  - Autocompletion
      --  - Symbol Search
      --  - and more!
      --
      -- Thus, Language Servers are external tools that must be installed separately from
      -- Neovim. This is where `mason` and related plugins come into play.
      --
      -- If you're wondering about lsp vs treesitter, you can check out the wonderfully
      -- and elegantly composed help section, `:help lsp-vs-treesitter`

      --  This function gets run when an LSP attaches to a particular buffer.
      --    That is to say, every time a new file is opened that is associated with
      --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
      --    function will be executed to configure the current buffer
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          -- NOTE: Remember that Lua is a real programming language, and as such it is possible
          -- to define small helper and utility functions so you don't have to repeat yourself.
          --
          -- In this case, we create a function that lets us more easily define mappings specific
          -- for LSP related items. It sets the mode, buffer and description for us each time.
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          local fzf = require 'fzf-lua'

          -- Jump to the definition of the word under your cursor.
          --  This is where a variable was first declared, or where a function is defined, etc.
          --  To jump back, press <C-t>.
          map('gd', function()
            fzf.lsp_definitions { jump_to_single_result = true }
          end, '[G]oto [D]efinition')

          -- WARN: This is not Goto Definition, this is Goto Declaration.
          --  For example, in C this would take you to the header.
          map('gD', function()
            fzf.lsp_declarations { jump_to_single_result = true }
          end, '[G]oto [D]eclaration')

          -- Find references for the word under your cursor.
          map('gr', fzf.lsp_references, '[G]oto [R]eferences')

          -- Jump to the implementation of the word under your cursor.
          --  Useful when your language has ways of declaring types without an actual implementation.
          map('gI', fzf.lsp_implementations, '[G]oto [I]mplementation')

          -- Jump to the type of the word under your cursor.
          --  Useful when you're not sure what type a variable is and you want to see
          --  the definition of its *type*, not where it was *defined*.
          map('<leader>D', fzf.lsp_typedefs, 'Type [D]efinition')

          -- Fuzzy find all the symbols in your current document.
          --  Symbols are things like variables, functions, types, etc.
          map('<leader>ds', fzf.lsp_document_symbols, '[D]ocument [S]ymbols')

          -- Fuzzy find all the symbols in your current workspace.
          --  Similar to document symbols, except searches over your entire project.
          map('<leader>ws', fzf.lsp_live_workspace_symbols, '[W]orkspace [S]ymbols')

          -- Rename the variable under your cursor.
          --  Most Language Servers support renaming across files, etc.
          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          map('<leader>ca', fzf.lsp_code_actions, '[C]ode [A]ction', { 'n', 'x' })
        end,
      })

      -- LSP servers and clients are able to communicate to each other what features they support.
      --  By default, Neovim doesn't support everything that is in the LSP specification.
      --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      -- Enable the following language servers
      --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
      --
      --  Add any additional override configuration in the following tables. Available keys are:
      --  - cmd (table): Override the default command used to start the server
      --  - filetypes (table): Override the default list of associated filetypes for the server
      --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
      --  - settings (table): Override the default settings passed when initializing the server.
      --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
      local servers = {
        -- clangd = {},
        -- gopls = {},
        -- pyright = {},
        -- rust_analyzer = {},
        -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
        --
        -- Some languages (like typescript) have entire language plugins that can be useful:
        --    https://github.com/pmizio/typescript-tools.nvim
        --
        -- But for many setups, the LSP (`ts_ls`) will work just fine
        -- ts_ls = {},
        --

        lua_ls = {
          -- cmd = {...},
          -- filetypes = { ...},
          -- capabilities = {},
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
              -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
              -- diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },
        ts_ls = {},
        tailwindcss = {
          settings = {
            tailwindCSS = {
              experimental = {
                classRegex = {
                  'tw`([^`]*)',
                  'tw="([^"]*)',
                  'tw={"([^"}]*)',
                  'tw\\.\\w+`([^`]*)',
                  'tw\\(.*?\\)`([^`]*)',
                },
              },
            },
          },
        },
        pyright = {},
        ruff_lsp = {},
        rust_analyzer = {},
      }

      -- Ensure the servers and tools above are installed
      --  To check the current status of installed tools and/or manually install
      --  other tools, you can run
      --    :Mason
      --
      --  You can press `g?` for help in this menu.
      require('mason').setup()

      -- You can add other tools here that you want Mason to install
      -- for you, so that they are available from within Neovim.
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua', -- Used to format Lua code
        'eslint-lsp', -- Used to format js/ts
        'eslint_d', -- Used to format js/ts
        'prettierd', -- Used to format js/ts
        'rustywind', -- Format tailwind classnames
        'codespell',
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for ts_ls)
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },

  { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = {
        timeout_ms = 500,
        lsp_format = 'fallback',
      },
      formatters_by_ft = {
        lua = { 'stylua' },
        -- Conform can also run multiple formatters sequentially
        -- You can use 'stop_after_first' to un the first available formatter from the list
        python = { 'ruff_organize_imports', 'ruff_fix', 'ruff_format' },
        javascript = { 'eslint_d', 'prettierd' },
        javascriptreact = { 'eslint_d', 'prettierd' },
        typescript = { 'eslint_d', 'prettierd' },
        typescriptreact = { 'eslint_d', 'prettierd' },
      },
    },
  },

  { -- Autocompletion
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      {
        'L3MON4D3/LuaSnip',
        build = (function()
          -- Build Step is needed for regex support in snippets.
          -- This step is not supported in many windows environments.
          -- Remove the below condition to re-enable on windows.
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
        dependencies = {
          -- `friendly-snippets` contains a variety of premade snippets.
          --    See the README about individual language/framework/plugin snippets:
          --    https://github.com/rafamadriz/friendly-snippets
          -- {
          --   'rafamadriz/friendly-snippets',
          --   config = function()
          --     require('luasnip.loaders.from_vscode').lazy_load()
          --   end,
          -- },
        },
      },
      'saadparwaiz1/cmp_luasnip',

      -- Adds other completion capabilities.
      --  nvim-cmp does not ship with all sources by default. They are split
      --  into multiple repos for maintenance purposes.
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'f3fora/cmp-spell',
    },
    config = function()
      -- See `:help cmp`
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      luasnip.config.setup {}

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = { completeopt = 'menu,menuone,noinsert' },

        -- For an understanding of why these mappings were
        -- chosen, you will need to read `:help ins-completion`
        --
        -- No, but seriously. Please read `:help ins-completion`, it is really good!
        mapping = cmp.mapping.preset.insert {
          -- Select the [n]ext item
          ['<C-n>'] = cmp.mapping.select_next_item(),
          -- Select the [p]revious item
          ['<C-p>'] = cmp.mapping.select_prev_item(),

          -- Scroll the documentation window [b]ack / [f]orward
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),

          -- Accept ([y]es) the completion.
          --  This will auto-import if your LSP supports it.
          --  This will expand snippets if the LSP sent a snippet.
          ['<C-y>'] = cmp.mapping.confirm { select = true },

          -- If you prefer more traditional completion keymaps,
          -- you can uncomment the following lines
          ['<CR>'] = cmp.mapping.confirm { select = true },
          --['<Tab>'] = cmp.mapping.select_next_item(),
          --['<S-Tab>'] = cmp.mapping.select_prev_item(),

          -- Manually trigger a completion from nvim-cmp.
          --  Generally you don't need this, because nvim-cmp will display
          --  completions whenever it has completion options available.
          ['<C-Space>'] = cmp.mapping.complete {},

          -- Think of <c-l> as moving to the right of your snippet expansion.
          --  So if you have a snippet that's like:
          --  function $name($args)
          --    $body
          --  end
          --
          -- <c-l> will move you to the right of each of the expansion locations.
          -- <c-h> is similar, except moving you backwards.
          -- ['<C-l>'] = cmp.mapping(function()
          --   if luasnip.expand_or_locally_jumpable() then
          --     luasnip.expand_or_jump()
          --   end
          -- end, { 'i', 's' }),
          -- ['<C-h>'] = cmp.mapping(function()
          --   if luasnip.locally_jumpable(-1) then
          --     luasnip.jump(-1)
          --   end
          -- end, { 'i', 's' }),

          -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
          --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
        },
        sources = {
          {
            name = 'lazydev',
            -- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
            group_index = 0,
          },
          { name = 'nvim_lsp' },
          { name = 'supermaven' },
          { name = 'luasnip' },
          { name = 'path' },
          { name = 'spell' },
        },
      }
    end,
  },

  { -- You can easily change to a different colorscheme.
    -- Change the name of the colorscheme plugin below, and then
    -- change the command in the config to whatever the name of that colorscheme is.
    --
    -- If you want to see what colorschemes are already installed, you can use `:FzfLua colorscheme`.
    'folke/tokyonight.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    init = function()
      -- Load the colorscheme here.
      -- Like many other themes, this one has different styles, and you could load
      -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
      vim.o.termguicolors = true
      vim.o.background = 'dark'
      vim.cmd.colorscheme 'tokyonight-storm'

      -- You can configure highlights by doing something like:
      -- vim.cmd.hi 'Comment gui=none'
    end,
  },

  -- Highlight todo, notes, etc in comments
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = {} },

  {
    'folke/trouble.nvim',
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = 'Trouble',
    keys = {
      {
        '<leader>xx',
        '<cmd>Trouble diagnostics toggle<cr>',
        desc = 'Diagnostics (Trouble)',
      },
      {
        '<leader>xX',
        '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
        desc = 'Buffer Diagnostics (Trouble)',
      },
      {
        '<leader>xL',
        '<cmd>Trouble loclist toggle<cr>',
        desc = 'Location List (Trouble)',
      },
      {
        '<leader>xQ',
        '<cmd>Trouble qflist toggle<cr>',
        desc = 'Quickfix List (Trouble)',
      },
    },
  },

  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup()

      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin
      local statusline = require 'mini.statusline'
      statusline.setup {
        -- set use_icons to true if you have a Nerd Font
        use_icons = vim.g.have_nerd_font,
        content = {
          -- show modified flag in inactive buffers
          inactive = function()
            return '%#MiniStatuslineInactive#%F %#Todo#%m%#MiniStatuslineInactive#%='
          end,
        },
      }

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end

      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_filename = function()
        return '%f %#Todo#%m%#MinistatusLineFilename#'
      end

      -- Similar to vim-sensible, but broader.
      --   Some config and options above likely duplicate this.
      require('mini.basics').setup {
        options = {
          basic = true,
          extra_ui = true,
        },
        mappings = {
          basic = false,
          windows = true,
        },
        autocommands = {
          basic = true,
        },
      }

      -- Keymaps for forwards/backwards objects, like vim-unimpaired
      require('mini.bracketed').setup()

      -- Automatically pair brackets, parens, etc.
      require('mini.pairs').setup()

      -- Diff hunk manipulation
      require('mini.diff').setup {
        view = {
          style = 'sign',
        },
      }
      vim.keymap.set('n', '<leader>do', require('mini.diff').toggle_overlay, { desc = 'Toggle [D]iff [O]verlay' })

      -- Fun icons for filetypes, actions, signs, etc.
      require('mini.icons').setup()

      -- Better un/commenting, text object
      require('mini.comment').setup()

      -- Higlight the word under the cursor
      require('mini.cursorword').setup()

      -- f, t, F, T are repeatable motions
      require('mini.jump').setup()

      -- Jump to locations with <enter>
      require('mini.jump2d').setup {
        view = {
          dim = true,
          n_steps_ahead = 1,
        },
      }

      local miniclue = require 'mini.clue'
      miniclue.setup { -- cute prompts about bindings
        triggers = {
          { mode = 'n', keys = '<Leader>' },
          { mode = 'x', keys = '<Leader>' },

          -- Built-in completion
          { mode = 'i', keys = '<C-x>' },

          -- `g` key
          { mode = 'n', keys = 'g' },
          { mode = 'x', keys = 'g' },

          -- Marks
          { mode = 'n', keys = "'" },
          { mode = 'n', keys = '`' },
          { mode = 'x', keys = "'" },
          { mode = 'x', keys = '`' },

          -- Registers
          { mode = 'n', keys = '"' },
          { mode = 'x', keys = '"' },
          { mode = 'i', keys = '<C-r>' },
          { mode = 'c', keys = '<C-r>' },

          -- Window commands
          { mode = 'n', keys = '<C-w>' },

          -- `z` key
          { mode = 'n', keys = 'z' },
          { mode = 'x', keys = 'z' },

          -- Bracketed
          { mode = 'n', keys = '[' },
          { mode = 'n', keys = ']' },

          -- Option toggles
          { mode = 'n', keys = '\\' },
        },
        clues = {
          miniclue.gen_clues.builtin_completion(),
          miniclue.gen_clues.g(),
          miniclue.gen_clues.marks(),
          miniclue.gen_clues.registers(),
          miniclue.gen_clues.windows(),
          miniclue.gen_clues.z(),
        },
        window = {
          delay = 100,
          config = { width = 'auto' },
          scroll_down = '<C-d>',
          scroll_up = '<C-u>',
        },
      }
      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },

  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs', -- Sets main module to use for opts
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
    opts = {
      ensure_installed = {
        'bash',
        'c',
        'diff',
        'html',
        'lua',
        'luadoc',
        'markdown',
        'markdown_inline',
        'query',
        'vim',
        'vimdoc',
        'python',
        'typescript',
        'javascript',
      },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = false,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true },
    },
    -- There are additional nvim-treesitter modules that you can use to interact
    -- with nvim-treesitter. You should go explore a few and see what interests you:
    --
    --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
    --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
    --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  },

  -- The following two comments only work if you have downloaded the kickstart repo, not just copy pasted the
  -- init.lua. If you want these files, they are in the repository, so you can just download them and
  -- place them in the correct locations.

  -- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for Kickstart
  --
  --  Here are some example plugins that I've included in the Kickstart repository.
  --  Uncomment any of the lines below to enable them (you will need to restart nvim).
  --
  -- require 'kickstart.plugins.debug',
  -- require 'kickstart.plugins.indent_line',
  -- require 'kickstart.plugins.lint',
  -- require 'kickstart.plugins.autopairs',
  -- require 'kickstart.plugins.neo-tree',
  -- require 'kickstart.plugins.gitsigns', -- adds gitsigns recommend keymaps

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    This is the easiest way to modularize your config.
  --
  --  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  --    For additional information, see `:help lazy.nvim-lazy.nvim-structuring-your-plugins`
  -- { import = 'custom.plugins' },
  {
    'supermaven-inc/supermaven-nvim',
    opts = {},
  },
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
