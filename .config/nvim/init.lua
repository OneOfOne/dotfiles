if vim.env.SSH_TTY then
	local osc52 = require('vim.ui.clipboard.osc52')

	local function copy_reg(reg)
		local orig = osc52.copy(reg)
		return function(lines, regtype)
			-- Write to Vim's internal register
			vim.fn.setreg(reg, table.concat(lines, '\n'), regtype)

			-- Send OSC52 to local clipboard
			orig(lines)
		end
	end

	vim.g.clipboard = {
		name = 'OSC 52 with register sync',
		copy = {
			['+'] = copy_reg('+'),
			['*'] = copy_reg('*'),
		},
		-- Do NOT use OSC52 paste, just use internal registers
		paste = {
			['+'] = function()
				return vim.fn.getreg('+'), 'v'
			end,
			['*'] = function()
				return vim.fn.getreg('*'), 'v'
			end,
		},
	}

	vim.o.clipboard = 'unnamedplus'
end

require('config.lazy')
require('config.abbr')
