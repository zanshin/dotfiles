local langs = {
	"bash",
	"css",
	"dockerfile",
	"gitignore",
	"go",
	"html",
	"javascript",
	"json",
	"lua",
	"markdown",
	"python",
	"ruby",
	"rust",
	"sql",
	"toml",
	"typescript",
	"vim",
	"vimdoc",
	"yaml",
}

return {
	-- "nvim-treesitter/nvim-treesitter",
	"neovim-treesitter/nvim-treesitter",
	-- branch = "master",
	branch = "main",
	build = ":TSUpdate",
	dependencies = {
		"neovim-treesitter/treesitter-parser-registry",
		"nvim-lua/plenary.nvim",
	},
	config = function()
		require("nvim-treesitter").setup({
			install_dir = vim.fn.stdpath("data") .. "/site",
		})

		require("nvim-treesitter").install(langs)

		vim.api.nvim_create_autocmd("FileType", {
			pattern = langs,
			callback = function()
				vim.treesitter.start()
				vim.wo.foldmethod = "expr"
				vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
				vim.wo.foldlevel = 99
				vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end,
		})
	end,
	-- main = "nvim-treesitter.configs",
	-- opts = {
	-- 	ensure_installed = {
	-- 		"bash",
	-- 		"css",
	-- 		"dockerfile",
	-- 		"gitignore",
	-- 		"go",
	-- 		"html",
	-- 		"javascript",
	-- 		"json",
	-- 		"lua",
	-- 		"markdown",
	-- 		"python",
	-- 		"ruby",
	-- 		"rust",
	-- 		"sql",
	-- 		"toml",
	-- 		"typescript",
	-- 		"vim",
	-- 		"vimdoc",
	-- 		"yaml",
	-- 	},
	-- 	auto_install = true,
	-- 	highlight = {
	-- 		enable = true,
	-- 		additional_vim_regex_highlighting = { "ruby" },
	-- 	},
	-- 	indent = { enable = true, disable = { "ruby" } },
	-- },
}
