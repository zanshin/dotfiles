-- Colorscheme

opt.termguicolors = true -- enable 24-bit RGB colors
cmd('set background=dark')

--
-- CATPPUCCIN colorscheme
-- colorscheme catppuccin " catppuccin-latte, catppuccin-frappe, catppuccin-macchiato, catppuccin-mocha
-- require('catppuccin').setup({
--   custom_highlights = function(colors)
--   return {
--     Comment = { fg = colors.subtext1},
--     LineNr = { fg = colors.blue},
--   }
-- end
-- })
-- cmd('colorscheme catppuccin-mocha')

--
-- AYU colorscheme
-- local colors = require('ayu.colors')
require('ayu').setup({
  mirage = false,
  overrides = {
    Comment = { fg = "#b0c4de" },
    LineNr = { fg = "#778899" }
  },
})

cmd('colorscheme ayu-dark')
