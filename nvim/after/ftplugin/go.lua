-- Go language specific settings
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = false

vim.opt_local.formatoptions = "cqrnj"


-- Organize Go imports
-- https://github.com/golang/tools/blob/master/gopls/doc/vim.md#neovim-imports
-- https://github.com/neovim/nvim-lspconfig/issues/115#issuecomment-902680058
function OrgImports(wait_ms)
  local params = vim.lsp.util.make_range_params()
  params.context = { only = { "source.organizeImports" } }
  local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
  for _, res in pairs(result or {}) do
    for _, r in pairs(res.result or {}) do
      if r.edit then
        vim.lsp.util.apply_workspace_edit(r.edit, "UTF-8")
      else
        vim.lsp.buf.execute_command(r.command)
      end
    end
  end
end

local go_lsp = vim.api.nvim_create_augroup("go_lsp", { clear = true })
vim.api.nvim_create_autocmd({ "BufWritePre" },
  {
    pattern = "*.go",
    command = ":silent lua vim.lsp.buf.format({ async = true })",
    group = go_lsp
  })
vim.api.nvim_create_autocmd({ "BufWritePre" },
  {
    pattern = "*.go",
    command = ":silent! lua OrgImports(3000)",
    group = go_lsp
  })
