-- LSP config
return {
  -- https://github.com/neovim/nvim-lspconfig
  'neovim/nvim-lspconfig',
  -- event = 'VeryLazy',
  dependencies = {
    -- LSP Plugin Management
    -- https://github.com/williamboman/mason.nvim
    -- https://github.com/williamboman/mason-lspconfig.nvim
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',

    -- LSP status update
    -- https://github.com/h-hui/fidget.nvim
    { 'j-hui/fidget.nvim', opts = {} },

    -- Additional configuration
    -- https://github.com/folke/neodev.nvim
    { 'folke/neodev.nvim' },
  },
  opts = {
    inlay_hints = { enabled = true },
    diagnostics = { virtual_text = { prefix = "icons" } },
    showMessage = { messageActionItem = { additionalProertiesSupport = true } },
    flags = { debounce_text_changes = 150 },
    -- ui = {
    --   windows = {
    --     border = 'rounded'
    --   },
    -- },
  },

  config = function()
    -- This function gets run when an LSP attaches to a perticular buffer.
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('zanshin-lsp-attach', { clear = true }),
      callback = function(event)
        -- local map function
        local map = function(keys, func, desc)
          vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        -- Jump to the defintion of the word under your cursor.
        map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

        -- Find references for the word under your cursor.
        map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

        -- Jump to the implementations of the word under your cursor.
        map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementations')

        -- Jump to the type of the word under your cursor.
        map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinitions')

        -- Fuzzy find all the symbols in your current document.
        map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

        -- Fuzzy find all the symbols in your current workspace.
        map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

        -- Rename the variable under your cursor.
        map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

        -- Execute a code action, usually your cursor needs to be on top of an
        -- error or suggestion from your LSP for this to activate.
        map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

        -- Opens a popup that displays documentation about the word under your
        -- cursor.
        -- map('K', vim.lsp.buf.hover, 'Hover Documentation')

        -- WARN: This is not GotoDefinition, the is Goto Declaration.
        map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

        -- The following two autocommands are used to highlight references of
        -- the word under your cursor when your cursor rests there for a little
        -- while. When you move your cursor, the highlights will be cleared but
        -- the second autocommand.
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.server_capabilities.documentHighlightProvider then
          local highlight_augroup = vim.api.nvim_create_augroup('zanshin-lsp-highlight', { clear = false })
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
          })
        end

        -- The following autocommand is used to enable inlay hints in your
        -- code, if the language server you are using supports them
        --
        -- This may be unwanted, since they displace some of your code
        if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
          map('<leader>th', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
          end, '[T]oggle Inlay [H]ints')
        end
      end,
    })

    vim.api.nvim_create_autocmd('LspDetach', {
      group = vim.api.nvim_create_augroup('zanshin-lsp-detach', { clear = true }),
      callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.server_capabilities.documentHighlightProvider then
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds { group = 'zanshin-lsp-highlight', buffer = event.buf }
        end
      end,
    })

    -- LSP servers and clients are able to communicate to each other what
    -- features they support. By default, neovim doesn't support everything
    -- that is in the LSP specfication. When you add nvim-cmp, luasnip, etc.
    -- Neovim now has *more* capabilities. So we create new capabilities with
    -- nvim_cmp, and then broadast that to the servers.
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())


    local util = require "lspconfig/util"

    -- Enable these language servers
    --
    -- Add any additional override configuration in the following tables.
    -- Available keys are:
    -- - cmd (table): Override the default command used to start the server
    -- - filetypes (table): Override the default list of associated file types
    -- - capabilities (table): Override fields in capabilitied
    -- - settings (table): Overrid the default settings passed when
    -- initializing the server
    local servers = {
      bashls = {},
      dockerls = {},
      gopls = {},

      -- gopls = {
      --   cmd = { "gopls" },
      --   capabilitied = capabilities,
      --   filetypes = { "go", "gomod", "gowork", "gotmpl" },
      --   root_dir = util.root_pattern("go.work", "go.mod", ".git"),
      --   settings = {
      --     gopls = {
      --       gofumpt = true,
      --       hints = {
      --         assignVariableTypes = true,
      --         compositeLiteralFields = true,
      --         compositeLiteralTypes = true,
      --         constantValues = true,
      --         functionTypeParameters = true,
      --         parameterNames = true,
      --         rangeVariableTypes = true,
      --       },
      --       analyses = {
      --         fieldalignment = true,
      --         unusedwrite = true,
      --         useany = true,
      --       },
      --       completeUnimported = true,
      --       staticcheck = true,
      --       directoryFilters = { "-.git", "-.jj", "-.vscode", "-.idea", "-.vscode-test", "-node_modules", "-.nvim" },
      --       semanticTokens = true,
      --     },
      --   },
      -- },

      jsonls = {},
      lua_ls = {
        -- Get the language server to recognize the 'vim' global
        settings = { Lua = { diagnostics = { globals = { 'vim' } } } }
      },
      pyright = {},
      rust_analyzer = {
        settings = {
          ["rust-analyzer"] = {
            assist = {
              importGranularity =  "module",
              importPrefix = "bu_self",
                group = "crate",
              },
            procMacro = { enable = true },
            cargo = { allFeatures = true },
            checkOnSave = {
              command = "clippy",
              extraArgs = { "--no-deps" },
            },
          },
        },
      },
      solargraph = {},
      tsserver = {},

      yamlls = {
        -- cmd = { "yamls" },
        cmd = { 'yaml-language-server', '--stdio' },
        filetypes = { "yaml", "yml" },
        root_dir = util.find_git_ancestor,
        settings = {
          yaml = {
            -- schemaStore = { enable = true },
            format = { enable = true },
            hover = true,
            completion = true,

            customTags = {
              "!And",
              "!And sequence",
              "!Base64",
              "!Cidr",
              "!Cidr sequence",
              "!Condition",
              "!Equals",
              "!Equals sequence",
              "!FindInMap",
              "!FindInMap sequence",
              "!GetAtt",
              "!GetAZ",
              "!If",
              "!If sequence",
              "!ImportValue",
              "!ImportValue sequence",
              "!Join",
              "!Join sequence",
              "!Not",
              "!Not sequence",
              "!Or",
              "!Or sequence",
              "!Ref",
              "!Select",
              "!Select sequence",
              "!Split",
              "!Split sequence",
              "!Sub",
              "!Sub sequence",
            },
          },
        },
      },
    }

    -- Ensure the servers and tools above are installed
    require('mason').setup()

    -- You can add other tools here that you want Mason to install for you, so
    -- that they are available from within Neovim.
    local ensure_installed = vim.tbl_keys(servers or {})
    vim.list_extend(ensure_installed, {
      'stylua', -- used to format Lua code
    })
    require('mason-tool-installer').setup { ensure_installed = ensure_installed }

    require('mason-lspconfig').setup {
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          -- Handle overriding only values explicitly passed by the server
          -- configuration above. Useful when disabling certain features of an
          -- LSP.
          server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
          require('lspconfig')[server_name].setup(server)
        end,
      },
    }

    require('lspconfig.ui.windows').default_options.border = 'rounded'
  end
}

-- require('mason-lspconfig').setup({
--   -- These are the language servers I want installed
--   -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#lua_ls
--   ensure_installed = {
--     "bashls",
--     "dockerls",
--     "gopls",
--     "jsonls",
--     "lua_ls",
--     "pyright",
--     "rust_analyzer",
--     "solargraph",
--     "tsserver",
--     "yamlls",
--   },
-- })

-- local lspconfig = require('lspconfig')
-- local util = require "lspconfig/util"

-- local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
-- local lsp_attach = function(client, bufnr)
--   -- vim.lsp.inlay_hint.enable(bufnr, true)

--   -- Create key bindings here
--   local opts = { buffer = 0, noremap = true, silent = true }
--   vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

--   vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
--   vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)
--   vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
--   vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)

--   vim.keymap.set("n", "<C-k", vim.lsp.buf.signature_help, opts)
-- end

-- Call setup on each LSP server
-- require('mason-lspconfig').setup_handlers({
--   function(server_name)
--     lspconfig[server_name].setup({
--       on_attach = lsp_attach,
--       capabilities = lsp_capabilities,
--     })
--   end
-- })

-- Lua LSP settings
-- lspconfig.lua_ls.setup {
--   settings = {
--     Lua = {
--       diagnostics = {
--         -- Get the language server to recognize the 'vim' global
--         globals = { 'vim' },
--       },
--     },
--   },
-- }

-- Go LSP lspconfig.gopls.setup {
-- lspconfig.gopls.setup {
--   settings = {
--     gopls = {
--       cmd = { "gopls" },
--       filetypes = { "go", "gomod", "gowork", "gotmpl" },
--       root_dir = util.root_pattern("go.work", "go.mod", ".git"),
--       gofumpt = true,
--       -- codelenses = {
--       --   gc_details = false,
--       --   generate = true,
--       --   regenerate_cgo = true,
--       --   run_govulncheck = true,
--       --   test = true,
--       --   tidy = true,
--       --   upgrade_dependency = true,
--       --   vendor = true,
--       -- },
--       hints = {
--         assignVariableTypes = true,
--         compositeLiteralFields = true,
--         compositeLiteralTypes = true,
--         constantValues = true,
--         functionTypeParameters = true,
--         parameterNames = true,
--         rangeVariableTypes = true,
--       },
--       analyses = {
--         fieldalignment = true,
--         -- nilness = true,
--         -- unusedparams = true,
--         unusedwrite = true,
--         useany = true,
--       },
--       -- usePlaceholders = true,
--       completeUnimported = true,
--       staticcheck = true,
--       directoryFilters = { "-.git", "-.jj", "-.vscode", "-.idea", "-.vscode-test", "-node_modules", "-.nvim" },
--       semanticTokens = true,
--     },
--   },
-- }

-- require('lspconfig.ui.windows').default_options.border = 'rounded'
-- end
-- }
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
