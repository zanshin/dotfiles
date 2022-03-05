local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
	return
end

require("config.lsp.lsp-installer")
require("config.lsp.handlers").setup()
