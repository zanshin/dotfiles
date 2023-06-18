-- netman
local status_ok, netman = pcall(require, "netman")
if not status_ok then
  return
end

netman.setup()
