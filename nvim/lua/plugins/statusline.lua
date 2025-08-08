-- Statusline
-- August 6, 2025
--

return {
  'beauwilliams/statusline.lua',
	dependencies = {
		'nvim-lua/lsp-status.nvim',
	},
	config = function()
		require('statusline').setup({
			match_colorscheme = true, -- Enable colorscheme inheritance (Default: false)
			tabline = true,           -- Enable the tabline (Default: true)
			lsp_diagnostics = true,   -- Enable Native LSP diagnostics (Default: true)
			ale_diagnostics = false,  -- Enable ALE diagnostics (Default: false)
		})
	end,
}
