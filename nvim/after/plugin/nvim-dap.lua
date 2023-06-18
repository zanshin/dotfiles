local status_ok, dap = pcall(require, "nvim-dap")
if not status_ok then
  return
end

dap.setup()

-- DAP mappings
-- map("n", "<leader>dt", ":lua require'dapui'.DapUiToggle<cr>")
-- map("n", "<leader>dc", ":lua require'dap'.continue()<cr>")
-- map("n", "<leader>dsi", ":lua require'dap'.step_into()<cr>")
-- map("n", "<leader>dso", ":lua require'dap'.step_over()<cr>")
-- map("n", "<leader>dsu", ":lua require'dap'.step_out()<cr>")
-- map("n", "<leader>db", ":lua require'dap'.toggle_breakpoint()<cr>")
-- -- map("n", "<leader>dr", ":lua require'dap'.repl.open()<cr>")
-- map("n", "<leader>dr", ":lua require'dapui'.open({reset = true})<cr>")

vim.api.nvim_set_keymap("n", "<leader>dc", ":DapContinue<cr>")
vim.api.nvim_set_keymap("n", "<leader>dsi", ":DapStepInto<cr>")
vim.api.nvim_set_keymap("n", "<leader>dso", ":DapStepOver<cr>")
vim.api.nvim_set_keymap("n", "<leader>dsu", ":DapStepOut<cr>")
vim.api.nvim_set_keymap("n", "<leader>db", ":DapToggleBreakpoint<cr>")
-- map("n", "<leader>dr", ":lua require'dap'.repl.open()<cr>")
