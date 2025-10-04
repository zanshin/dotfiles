-- Gen - Ollama plugin
-- October 3, 2025
--

return {
	"David-Kunz/gen.nvim",
	config = function()
		require("gen").setup({
			model = "mistral:latest",
			host = "localhost",
			port = "11434",
			display_mode = "split",
			show_prompt = false,
			show_model = false,
			no_auto_close = false,
		})
	end,

	vim.keymap.set({ "n", "v" }, "<leader>]", ":Gen<CR>"),
}
