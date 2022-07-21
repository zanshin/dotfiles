local status_ok, nvim-dap-virtual-text = pcall(require, "nvim-dap-virtual-text")
if not status_ok then
  return
end

nvim-dap-virtual-text.setup()
