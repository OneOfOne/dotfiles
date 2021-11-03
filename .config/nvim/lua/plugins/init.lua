local present, packer = pcall(require, "plugins.packerInit")

if not present then
	return false
end

local use = packer.use

return packer.startup(function()
	use { "wbthomason/packer.nvim" }

	-- libs
	use { "nvim-lua/popup.nvim" }
	use { "nvim-lua/plenary.nvim" }
	-- use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
	-- icons
	use { "kyazdani42/nvim-web-devicons" }
	use { "ryanoasis/vim-devicons" }

	-- lsp
	-- use { 'neovim/nvim-lspconfig' }
	-- use { 'onsails/lspkind-nvim' }
	-- use { 'nvim-lua/lsp_extensions.nvim' }
	-- use { 'nvim-lua/completion-nvim' }
	-- use { 'RishabhRD/popfix' }
	-- use { 'RishabhRD/nvim-lsputils' }
	-- use { 'ms-jpq/coq_nvim', branch = 'coq' }
	-- use { 'ms-jpq/coq.artifacts', branch = 'artifacts'}

	use { "neoclide/coc.nvim", branch = "release" }
	use { "sudormrfbin/cheatsheet.nvim" }

	-- telescope
	use { "nvim-telescope/telescope.nvim" }
	-- use { 'nvim-telescope/telescope-fzy-native.nvim' }
	-- use { 'nvim-telescope/telescope-project.nvim' }
	-- use { 'gbrlsnchs/telescope-lsp-handlers.nvim' }
	use { "fannheyward/telescope-coc.nvim" }

	-- Debugger
	use { "mfussenegger/nvim-dap" }
	use { "rcarriga/nvim-dap-ui" }
	use { "theHamsta/nvim-dap-virtual-text" }
	use { "nvim-telescope/telescope-dap.nvim" }

	-- -- Tim Pope docet
	use { "tpope/vim-sensible" }
	-- use { 'tpope/vim-abolish' }
	-- use { 'tpope/vim-surround' }
	-- use { 'tpope/vim-bundler' }
	-- use { 'tpope/vim-repeat' }
	-- use { 'tpope/vim-endwise' }
	-- use { 'tpope/vim-dispatch' }
	-- use { 'tpope/vim-dadbod' }
	-- use { 'tpope/vim-jdaddy' }
	use { "tpope/vim-fugitive" }
	-- use { 'tpope/vim-commentary' }

	use { "kyazdani42/nvim-tree.lua" }
	-- 	requires = 'kyazdani42/nvim-web-devicons',
	-- 	config = function()
	-- 		vim.cmd([[doautocmd NvimTree BufEnter *]])
	-- 	end
	-- }

	-- theme
	use { "sainnhe/everforest" }
	-- use { 'christianchiarulli/nvcode-color-schemes.vim' }
	-- use { 'Pocco81/Catppuccino.nvim' }
	-- use { 'nathanaelkane/vim-indent-guides' }

	-- other
	-- use { 'romgrk/barbar.nvim' }
	use { "hoob3rt/lualine.nvim" }
	use { "kdheepak/tabline.nvim" }
end)
