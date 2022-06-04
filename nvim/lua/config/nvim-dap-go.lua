local status_ok, dapgo = pcall(require, "dap-go")
if not status_ok then
  -- vim-notify "Whoops"
  return
end

dapgo.setup()
map("n", "<leader>dt", ":lua require('dap-go').debug_test()<CR>")
