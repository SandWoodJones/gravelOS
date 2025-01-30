local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.font = wezterm.font {
  family = 'Maple Mono',
  harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0', 'zero', 'cv01', 'cv02' },
}

config.keys = {
  { key = 'w', mods = 'CTRL', action = wezterm.action.CloseCurrentTab { confirm = false } },
}

return config
