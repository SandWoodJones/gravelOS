local config = wezterm.config_builder()

local function direction_binds(key, dir)
  return {
    { key = key, mods = 'LEADER', action = wezterm.action.SplitPane { direction = dir } },
    { key = key, mods =   'CTRL', action = wezterm.action.ActivatePaneDirection(dir) },
    { key = key, mods =    'ALT', action = wezterm.action.AdjustPaneSize { dir, 3 } }
  }
end

config = {
  font = wezterm.font {
    family = 'Maple Mono',
    harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0', 'zero', 'cv01', 'cv02' }
  },

  leader = { key = ' ', mods = 'CTRL', timeout_milliseconds = 1000 },
  keys = {
    -- TODO: https://wezterm.org/config/lua/config/skip_close_confirmation_for_processes_named.html
    { key = 'w', mods = 'CTRL', action = wezterm.action.CloseCurrentTab { confirm = false } },
    { key = 'w', mods = 'LEADER', action = wezterm.action.CloseCurrentPane { confirm = false } },
  }
}

for _, pair in ipairs({ {'h', 'Left'}, {'j', 'Down'}, {'k', 'Up'}, {'l', 'Right'} }) do
  local key, dir = pair[1], pair[2]
  for _, bind in ipairs(direction_binds(key, dir)) do
    table.insert(config.keys, bind)
  end
end

return config
