local status_ok, dap = pcall(require, "dap")
if not status_ok then
  return
end

vim.fn.sign_define("DapBreakpoint", { text = "•⬢", texthl = "Yellow", linehl = "", numhl = "Yellow" })
vim.fn.sign_define("DapStopped", { text = "▶", texthl = "Green", linehl = "ColorColumn", numhl = "Green" })

map("n", "<leader>dc", ":lua require'dap'.continue()<cr>")
map("n", "<leader>dsi", ":lua require'dap'.step_into()<cr>")
map("n", "<leader>dso", ":lua require'dap'.step_over()<cr>")
map("n", "<leader>dsu", ":lua require'dap'.step_out()<cr>")
map("n", "<leader>b", ":lua require'dap'.toggle_breakpoint()<cr>")
map("n", "<leader>dr", ":lua require'dap'.repl.open()<cr>")

-- local remap = require'utils'.remap
--
-- remap({ 'n', 'v' }, '<F5>', "<cmd>lua require'dap'.continue()<CR>", { silent = true })
-- remap({ 'n', 'v' }, '<F8>', "<cmd>lua require'dapui'.toggle()<CR>", { silent = true })
-- remap({ 'n', 'v' }, '<F9>', "<cmd>lua require'dap'.toggle_breakpoint()<CR>", { silent = true })
-- remap({ 'n', 'v' }, '<F10>', "<cmd>lua require'dap'.step_over()<CR>", { silent = true })
-- remap({ 'n', 'v' }, '<F11>', "<cmd>lua require'dap'.step_into()<CR>", { silent = true })
-- remap({ 'n', 'v' }, '<F12>', "<cmd>lua require'dap'.step_out()<CR>", { silent = true })
-- remap({ 'n', 'v' }, '<leader>db', "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", { silent = true })
-- remap({ 'n', 'v' }, '<leader>dp', "<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>", { silent = true })
-- remap({ 'n', 'v' }, '<leader>dr', "<cmd>lua require'dap'.repl.toggle()<CR>", { silent = true })

-- configure language adapaters
-- require "config.dap-config-go"
-- require "config.dap.lua"

return dap
