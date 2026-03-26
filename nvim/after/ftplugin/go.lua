-- Go language specific settings
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = false

vim.opt_local.formatoptions = "cqnj"

-- Organize Go imports
-- https://github.com/golang/tools/blob/master/gopls/doc/vim.md#neovim-imports
-- https://github.com/neovim/nvim-lspconfig/issues/115#issuecomment-902680058
local function org_imports(wait_ms)
	local params = vim.lsp.util.make_range_params(0, "utf-8")
	params.context = { only = { "source.organizeImports" } }
	local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
	for _, res in pairs(result or {}) do
		for _, r in pairs(res.result or {}) do
			if r.edit then
				vim.lsp.util.apply_workspace_edit(r.edit, "utf-8")
			end
		end
	end
end

local go_lsp = vim.api.nvim_create_augroup("go_lsp", { clear = true })
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	pattern = "*.go",
	command = ":silent lua vim.lsp.buf.format({ async = true })",
	group = go_lsp,
})

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	pattern = "*.go",
	group = go_lsp,
	callback = function()
		vim.lsp.buf.format({ async = false })
		org_imports(3000)
	end,
})
