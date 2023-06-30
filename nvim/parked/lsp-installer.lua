local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
  return
end

lsp_installer.setup({
  ensure_installed = {
    "bashls",
    "dockerls",
    "gopls",
    "jsonls",
    "pyright",
    "rust-analyzer",
    "solargraph",
    "sumneko_lua",
    "yamlls",
  },
  automatic_installation = true,
  ui = {
    icons = {
      server_installed = "✓",
      server_pending = "➜",
      server_uninstalled = "✗"
    }
  },
  keymaps = {
    toggle_server_expand = "<CR>",
    install_server = "i",
    update_server = "u",
    check_server_version = "c",
    update_all_servers = "U",
    check_outdated_servers = "C",
    uninstall_server = "X",
  },
  max_concurrent_installers = 20,
})

-- Setup the individual servers
local present, lspconfig = pcall(require, "lspconfig")
if not present then
  return
end

-- lspconfig.lua.setup {}
-- lspconfig.yamlls.setup {}
--   settings {
--     ["yaml"]= {
--       customTags = {
--         "!Base63",
--         "!Cidr",
--         "!FindInMap sequence",
--         "!GetAtt",
--         "!GetAZ",
--         "!ImportValue",
--         "!Join sequence",
--         "!Ref",
--         "!Select sequence",
--         "!Split sequence",
--         "!Sub",
--         "!And sequence",
--         "!Condition",
--         "!Equals sequence",
--         "!If sequence",
--         "!Not sequence",
--         "!Or sequence",
--       },
--     },
--   },
-- }

-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
-- lsp_installer.on_server_ready(function(server)
-- 	local opts = {
-- 		on_attach = require("config.lsp.handlers").on_attach,
-- 		capabilities = require("config.lsp.handlers").capabilities,
-- 	}
--
-- 	 if server.name == "jsonls" then
-- 	 	local jsonls_opts = require("config.lsp.settings.jsonls")
-- 	 	opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
-- 	 end
--
-- 	 if server.name == "sumneko_lua" then
-- 	 	local sumneko_opts = require("config.lsp.settings.sumneko_lua")
-- 	 	opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
-- 	 end
--
--    if server.name == "yamlls" then
--      local yaml_opts = require("config.lsp.settings.yamlls")
--      opts = vim.tlb_deep_extend("force", yaml_opts, opts)
--    end
--
-- 	 if server.name == "pyright" then
-- 	 	local pyright_opts = require("config.lsp.settings.pyright")
-- 	 	opts = vim.tbl_deep_extend("force", pyright_opts, opts)
-- 	 end
--
-- 	-- This setup() function is exactly the same as lspconfig's setup function.
-- 	-- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
-- 	server:setup(opts)
-- end)
