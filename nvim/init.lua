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
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Make line numbers default
vim.o.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
vim.o.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.o.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.o.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.o.list = false
vim.opt.listchars = { tab = '⇥ ', trail = '·', nbsp = '␣', eol = '¬', extends = '❯', precedes = '❮' }

-- Preview substitutions live, as you type!
vim.o.inccommand = 'split'

-- Show which line your cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10
vim.o.sidescrolloff = 5

-- Don't wrap
vim.o.wrap = false

-- Set text width
vim.o.textwidth = 100
vim.o.colorcolumn = '+1'

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
vim.o.equalalways = false

-- Enable spell checking
vim.o.spell = false
vim.o.spelllang = 'en_us'

-- Less busy diff views
vim.opt.diffopt:append { vertical = true, algorithm = 'histogram', ['indent-heuristic'] = true }
vim.opt.fillchars:append { diff = ' ' }

-- Show matching parens
vim.o.showmatch = true

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.o.confirm = true

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setqflist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Scroll more lines at a time
vim.keymap.set('n', '<C-e>', '5<C-e>')
vim.keymap.set('n', '<C-y>', '5<C-y>')

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`
vim.api.nvim_create_autocmd('BufReadPost', {
  desc = 'Jump to last cursor position',
  group = vim.api.nvim_create_augroup('last-cursor-position', { clear = true }),
  callback = function()
    if vim.bo.filetype:sub(1, 3) ~= 'git' and vim.fn.line '\'"' > 0 and vim.fn.line '\'"' <= vim.fn.line '$' then
      vim.cmd 'normal! g`"'
    end
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  desc = 'Prose formatting and wrapped line display',
  group = vim.api.nvim_create_augroup('text-formatting', { clear = true }),
  pattern = { 'markdown', 'ghmarkdown', 'git*', 'text' },
  callback = function()
    vim.bo.textwidth = 0
    vim.bo.wrapmargin = 0

    vim.wo.wrap = true
    vim.wo.linebreak = true
    vim.wo.breakindent = true
    vim.wo.showbreak = '» '
    -- 2 to hide conceal text
    vim.wo.conceallevel = 2
  end,
})

-- [[ User commands ]]
vim.api.nvim_create_user_command('E', 'e<bang>', { bang = true, desc = 'Reload current buffer' })
vim.api.nvim_create_user_command('W', 'w<bang>', { bang = true, desc = 'Write current buffer' })
vim.api.nvim_create_user_command('Q', 'q<bang>', { bang = true, desc = 'Quit current buffer' })
vim.api.nvim_create_user_command('WQ', 'wq<bang>', { bang = true, desc = 'Write and quit current buffer' })
vim.api.nvim_create_user_command('Wq', 'wq<bang>', { bang = true, desc = 'Write and quit current buffer' })
vim.api.nvim_create_user_command('WA', 'wa<bang>', { bang = true, desc = 'Write all buffers' })
vim.api.nvim_create_user_command('Wa', 'wa<bang>', { bang = true, desc = 'Write all buffers' })
vim.api.nvim_create_user_command('QA', 'qa<bang>', { bang = true, desc = 'Quit all buffers' })
vim.api.nvim_create_user_command('Qa', 'qa<bang>', { bang = true, desc = 'Quit all buffers' })
vim.api.nvim_create_user_command('Wqa', 'wqa<bang>', { bang = true, desc = 'Write and quit all buffers' })

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

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

  -- :Gdiff, :Gcommit, etc.
  'tpope/vim-fugitive',

  -- :GBrowse with Github
  'tpope/vim-rhubarb',

  -- Netrw improvements
  {
    'tpope/vim-vinegar',
    init = function()
      vim.cmd [[ nnoremap - -]]
    end,
  },

  -- JSON syntax, concealment
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
          'RainbowDelimiterBlue',
          'RainbowDelimiterYellow',
          'RainbowDelimiterGreen',
          'RainbowDelimiterOrange',
          'RainbowDelimiterCyan',
          'RainbowDelimiterRed',
        },
      }
    end,
  },

  -- Prefer two-way merge with conflicts pre-resolved
  -- Requires gitconfig changes to use as git mergetool
  'samoshkin/vim-mergetool',

  -- Navigate between vim and tmux panes with the same keys
  {
    'alexghergh/nvim-tmux-navigation',
    config = function()
      require('nvim-tmux-navigation').setup {
        keybindings = {
          left = '<C-h>',
          down = '<C-j>',
          up = '<C-k>',
          right = '<C-l>',
          last_active = '<C-\\>',
          next = '<C-Space>',
        },
      }
    end,
  },

  -- NOTE: Plugins can also be added by using a table,
  -- with the first argument being the link and the following
  -- keys can be used to configure plugin behavior/loading/etc.
  --
  -- Use `opts = {}` to automatically pass options to a plugin's `setup()` function, forcing the plugin to be loaded.
  --

  -- FZF-powered pickers for many lists: files, buffers, git, keymaps, etc.
  {
    'ibhagwan/fzf-lua',
    event = 'VimEnter',
    config = function()
      local fzf = require 'fzf-lua'
      fzf.setup {
        { 'fzf-tmux' },
        fzf_colors = true,
        winopts = {
          preview = {
            default = 'bat',
            hidden = false,
            horizontal = 'right:40%',
          },
        },
        keymap = {
          fzf = {
            -- inherits the default keymaps
            true,
            -- use C-q to select all items and convert to quickfix list
            ['ctrl-q'] = 'select-all+accept',
          },
        },
      }

      -- Use the fzf-lua UI for vim.ui.select
      fzf.register_ui_select()

      vim.keymap.set('n', '<leader><leader>', fzf.files, { desc = '[ ] Pick files' })
      vim.keymap.set('n', "<leader>'", fzf.buffers, { desc = "['] Pick buffers" })
      vim.keymap.set('n', '<leader>,', fzf.git_files, { desc = '[,] Pick git files' })
      vim.keymap.set('n', '<leader><', fzf.git_status, { desc = '[<] Pick git files with status' })
      vim.keymap.set('n', '<leader>.', fzf.grep_cword, { desc = 'Search word under cursor' })
      vim.keymap.set('n', '<leader>>', fzf.grep_cWORD, { desc = 'Search WORD under cursor' })
      vim.keymap.set('n', '<leader>p', fzf.grep_project, { desc = 'Search [p]roject' })
      vim.keymap.set('n', 'z=', fzf.spell_suggest, { desc = 'Select suggested spelling' })
    end,
  },

  -- Inline line-wise git blame
  {
    'f-person/git-blame.nvim',
    opts = {
      enabled = false,
      date_format = '%r',
      virtual_text_column = 100,
    },
    keys = {
      {
        '<leader>gb',
        function()
          vim.cmd.GitBlameToggle()
        end,
        desc = '[G]it [B]lame',
      },
    },
  },

  -- NOTE: Plugins can also be configured to run Lua code when they are loaded.
  --
  -- This is often very useful to both group configuration, as well as handle
  -- lazy loading plugins that don't need to be loaded immediately at startup.
  --
  -- For example, in the following configuration, we use:
  --  event = 'VimEnter'
  --
  -- which loads which-key before all the UI elements are loaded. Events can be
  -- normal autocommands events (`:help autocmd-events`).
  --
  -- Then, because we use the `opts` key (recommended), the configuration runs
  -- after the plugin has been loaded as `require(MODULE).setup(opts)`.

  -- Useful plugin to show you pending key bindings
  {
    'folke/which-key.nvim',
    -- Sets the loading event to 'VimEnter'
    event = 'VimEnter',
    opts = {
      -- delay between pressing a key and opening which-key (milliseconds)
      -- this setting is independent of vim.o.timeoutlen
      delay = 0,
      icons = {
        -- set icon mappings to true if you have a Nerd Font
        mappings = vim.g.have_nerd_font,
        -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
        -- default which-key.nvim defined Nerd Font icons, otherwise define a string table
        keys = vim.g.have_nerd_font and {} or {
          Up = '<Up> ',
          Down = '<Down> ',
          Left = '<Left> ',
          Right = '<Right> ',
          C = '<C-…> ',
          M = '<M-…> ',
          D = '<D-…> ',
          S = '<S-…> ',
          CR = '<CR> ',
          Esc = '<Esc> ',
          ScrollWheelDown = '<ScrollWheelDown> ',
          ScrollWheelUp = '<ScrollWheelUp> ',
          NL = '<NL> ',
          BS = '<BS> ',
          Space = '<Space> ',
          Tab = '<Tab> ',
          F1 = '<F1>',
          F2 = '<F2>',
          F3 = '<F3>',
          F4 = '<F4>',
          F5 = '<F5>',
          F6 = '<F6>',
          F7 = '<F7>',
          F8 = '<F8>',
          F9 = '<F9>',
          F10 = '<F10>',
          F11 = '<F11>',
          F12 = '<F12>',
        },
      },

      -- Document existing key chains
      spec = {
        { '<leader>c', group = '[C]ode', mode = { 'n', 'x' } },
        { '<leader>d', group = '[D]ocument' },
        { '<leader>g', group = '[G]it' },
        { '<leader>x', group = 'Diagnostics' },
      },
    },
  }, -- after the plugin has been loaded as `require(MODULE).setup(opts)`.

  -- NOTE: Plugins can specify dependencies.
  --
  -- The dependencies are proper plugin specifications as well - anything
  -- you do for a plugin at the top level, you can do for a dependency.
  --
  -- Use the `dependencies` key to specify the dependencies of a particular plugin

  -- LSP Plugins

  -- `lazydev` configures Lua LSP for your Neovim config, runtime, and plugins
  -- used for completion, annotations and signatures of Neovim APIs
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        {
          path = '${3rd}/luv/library',
          words = { 'vim%.uv' },
        },
      },
    },
  },

  -- Main LSP Configuration
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      -- Mason must be loaded before its dependents so we need to set it up here.
      -- NOTE: `opts = {}` is the same as calling `require('mason').setup({})`
      { 'mason-org/mason.nvim', opts = {} },
      'mason-org/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      { 'zapling/mason-lock.nvim', opts = {} },

      -- Useful status updates for LSP.
      { 'j-hui/fidget.nvim', opts = {} },

      -- Allows extra capabilities provided by blink.cmp
      'saghen/blink.cmp',
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

          -- Rename the variable under your cursor.
          --  Most Language Servers support renaming across files, etc.
          map('grn', vim.lsp.buf.rename, '[R]e[n]ame')

          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          map('gra', fzf.lsp_code_actions, 'Code [A]ction', { 'n', 'x' })

          -- Find references for the word under your cursor.
          map('grr', fzf.lsp_references, '[G]oto [R]eferences')

          -- Jump to the implementation of the word under your cursor.
          --  Useful when your language has ways of declaring types without an actual implementation.
          map('gri', fzf.lsp_implementations, '[G]oto [I]mplementation')

          -- Jump to the definition of the word under your cursor.
          --  This is where a variable was first declared, or where a function is defined, etc.
          --  To jump back, press <C-t>.
          map('grd', function()
            fzf.lsp_definitions { jump1 = true }
          end, '[G]oto [D]efinition')

          -- WARN: This is not Goto Definition, this is Goto Declaration.
          --  For example, in C this would take you to the header.
          map('grD', function()
            fzf.lsp_declarations { jump1 = true }
          end, '[G]oto [D]eclaration')

          -- Fuzzy find all the symbols in your current document.
          --  Symbols are things like variables, functions, types, etc.
          map('gO', fzf.lsp_document_symbols, 'Document Symbols')

          -- Fuzzy find all the symbols in your current workspace.
          --  Similar to document symbols, except searches over your entire project.
          map('gW', fzf.lsp_live_workspace_symbols, '[W]orkspace Symbols')

          -- Jump to the type of the word under your cursor.
          --  Useful when you're not sure what type a variable is and you want to see
          --  the definition of its *type*, not where it was *defined*.
          map('grt', function()
            fzf.lsp_typedefs { jump1 = true }
          end, '[T]ype Definition')
        end,
      })

      -- Diagnostic Config
      -- See :help vim.diagnostic.Opts
      vim.diagnostic.config {
        severity_sort = true,
        float = { border = 'rounded', source = 'if_many' },
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = vim.g.have_nerd_font and {
          text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN] = '󰀪 ',
            [vim.diagnostic.severity.INFO] = '󰋽 ',
            [vim.diagnostic.severity.HINT] = '󰌶 ',
          },
        } or {},
        virtual_text = {
          source = 'if_many',
          spacing = 2,
          format = function(diagnostic)
            local diagnostic_message = {
              [vim.diagnostic.severity.ERROR] = diagnostic.message,
              [vim.diagnostic.severity.WARN] = diagnostic.message,
              [vim.diagnostic.severity.INFO] = diagnostic.message,
              [vim.diagnostic.severity.HINT] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
          end,
        },
      }

      -- LSP servers and clients are able to communicate to each other what features they support.
      --  By default, Neovim doesn't support everything that is in the LSP specification.
      --  When you add blink.cmp, luasnip, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilities with blink.cmp, and then broadcast that to the servers.
      local capabilities = require('blink.cmp').get_lsp_capabilities()

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
          -- cmd = { ... },
          -- filetypes = { ... },
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
                  { 'c(?:ls)?x\\(([^)]*)\\)', '["\'`]([^"\'`]*)["\'`]' },
                },
              },
            },
          },
        },
        basedpyright = {},
        ruff = {},
        rust_analyzer = {},
        stylelint_lsp = {},
        cssls = {},
        css_variables = {},
        sqlls = {},
        buf_ls = {},
        harper_ls = {
          settings = {
            ['harper-ls'] = {
              linters = {
                SentenceCapitalization = false,
                Spaces = false,
              },
            },
          },
        },
      }

      -- Ensure the servers and tools above are installed
      --
      -- To check the current status of installed tools and/or manually install
      -- other tools, you can run
      --    :Mason
      --
      -- You can press `g?` for help in this menu.
      --
      -- `mason` had to be setup earlier: to configure its options see the
      -- `dependencies` table for `nvim-lspconfig` above.
      --
      -- You can add other tools here that you want Mason to install
      -- for you, so that they are available from within Neovim.
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua', -- Used to format Lua code
        'biome', -- Used to format js/ts
        'eslint', -- Used to format js/ts
        'eslint_d', -- Used to format js/ts
        'prettierd', -- Used to format js/ts
        'stylelint', -- Used to format css
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        ensure_installed = {}, -- explicitly set to an empty table (Kickstart populates installs via mason-tool-installer)
        automatic_installation = false,
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

  -- Typescript specific LSP config
  {
    'pmizio/typescript-tools.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
    opts = {
      settings = {
        tsserver_file_preferences = {
          importModuleSpecifierPreference = 'non-relative',
          includeInlayParameterNameHints = 'all',
          includeInlayParameterNameHintsWhenArgumentMatchesName = true,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayVariableTypeHintsWhenTypeMatchesName = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
        },
        jsx_close_tag = {
          enabled = true,
        },
      },
    },
  },

  -- Autoformat
  {
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
    config = function()
      require('conform').setup {
        notify_on_error = false,
        format_on_save = {
          timeout_ms = 500,
          lsp_format = 'fallback',
        },
        formatters = {
          ['biome-check'] = {
            require_cwd = true,
          },
          eslint_d = {
            -- for some reason, the default cwd for eslint_d only looks for package.json
            cwd = require('conform.util').root_file {
              '.eslintrc.js',
              '.eslintrc.json',
              '.eslintrc.yaml',
              'eslint.config.js',
              'eslint.config.mjs',
              'eslint.config.cjs',
              'eslint.config.ts',
            },
            require_cwd = true,
          },
          prettierd = {
            require_cwd = true,
          },
        },
        formatters_by_ft = {
          lua = { 'stylua' },
          -- Conform can also run multiple formatters sequentially
          -- You can use 'stop_after_first' to run the first available formatter from the list
          python = { 'ruff_organize_imports', 'ruff_fix', 'ruff_format' },
          javascript = { 'biome-check', 'eslint_d', 'prettierd' },
          javascriptreact = { 'biome-check', 'eslint_d', 'prettierd' },
          typescript = { 'biome-check', 'eslint_d', 'prettierd' },
          typescriptreact = { 'biome-check', 'eslint_d', 'prettierd' },
          markdown = { 'prettierd', 'injected' },
          css = { 'stylelint' },
          proto = { 'buf' },
          ['*'] = { 'trim_whitespace' },
        },
      }
    end,
  },

  { -- Autocompletion
    'saghen/blink.cmp',
    event = 'VimEnter',
    version = '1.*',
    dependencies = {
      { 'supermaven-inc/supermaven-nvim', opts = {} },
      'huijiro/blink-cmp-supermaven',
    },
    --- @module 'blink.cmp'
    --- @type blink.cmp.Config
    opts = {
      keymap = {
        -- 'default' (recommended) for mappings similar to built-in completions
        --   <c-y> to accept ([y]es) the completion.
        --    This will auto-import if your LSP supports it.
        --    This will expand snippets if the LSP sent a snippet.
        -- 'super-tab' for tab to accept
        -- 'enter' for enter to accept
        -- 'none' for no mappings
        --
        -- For an understanding of why the 'default' preset is recommended,
        -- you will need to read `:help ins-completion`
        --
        -- No, but seriously. Please read `:help ins-completion`, it is really good!
        --
        -- All presets have the following mappings:
        -- <tab>/<s-tab>: move to right/left of your snippet expansion
        -- <c-space>: Open menu or open docs if already open
        -- <c-n>/<c-p> or <up>/<down>: Select next/previous item
        -- <c-e>: Hide menu
        -- <c-k>: Toggle signature help
        --
        -- See :h blink-cmp-config-keymap for defining your own keymap
        preset = 'default',

        -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
        --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
      },

      appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono',
      },

      completion = {
        -- By default, you may press `<c-space>` to show the documentation.
        -- Optionally, set `auto_show = true` to show the documentation after a delay.
        documentation = { auto_show = false, auto_show_delay_ms = 500 },
      },

      sources = {
        default = { 'lsp', 'supermaven', 'path', 'buffer' },
        providers = {
          supermaven = {
            name = 'supermaven',
            module = 'blink-cmp-supermaven',
            async = true,
          },
        },
      },

      -- Blink.cmp includes an optional, recommended rust fuzzy matcher,
      -- which automatically downloads a prebuilt binary when enabled.
      --
      -- By default, we use the Lua implementation instead, but you may enable
      -- the rust implementation via `'prefer_rust_with_warning'`
      --
      -- See :h blink-cmp-config-fuzzy for more information
      fuzzy = { implementation = 'lua' },

      -- Shows a signature help window while you type arguments for a function
      signature = { enabled = true },
    },
  },

  -- Colorscheme
  { -- You can easily change to a different colorscheme.
    -- Change the name of the colorscheme plugin below, and then
    -- change the command in the config to whatever the name of that colorscheme is.
    --
    -- If you want to see what colorschemes are already installed, you can use `:FzfLua colorscheme`.
    'shaunsingh/nord.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    init = function()
      vim.o.termguicolors = true
      vim.o.background = 'dark'
      vim.g.nord_contrast = true
      vim.g.nord_borders = true
      vim.cmd.colorscheme 'nord'
    end,
  },

  -- Highlight todo, notes, etc in comments
  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {},
  },

  -- Diagnostics display
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

  -- Focus mode for prose filetypes
  {
    'folke/zen-mode.nvim',
    ft = { 'markdown', 'ghmarkdown', 'text', 'gitcommit' },
    event = 'VimEnter',
    opts = {
      window = {
        width = 0.65,
      },
    },
    config = function()
      vim.api.nvim_create_autocmd({ 'VimEnter' }, {
        desc = 'Zen mode for prose',
        group = vim.api.nvim_create_augroup('zen-mode', { clear = true }),
        pattern = { '*.md', '*.markdown', '*.txt', 'COMMIT_EDITMSG' },
        callback = function()
          require('zen-mode').open { window = { width = 0.65 } }
        end,
      })
    end,
  },

  -- Color highlighting
  {
    'uga-rosa/ccc.nvim',
    opts = {
      highlighter = {
        auto_enable = true,
      },
      lsp = true,
    },
  },

  -- Collection of various small independent plugins/modules
  {
    'echasnovski/mini.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' },
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      local spec_treesitter = require('mini.ai').gen_spec.treesitter
      require('mini.ai').setup {
        custom_textobjects = {
          F = spec_treesitter {
            a = '@function.outer',
            i = '@function.inner',
          },
          o = spec_treesitter {
            a = { '@conditional.outer', '@loop.outer' },
            i = { '@conditional.inner', '@loop.inner' },
          },
        },
      }

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
          -- show modified flag in inactive windows
          inactive = function()
            return '%#MiniStatuslineInactive#%f %#Todo#%m%#MiniStatuslineInactive#%='
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
        return '%f %#DiffChange#%m%#MinistatusLineFilename#'
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
      require('mini.bracketed').setup {
        -- Use mappings from mini.indentscope
        indent = { suffix = '' },

        -- Disable mappings that are defined elsewhere
        file = { suffix = '' },
        window = { suffix = '' },
      }

      -- Automatically pair brackets, parens, etc.
      require('mini.pairs').setup {
        mappings = {
          -- Single quote: Prevent pairing if either side is a letter
          ['"'] = {
            action = 'closeopen',
            pair = '""',
            neigh_pattern = '[^%w\\][^%w]',
            register = { cr = false },
          },
          -- Single quote: Prevent pairing if either side is a letter
          ["'"] = {
            action = 'closeopen',
            pair = "''",
            neigh_pattern = '[^%w\\][^%w]',
            register = { cr = false },
          },
          -- Backtick: Prevent pairing if either side is a letter
          ['`'] = {
            action = 'closeopen',
            pair = '``',
            neigh_pattern = '[^%w\\][^%w]',
            register = { cr = false },
          },
        },
        skip_ts = { 'string', 'comment' },
        skip_unbalanced = true,
        markdown = true,
      }

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

      -- Highlight the word under the cursor
      require('mini.cursorword').setup()

      -- t, f, T, F are repeatable motions
      -- Highlight the next motion for subsequent tfTF motions
      require('mini.jump').setup {
        delay = {
          -- Delay between jump and highlighting all possible jumps
          highlight = 1000,
          -- Delay between jump and automatic stop if idle (no jump is done)
          idle_stop = 3000,
        },
      }

      -- Jump to locations with <enter>
      require('mini.jump2d').setup {
        view = {
          dim = true,
          n_steps_ahead = 2,
        },
        allowed_lines = {
          cursor_at = false,
          blank = false,
          fold = false,
        },
      }

      -- Highlight trailing whitespace and automatically trim it on write
      require('mini.trailspace').setup()

      -- Indent guides
      local indentscope = require 'mini.indentscope'
      indentscope.setup {
        draw = {
          animation = indentscope.gen_animation.none(),
        },
      }
    end,
  },

  -- Highlight, edit, and navigate code
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs', -- Sets main module to use for opts
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
    opts = {
      ensure_installed = {
        'bash',
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
        'css',
      },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true },
    },
    config = function()
      -- <C-l> jumps to the end of the current treesitter node
      vim.keymap.set('i', '<C-L>', function()
        local node = vim.treesitter.get_node()
        if node ~= nil then
          local row, col = node:end_()
          pcall(vim.api.nvim_win_set_cursor, 0, { row + 1, col })
        end
      end, { desc = 'insjump' })
    end,
    -- There are additional nvim-treesitter modules that you can use to interact
    -- with nvim-treesitter. You should go explore a few and see what interests you:
    --
    --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
    --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
    --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  },

  -- Allow zip file reading
  'lbrayner/vim-rzip',

  -- Edit and manage Obsidian notes and links
  {
    'obsidian-nvim/obsidian.nvim',
    version = '*', -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = 'markdown',
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    -- event = {
    --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
    --   -- refer to `:h file-pattern` for more examples
    --   'BufReadPre '
    --     .. vim.fn.expand '~'
    --     .. '/Library/Mobile Documents/iCloud~md~obsidian/Documents/Obsidian Vault/**/*.md',
    --   'BufNewFile ' .. vim.fn.expand '~' .. '/Library/Mobile Documents/iCloud~md~obsidian/Documents/Obsidian Vault/**/*.md',
    -- },
    dependencies = {
      -- Required.
      'nvim-lua/plenary.nvim',

      -- Optional.
      'saghen/blink.cmp',
      'ibhagwan/fzf-lua',
      'nvim-treesitter/nvim-treesitter',
    },
    opts = {
      workspaces = {
        {
          name = 'work',
          path = '~/Library/Mobile Documents/iCloud~md~obsidian/Documents/Obsidian Vault',
        },
      },
      completion = {
        nvim_cmp = false,
        blink = true,
        min_chars = 1,
      },
    },
  },

  -- Enforce better vim motions and text objects
  {
    'm4xshen/hardtime.nvim',
    dependencies = {
      'MunifTanjim/nui.nvim',
    },
    opts = {
      disable_mouse = false,
      max_count = 7,
      max_time = 500,
    },
  },

  -- The following comments only work if you have downloaded the kickstart repo, not just copy pasted the
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
  -- { import = 'custom.plugins' },
  --
  -- For additional information with loading, sourcing and examples see `:help lazy.nvim-🔌-plugin-spec`
  -- Or use telescope!
  -- In normal mode type `<space>sh` then write `lazy.nvim-plugin`
  -- you can continue same window with `<space>sr` which resumes last telescope search
}, {})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
