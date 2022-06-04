local status_ok, dap-go = pcall(require, "dap-go")
if not status_ok then
  vim-notify "Whoops"
  return
end

dap-go.setup()
map("n", "<leader>dt", ":lua require('dap-go').debug_test()<CR>")
