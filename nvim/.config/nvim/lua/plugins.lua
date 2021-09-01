return require('packer').startup(function()
	use 'wbthomason/packer.nvim'
	use 'nvim-lua/completion-nvim'
	use 'dense-analysis/ale'
	use {
		'lervag/vimtex',
		ft = {'tex', 'latex'}
	}
	use {
		'preservim/nerdtree',
		disable = true
	}
	use 'kyazdani42/nvim-tree.lua'
	use 'edkolev/tmuxline.vim'
	use 'norcalli/nvim-colorizer.lua'
	use {
		'preservim/tagbar',
		cmd = 'TagbarToggle'
	}
	use {
		'ObserverOfTime/discord.nvim',
		run = ':UpdateRemotePlugins'
	}
	use 'b3nj5m1n/kommentary'
	use {
		'ndmitchell/ghcid',
		ft = 'haskell',
		rtp = 'plugins/nvims',
		cmd = 'Ghcid'
	}
	use 'pineapplegiant/spaceduck'
	use 'vimwiki/vimwiki'
	use 'machakann/vim-sandwich'
	use 'kyazdani42/nvim-web-devicons'
	use 'neovim/nvim-lspconfig'
	use 'romgrk/barbar.nvim'
	use {
		'nvim-treesitter/nvim-treesitter',
		branch = '0.5-compat',
		run = ':TSUpdate'
	}
	use {
		'hoob3rt/lualine.nvim',
		requires = {'kyazdani42/nvim-web-devicons', opt = true}
	}
	use {
		'nvim-telescope/telescope.nvim',
		requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
	}
	use {
		'neovimhaskell/haskell-vim',
		ft = 'haskell'
	}
	use {
		"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
	}
end)
