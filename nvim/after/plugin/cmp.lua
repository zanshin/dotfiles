-- Protected require of cmp plugin
local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
  vim.notify("cmp not available.")
  return
end

-- Completion Plugin Setup
cmp.setup {
  -- Enable LSP snippets
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    -- Add tab support
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<C-S-f>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  },
  -- Installed sources:
  sources = {
    { name = 'path' },                                       -- file paths
    { name = 'nvim_lsp',               keyword_length = 3 }, -- from language server
    { name = 'nvim_lsp_signature_help' },                    -- display function signatures with current parameter emphasized
    { name = 'nvim_lua',               keyword_length = 2 }, -- complete neovim's Lua runtime API such vim.lsp.*
    { name = 'buffer',                 keyword_length = 2 }, -- source current buffer
    { name = 'vsnip',                  keyword_length = 2 }, -- nvim-cmp source for vim-vsnip
    { name = 'calc' },                                       -- source for math calculation
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  formatting = {
    fields = { 'menu', 'abbr', 'kind' },
    format = function(entry, item)
      local menu_icon = {
        nvim_lsp = 'λ',
        vsnip = '⋗',
        buffer = 'Ω',
        path = '🖫',
      }
      item.menu = menu_icon[entry.source.name]
      return item
    end,
  },
}

-- Original confi commented out 6/26/2023
-- Protected require of luasnip plugin
-- -- local snip_status_ok, luasnip = pcall(require, "luasnip")
-- -- if not snip_status_ok then
-- --   vim.notify("luasnip not available.")
-- --   return
-- -- end
--
-- -- Protected require of lspkind plugin
-- local lspkind_status_ok, lspkind = pcall(require, "lspkind")
-- if not lspkind_status_ok then
--   return
-- end
--
-- -- Lasy load some vscode stuff
-- require("luasnip/loaders/from_vscode").lazy_load()
--
-- -- Improve "super" tab functionality for stepping through snippets
-- -- local check_backspace = function()
-- --   local col = vim.fn.col "." - 1
-- --   return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
-- -- end
--
-- cmp.setup {
--   -- snippet = {
--   --   expand = function(args)
--   --     luasnip.lsp_expand(args.body) -- For `luasnip` users.
--   --   end,
--   -- },
--
--   mapping = {
--     ["<C-p>"] = cmp.mapping.select_prev_item(),
--     ["<C-n>"] = cmp.mapping.select_next_item(),
--     -- Add TAB support
--     ["<S-Tab>"] = cmp.mapping.select_prev_item(),
--     ["<Tab>"] = cmp.mapping.select_next_item(),
--     ["<C-S-f>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
--     ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
--     ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
--     ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
--     ["<C-e>"] = cmp.mapping {
--       i = cmp.mapping.abort(),
--       c = cmp.mapping.close(),
--     },
--     -- Accept currently selected item. If none selected, `select` first item.
--     -- Set `select` to `false` to only confirm explicitly selected items.
--     ["<CR>"] = cmp.mapping.confirm { select = false },
--
--   --   ["<Tab>"] = cmp.mapping(function(fallback)
--   --     if cmp.visible() then
--   --       cmp.select_next_item()
--   --     elseif luasnip.expandable() then
--   --       luasnip.expand()
--   --     elseif luasnip.expand_or_jumpable() then
--   --       luasnip.expand_or_jump()
--   --     elseif check_backspace() then
--   --       fallback()
--   --     else
--   --       fallback()
--   --     end
--   --   end, {
--   --     "i",
--   --     "s",
--   --   }),
--   --   ["<S-Tab>"] = cmp.mapping(function(fallback)
--   --     if cmp.visible() then
--   --       cmp.select_prev_item()
--   --     elseif luasnip.jumpable(-1) then
--   --       luasnip.jump(-1)
--   --     else
--   --       fallback()
--   --     end
--   --   end, {
--   --     "i",
--   --     "s",
--   --   }),
--   -- },
--
--   sources = {
--     -- Order ranks these
--     -- These are global
--     { name = "path" },                                       -- file paths
--     { name = "nvim_lsp",               keyword_length = 3 }, -- from language server
--     { name = "nvim_lsp_signature_help" },                    -- display function signatures
--     { name = "nvim_lua",               keyword_length = 2 }, -- complete nvim lua API such as vim.lsp.*
--     { name = "buffer",                 keyword_length = 5 }, -- source current buffer
--     { name = "luasnip" },                                    -- snippets
--   },
--
--   formatting = {
--     format = lspkind.cmp_format({ with_text = true }),
--     menu = {
--       buffer = "[buf]",
--       nvim_lsp = "[lsp]",
--       nvim_lua = "[api]",
--       path = "[pwd]",
--       luasnip = '[snp]',
--     },
--   },
--
--   window = {
--     completion = cmp.config.window.bordered(),
--     documentation = cmp.config.window.bordered(),
--     -- documentation = {
--     --   border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
--     -- },
--   },
--
--   confirm_opts = {
--     behavior = cmp.ConfirmBehavior.Replace,
--     select = false,
--   },
--
--   experimental = {
--     -- New menu, better than the old menu
--     native_menu = false,
--
--     -- "ghost" completion
--     ghost_text = true,
--   },
-- }
--
-- -- -- Use buffer source for `/`
-- -- cmp.setup.cmdline('/', {
-- --   completion = { autocomplete = false },
-- --   sources = {
-- --     -- { name = 'buffer' }
-- --     { name = 'buffer', opts = { keyword_pattern = [=[[^[:blank:]].*]=] } }
-- --   }
-- -- })
-- --
-- -- -- Use cmdline & path source for ':'
-- -- cmp.setup.cmdline(':', {
-- --   mapping = cmp.mapping.preset.cmdline(),
-- --   completion = { autocomplete = true },
-- --   sources = cmp.config.sources({
-- --     { name = 'path' }
-- --   }, {
-- --     { name = 'cmdline' }
-- --   })
-- -- })
