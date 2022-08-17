local status_ok, virtual_text = pcall(require, "nvim-dap-virtual-text")
if not status_ok then
  return
end

virtual_text.setup()
