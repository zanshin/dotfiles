-- Colorscheme

opt.termguicolors = true -- enable 24-bit RGB colors
cmd('set background=dark')

-- local colors = require('ayu.colors')
require('ayu').setup({
  mirage = false,
  overrides = {
    Comment = { fg = "#b0c4de" },
    LineNr = { fg = "#778899" }
  },
})

cmd('colorscheme ayu-dark')
