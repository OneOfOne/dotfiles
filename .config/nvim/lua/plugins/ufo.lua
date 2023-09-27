return {
	'kevinhwang91/nvim-ufo',
	dependencies = {
		'kevinhwang91/promise-async',
	},
	opts = {
		filetype_exclude = { 'help', 'alpha', 'dashboard', 'neo-tree', 'Trouble', 'lazy', 'mason' },
	},
	event = "BufReadPost",
	config = function(_, opts)
		local ufo = require('ufo')
		vim.api.nvim_create_autocmd('FileType', {
			group = vim.api.nvim_create_augroup('local_detach_ufo', { clear = true }),
			pattern = opts.filetype_exclude,
			callback = function() ufo.detach() end
		})

		opts.provider_selector = function()
			return { 'treesitter', 'indent' }
		end

		opts.fold_virt_text_handler = function(virt_text, lnum, end_lnum, width, truncate)
			local result = { { "+", 'Folded' } }
			local _end = end_lnum - 1
			local final_text = vim.trim(vim.api.nvim_buf_get_text(0, _end, 0, _end, -1, {})[1])
			local suffix = final_text:format(end_lnum - lnum - 1)
			local suffix_width = vim.fn.strdisplaywidth(suffix)
			local target_width = width - suffix_width
			local hl_group = ''
			local cur_width = 0
			for _, chunk in ipairs(virt_text) do
				local chunk_text = chunk[1]
				hl_group = chunk[2]
				local chunk_width = vim.fn.strdisplaywidth(chunk_text)
				if target_width > cur_width + chunk_width then
					table.insert(result, chunk)
				else
					chunk_text = truncate(chunk_text, target_width - cur_width)
					table.insert(result, { chunk_text, hl_group })
					chunk_width = vim.fn.strdisplaywidth(chunk_text)
					-- str width returned from truncate() may less than 2nd argument, need padding
					if cur_width + chunk_width < target_width then
						suffix = suffix .. (' '):rep(target_width - cur_width - chunk_width)
					end
					break
				end
				cur_width = cur_width + chunk_width
			end
			table.insert(result, { ' ⋯ ', 'NonText' })
			table.insert(result, { suffix, hl_group })
			local num = (' 󰁂 %d '):format(end_lnum - lnum)
			table.insert(result, { num, 'NonText' })
			return result
		end

		vim.opt.foldcolumn = '0'
		vim.opt.foldlevel = 99
		vim.opt.foldlevelstart = -1

		ufo.setup(opts)
	end,
}
