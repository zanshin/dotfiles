-- Colorscheme

opt.termguicolors = true -- enable 24-bit RGB colors
cmd('set background=dark')
cmd('colorscheme ayu-dark')

-- local colors = require('ayu.colors')
-- require('ayu').setup({
--   mirage = false,
--   overrides = {
--     Comment = { fg = "Gray63" },
--     line = { fg = "#ffcc66" }
--   },
-- })

-- local colorscheme = "onedarkhc"
-- local colorscheme = "ayu-dark"
-- local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
-- if not status_ok then
--   vim.notify("colorscheme " .. colorscheme .. " not found.")
--   return
-- end
-- cmd('colorscheme onedarkhc')
