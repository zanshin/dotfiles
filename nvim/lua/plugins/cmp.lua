-- Completion Plugin Setup
return {
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    'nvim-lua/popup.nvim',
    'nvim-lua/plenary.nvim',

    'hrsh7th/cmp-nvim-lsp',                -- lsp completions
    'hrsh7th/cmp-nvim-lua',                -- lua completions
    'hrsh7th/cmp-nvim-lsp-signature-help', -- lsp signature completions
    'hrsh7th/cmp-vsnip',                   -- VSCode(LSP)'s snippet feature in vim/nvim
    'hrsh7th/cmp-path',                    -- path completions
    'hrsh7th/cmp-buffer',                  -- buffer completions
  },
  config = function()
    local cmp = require('cmp')

    cmp.setup({
      snippet = {
        expand = function(args)
          vim.fn["vsnip#anonymous"](args.body)
        end,
      },
      mapping = {
        -- Select the [n]ext item
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        -- Select the [p]revious item
        ['<C-n>'] = cmp.mapping.select_next_item(),

        -- Accept ([y]es) the completion.
        -- This will auto-import if your LSP supports it.
        -- This will expand snippets if the LSP sent a snippet.
        ['<C-y'] = cmp.mapping.confirm { select = true },

        -- Manually trigger a completion fron nvim-cmp.
        --  Generally you don't need this, because nvim-cmp will display
        --  completions whenever it has completion options available.
        ['<C-Space>'] = cmp.mapping.complete {},

        ['<C-e>'] = cmp.mapping.close(),

        -- Old confirm behaviour - not useful
        -- ['<CR>'] = cmp.mapping.confirm({
        --   behavior = cmp.ConfirmBehavior.Insert,
        --   select = true,
        -- })
        -- Scroll 4 lines
        -- ['<C-S-f>'] = cmp.mapping.scroll_docs(-4),
        -- ['<C-f>'] = cmp.mapping.scroll_docs(4),
        -- Add tab support
        -- ['<S-Tab>'] = cmp.mapping.select_prev_item(),
        -- ['<Tab>'] = cmp.mapping.select_next_item(),
      },
      -- Installed sources:
      sources = {
        { name = 'path' },
        { name = 'nvim_lsp',               keyword_length = 3 },
        { name = 'nvim_lsp_signature_help' },
        { name = 'nvim_lua',               keyword_length = 3 },
        { name = 'buffer',                 keyword_length = 3 },
        { name = 'vsnip',                  keyword_length = 3 },
        { name = 'calc' },
        { name = 'crates' },
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

    })
  end,
}
