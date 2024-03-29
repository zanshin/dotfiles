-- LSP config
return {
  -- https://github.com/neovim/nvim-lspconfig
  'neovim/nvim-lspconfig',
  event = 'VeryLazy',
  dependencies = {
    -- LSP Plugin Management
    -- https://github.com/williamboman/mason.nvim
    -- https://github.com/williamboman/mason-lspconfig.nvim
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',

    -- LSP status update
    -- https://github.com/h-hui/fidget.nvim
    { 'j-hui/fidget.nvim', opts = {} },

    -- Additional configuration
    -- https://github.com/folke/neodev.nvim
    { 'folke/neodev.nvim' },
  },
  opts = {
    inlay_hints = { enabled = true },
    -- ui = {
    --   windows = {
    --     border = 'rounded'
    --   },
    -- },
  },
  config = function()
    require('mason').setup()
    require('mason-lspconfig').setup({
      -- These are the language servers I want installed
      -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#lua_ls
      ensure_installed = {
        "bashls",
        "dockerls",
        "gopls",
        "jsonls",
        "lua_ls",
        "pyright",
        "rust_analyzer",
        "solargraph",
        "tsserver",
        "yamlls",
      },
    })

    local lspconfig = require('lspconfig')
    local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
    local lsp_attach = function(client, bufnr)
      -- vim.lsp.inlay_hint.enable(bufnr, true)

      -- Create key bindings here
      local opts = { buffer = 0, noremap = true, silent = true }
      vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

      vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
      vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
      vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)

      vim.keymap.set("n", "<C-k", vim.lsp.buf.signature_help, opts)
    end

    -- Call setup on each LSP server
    require('mason-lspconfig').setup_handlers({
      function(server_name)
        lspconfig[server_name].setup({
          on_attach = lsp_attach,
          capabilities = lsp_capabilities,
        })
      end
    })

    -- Lua LSP settings
    lspconfig.lua_ls.setup {
      settings = {
        Lua = {
          diagnostics = {
            -- Get the language server to recognize the 'vim' global
            globals = { 'vim' },
          },
        },
      },
    }

    -- Go LSP lspconfig.gopls.setup {
    lspconfig.gopls.setup {
      settings = {
        gopls = {
          completeUnimported = true,
          usePlaceholders = true,
          analyses = {
            unusedparams = true,
          },
        },
      },
    }

    require('lspconfig.ui.windows').default_options.border = 'rounded'
  end
}
--
-- -- Fold in completion capabilities
-- -- local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
-- -- local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
--
-- -- Options for keymaps. buffer = 0 means current buffer only
-- local opts = { buffer = 0, noremap = true, silent = true }
--
-- -- Diagnostics
-- vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
-- vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
-- vim.keymap.set("n", "<leader>dl", "<cmd>Telescope diagnostics<cr>", opts)
-- vim.keymap.set("n", "<leader>de", "<cmd>lua vim.diagnostic.open_float()<cr>", opts)
-- vim.keymap.set("n", "<leader>q", "<cmd>lua vim.diagnostics.set_loclist()<cr>", opts)
--
-- -- Use an on_attach function to only map the following keys
-- -- after the language server attaches to the current buffer
-- -- local on_attach = function(client, bufnr)
-- local on_attach = function()
--   -- Use built in keymap function for Mappings
--   vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
--
--   vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
--   vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)
--   vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
--   vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
--
--   vim.keymap.set("n", "<C-k", vim.lsp.buf.signature_help, opts)
--
--   -- local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
--   -- local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
--   --
--   -- -- Mappings
--   -- buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
--   -- buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
--   -- buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
--   -- buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
--   -- buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
--   -- buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
--   -- buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
--
--   -- Set some keybinds conditionally on server capabilities
--   -- if client.resolved_capabilities.document_formatting then
--   --   buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
--   -- elseif client.resolved_capabilities.document_range_formatting then
--   --   buf_set_keymap("n", "<sapce>f", "<cmd>lua vim.lsp.buf.formatting(0<CR>", opts)
--   -- end
--
--   vim.api.nvim_create_autocmd("CursorHold", {
--     buffer = 0,
--     callback = function()
--       local lopts = {
--         focusable = false,
--         close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
--         border = 'rounded',
--         source = 'always',
--         prefix = ' ',
--         scope = 'cursor',
--       }
--       vim.diagnostic.open_float(nil, lopts)
--     end
--   })
-- end
--
-- -- Use a loop to call 'setup' on multiple servers and
-- -- map buffer local keybindings when the LSP attaches
-- local servers = {
--   'bashls',
--   'dockerls',
--   'gopls',
--   'jsonls',
--   'pyright',
--   'rust_analyzer',
--   'solargraph',
--   -- 'sumneko_lua',
--   'tsserver',
--   'lua_ls',
--   'yamlls',
-- }
--
-- -- Setup for each LSP specified here (for now) — messy but centralized
-- for _, lsp in pairs(servers) do
--   lspconfig[lsp].setup {
--     on_attach = on_attach,
--     -- capabilities = capabilities,
--     settings = {
--       -- Lua
--       Lua = { diagnostics = { globals = { 'vim' } } },
--
--       -- rust-analyzer
--       -- features = ssr, for LSP support in leptos SSR functions } },
--       -- https://gist.github.com/GeordieP/07ad21a714f98deda71a9ea4330caef1?permalink_comment_id=4666712#gistcomment-4666712
--       -- ["rust-analyzer"] = { cargo = { allFeatures = "ssr" } },
--
--       -- Typescript
--       -- typescript = { disableSuggestions = true },
--
--       -- YAML
--       yaml = {
--         customTags = {
--           "!Base63",
--           "!Cidr",
--           "!FindInMap sequence",
--           "!GetAtt",
--           "!GetAZ",
--           "!ImportValue",
--           "!Join sequence",
--           "!Ref",
--           "!Select sequence",
--           "!Split sequence",
--           "!Sub",
--           "!And sequence",
--           "!Condition",
--           "!Equals sequence",
--           "!If sequence",
--           "!Not sequence",
--           "!Or sequence",
--         }
--       },
--     }
--   }
-- end
--
-- require 'nvim-treesitter.configs'.setup {
--   highlight = {
--     enable = true
--   },
-- }
