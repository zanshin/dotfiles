local status_ok, dapui = pcall(require, "dapui")
if not status_ok then
  return
end

dapui.setup()

-- DAP UI mappings
vim.api.nvim_set_keymap("n", "<leader>dt", ":lua require'dapui'.toggle()<cr>", { noremap = true })
