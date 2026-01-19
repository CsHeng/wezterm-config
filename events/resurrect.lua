local wezterm = require('wezterm')

local ok, resurrect = pcall(wezterm.plugin.require, 'https://github.com/MLFlexer/resurrect.wezterm')
if not ok then
   wezterm.log_warn('resurrect plugin not available; skipping session restore', resurrect)
   return { setup = function() end }
end

local M = {}

M.setup = function()
   -- Keep some scrollback so you can remember what you were doing before closing.
   resurrect.state_manager.set_max_nlines(100)

   local is_windows = wezterm.target_triple:find('windows') ~= nil
   local separator = is_windows and '\\' or '/'

   local function read_current_state()
      local file_path = resurrect.state_manager.save_state_dir .. separator .. 'current_state'
      local file = io.open(file_path, 'r')
      if not file then
         return nil, nil, file_path
      end
      local name = file:read('*line')
      local type = file:read('*line')
      file:close()
      return name, type, file_path
   end

   local function restore_last_workspace_into(window, name)
      local ok_restore, err = pcall(function()
         if not name or name == '' then
            wezterm.log_info('resurrect: no workspace name; skip restore')
            return
         end

         wezterm.log_info('resurrect: restoring workspace', { workspace = name })
         local state = resurrect.state_manager.load_state(name, 'workspace')
         resurrect.workspace_state.restore_workspace(state, {
            window = window,
            spawn_in_workspace = true,
            close_open_tabs = true,
            relative = true,
            restore_text = true,
            on_pane_restore = resurrect.tab_state.default_on_pane_restore,
         })
         wezterm.mux.set_active_workspace(name)
         wezterm.log_info('resurrect: restore finished', { workspace = name })
      end)

      if not ok_restore then
         wezterm.log_warn('resurrect: restore failed', err)
      end
   end

   local function save_current_workspace()
      local ok_save, err = pcall(function()
         local state = resurrect.workspace_state.get_workspace_state()
         resurrect.state_manager.save_state(state)
         resurrect.state_manager.write_current_state(state.workspace, 'workspace')
         wezterm.log_info('resurrect: saved workspace state', { workspace = state.workspace })
      end)
      if not ok_save then
         wezterm.log_warn('resurrect: failed to save workspace state', err)
      end
   end

   local last_save_ts = 0
   local function maybe_save_current_workspace(min_interval_seconds)
      local now = os.time()
      if now - last_save_ts < min_interval_seconds then
         return
      end
      last_save_ts = now
      save_current_workspace()
   end

   wezterm.on('gui-startup', function(cmd)
      local state_name, state_type, state_file = read_current_state()
      local spawn_args = cmd or {}

      if state_type == 'workspace' and state_name and state_name ~= '' and spawn_args.workspace == nil then
         spawn_args.workspace = state_name
      end

      local _, _, window = wezterm.mux.spawn_window(spawn_args)

      if state_type == 'workspace' and state_name and state_name ~= '' then
         restore_last_workspace_into(window, state_name)
      else
         wezterm.log_info('resurrect: no saved workspace to restore', {
            name = state_name,
            type = state_type,
            file = state_file,
         })
      end
      maybe_save_current_workspace(1)
   end)

   local function schedule_autosave()
      wezterm.time.call_after(30, function()
         maybe_save_current_workspace(30)
         schedule_autosave()
      end)
   end

   -- Start a lightweight autosave loop once the GUI is up.
   wezterm.on('gui-startup', schedule_autosave)

   -- Best-effort save when the window is closed.
   -- Note: "window-close-requested" is an officially documented event; "gui-shutdown" is a final fallback.
   wezterm.on('window-close-requested', function()
      maybe_save_current_workspace(0)
   end)

   wezterm.on('gui-shutdown', function()
      maybe_save_current_workspace(0)
   end)

   -- No keybindings: auto restore on startup + periodic/exit save only.
end

return M
