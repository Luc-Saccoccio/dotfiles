local packer = require "packer"
local use = packer.use
return packer.startup({
    function()
        use 'dense-analysis/ale'
	use 'erikbackman/aurora.vim'
	use {
		'hrsh7th/cmp-nvim-lsp',
	}
	use {
		'hrsh7th/cmp-nvim-lua',
	}
	use 'hrsh7th/cmp-buffer'
	use {
		'saadparwaiz1/cmp_luasnip',
	}
	use {
		'rafamadriz/friendly-snippets',
		event = "InsertEnter",
	}
	use 'neovimhaskell/haskell-vim'
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
	use 'preservim/tagbar'
	use {
		'nvim-telescope/telescope.nvim',
		requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
	}
	use 'edkolev/tmuxline.vim'
	use {
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate'
	}
	use 'pineapplegiant/spaceduck'
	use 'tpope/vim-fugitive'
	use 'lervag/vimtex'
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
