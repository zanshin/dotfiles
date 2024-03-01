-- Pull in wezterm API
local wezterm = require 'wezterm'

-- Table to hold the configuration
local config = {}

-- Use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- My configuration follows
-- config.color_scheme = 'nightfox'
-- config.color_scheme = 'ayu'
config.color_scheme = 'Chalk (base16)'

config.scrollback_lines = 10000

-- fonts
config.font = wezterm.font 'JetBrainsMonoNL Nerd Font'
config.font_size = 16
config.line_height = 1.1

-- tabs
config.use_fancy_tab_bar = false
config.window_frame = {
  font = wezterm.font { family = 'Fira Code', weight = 'Bold' },
  font_size = 12.0,
  active_titlebar_bg = '#333333',
  inactive_titlebar_bg = '#666666',
}

config.colors = {
  tab_bar = {
    -- The color of the inactive tab bar edge/divider
  },
}

-- window padding
config.enable_scroll_bar = false
config.window_padding = {
  left = "9",
  right = "9",
  top = 0,
  bottom = 0,
}



-- Finally, return the configuration
-- to wezterm
return config
