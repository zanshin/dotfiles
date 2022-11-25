-- Colorscheme

opt.termguicolors = true      -- enable 24-bit RGB colors
cmd('set background=dark')

-- local colorscheme = "onedarkhc"
local colorscheme = "ayu"
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found.")
  return
end
-- cmd('colorscheme onedarkhc')
