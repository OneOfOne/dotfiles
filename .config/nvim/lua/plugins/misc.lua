vim.o.foldcolumn = '0' -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

return {
	{
		'kevinhwang91/nvim-ufo',
		dependencies = { 'kevinhwang91/promise-async' },
		opts = {
			filetype_exclude = { 'help', 'alpha', 'dashboard', 'neo-tree', 'Trouble', 'lazy', 'mason' },
			 provider_selector = function(bufnr, filetype, buftype)
				return {'treesitter', 'indent'}
			end
		},
		config = function(_, opts)
				vim.api.nvim_create_autocmd('FileType', {
					group = vim.api.nvim_create_augroup('local_detach_ufo', { clear = true }),
					pattern = opts.filetype_exclude,
					callback = function()
						require('ufo').detach()
					end,
				})

			vim.opt.foldlevelstart = 99
			require('ufo').setup(opts)
		end,
	},
	{
		'willothy/wezterm.nvim',
		config = true,
	}
}
