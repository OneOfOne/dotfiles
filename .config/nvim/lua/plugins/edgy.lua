return {
	"folke/edgy.nvim",
	dependencies = {
		-- {
		-- 	"simrat39/symbols-outline.nvim",
		-- 	config = true,
		-- },
	},
	opts = function()
		local opts = {
			animate = {
				enabled = true,
			},
			bottom = {
				{
					ft = "toggleterm",
					size = { height = 0.3 },
					filter = function(_, win)
						return vim.api.nvim_win_get_config(win).relative == ""
					end,
				},
				{
					ft = "noice",
					size = { height = 0.3 },
					filter = function(_, win)
						return vim.api.nvim_win_get_config(win).relative == ""
					end,
				},
				{
					ft = "lazyterm",
					title = "Term",
					size = { height = 0.3 },
					filter = function(buf)
						return not vim.b[buf].lazyterm_cmd
					end,
				},
				"Trouble",
				{ ft = "qf", title = "QuickFix" },
				{
					ft = "help",
					size = { height = 20 },
					-- don't open help files in edgy that we're editing
					filter = function(buf)
						return vim.bo[buf].buftype == "help"
					end,
				},
				{ ft = "spectre_panel", size = { height = 0.4 } },
				{ title = "Neotest Output", ft = "neotest-output-panel", size = { height = 15 } },
			},
			left = {
				{
					title = "Files",
					ft = "neo-tree",
					filter = function(buf)
						return vim.b[buf].neo_tree_source == "filesystem"
					end,
					pinned = true,
					open = function()
						vim.api.nvim_input("<esc><space>e")
					end,
					size = { height = 0.6 },
				},
				{ title = "Tests", ft = "neotest-summary" },
				{
					title = "Git",
					ft = "neo-tree",
					filter = function(buf)
						return vim.b[buf].neo_tree_source == "git_status"
					end,
					pinned = true,
					open = "Neotree position=right git_status",
				},
				"neo-tree",
			},
			right = {
				{
					ft = "Outline",
					pinned = true,
					open = "SymbolsOutlineOpen",
				},
			},
		}
		return opts
	end
}
