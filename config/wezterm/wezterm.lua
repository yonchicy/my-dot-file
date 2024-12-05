-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- wezterm.gui is not available to the mux server, so take care to
-- do something reasonable when this config is evaluated by the mux
local function get_appearance()
  if wezterm.gui then
    return wezterm.gui.get_appearance()
  end
  return 'Dark'
end

local function scheme_for_appearance(appearance)
  if appearance:find 'Dark' then
    return 'Github Dark (Gogh)'
  else
    return 'One Light (Gogh)'
  end
end

config.color_scheme = scheme_for_appearance(get_appearance())
config.font = wezterm.font_with_fallback {
  { family = 'VictorMono Nerd Font', weight = 650 },
}
config.font_size = 14
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.window_close_confirmation = "NeverPrompt"
config.window_decorations = "TITLE | RESIZE"

config.default_cursor_style = 'BlinkingBlock'
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}
-- and finally, return the configuration to wezterm
return config
