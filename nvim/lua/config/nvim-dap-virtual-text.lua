local status_ok, dvt = pcall(require, "nvim-dap-virtual-text")
if not status_ok then
  return
end

dvt.setup()
