local status_ok, mason = pcall(require, "mason")
if not status_ok then
  vim.notify("mason not available.")
  return
end

-- Mason Setup
mason.setup({
    ui = {
        icons = {
            package_installed = "",
            package_pending = "",
            package_uninstalled = "",
        },
    }
})

require("mason-lspconfig").setup()
