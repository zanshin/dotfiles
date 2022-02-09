set completeopt=menu,menuone,noselect

-- setup lspkind
local lspkind = require "lspkind"
lspkind.init()

-- Setup nvim-cmp.
local cmp = require "cmp"

cmp.setup {
  mapping = {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-e>'] = cmp.mapping.close(),
    ['<C-y>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    },

    ['<C-Space>'] = cmp.mapping.complete(),
  },

  sources = {
    -- Order ranks these
    -- These are global
    { name = "nvim_lsp" },
    { name = "path"  },
    { name = "nvm_lua"  },
    { name = "buffer", keyword_length = 5 },
  },

  formatting = {
    format = lspkind.cmp_format({with_text = true}),
    menu = {
      buffer = "[buf]",
      nvim_lsp = "[LSP]",
      nvim_lua = "[api]",
      path = "[path]",
    },
  },

  experimental = {
    -- New menu, better than the old menu
    native_menu = false,

    -- "ghost" completion
    ghost_text = true,
  },
}

