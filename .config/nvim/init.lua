require('config.lazy')
require('config.abbr')

if vim.env.SSH_TTY then
	local function raw_osc52_copy(lines, _)
		local text = table.concat(lines, '\n')
		-- Base64 encode the string using Neovim's built-in function
		local base64 = vim.base64.encode(text)
		-- Build the raw escape sequence sequence and pipe to standard output
		local osc52_sequence = string.format('\27]52;c;%s\a', base64)
		io.stdout:write(osc52_sequence)
		io.stdout:flush()
	end

	vim.g.clipboard = {
		name = 'Forced OSC 52',
		copy = {
			['+'] = raw_osc52_copy,
			['*'] = raw_osc52_copy,
		},
		-- Keep pasting local/internal to avoid network lag timeouts over SSH
		paste = {
			['+'] = function()
				return { vim.fn.split(vim.fn.getreg(''), '\n'), vim.fn.getregtype('') }
			end,
			['*'] = function()
				return { vim.fn.split(vim.fn.getreg(''), '\n'), vim.fn.getregtype('') }
			end,
		},
	}

	vim.o.clipboard = 'unnamedplus'
end
