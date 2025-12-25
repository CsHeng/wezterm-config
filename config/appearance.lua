local gpu_adapters = require('utils.gpu-adapter')
--local backdrops = require('utils.backdrops')
--local colors = require('colors.custom')

return {
   window_decorations = "RESIZE", -- "INTEGRATED_BUTTONS|RESIZE|NONE"

   max_fps = 120,
   front_end = 'WebGpu', ---@type 'WebGpu' | 'OpenGL' | 'Software'
   webgpu_power_preference = 'HighPerformance',
   webgpu_preferred_adapter = gpu_adapters:pick_best(),
   -- webgpu_preferred_adapter = gpu_adapters:pick_manual('Dx12', 'IntegratedGpu'),
   -- webgpu_preferred_adapter = gpu_adapters:pick_manual('Gl', 'Other'),
   underline_thickness = '1.5pt',

   -- cursor
   animation_fps = 120,
   cursor_blink_ease_in = 'EaseOut',
   cursor_blink_ease_out = 'EaseOut',
   default_cursor_style = 'BlinkingBar',
   cursor_blink_rate = 650,

   -- color scheme
   -- colors = colors,
    colors = {
        tab_bar = {
            background = "#002b36", -- Base03 (最暗，tab 背景)
            active_tab = {
                bg_color = "#268bd2", -- Blue
                fg_color = "#fdf6e3", -- Base3 (最亮前景)
                intensity = "Bold",
                underline = "None",
                italic = false,
                strikethrough = false,
            },
            inactive_tab = {
                bg_color = "#073642", -- Base02
                fg_color = "#93a1a1", -- Base1
            },
            --inactive_tab_hover = {
            --    bg_color = "#586e75", -- Base01
            --    fg_color = "#eee8d5", -- Base2
            --    italic = true,
            --},
            --new_tab = {
            --    bg_color = "#002b36", -- Base03
            --    fg_color = "#839496", -- Base0
            --},
            --new_tab_hover = {
            --    bg_color = "#268bd2", -- Blue
            --    fg_color = "#fdf6e3", -- Base3
            --},
        },
        -- 背景色也换掉（整体 Solarized）
        background = "#002b36",
        foreground = "#e0e0e0",
    },

    color_scheme = "Builtin Solarized Dark",
   --color_scheme = "Builtin Catppuccin Mocha",

   -- background: pass in `true` if you want wezterm to start with focus mode on (no bg images)
   -- background = backdrops:initial_options(false),

   background = {
      -- {
      --    source = { File = wezterm.GLOBAL.background },
      --    horizontal_align = 'Center',
      -- },
      {
         source = { Color = 'rgba(0, 0, 0, 0.9)' },
         height = '120%',
         width = '120%',
         vertical_offset = '-10%',
         horizontal_offset = '-10%',
         opacity = 1,
      },
   },

   -- window background
   window_background_opacity = 0.9,
   text_background_opacity = 0.9,

   -- scrollbar
   enable_scroll_bar = true,

   -- tab bar
   enable_tab_bar = true,
   hide_tab_bar_if_only_one_tab = true, -- Hide tab bar when only one tab
   use_fancy_tab_bar = false, -- Use simpler tab style like ghostty/iterm
   tab_max_width = 1000, -- Large value to enable equal-width tabs
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
      active_titlebar_bg = '#090909',
      -- active_titlebar_bg = "#1e1e2e",
      inactive_titlebar_bg = "#181825",
      -- font = fonts.font,
      -- font_size = fonts.font_size,
   },
   -- inactive_pane_hsb = {
   --    saturation = 0.9,
   --    brightness = 0.65,
   -- },
   inactive_pane_hsb = {
      saturation = 1,
      brightness = 1,
   },

   visual_bell = {
      fade_in_function = 'EaseIn',
      fade_in_duration_ms = 250,
      fade_out_function = 'EaseOut',
      fade_out_duration_ms = 250,
      target = 'CursorColor',
   },
}
