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
		'mason-nvim-dap.nvim',
		enabled = not require('config.utils').is_local(),
	},
	{
		'mason-lspconfig.nvim',
		enabled = not require('config.utils').is_local(),
	},
	{ 'nvim-dap', enabled = false },
	{
		'conform.nvim',
		enabled = false,
	},
	{
		'nvim-lint',
		enabled = false,
	},
	{
		'LuaSnip',
		enabled = false,
	},
	{
		'friendly-snippets',
		enabled = false,
	},
	{
		'grug-far.nvim',
		enabled = false,
	},
}
