local wezterm = require('wezterm')
local platform = require('utils.platform')

local font_presets = {
  -- Hack
  hack_regular = {
    font = wezterm.font_with_fallback({
      { family = 'Hack Nerd Font', weight = 'Regular' },
      { family = 'Noto Sans Mono CJK SC' },
      'Apple Symbols',
    }),
    font_size = platform.is_mac and 15 or 12,
    line_height = 1.0,
    cell_width = 1.0,
  },

  -- JetBrains
  jetbrains_regular = {
    font = wezterm.font_with_fallback({
      { family = 'JetBrainsMono Nerd Font', weight = 'Regular' },
      { family = 'Noto Sans Mono CJK SC' },
      'Apple Symbols',
    }),
    font_size = platform.is_mac and 15 or 12,
    line_height = 1.0,
    cell_width = 1.0,
  },

  jetbrains_bold = {
    font = wezterm.font_with_fallback({
      { family = 'JetBrainsMono Nerd Font', weight = 'Bold' },
      { family = 'Noto Sans Mono CJK SC', scale = 1.1 },
      'Apple Symbols',
    }),
    font_size = platform.is_mac and 15 or 12,
    line_height = 1.0,
    cell_width = 1.0,
  },

  -- Maple
  maple_regular = {
    font = wezterm.font_with_fallback({
      { family = 'Maple Mono NF CN', weight = 'Regular' },
      'Apple Symbols',
    }),
    font_size = platform.is_mac and 15 or 12,
    line_height = 1.0,
    cell_width = 1.0,
  },

  maple_bold = {
    font = wezterm.font_with_fallback({
      { family = 'Maple Mono NF CN', weight = 'Bold' },
      'Apple Symbols',
    }),
    font_size = platform.is_mac and 15 or 12,
    line_height = 1.05,
    cell_width = 1.0,
  },

  -- Meslo
  meslo_regular = {
    font = wezterm.font_with_fallback({
      { family = 'MesloLGS NF', weight = 'Regular' },
      { family = 'Noto Sans Mono CJK SC', scale = 1.1 },
      'Apple Symbols',
    }),
    font_size = platform.is_mac and 15 or 12,
    line_height = 1.0,
    cell_width = 1.0,
  },

  -- Sarasa
  sarasa_medium = {
    font = wezterm.font_with_fallback({
      { family = 'Sarasa Mono SC', weight = 'Medium' },
      'Apple Symbols',
    }),
    font_size = platform.is_mac and 15 or 12,
    line_height = 1.0,
    cell_width = 1.0,
  },

  -- Consolas
  consolas = {
    font = wezterm.font_with_fallback({
      { family = 'Consolas for Powerline', weight = 'Regular' },
      'Apple Symbols',
    }),
    font_size = platform.is_mac and 15 or 12,
    line_height = 1.0,
    cell_width = 1.0,
  },
}

-- 切换预设：修改 active_font 为上面 font_presets 中的任意 key
-- 可选值（按主字体字母排序）：
--   - consolas
--   - hack_regular
--   - jetbrains_bold
--   - jetbrains_regular
--   - maple_bold
--   - maple_regular
--   - meslo_regular
--   - sarasa_medium
local active_font = font_presets.maple_regular

return {

  font = active_font.font,
  font_size = active_font.font_size,
  line_height = active_font.line_height,
  cell_width = active_font.cell_width,

  --ref: https://wezfurlong.org/wezterm/config/lua/config/freetype_pcf_long_family_names.html#why-doesnt-wezterm-use-the-distro-freetype-or-match-its-configuration
  freetype_load_target = 'Normal', ---@type 'Normal'|'Light'|'Mono'|'HorizontalLcd'
  freetype_load_flags = 'DEFAULT', ---@type 'NO_HINTING'|'DEFAULT'|'FORCE_AUTOHINT'
  freetype_render_target = 'Normal', ---@type 'Normal'|'Light'|'Mono'|'HorizontalLcd'

  -- 禁 ligature / calt，避免 glyph 重排
  -- harfbuzz_features = { 'calt=0', 'liga=0', 'clig=0', 'kern=0', 'dlint=0', 'hlig=0' },
}
