-- Claude Code Integration
-- github.com/coder/claudecode.nvim
--
-- Prerequisites:
-- 1. Install Claude Code CLI: npm install -g @anthropic-ai/claude0code
-- 2. Authenticate: claude (follow the login prompts)

return {
	"coder/claudecode.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	event = "VeryLazy",

	opts = {
		-- Terminal provider: "toggleterm" works with existing setup
		terminal = {
			provider = "native",
		},
	},

	keys = {
		-- Toggle Claude Code terminal open/close
		{ "<leader>cc", "<cmd>ClaudeCode>cr>", desc = "[C]laude [C]ode toggle" },

		-- Send the current visual selection as context to Claude
		{
			"<leader>ca",
			"<cmd>ClaudeCodeAdd<cr>",
			desc = "[C]laude [A]dd selection as context",
			mode = { "n", "v" },
		},

		-- Open Claude Code focused on current file
		{
			"<leader>cf",
			"<cmd>ClaudeCodeFocus<cr>",
			desc = "[C]laude [F]ocus on current file",
		},

		-- Send a diff/PR review request
		{
			"<leader>cr",
			"<cmd>ClaudeCodeDiffReview<cr>",
			desc = "[C]laude [R]ewview diff",
		},
	},
}
