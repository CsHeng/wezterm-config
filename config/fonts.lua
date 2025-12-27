local wezterm = require('wezterm')
local platform = require('utils.platform')

local function font_with_fallback(font_family, options)
  local font_spec = options
    and { family = font_family, weight = options.weight }
    or font_family

  return wezterm.font_with_fallback({
    font_spec,                     -- 主字体（Maple / JetBrains / Sarasa 等）
    -- "Noto Sans Mono CJK SC",       -- CJK 等宽兜底
    -- "BabelStone Han",              -- 罕见汉字
  })
end

local font_presets = {

  sarasa_mono = {
    font = font_with_fallback('Sarasa Mono SC', { weight = 'Medium' }),
    font_size = platform.is_mac and 15 or 12,
    line_height = 1.0,
    cell_width = 1.0,
  },

  jetbrains_mono_nf = {
    font = font_with_fallback('JetBrainsMono Nerd Font', { weight = 'Bold' }),
    font_size = platform.is_mac and 15 or 12,
    line_height = 1.0,
    cell_width = 1.0,
  },

  maple_mono_nf_cn = {
    font = font_with_fallback('Maple Mono NF CN', { weight = 'Bold' }),
    font_size = platform.is_mac and 15 or 12,
    line_height = 0.95,
    cell_width = 1.0,
  },
}

local active_font = font_presets.maple_mono_nf_cn

return {

  font = active_font.font,
  font_size = active_font.font_size,
  line_height = active_font.line_height,
  cell_width = active_font.cell_width,

  --ref: https://wezfurlong.org/wezterm/config/lua/config/freetype_pcf_long_family_names.html#why-doesnt-wezterm-use-the-distro-freetype-or-match-its-configuration
  freetype_load_target = 'Normal', ---@type 'Normal'|'Light'|'Mono'|'HorizontalLcd'
  freetype_load_flags = 'NO_HINTING', ---@type 'NO_HINTING'|'DEFAULT'|'FORCE_AUTOHINT'
  freetype_render_target = 'Normal', ---@type 'Normal'|'Light'|'Mono'|'HorizontalLcd'

  -- 禁 ligature / calt，避免 glyph 重排
  harfbuzz_features = { 'calt=0', 'liga=0', 'clig=0', 'kern=0' },
}
