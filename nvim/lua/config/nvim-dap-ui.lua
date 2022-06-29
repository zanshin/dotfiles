local status_ok, dapui = pcall(require, "dapui")
if not status_ok then
  return
end

dapui.setup({
  sidebar = {
    size = 50,
    position = "right",
    elements = {
      { id = "scopes", size = 0.35, },
      { id = "stacks", size = 0.35 },
      { id = "breakpoints", size = 0.15 },
      { id = "watches", size = 00.15 },
    }
  },
  tray = {
    elements = { "repl", "console" },
    size = 10,
    position = "bottom", -- Can be "left", "right", "top", "bottom"
  },
})

local dap = require("dap")

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end
