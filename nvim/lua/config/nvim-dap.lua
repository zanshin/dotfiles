local status_ok, dap = pcall(require, "nvim-dap")
if not status_ok then
  return
end


map("n", "<leader>dc", ":lua require'dap'.continue()<cr>")
map("n", "<leader>dsi", ":lua require'dap'.step_into()<cr>")
map("n", "<leader>dso", ":lua require'dap'.step_over()<cr>")
map("n", "<leader>dsu", ":lua require'dap'.step_out()<cr>")
map("n", "<leader>b", ":lua require'dap'.toggle_breakpoint()<cr>")
map("n", "<leader>dr", ":lua require'dap'.repl.open()<cr>")
