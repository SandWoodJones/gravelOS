local config = wezterm.config_builder()

local palette, _ = wezterm.color.load_scheme(os.getenv("XDG_CONFIG_HOME") .. "/wezterm/colors/@color_scheme_slug@.toml")

local function tab_title(tab, tabs, panes, config, hover, max_width)
  local title
  if tab.tab_title and #tab.tab_title > 0 then
    title = tab.tab_title
  else
    title = tab.active_pane.title
  end

  title = wezterm.truncate_right(tab.tab_index .. ': ' .. title, max_width - 3)

  local background = palette.background
  local foreground = palette.cursor_border
  if tab.is_active then
    background = palette.cursor_border
    foreground = palette.cursor_fg
  elseif hover then
    background = palette.split
    foreground = palette.scrollbar_thumb
  elseif tab.is_last_active then
    background = palette.selection_bg
    foreground = palette.background
  end

  return {
    { Background = { Color = palette.background } },
    { Text = ' ' },
    { Background = { Color = palette.background } },
    { Foreground = { Color = background } },
    { Text = '' },
    { Background = { Color = background } },
    { Foreground = { Color = foreground } },
    { Text = title},
    { Background = { Color = palette.background } },
    { Foreground = { Color = background } },
    { Text = '' },
  }
end

config = {
  enable_scroll_bar = true,

  font = wezterm.font { family = 'Maple Mono', harfbuzz_features = { 'calt', 'zero', 'cv01', 'cv03', 'cv61', 'ss05' } },
  
  color_scheme = "@color_scheme_slug@",
  colors = {
    tab_bar = {
      background = palette.background,
      
      active_tab = {
        bg_color = palette.cursor_border,
        fg_color = palette.cursor_fg,
        intensity = "Bold",
      },
      inactive_tab = {
        bg_color = palette.background,
        fg_color = palette.cursor_border,
      },
      inactive_tab_hover = {
        bg_color = palette.selection_bg,
        fg_color = palette.scrollbar_thumb,
      },

      new_tab = {
        bg_color = palette.background,
        fg_color = palette.cursor_border,
        intensity = "Bold",
      },
      new_tab_hover = {
        bg_color = palette.selection_bg,
        fg_color = palette.scrollbar_thumb,
        intensity = "Bold",
      },
    },
  },

  hide_tab_bar_if_only_one_tab = true,
  use_fancy_tab_bar = false,
  tab_bar_style = {
    new_tab = wezterm.format {
      { Text = '  +' },
    },
    new_tab_hover = wezterm.format {
      { Background = { Color = palette.background } },
      { Foreground = { Color = palette.split } },
      { Text = ' ' },
      { Background = { Color = palette.split } },
      { Foreground = { Color = palette.scrollbar_thumb } },
      { Text = '+' },
      { Background = { Color = palette.background } },
      { Foreground = { Color = palette.split } },
      { Text = '' },
    },
  },
  wezterm.on('format-tab-title', tab_title),

  leader = { key = ' ', mods = 'CTRL', timeout_milliseconds = 1000 },
  keys = {
    -- TODO: https://wezterm.org/config/lua/config/skip_close_confirmation_for_processes_named.html
    { key = 't', mods = 'CTRL', action = wezterm.action.SpawnTab 'CurrentPaneDomain' },
    { key = 'w', mods = 'CTRL', action = wezterm.action.CloseCurrentTab { confirm = false } },
    { key = 'Tab', mods = 'CTRL', action = wezterm.action.ActivateTabRelative(1) },
    { key = 'Tab', mods = 'CTRL|ALT', action = wezterm.action.ActivateTabRelative(-1) },
    { key = 'w', mods = 'LEADER', action = wezterm.action.CloseCurrentPane { confirm = false } },
  },
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
