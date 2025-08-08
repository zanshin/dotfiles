-- Colorscheme
-- August 4.2025

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
      LspInlayHint = { fg = "#778899" },
    },
  },
  config = function(_, opts)
    require('ayu').setup(opts)
    vim.opt.termguicolors = true -- enable 24-bit RGB colors
    vim.cmd('set background=dark')
    vim.cmd("colorscheme ayu-dark")
  end
}
