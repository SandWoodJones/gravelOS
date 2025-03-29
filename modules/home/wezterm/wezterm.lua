local config = wezterm.config_builder()

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
  local binds = {
    { key = pair[1], mods = 'LEADER', action = wezterm.action.SplitPane { direction = pair[2] } },
    { key = pair[1], mods =   'CTRL', action = wezterm.action.ActivatePaneDirection(pair[2]) },
    { key = pair[1], mods =    'ALT', action = wezterm.action.AdjustPaneSize { pair[2], 3 } }
  }

  for _, bind in ipairs(binds) do table.insert(config.keys, bind) end
end

for i=1,9 do
  table.insert(config.keys, { key = tostring(i), mods = 'LEADER', action = wezterm.action.ActivateTab(i - 1) } )
end

return config
