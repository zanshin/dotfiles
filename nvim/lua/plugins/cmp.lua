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

    'onsails/lspkind.nvim',                -- VSCode like pictograms 
  },
  config = function()
    local lspkind = require "lspkind"
    lspkind.init {}

    local cmp = require('cmp')

    cmp.setup({
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
      mapping = {
        -- Select the [p]revious item or [n] item
        ['<C-p>'] = cmp.mapping.select_prev_item{ behavior = cmp.SelectBehavior.Insert },
        ['<C-n>'] = cmp.mapping.select_next_item{ behavior = cmp.SelectBehavior.Insert },

        -- Accept ([y]es) the completion.
        -- This will auto-import if your LSP supports it.
        -- This will expand snippets if the LSP sent a snippet.
        ['<C-y'] = cmp.mapping.confirm (
          cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
          },
          -- completions in [i]nsert and [c]ommand modes
          { "i", "c" }
        ),

        -- Manually trigger a completion fron nvim-cmp.
        --  Generally you don't need this, because nvim-cmp will display
        --  completions whenever it has completion options available.
        ['<C-Space>'] = cmp.mapping.complete {},

        ['<C-e>'] = cmp.mapping.close(),
      },
      snippet = {
        expand = function(args)
          vim.fn["vsnip#anonymous"](args.body)
        end,
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      formatting = {
        format = lspkind.cmp_format({
          mode = 'symbol', -- 'text', 'text_symbol', 'symbol_text', 'symbol'
          maxwidth = 50, 
          ellipsis_char = '...', -- show ellipses_char when popup menu exceeds maxwidth
          show_labelDetails = true, -- show labelDetails in menu. Disabled by default
        })
      },
      -- formatting = {
      --   fields = { 'menu', 'abbr', 'kind' },
      --   format = function(entry, item)
      --     local menu_icon = {
      --       nvim_lsp = 'λ',
      --       vsnip = '⋗',
      --       buffer = 'Ω',
      --       path = '🖫',
      --     }
      --     item.menu = menu_icon[entry.source.name]
      --     return item
      --   end,
      -- },

    })
  end,
}
