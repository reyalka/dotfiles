local wezterm = require("wezterm")

local config = {}

config.use_ime = true
config.front_end = "OpenGL"
config.color_scheme = "Everblush"
config.enable_wayland = false

-- Font configuration using Nerd Font
config.font = wezterm.font("JetBrains Mono Nerd Font", { weight = "Regular" })
config.font_size = 12.0

return config
