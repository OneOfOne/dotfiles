local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
	fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
	vim.cmd 'packadd packer.nvim'
	vim.cmd 'autocmd BufWritePost plugins.lua PackerCompile' -- Auto compile when there are changes in plugins.lua
end

local packer = require('packer')
packer.startup(function()
	use {'wbthomason/packer.nvim'}

	-- libs
	use { 'nvim-lua/popup.nvim' }
	use { 'nvim-lua/plenary.nvim' }
	use { 'simnalamburt/vim-mundo' }
	use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

	-- prettification
	use { 'junegunn/vim-easy-align' }
	use { 'mhartington/formatter.nvim' }



	-- icons
	use { 'kyazdani42/nvim-web-devicons' }
	use { 'ryanoasis/vim-devicons' }

	-- lsp
	use { 'neovim/nvim-lspconfig' }
	use { 'onsails/lspkind-nvim' }
	use { 'nvim-lua/lsp_extensions.nvim' }
	use { 'ms-jpq/coq_nvim', branch = 'coq' }
	use { 'ms-jpq/coq.artifacts', branch = 'artifacts'}

	-- telescope
	use { 'nvim-telescope/telescope.nvim' }
	-- use { 'nvim-telescope/telescope-fzy-native.nvim' }
	-- use { 'nvim-telescope/telescope-project.nvim' }
	use { 'gbrlsnchs/telescope-lsp-handlers.nvim' }

	-- Debugger
	use { 'mfussenegger/nvim-dap' }
	use { 'rcarriga/nvim-dap-ui' }
	use { 'theHamsta/nvim-dap-virtual-text' }
	use { 'nvim-telescope/telescope-dap.nvim' }

	-- Tim Pope docet
	use { 'tpope/vim-sensible' }
	-- use { 'tpope/vim-rails' }
	use { 'tpope/vim-abolish' }
	use { 'tpope/vim-surround' }
	use { 'tpope/vim-bundler' }
	-- use { 'tpope/vim-capslock' }
	use { 'tpope/vim-repeat' }
	use { 'tpope/vim-endwise' }
	-- use { 'tpope/vim-rvm' }
	use { 'tpope/vim-dispatch' }
	use { 'tpope/vim-dadbod' }
	use { 'tpope/vim-jdaddy' }
	use { 'tpope/vim-fugitive' }
	use { 'tpope/vim-commentary' }

	use { 'kyazdani42/nvim-tree.lua' }
	-- 	requires = 'kyazdani42/nvim-web-devicons',
	-- 	config = function()
	-- 		vim.cmd([[doautocmd NvimTree BufEnter *]])
	-- 	end
	-- }

	-- theme
	use { 'sainnhe/everforest' }
	-- use { 'christianchiarulli/nvcode-color-schemes.vim' }
	-- use { 'Pocco81/Catppuccino.nvim' }
	-- use { 'nathanaelkane/vim-indent-guides' }

	-- other
	use { 'romgrk/barbar.nvim' }
	use { 'hoob3rt/lualine.nvim' }
end)
packer.clean()
packer.install()
return packer
