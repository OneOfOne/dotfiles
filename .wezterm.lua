local wezterm = require 'wezterm'
local act = wezterm.action

local cfg = {}

if wezterm.config_builder then
	cfg = wezterm.config_builder()
end

cfg.color_scheme = 'Catppuccin Mocha'
cfg.keys = {
	{ key = 'h', mods = 'SUPER', action = act.ActivatePaneDirection 'Left' },
	{ key = 'j', mods = 'SUPER', action = act.ActivatePaneDirection 'Down' },
	{ key = 'k', mods = 'SUPER', action = act.ActivatePaneDirection 'Up' },
	{ key = 'l', mods = 'SUPER', action = act.ActivatePaneDirection 'Right' },
}
-- cfg.enable_tab_bar = false
-- cfg.window_close_confirmation = 'NeverPrompt'

return cfg
