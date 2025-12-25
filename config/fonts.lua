local wezterm = require('wezterm')
local platform = require('utils.platform')

-- === 字体配置预设 ===
-- 切换字体：修改 active_font 为下述 preset 之一
local font_presets = {
   -- Sarasa Term SC
   sarasa_term = {
      font = wezterm.font('Sarasa Term SC', { weight = 'Bold' }),
      font_size = platform.is_mac and 15 or 12,
      line_height = 1.0,
      cell_width = 1.05,
   },

   -- Sarasa Mono SC（更紧凑）
   sarasa_mono = {
      font = wezterm.font('Sarasa Mono SC'),
      font_size = platform.is_mac and 15 or 12,
      line_height = 1.0,
      cell_width = 1.05,
   },

   -- Noto Sans Mono CJK SC
   noto_sans_mono = {
      font = wezterm.font('Noto Sans Mono CJK SC', { weight = 'Bold' }),
      font_size = platform.is_mac and 14 or 12,
      line_height = 1.0,
      cell_width = 1.05,
   },

   yahei_consolas_hybrid = {
      font = wezterm.font('Yahei Consolas Hybrid', { weight = 'Bold' }),
      font_size = platform.is_mac and 14 or 12,
      line_height = 1.0,
      cell_width = 1.05,
   },

   -- JetBrains Mono（带 fallback）
   jetbrains = {
      font = wezterm.font_with_fallback({
         { family = 'JetBrains Mono', weight = 'Light' },
         'MesloLGS NF',
         'BabelStone Han',
         'Sarasa Term SC',
      }),
      font_size = platform.is_mac and 15 or 12,
      line_height = 1.0,
      cell_width = 1.05,
   },

}

-- 选择当前使用的字体 preset
local active_font = font_presets.sarasa_mono

return {
   font = active_font.font,
   font_size = active_font.font_size,
   line_height = active_font.line_height,
   cell_width = active_font.cell_width,

   --ref: https://wezfurlong.org/wezterm/config/lua/config/freetype_pcf_long_family_names.html#why-doesnt-wezterm-use-the-distro-freetype-or-match-its-configuration
   freetype_load_target = 'Light', ---@type 'Normal'|'Light'|'Mono'|'HorizontalLcd'
   freetype_load_flags = 'NO_HINTING', ---@type 'NO_HINTING'|'DEFAULT'|'FORCE_AUTOHINT'
   -- harfbuzz_features = { 'calt', 'liga', 'clig' }, -- 启用连字特性
}
