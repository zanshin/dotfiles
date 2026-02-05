-- Claude Code
-- February 5, 2026
--

-- Enable auto-reload for files changed externally by Claude Code
vim.opt.autoread = true
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold" }, { command = "checktime" })

return {
	"coder/claudecode.nvim",
	dependencies = {},
	config = function()
		require("claudecode").setup({
			terminal = {
				provider = "toggleterm", -- or "float", "split", "vsplit", "tab"
			},
		})
	end,
	keys = {
		{ "<leader>cc", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude Code" },
	},
}
