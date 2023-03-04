local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = { {'nvim-treesitter/nvim-treesitter', build = ':TSUpdate', event = 'BufEnter', priority = 100, lazy = false},
                  {'ashinkarov/nvim-agda', ft = 'agda'},
                   'erikbackman/aurora.vim',
                  {'hrsh7th/cmp-nvim-lsp', lazy = true},
                  {'hrsh7th/cmp-buffer', lazy = true},
                  {'neovimhaskell/haskell-vim', ft = 'haskell'},
                  {'b3nj5m1n/kommentary', keys = { "gcc", "gc" }},
                  {'nvim-lualine/lualine.nvim', dependencies = {'kyazdani42/nvim-web-devicons'}},
                  {'nvim-neorg/neorg', build = ':Neorg sync-parsers', dependencies = { 'nvim-lua/plenary.nvim', 'nvim-neorg/neorg-telescope' }, ft = "norg", cmd = "Neorg"},
                   'LionC/nest.nvim',
                  {'hrsh7th/nvim-cmp'},
                   'norcalli/nvim-colorizer.lua',
                   'neovim/nvim-lspconfig',
                   'kyazdani42/nvim-tree.lua',
                   'tweekmonster/startuptime.vim',
                  {'nvim-telescope/telescope.nvim', dependencies = {'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim'}},
                   'edkolev/tmuxline.vim',
                   'p00f/nvim-ts-rainbow',
                   'pineapplegiant/spaceduck',
                   'tpope/vim-fugitive'
                }

local options = {
    defaults = {
        lazy = true,
    },
    performance = {
        cache = { enabled = true },
        reset_packpath = true, -- reset the package path to improve startup time
        rtp = {
            reset = true,
            disabled_plugins = {
                "2html_plugin",
                "getscript",
                "getscriptPlugin",
                "gzip",
                "logipat",
		"fzf",
                "netrw",
                "netrwPlugin",
                "netrwSettings",
                "netrwFileHandlers",
                "matchit",
                "tar",
                "tarPlugin",
                "rrhelper",
                "spellfile_plugin",
                "vimball",
                "vimballPlugin",
                "zip",
                "zipPlugin",
            }
        }
    }
}

require('lazy').setup(plugins, options)
