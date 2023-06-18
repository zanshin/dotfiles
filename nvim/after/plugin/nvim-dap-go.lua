local status_ok, dapgo = pcall(require, "dap-go")
if not status_ok then
  -- vim-notify "Whoops"
  return
end

dapgo.setup()
map("n", "<leader>dgt", ":lua require('dap-go').debug_test()<CR>")
