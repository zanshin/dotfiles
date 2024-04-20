return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  init = function()
    vim.opt.timeout = true
    vim.opt.timeoutlen = 300
  end,
}
