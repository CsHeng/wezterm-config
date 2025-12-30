# Agents.md

This file contains commands and procedures useful for AI agents working with this WezTerm configuration repository.

## Configuration Validation

### WezTerm Configuration Test
```bash
# Test if WezTerm can load the configuration without errors
# This command lists WezTerm tabs/panes; config errors will be shown
wezterm cli ls 2>&1
```

**Note**: If the configuration has syntax errors, this command will fail with error messages indicating the problematic file and line number.

### Lua Syntax Check
```bash
# Check Lua syntax for individual files
luac -p wezterm.lua
luac -p config/fonts.lua
luac -p events/*.lua
luac -p utils/*.lua
```

## Development Commands

### Code Formatting
```bash
# Format Lua files with stylua (excludes init.lua which has special formatting)
stylua -g '!/config/init.lua' wezterm.lua colors/ config/ events/ utils/
```

### Linting
```bash
# Lint Lua files with luacheck
luacheck wezterm.lua colors/* config/* events/* utils/*
```

## Font Management

### Check Installed Fonts
```bash
# List all installed fonts
fc-list : family

# Check specific fonts
fc-list : family | grep -iE "jetbrains|maple|hack|sarasa|noto|meslo"
```

### Install Fonts via Homebrew
```bash
# Install Nerd Fonts
brew install --cask font-jetbrains-mono-nerd-font
brew install --cask font-hack-nerd-font
brew install --cask font-maple-nerd-font
brew install --cask font-meslo-lg-nerd-font

# Install CJK fonts
brew install --cask font-noto-sans-mono-cjk-sc
brew install --cask font-sarasa-gothic
```

### Testing Font Presets
To test different font presets, edit `config/fonts.lua` and change the `active_font` variable:

```lua
-- Available presets (alphabetically by main font):
--   - hack_nf_cjk
--   - jetbrains_mono_nf
--   - jetbrains_mono_nf_cjk
--   - maple_mono_nf_cn
--   - maple_mono_nf_cn_optimized
--   - meslolgs_nf_cjk
--   - sarasa_mono

local active_font = font_presets.jetbrains_mono_nf_cjk
```

Then reload WezTerm configuration:
```bash
# Reload configuration (default keybinding: SUPER+SHIFT+R)
# Or restart WezTerm
```

## Common Issues

### Circular Dependencies
When testing individual Lua files, avoid using `require()` as it may trigger circular dependencies in this project. Use `luac -p` for syntax-only checking instead.

### Font Not Found
If a font preset fails to load, check if the font is installed:
```bash
fc-list : family | grep -i "FontName"
```

If missing, install via Homebrew (see Font Management section).

## Project Structure Quick Reference

- `wezterm.lua` - Main entry point
- `config/` - Configuration modules (fonts, appearance, bindings, etc.)
- `events/` - Event handlers (status bar, tab titles, etc.)
- `utils/` - Utility modules (backdrops, GPU selection, platform detection)
- `colors/` - Color scheme definitions
- `agents.md` - This file (agent procedures and commands)
