local wezterm = require("wezterm")
local act = wezterm.action

local cfg = {}

if wezterm.config_builder then
	cfg = wezterm.config_builder()
end

cfg.keys = {
	{ key = "h",   mods = "SUPER",      action = act.ActivatePaneDirection("Left") },
	{ key = "j",   mods = "SUPER",      action = act.ActivatePaneDirection("Down") },
	{ key = "k",   mods = "SUPER",      action = act.ActivatePaneDirection("Up") },
	{ key = "l",   mods = "SUPER",      action = act.ActivatePaneDirection("Right") },
	{ key = "v",   mods = "CTRL",       action = "DisableDefaultAssignment" },
	{ key = "a",   mods = "CTRL",       action = "DisableDefaultAssignment" },
	{ key = "Tab", mods = "CTRL",       action = "DisableDefaultAssignment" },
	{ key = "Tab", mods = "CTRL|SHIFT", action = "DisableDefaultAssignment" },
}

cfg.font = wezterm.font_with_fallback({
	{ family = "Liga SFMono Nerd Font", weight = 500 },
	"Noto Color Emoji",
	"Noto Sans Symbols",
	"Noto Sans Symbols 2",
})

cfg.font_size = 11
cfg.harfbuzz_features = { "calt=1", "clig=1", "liga=1" }
cfg.underline_position = "200%"

cfg.enable_tab_bar = false
-- cfg.window_close_confirmation = 'NeverPrompt'
cfg.force_reverse_video_cursor = true

cfg.color_scheme = "gruvbox_material_dark_hard"
cfg.color_schemes = {
	["gruvbox_material_dark_hard"] = {
		foreground = "#D4BE98",
		background = "#1D2021",
		cursor_bg = "#D4BE98",
		cursor_border = "#D4BE98",
		cursor_fg = "#1D2021",
		selection_bg = "#D4BE98",
		selection_fg = "#3C3836",

		ansi = { "#1d2021", "#ea6962", "#a9b665", "#d8a657", "#7daea3", "#d3869b", "#89b482", "#d4be98" },
		brights = { "#eddeb5", "#ea6962", "#a9b665", "#d8a657", "#7daea3", "#d3869b", "#89b482", "#d4be98" },
	},
}

cfg.initial_rows = 77
cfg.initial_cols = 284
return cfg
