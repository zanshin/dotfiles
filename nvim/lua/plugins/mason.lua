-- Mason
return {
  'williamboman/mason.nvim',
  config = function()
    require('mason').setup()
  end,
  dependencies = {
    'williamboman/mason-lspconfig.nvim'
  },
  opts = {
    ui = {
      icons = {
        package_installed = "",
        package_pending = "",
        package_uninstalled = "",
      },
    },
  },
}

-- require("mason-lspconfig").setup()
