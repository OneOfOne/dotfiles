return {
	{
		'chrisgrieser/nvim-spider',
		keys = {
			{ 'w', "<cmd>lua require('spider').motion('w')<CR>", mode = { 'n', 'o', 'x' } },
			{ 'e', "<cmd>lua require('spider').motion('e')<CR>", mode = { 'n', 'o', 'x' } },
			{ 'b', "<cmd>lua require('spider').motion('b')<CR>", mode = { 'n', 'o', 'x' } },
		},
	},
	{
		'gbprod/cutlass.nvim',
		opts = {
			cut_key = 'x',
			exclude = { 'xd' },
			registers = {
				select = '+',
			},
		},
	},
	{
		'chentoast/marks.nvim',
		event = 'BufReadPre',
		opts = {
			default_mappings = true,
			force_write_shada = false,
			refresh_interval = 250,
		},
	},
}
