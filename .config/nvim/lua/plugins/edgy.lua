return {
	'folke/edgy.nvim',
	opts = function(_, opts)
		return vim.tbl_deep_extend('force', opts, {
			animate = {
				enabled = false,
			},
			options = {
				left = { size = 40 },
				right = { size = 40 },
			},
			left = {
				{
					title = 'Files',
					ft = 'neo-tree',
					filter = function(buf)
						return vim.b[buf].neo_tree_source == 'filesystem'
					end,
					pinned = true,
					open = function()
						vim.api.nvim_input('<esc><space>e')
					end,
					size = { height = 0.5 },
				},
				{ title = 'Tests', ft = 'neotest-summary' },
				-- {
				-- 	title = 'Git',
				-- 	ft = 'neo-tree',
				-- 	filter = function(buf)
				-- 		return vim.b[buf].neo_tree_source == 'git_status'
				-- 	end,
				-- 	pinned = true,
				-- 	open = 'Neotree position=right git_status',
				-- },
				-- {
				-- 	title = 'Symbols',
				-- 	ft = 'neo-tree',
				-- 	filter = function(buf)
				-- 		return vim.b[buf].neo_tree_source == 'document_symbols'
				-- 	end,
				-- 	pinned = true,
				-- 	open = 'Neotree position=top document_symbols',
				-- },
				'neo-tree',
			},
		})
	end,
}
