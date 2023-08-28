local wezterm = require 'wezterm'
local cfg = {}

if wezterm.config_builder then
	cfg = wezterm.config_builder()
end

cfg.color_scheme = 'Catppuccin Mocha'
cfg.enable_tab_bar = false
-- cfg.window_close_confirmation = 'NeverPrompt'

wezterm.on('gui-startup', function(cmd)
	local mux = wezterm.mux
	local tab, pane, window = mux.spawn_window({ cwd = cmd.cwd, set_environment_variables = cmd.set_environment_variables })
	pane:split {}
	pane:split { direction = 'Top', top_level = true, size = 0.8, args = cmd.args }
end)

return cfg
