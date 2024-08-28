local wezterm = require 'wezterm'
local act = wezterm.action
local mux = wezterm.mux
local config = {}

-- Theme options
config.color_scheme = 'Catppuccin Mocha'
local color_schemes = wezterm.color.get_builtin_schemes()
local color_scheme = color_schemes[config.color_scheme]

-- Font options
config.font = wezterm.font 'JetBrainsMono Nerd Font'
config.adjust_window_size_when_changing_font_size = false

-- Other options
config.window_background_opacity = 0.8
config.macos_window_background_blur = 20
config.window_decorations = 'RESIZE'
config.default_cursor_style = 'BlinkingBar'
config.animation_fps = 1
config.scrollback_lines = 10000
config.enable_scroll_bar = true
config.tab_max_width = 20

-- Style tabs
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.pl_left_hard_divider

wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
  local index = tonumber(tab.tab_index) + 1
  local is_first = index == 1
  local is_last = index == #tabs
  local total_width = 4 -- 2 for the arrows and 2 for the padding

  local background = color_scheme.background
  local foreground = color_scheme.foreground

  if tab.is_active then
    background = color_scheme.selection_bg
    foreground = color_scheme.selection_fg
  elseif hover then
    background = color_scheme.cursor_bg
    foreground = color_scheme.cursor_fg
  end

  local leading_fg = color_scheme.background
  local leading_bg = background
  local leading_txt = SOLID_RIGHT_ARROW

  local trailing_fg = background
  local trailing_bg = color_scheme.background
  local trailing_txt = SOLID_RIGHT_ARROW

  if is_first then
    leading_txt = ""
    total_width = total_width - 1
  end

  if is_last then
    trailing_txt = ""
    total_width = total_width - 1
  end

  local title = index.." "..tab.active_pane.title
  total_width = total_width + #title

  if total_width > config.tab_max_width then
    title = title:sub(1, #title - (total_width - config.tab_max_width))
  end

  return {
    {Background={Color=leading_bg}},  {Foreground={Color=leading_fg}},
      {Text=leading_txt},
    {Background={Color=background}},  {Foreground={Color=foreground}},
      {Text=" "..title.." "},
    {Background={Color=trailing_bg}}, {Foreground={Color=trailing_fg}},
      {Text=trailing_txt},
  }
end)

-- Launch maximized
wezterm.on('gui-startup', function(cmd)
  local tab, pane, window = mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

-- Key bindings
config.disable_default_key_bindings = true
config.keys = {

  -- Navigation
  { key = '1', mods = 'SUPER', action = act.ActivateTab(0) },
  { key = '2', mods = 'SUPER', action = act.ActivateTab(1) },
  { key = '3', mods = 'SUPER', action = act.ActivateTab(2) },
  { key = '4', mods = 'SUPER', action = act.ActivateTab(3) },
  { key = '5', mods = 'SUPER', action = act.ActivateTab(4) },
  { key = '6', mods = 'SUPER', action = act.ActivateTab(5) },
  { key = '7', mods = 'SUPER', action = act.ActivateTab(6) },
  { key = '8', mods = 'SUPER', action = act.ActivateTab(7) },
  { key = '9', mods = 'SUPER', action = act.ActivateTab(-1) },

  { key = 'LeftArrow', mods = 'SUPER|SHIFT', action = act.ActivateTabRelative(-1) },
  { key = 'RightArrow', mods = 'SUPER|SHIFT', action = act.ActivateTabRelative(1) },

  { key = 'LeftArrow', mods = 'SUPER', action = act.ActivatePaneDirection 'Left' },
  { key = 'RightArrow', mods = 'SUPER', action = act.ActivatePaneDirection 'Right' },
  { key = 'UpArrow', mods = 'SUPER', action = act.ActivatePaneDirection 'Up' },
  { key = 'DownArrow', mods = 'SUPER', action = act.ActivatePaneDirection 'Down' },

  -- Resize panes
  { key = 'LeftArrow', mods = 'SUPER|ALT', action = act.AdjustPaneSize{ 'Left', 3 } },
  { key = 'RightArrow', mods = 'SUPER|ALT', action = act.AdjustPaneSize{ 'Right', 3 } },
  { key = 'UpArrow', mods = 'SUPER|ALT', action = act.AdjustPaneSize{ 'Up', 1 } },
  { key = 'DownArrow', mods = 'SUPER|ALT', action = act.AdjustPaneSize{ 'Down', 1 } },

  -- Pane tab and window controls
  { key = 'd', mods = 'SUPER', action = act.SplitHorizontal{ domain =  'CurrentPaneDomain' } },
  { key = 'd', mods = 'SUPER|SHIFT', action = act.SplitVertical{ domain =  'CurrentPaneDomain' } },
  { key = 't', mods = 'SUPER', action = act.SpawnTab 'CurrentPaneDomain' },
  { key = 'n', mods = 'SUPER', action = act.SpawnWindow },
  { key = 'w', mods = 'SUPER', action = act.CloseCurrentPane{ confirm = true } },
  { key = 'h', mods = 'SUPER', action = act.HideApplication },
  { key = 'q', mods = 'SUPER', action = act.QuitApplication },

  -- Toggle maximized state
  { key = 'Enter', mods = 'SUPER', action = wezterm.action_callback(function(win, pane)
    win:maximize()
  end), },

  -- Text editting
  { key = 'c', mods = 'SUPER', action = act.CopyTo 'Clipboard' },
  { key = 'v', mods = 'SUPER', action = act.PasteFrom 'Clipboard' },
  { key = 'x', mods = 'SUPER|SHIFT', action = act.ActivateCopyMode },
  { key = 'f', mods = 'SUPER', action = act.Search 'CurrentSelectionOrEmptyString' },

  -- Font size
  { key = '0', mods = 'SUPER', action = act.ResetFontSize },
  { key = '-', mods = 'SUPER', action = act.DecreaseFontSize },
  { key = '=', mods = 'SUPER', action = act.IncreaseFontSize },

  -- Other actions
  { key = 'z', mods = 'SUPER', action = act.TogglePaneZoomState },
  { key = 'r', mods = 'SUPER', action = act.ReloadConfiguration },
  { key = 'l', mods = 'SUPER', action = act.ShowLauncher },
  { key = 'p', mods = 'SUPER|SHIFT', action = act.ActivateCommandPalette },

   -- MacOS backward and forward word
  { key = "LeftArrow", mods = "ALT", action = act.SendString("\x1bb") },
  { key = "RightArrow", mods = "ALT", action = act.SendString("\x1bf") },
}

return config
