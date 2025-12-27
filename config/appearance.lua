local gpu_adapters = require('utils.gpu-adapter')
local wezterm = require('wezterm')
-- local backdrops = require('utils.backdrops')
-- local colors = require('colors.custom')

return {
   window_decorations = "RESIZE", -- "INTEGRATED_BUTTONS|RESIZE|NONE"

   max_fps = 144,
   front_end = 'WebGpu', ---@type 'WebGpu' | 'OpenGL' | 'Software'
   webgpu_power_preference = 'HighPerformance',
   webgpu_preferred_adapter = gpu_adapters:pick_best(),
   -- webgpu_preferred_adapter = gpu_adapters:pick_manual('Dx12', 'IntegratedGpu'),
   -- webgpu_preferred_adapter = gpu_adapters:pick_manual('Gl', 'Other'),
   underline_thickness = '1.5pt',

   -- cursor
   animation_fps = 144,
   cursor_blink_ease_in = 'EaseOut',
   cursor_blink_ease_out = 'EaseOut',
   default_cursor_style = 'BlinkingBar',
   cursor_blink_rate = 650,

   -- color scheme
   -- colors = colors,
   colors = {
      tab_bar = {
         background = 'rgba(0, 0, 0, 0)',
      },
   },

   -- color_scheme = "Solarized Dark - Patched",
   -- color_scheme = "Builtin Solarized Dark",
   -- color_scheme = "Builtin Catppuccin Mocha",
   color_scheme = "Builtin Dracula",
   -- color_scheme = "Builtin Tokyo Night",
   -- color_scheme = "Builtin One Dark",
   -- color_scheme = "Builtin Nord",
   -- color_scheme = "Builtin Gruvbox Dark",

   -- background: pass in `true` if you want wezterm to start with focus mode on (no bg images)
   -- background = backdrops:initial_options(false),

   background = {
      -- {
      --    source = { File = wezterm.config_dir .. '/backdrops/voyage.jpg' },
      --    horizontal_align = 'Center',
      -- },
      {
         source = { Color = 'rgba(0, 0, 0, 0.9)' },
         height = '120%',
         width = '120%',
         vertical_offset = '-10%',
         horizontal_offset = '-10%',
         opacity = 0.9,
      },
   },

   -- window background
   window_background_opacity = 0.9,
   text_background_opacity = 0.9,

   -- scrollbar
   enable_scroll_bar = true,

   -- tab bar
   enable_tab_bar = true,
   hide_tab_bar_if_only_one_tab = false,
   use_fancy_tab_bar = false,
   tab_max_width = 40,
   tab_bar_at_bottom = false,
   show_tab_index_in_tab_bar = false,
   switch_to_last_active_tab_when_closing_tab = true,

   -- command palette
   command_palette_fg_color = '#b4befe',
   command_palette_bg_color = '#11111b',
   command_palette_font_size = 12,
   command_palette_rows = 25,

   -- window
   window_padding = {
      left = 5,
      right = 5,
      top = 2,
      bottom = 2,
   },
   adjust_window_size_when_changing_font_size = false,
   window_close_confirmation = 'NeverPrompt',
   window_frame = {
      -- active_titlebar_bg = '#090909',
      active_titlebar_bg = "#1e1e2e",
      inactive_titlebar_bg = "#181825",
      -- font = fonts.font,
      -- font_size = fonts.font_size,
   },
   inactive_pane_hsb = {
      saturation = 0.8,
      brightness = 0.65,
   },

   visual_bell = {
      fade_in_function = 'EaseIn',
      fade_in_duration_ms = 250,
      fade_out_function = 'EaseOut',
      fade_out_duration_ms = 250,
      target = 'CursorColor',
   },
}
