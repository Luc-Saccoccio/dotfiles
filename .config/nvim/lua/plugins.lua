local packer = require "packer"
local use = packer.use
return packer.startup({
	function()
		use {
			'hrsh7th/cmp-nvim-lsp',
		}
		use {
			'hrsh7th/cmp-nvim-lua',
		}
		use 'hrsh7th/cmp-buffer'
		use 'f3fora/cmp-spell'
		use {
			'saadparwaiz1/cmp_luasnip',
		}
		use 'nathom/filetype.nvim'
		use {
			'rafamadriz/friendly-snippets',
			event = "InsertEnter",
		}
		use {
			'neovimhaskell/haskell-vim',
			ft = 'haskell'
		}
		use 'lewis6991/impatient.nvim'
		use 'lukas-reineke/indent-blankline.nvim'
		use 'b3nj5m1n/kommentary'
		use {
			'nvim-lualine/lualine.nvim',
			requires = {'kyazdani42/nvim-web-devicons', opt = true}
		}
		use {
			'L3MON4D3/LuaSnip',
			wants = "friendly-snippets",
		}
		use {
			'tami5/lspsaga.nvim',
			commit = "373bc031b39730cbfe492533c3acfac36007899a"
		}
		use 'LionC/nest.nvim'
		use {
			'hrsh7th/nvim-cmp',
		}
		use 'norcalli/nvim-colorizer.lua'
		use 'neovim/nvim-lspconfig'
		use 'kyazdani42/nvim-tree.lua'
		use 'kyazdani42/nvim-web-devicons'
		use 'wbthomason/packer.nvim'
		use 'tversteeg/registers.nvim'
		use {
			"tweekmonster/startuptime.vim",
		}
		use 'simrat39/symbols-outline.nvim'
		use {
			'nvim-telescope/telescope.nvim',
			requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
		}
		use 'edkolev/tmuxline.vim'
		use 'folke/tokyonight.nvim'
		use {
			"folke/trouble.nvim",
			requires = "kyazdani42/nvim-web-devicons",
		}
		use {
			'nvim-treesitter/nvim-treesitter',
			branch = '0.5-compat',
			run = ':TSUpdate'
		}
		use 'pineapplegiant/spaceduck'
		use 'machakann/vim-sandwich'
		use {
			'lervag/vimtex',
			-- ft = {'tex', 'latex'},
		}
		use {
			'vimwiki/vimwiki',
			branch = "dev"
		}
	end,
	config = {
	-- Move to lua dir so impatient.nvim can cache it
	compile_path = vim.fn.stdpath('config')..'/lua/packer_compiled.lua'
	}
})
