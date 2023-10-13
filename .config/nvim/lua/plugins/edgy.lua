return {
	'folke/edgy.nvim',
	opts = function(_, opts)
		return vim.tbl_deep_extend('force', opts, {
			animate = {
				enabled = true,
			},
			options = {
				left = { size = 40 },
				right = { size = 40 },
			},
		})
	end,
}
