local platform = require('utils.platform')
local wezterm = require 'wezterm'

local options = {
   -- ref: https://wezfurlong.org/wezterm/config/lua/SshDomain.html
   ssh_domains = {},

   -- ref: https://wezfurlong.org/wezterm/multiplexing.html#unix-domains
   unix_domains = {},

   -- ref: https://wezfurlong.org/wezterm/config/lua/WslDomain.html
   wsl_domains = {},
}

for host, config in pairs(wezterm.enumerate_ssh_hosts()) do
  table.insert(options.ssh_domains, {
    -- the name can be anything you want; we're just using the hostname
    name = host,
    -- remote_address must be set to `host` for the ssh config to apply to it
    remote_address = host,

    -- if you don't have wezterm's mux server installed on the remote
    -- host, you may wish to set multiplexing = "None" to use a direct
    -- ssh connection that supports multiple panes/tabs which will close
    -- when the connection is dropped.

    -- multiplexing = "None",

    -- if you know that the remote host has a posix/unix environment,
    -- setting assume_shell = "Posix" will result in new panes respecting
    -- the remote current directory when multiplexing = "None".
    assume_shell = 'Posix',
  })
end

if platform.is_win then
   options.ssh_domains = {
      {
         name = 'ssh:wsl',
         remote_address = 'localhost',
         multiplexing = 'None',
         default_prog = { 'fish', '-l' },
         assume_shell = 'Posix',
      },
   }

   options.wsl_domains = {
      {
         name = 'wsl:ubuntu-fish',
         distribution = 'Ubuntu',
         username = 'kevin',
         default_cwd = '/home/kevin',
         default_prog = { 'fish', '-l' },
      },
      {
         name = 'wsl:ubuntu-bash',
         distribution = 'Ubuntu',
         username = 'kevin',
         default_cwd = '/home/kevin',
         default_prog = { 'bash', '-l' },
      },
   }
end

return options
