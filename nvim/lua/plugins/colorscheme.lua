-- Colorscheme
return {
  'Shatur/neovim-ayu',
  lazy = false,
  priority = 1000,
  opts = {
    mirage = false,
    overrides = {
      Comment = { fg = "#b0c4de" },
      LineNr = { fg = "#778899" },
      Folded = { fg = "#6495ed" },
      FoldColumn = { fg = "#6495ed" },
    },
  },
  config = function(_, opts)
    require('ayu').setup(opts)
    vim.opt.termguicolors = true -- enable 24-bit RGB colors
    vim.cmd('set background=dark')
    vim.cmd("colorscheme ayu-dark")
  end
}


-- AYU colorscheme
-- local colors = require('ayu.colors')
-- require('ayu').setup({
--   mirage = false,
--   overrides = {
--     Comment = { fg = "#b0c4de" },
--     LineNr = { fg = "#778899" }
--   },
-- })
--
-- cmd('colorscheme ayu-dark')
