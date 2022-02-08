local present, dap = pcall(require, 'dap')
if not present then
	return false
end
local utils = require('utils')
local m = utils.map

dap.adapters.go = function(callback, config)
	local stdout = vim.loop.new_pipe(false)
	local handle
	local pid_or_err
	local port = 38697
	local opts = {
		stdio = {nil, stdout},
		args = {"dap", "-l", "127.0.0.1:" .. port},
		detached = true
	}
	handle, pid_or_err = vim.loop.spawn("dlv", opts, function(code)
		stdout:close()
		handle:close()
		if code ~= 0 then
			print('dlv exited with code', code)
		end
	end)
	assert(handle, 'Error running dlv: ' .. tostring(pid_or_err))
	stdout:read_start(function(err, chunk)
		assert(not err, err)
		if chunk then
			vim.schedule(function()
			require('dap.repl').append(chunk)
			end)
		end
	end)
	-- Wait for delve to start
	vim.defer_fn(
		function()
			callback({type = "server", host = "127.0.0.1", port = port})
		end,
	100)
end
-- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
dap.configurations.go = {
	{
		type = "go",
		name = "Debug",
		request = "launch",
		program = "${file}"
	},
	{
		type = "go",
		name = "Debug test", -- configuration for debugging test files
		request = "launch",
		mode = "test",
		program = "${file}"
	},
	-- works with go.mod packages and sub packages
	{
		type = "go",
		name = "Debug test (go.mod)",
		request = "launch",
		mode = "test",
		program = "./${relativeFileDirname}"
	}
}

vim.g.dap_virtual_text = true
require('telescope').load_extension('dap')

m('n', '<F5>', [[<cmd>lua require('dap').continue()<cr>]])
m('n', '<leader>dd', [[<cmd>lua require('dap').continue()<cr>]])
m('n', '<F10>', [[<cmd>lua require('dap').step_over()<cr>]])
m('n', '<F11>', [[<cmd>lua require('dap').step_into()<cr>]])
m('n', '<F12>', [[<cmd>lua require('dap').step_out()<cr>]])
m('n', '<leader>b', [[<cmd>lua require('dap').toggle_breakpoint()<cr>]])
m('n', '<leader>B', [[<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>]])
m('n', '<leader>lp', [[<cmd>lua require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>]])
m('n', '<leader>dr', [[<cmd>lua require('dap').repl.open()<cr>]])
m('n', '<leader>dl', [[<cmd>lua require('dap').repl.run_last()<cr>`]])
m('n', '<leader>dn', [[<cmd>lua require('dap-python').test_method()<cr>]])
m('n', '<leader>dcc', [[<cmd>{}<cr>]])
m('n', '<leader>dco', [[<cmd>lua require"telescope".extensions.dap.configurations{}<cr>]])
m('n', '<leader>dlb', [[<cmd>lua require"telescope".extensions.dap.list_breakpoints{}<cr>]])
m('n', '<leader>dv', [[<cmd>lua require"telescope".extensions.dap.variables{}<cr>]])
m('n', '<leader>df', [[<cmd>lua require"telescope".extensions.dap.frames{}<cr>]])
