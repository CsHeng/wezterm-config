local wezterm = require('wezterm')
local platform = require('utils.platform')

local function font_with_fallback(font_family)
  -- family names, not file names
  return wezterm.font_with_fallback({
    font_family,
    "MesloLGS NF",            -- 主字体
    "BabelStone Han",         -- 冷僻字 fallback
    "Maple Mono SC NF",       -- nice double-spaced symbols!
  })
end

local function font_and_rules_for_jetbrains()
  local font_rules = {
    {
      italic = true,
      font = font_with_fallback("JetBrains Mono Light Italic"),
    },
    {
      italic = true, intensity = "Bold",
      font = font_with_fallback("JetBrains Mono Bold Italic"),
    },
    {
      intensity = "Bold",
      font = font_with_fallback("JetBrains Mono Bold"),
    },
  }
  return font_rules
end

-- Use a _very slightly_ lighter variant, so that regular bold really stand out
local font_family = font_with_fallback('JetBrains Mono Light')
local font_size = platform.is_mac and 14 or 12

return {
   font = font_family,
   font_rules = font_and_rules_for_jetbrains(),
   font_size = font_size,

   --ref: https://wezfurlong.org/wezterm/config/lua/config/freetype_pcf_long_family_names.html#why-doesnt-wezterm-use-the-distro-freetype-or-match-its-configuration
   freetype_load_target = 'Normal', ---@type 'Normal'|'Light'|'Mono'|'HorizontalLcd'
   freetype_render_target = 'Normal', ---@type 'Normal'|'Light'|'Mono'|'HorizontalLcd'
}
