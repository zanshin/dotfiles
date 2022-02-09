local M = {}

M.setup = function(on_attach, capabilities)
  require("lspconfig").bashls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })
end

return M
