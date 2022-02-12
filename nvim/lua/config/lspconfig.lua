-- LSP Configurations
-- local lspconfig = require("lspconfig")

local lsp = vim.lsp

local border_opts = { border = "single", focusable = false, scope = "line"  }

vim.diagnostic.config({ virtual_text = false, float = border_opts })

lsp.handlers["textDocument/signatureHelp"] = lsp.with(lsp.handlers.signature_help, border_opts)
lsp.handlers["textDocument/hover"] = lsp.with(lsp.handlers.hover, border_opts)

local get_map_options = function(custom_options)
  local options = { noremap = true, silent = true }
  if custom_options then
    options = vim.tbl_extend("force", options, custom_options)
  end
  return options
end

local buf_map = function(mode, target, source, opts, bufnr)
  api.nvim_buf_set_keymap(bufnr or 0, mode, target, source, get_map_options(opts))
end

-- on_attach function
local on_attach = function(client, bufnr)
--    require('completion').on_attach()
    -- completion
    -- buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- mappings
    -- See :help vim.lsp.* for documenatation on any of the below functions
    buf_map('n', 'gD',       '<Cmd>lua vim.lsp.buf.declaration()<cr>', nil, bufnr)
    buf_map('n', 'gd',       '<Cmd>lua vim.lsp.buf.definition()<cr>', nil, bufnr)
    buf_map('n', 'K',        '<Cmd>lua vim.lsp.buf.hover()<cr>', nil, bufnr)
    buf_map('n', 'gi',       '<Cmd>lua vim.lsp.buf.implementation()<cr>', nil, bufnr)
    buf_map('n', '<C-k>',    '<Cmd>lua vim.lsp.buf.signature_help()<cr>', nil, bufnr)
    buf_map('n', 'gr',       '<Cmd>lua vim.lsp.buf.references()<cr>', nil, bufnr)
    buf_map('n', '<space>e', '<Cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>', nil, bufnr)
    buf_map('n', '[d',       '<Cmd>lua vim.lsp.diagnostic.goto_prev()<cr>', nil, bufnr)
    buf_map('n', ']d',       '<Cmd>lua vim.lsp.diagnostic.goto_next()<cr>', nil, bufnr)
    buf_map('n', '<space>q', '<Cmd>lua vim.lsp.diagnostic.set_loclist()<cr>', nil, bufnr)

    -- telescope
    buf_map("n", "gr", ":LspRef<CR>", nil, bufnr)
    buf_map("n", "gd", ":LspDef<CR>", nil, bufnr)
    buf_map("n", "ga", ":LspAct<CR>", nil, bufnr)
    buf_map("v", "ga", "<Esc><cmd> LspRangeAct<CR>", nil, bufnr)

    if client.resolved_capabilities.document_formatting then
      vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
    end

    require("illuminate").on_attach(client)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

-- require("config.lsp.bashls").setup(on_attach, capabilities)
require("config.lsp.gopls").setup(on_attach, capabilities)
-- require("config.lsp.jsonls").setup(on_attach, capabilities)
