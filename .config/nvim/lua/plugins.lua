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

local plugins = {
  {
    'RRethy/nvim-base16',
    lazy = false,
  },

  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = 'BufEnter',
    priority = 100,
    lazy = false,
    opts = function() return require("plug-config.treesitter") end
  },

  {
    'ashinkarov/nvim-agda',
    ft = 'agda'
  },

  {
    'hrsh7th/cmp-nvim-lsp',
    enabled = false,
  },

  {
    'hrsh7th/cmp-buffer',
    enabled = false,
  },

   {
     'neovimhaskell/haskell-vim',
     ft = 'haskell',
   },

  {
    'b3nj5m1n/kommentary',
    keys = { "gcc", {"gc", mode = "v"} }
  },

  {
    'nvim-lualine/lualine.nvim',
    dependencies = {'kyazdani42/nvim-web-devicons'}, opts = function() return require("plug-config.lualine") end,
    lazy = false,
  },

   'LionC/nest.nvim',

  {
    'hrsh7th/nvim-cmp',
    opts = function() return require("plug-config.cmp") end,
    dependencies = { 'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-buffer' },
    enabled = false,
  },
  {
    'dcampos/nvim-snippy',
    opts = function() return require("plug-config.snippy") end,
    enabled = false,
  },

  {
    'dcampos/cmp-snippy',
    enabled = false,
  },

  {
    'norcalli/nvim-colorizer.lua',
    opts = function() return require("plug-config.colorizer") end
  },

  {
    'Julian/lean.nvim',
    opts = function() return require("plug-config.lean") end,
    ft = "lean",
  },

  {
    'neovim/nvim-lspconfig',
    config = require("plug-config.lsp"),
    cmd = "LspStart",
  },

  {
    'nvim-tree/nvim-tree.lua',
    opts = function() return require("plug-config.nvim-tree") end,
    cmd = "NvimTreeFindFileToggle",
  },

  {
    'nvim-telescope/telescope.nvim',
    dependencies = {'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim'},
    cmd = "Telescope"
  },

  {
    'edkolev/tmuxline.vim',
    cmd = "Tmuxline",
  },

   'pineapplegiant/spaceduck',
  {
    'tpope/vim-fugitive',
    cmd = "G"
  },
  {
    "nvim-neorg/neorg",
    build = ":Neorg sync-parsers",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = function() return require("plug-config.neorg") end,
    keys = {
      { "<leader>ww", ":Neorg workspace work<cr>", desc = "Open work" },
      { "<leader>wh", ":Neorg workspace home<cr>", desc = "Open home" },
    },
    cmd = "Neorg",
  },

  --[[ {
    'serenevoid/kiwi.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = function() return require("plug-config.kiwi") end,
    keys = {
      { "<leader>ww", ":lua require(\"kiwi\").open_wiki_index()<cr>", desc = "Open Wiki index" },
      { "<leader>wd", ":lua require(\"kiwi\").open_diary_index()<cr>", desc = "Open Diary index" },
      { "<leader>wn", ":lua require(\"kiwi\").open_diary_new()<cr>", desc = "Open today's Diary" },
    },
  }, ]]
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
