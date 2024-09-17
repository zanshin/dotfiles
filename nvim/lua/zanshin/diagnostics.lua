-- LSP Diagnostics Options Setup
-- from https://rsdlt.github.io/posts/rust-nvim-ide-guide-walkthrough-development-debug/
-- local sign = function(opts)
--   -- vim.fn.sign_define(opts.name, {
--   vim.diagnostic.config(opts.name, {
--     texthl = opts.name,
--     text = opts.text,
--     numhl = ''
--   })
-- end

-- sign({ name = 'DiagnosticSignError', text = '' })
-- sign({ name = 'DiagnosticSignWarn', text = '' })
-- sign({ name = 'DiagnosticSignHint', text = '' })
-- sign({ name = 'DiagnosticSignInfo', text = '' })

vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  update_in_insert = true,
  underline = true,
  severity_sort = false,
  float = {
    border = 'rounded',
    source = 'always',
    header = '',
    prefix = '',
  },
})

vim.cmd([[
set signcolumn=yes
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]])
