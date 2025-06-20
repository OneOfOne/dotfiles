return {
	{ 'catppuccin', enabled = false },
	{
		'ellisonleao/gruvbox.nvim',
		enabled = false,
	},
	{
		'folke/tokyonight.nvim',
		enabled = false,
	},
	{
		'folke/persistence.nvim',
		enabled = false,
	},
	{
		'folke/todo-comments.nvim',
		enabled = false,
	},
	{
		'folke/neoconf.nvim',
		enabled = false,
	},
	-- disabled to be able to use system binaries
	{
		'jay-babu/mason-nvim-dap.nvim',
		enabled = not require('config.utils').is_local(),
	},
	{
		'mason-org/mason-lspconfig.nvim',
		enabled = not require('config.utils').is_local(),
	},
	{ 'nvim-dap', enabled = false },
	{
		'stevearc/conform.nvim',
		enabled = false,
	},
	{
		'mfussenegger/nvim-lint',
		enabled = false,
	},
	{
		'L3MON4D3/LuaSnip',
		enabled = false,
	},
	{
		'rafamadriz/friendly-snippets',
		enabled = false,
	},
}
