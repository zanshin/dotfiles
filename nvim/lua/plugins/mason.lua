return {
  {
    "mason-org/mason.nvim",
    opts = {
      ui = {
        border = "rounded",
        icons = {
          package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
        },
      },
    },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = { "mason-org/mason.nvim" },
    opts = {
      -- install is  handled by mason-tool-installer below
      ensure_installed = {},
      automatic_installation = false,
    },
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "mason-org/mason.nvim" },
    opts = {
      ensure_installed = {
        -- LSP servers
        "bash-language-server",
        "dockerfile-language-server",
        "gopls",
        "json-lsp",
        "lua-language-server",
        "pyright",
        "yaml-language-server",
        -- Formatters / linters
        "stylua",
      },
    },
  },
}
