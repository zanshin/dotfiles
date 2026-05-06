return {

	-- LSP Plugins
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				-- Load luvit types when the `vim.uv` word is found
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
	{
		-- Native LSP Configuration (0.12+)
    -- nvim-lspconfig no longer required
    -- servers are configured with vim.lsp.config()
    -- servers are enabled via vim.lsp.enable()
    -- blink.cmp is the only LSP-related plugin
  	"saghen/blink.cmp",
    -- Mason is now in mason.lua
		dependencies = { "folke/lazydev.nvim" },
		config = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
				callback = function(event)
					local client = vim.lsp.get_client_by_id(event.data.client_id)
          if not client  then
            return
          end

          -- NOTE: As of Neovim 0.12 the following keymaps are built-in
          -- defaults and no longer need to be defined manually:
          -- grn -> vim.lsp.buf.rename
          -- gra -> vim.lsp.buf.code_action
          -- grr -> vim.lsp.buf.reference
          -- gri -> vim.lsp.buf.implementation
          -- grd -> vim.lsp.buf.definiton
          -- grD -> vim.lsp.buf.declaration
          -- gO  -> vim.lsp.buf.document_symbol
          -- gW  -> vim.lsp.buf.workspace_symbol
          -- grt -> vim.lsp.buf.type_definition
          -- See :help lsp-defaults

          -- Toggle inlay hints (if supported)
          if client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
            vim.keymap.set("n", "<leader>th", function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf}))
            end, { buffer = event.buf, desc = "LSP: [T]oggle Inlay [H]ints" })
          end

          -- Document highlight on cursor hold
          if client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup("my-lsp-highlight", { clear = false })

            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd("LspDetach", {
              group = vim.api.nvim_create_augroup("my-lsp-detach", { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api_nvim_clear_autocmds({ group = "my-lsp-highlight", buffer = event2.buf })
              end,
            })
          end
        end,
      })

			-- Format on save using file type LSP
			vim.api.nvim_create_autocmd("BufWritePre", {
				desc = "Format buffer using LSP on save",
				group = vim.api.nvim_create_augroup("my-format-on-save", { clear = true }),
				callback = function()
					vim.lsp.buf.format()
				end,
			})

			-- Diagnostic Config
			-- See :help vim.diagnostic.Opts
			vim.diagnostic.config({
				severity_sort = true,
				float = { border = "rounded", source = "if_many" },
				underline = { severity = vim.diagnostic.severity.ERROR },
				signs = vim.g.have_nerd_font and {
					text = {
						[vim.diagnostic.severity.ERROR] = "󰅚 ",
						[vim.diagnostic.severity.WARN] = "󰀪 ",
						[vim.diagnostic.severity.INFO] = "󰋽 ",
						[vim.diagnostic.severity.HINT] = "󰌶 ",
					},
				} or {},
				virtual_text = false,
			})

      -- Extend capabilities with blink.cmp for all servers
			local capabilities = require("blink.cmp").get_lsp_capabilities()

      -- Server configurations using native vim.lsp.config()
      -- Each entry maps directly to a vim.lsp.config() call and a 
      -- corresponding vim.lsp.enable() -- Mason handles the installation.
			local servers = {
				bashls = {},
				dockerls = {},
				gopls = {},
				jsonls = {},
				lua_ls = {
					settings = { Lua = { diagnostics = { globals = { "vim" } } } },
				},
				pyright = {},
				yamlls = {
					cmd = { "yaml-language-server", "--stdio" },
					filetypes = { "yaml", "yml" },
					settings = {
						yaml = {
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
							}, -- custom tags
						}, -- yaml
					}, -- settings
				}, -- yamlls
			}

      for name, config in pairs(servers)  do
        config.capabilities = vim.tbl_deep_extend("force", {},  capabilities, config.capabilities or {})
        vim.lsp.config(name, config)
        vim.lsp.enable(name)
      end
    end,
	},
}
