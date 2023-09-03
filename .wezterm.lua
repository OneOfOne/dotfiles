local wezterm = require("wezterm")
local act = wezterm.action

local cfg = {}

if wezterm.config_builder then
	cfg = wezterm.config_builder()
end

cfg.color_scheme = "Catppuccin Mocha"
cfg.keys = {
	{ key = "h", mods = "SUPER", action = act.ActivatePaneDirection("Left") },
	{ key = "j", mods = "SUPER", action = act.ActivatePaneDirection("Down") },
	{ key = "k", mods = "SUPER", action = act.ActivatePaneDirection("Up") },
	{ key = "l", mods = "SUPER", action = act.ActivatePaneDirection("Right") },
	{ key = "Tab", mods = "CTRL", action = "DisableDefaultAssignment" },
	{ key = "Tab", mods = "CTRL|SHIFT", action = "DisableDefaultAssignment" },
}

cfg.font = wezterm.font_with_fallback({
	{ family = "Liga SFMono Nerd Font", weight = 600 },
	"Noto Color Emoji",
	"Noto Sans Symbols",
})

cfg.font_size = 12
cfg.harfbuzz_features = { "calt=1", "clig=1", "liga=1" }
cfg.underline_position = "200%"

-- cfg.enable_tab_bar = false
-- cfg.window_close_confirmation = 'NeverPrompt'

return cfg
