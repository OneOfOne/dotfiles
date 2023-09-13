local wezterm = require("wezterm")
local act = wezterm.action

local cfg = {}

if wezterm.config_builder then
	cfg = wezterm.config_builder()
end

cfg.color_scheme = "Gruvbox dark, hard (base16)"
cfg.keys = {
	{ key = "h", mods = "SUPER", action = act.ActivatePaneDirection("Left") },
	{ key = "j", mods = "SUPER", action = act.ActivatePaneDirection("Down") },
	{ key = "k", mods = "SUPER", action = act.ActivatePaneDirection("Up") },
	{ key = "l", mods = "SUPER", action = act.ActivatePaneDirection("Right") },
	{ key = "v", mods = "CTRL", action = "DisableDefaultAssignment" },
	{ key = "a", mods = "CTRL", action = "DisableDefaultAssignment" },
	{ key = "Tab", mods = "CTRL", action = "DisableDefaultAssignment" },
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

-- cfg.enable_tab_bar = false
-- cfg.window_close_confirmation = 'NeverPrompt'
cfg.force_reverse_video_cursor = true
cfg.colors = {
	-- foreground = "#dcd7ba",
	-- background = "#1f1f28",
	--
	-- cursor_bg = "#c8c093",
	-- cursor_fg = "#c8c093",
	-- cursor_border = "#c8c093",
	--
	-- selection_fg = "#c8c093",
	-- selection_bg = "#2d4f67",
	--
	-- scrollbar_thumb = "#16161d",
	-- split = "#16161d",
	--
	-- ansi = { "#090618", "#c34043", "#76946a", "#c0a36e", "#7e9cd8", "#957fb8", "#6a9589", "#c8c093" },
	-- brights = { "#727169", "#e82424", "#98bb6c", "#e6c384", "#7fb4ca", "#938aa9", "#7aa89f", "#dcd7ba" },
	-- indexed = { [16] = "#ffa066", [17] = "#ff5d62" },
}
return cfg
