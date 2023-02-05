local packer = require "packer"
local use = packer.use
return packer.startup({
    function()
	use {
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate'
	}
	use 'ashinkarov/nvim-agda'
	use 'erikbackman/aurora.vim'
	use {
		'hrsh7th/cmp-nvim-lsp',
	}
	use 'hrsh7th/cmp-buffer'
	use 'neovimhaskell/haskell-vim'
	use 'lewis6991/impatient.nvim'
	use 'b3nj5m1n/kommentary'
	use {
		'nvim-lualine/lualine.nvim',
		requires = {'kyazdani42/nvim-web-devicons', opt = true}
	}
	use {
		'nvim-neorg/neorg',
		run = ":Neorg sync-parsers",
		requires = { "nvim-lua/plenary.nvim", "nvim-neorg/neorg-telescope" },
	}
	use 'LionC/nest.nvim'
	use 'hrsh7th/nvim-cmp'
	use 'norcalli/nvim-colorizer.lua'
	use 'neovim/nvim-lspconfig'
	use 'kyazdani42/nvim-tree.lua'
	use 'kyazdani42/nvim-web-devicons'
	use 'wbthomason/packer.nvim'
	use {
		"tweekmonster/startuptime.vim",
	}
	use {
		'nvim-telescope/telescope.nvim',
		requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
	}
	use 'edkolev/tmuxline.vim'
	use 'p00f/nvim-ts-rainbow'
	use 'pineapplegiant/spaceduck'
	use 'tpope/vim-fugitive'
    end,
    config = {
    -- Move to lua dir so impatient.nvim can cache it
    compile_path = vim.fn.stdpath('config')..'/lua/packer_compiled.lua'
    }
})
