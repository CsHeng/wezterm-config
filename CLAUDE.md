# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a comprehensive WezTerm terminal configuration with a modular Lua architecture. The config provides a highly customizable terminal experience with features like background image management, GPU optimization, cross-platform keybindings, and extensive customization options.

## Architecture

### Core Configuration System
- **Entry Point**: `wezterm.lua` - Main configuration file that orchestrates all modules
- **Config Builder**: `config/init.lua` - Implements a fluent interface for building configurations with duplicate detection
- **Module Pattern**: Each configuration aspect (appearance, bindings, fonts, etc.) is a separate module that gets appended to the main config

### Key Modules

#### Configuration Modules (`config/`)
- `appearance.lua` - Visual settings, GPU adapter selection, performance settings
- `bindings.lua` - Keybindings and key tables
- `domains.lua` - SSH and WSL domain configurations
- `fonts.lua` - Font settings and typography
- `general.lua` - General terminal settings
- `launch.lua` - Default shell and launch configurations

#### Event Handlers (`events/`)
- `left-status.lua` - Left status bar setup
- `right-status.lua` - Right status bar with date/time
- `tab-title.lua` - Tab title management and unseen indicators
- `new-tab-button.lua` - New tab button functionality

#### Utility Modules (`utils/`)
- `backdrops.lua` - Background image management system with cycling and fuzzy search
- `gpu-adapter.lua` - Intelligent GPU adapter selection based on performance hierarchy
- `platform.lua` - Platform detection and utilities
- `cells.lua` - Cell manipulation utilities
- `math.lua` - Mathematical utilities
- `opts-validator.lua` - Configuration validation

#### Color Schemes (`colors/`)
- `custom.lua` - Custom color palette
- `canonical_solarized.lua` - Solarized color scheme
- `canonical_solarized_auto_appearance.lua` - Auto-appearance Solarized variant

## Development Commands

### Code Quality
```bash
# Format code with stylua
stylua -g '!/config/init.lua' wezterm.lua colors/ config/ events/ utils/

# Lint code with luacheck
luacheck wezterm.lua colors/* config/* events/* utils/*
```

### Configuration Testing
```bash
# Validate configuration (requires WezTerm)
wezterm --verify-config
```

### Update Process
```bash
# Update from upstream repository
./cmd/update.sh
```

## Key Development Patterns

### Configuration Module Pattern
Each configuration module should return a table that gets merged into the main config:

```lua
return {
   -- WezTerm configuration options
   option_name = value,
   -- ... more options
}
```

### Fluent Interface for Config
The main config uses a fluent interface pattern:

```lua
return Config:init()
   :append(require('config.appearance'))
   :append(require('config.bindings'))
   -- ... more modules
```

### Event Handler Setup
Event handlers use a setup pattern:

```lua
require('events.left-status').setup()
require('events.right-status').setup({ date_format = '%a %H:%M:%S' })
```

### Utility Classes
Utility modules use object-oriented patterns with metatables:

```lua
local Utility = {}
Utility.__index = Utility

function Utility:new()
   return setmetatable({}, self)
end
```

## Important Configuration Details

### Keybinding System
- Uses `SUPER` and `SUPER_REV` keys that adapt per platform
- Leader key: `SUPER_REV` + `Space`
- Implements key tables for complex operations (resize_font, resize_pane)

### GPU Optimization
- Automatically selects best GPU adapter based on device type hierarchy
- Platform-specific backend preferences:
  - Windows: Dx12 > Vulkan > OpenGL
  - Linux: Vulkan > OpenGL
  - macOS: Metal

### Background Image System
- Supports cycling through images in backdrops directory
- Fuzzy search functionality
- Focus mode with color overlay
- Configurable image directory

## File Structure Conventions

- All Lua files use 3-space indentation
- Single quotes preferred, auto-detection enabled
- Line length limited to 150 characters
- Type annotations using LuaDoc comments (`---@type`)
- Module files return configuration tables or classes

## Platform-Specific Considerations

### macOS
- Default shell paths configured for common locations
- Metal backend for GPU rendering
- Homebrew font installation paths

### Windows
- WSL domain configurations
- Scoop/winget installation paths
- Dx12 backend preferred

### Linux
- Multiple shell path options
- Vulkan backend preferred
- Package manager font paths