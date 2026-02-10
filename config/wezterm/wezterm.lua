---@type Wezterm
local wezterm = require("wezterm")

---@type Config
local config = wezterm.config_builder()

config.use_ime = true
config.front_end = "OpenGL"
config.color_scheme = "Everblush"
config.enable_wayland = false
-- config.default_domain = "WSL:NixOS"
config.automatically_reload_config = true
config.font_size = 16.0
config.window_background_opacity = 0.85
config.window_decorations = "RESIZE"
config.window_frame = {
    inactive_titlebar_bg = "none",
    active_titlebar_bg = "none",
}
config.show_new_tab_button_in_tab_bar = false

return config
