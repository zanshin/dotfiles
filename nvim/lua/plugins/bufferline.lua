return {
  "akinsho/bufferline.nvim",
  -- version = 'v3.*',
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require('bufferline').setup({
      options = {
        mode = 'buffers',
        numbers = 'none',
        indicator = {
          icon = '▎',
          style = 'icon'
        },
        modified_icon = "●",
        buffer_close_icon = "",
        close_icon = "",
        left_trunc_marker = "",
        right_trunc_marker = "",
        diagnostics_indicator = true,
        diagnostics = "nvim_lsp",
        show_buffer_icons = true,
        show_buffer_close_icons = false,
        show_close_icon = false,
        enforce_regular_tabs = true,
        offsets = {
          filetype = "neo-tree",
          text = "Finder",
          highlight = "Directory",
          separator = true
        },
      },
    })
  end
}

-- require("bufferline").setup {
--   options = {
--     mode = "buffers", -- set to "tabs" to only show tabpages instead
--     numbers = "none",
--     --   indicator = {
--     --     icon = '▎', -- this should be omitted if indicator style is not 'icon'
--     --     style = 'icon',
--     --   },
--     --   buffer_close_icon = '󰅖',
--     --   modified_icon = '●',
--     --   close_icon = '',
--     --   left_trunc_marker = '',
--     --   right_trunc_marker = '',
--     --   max_name_length = 18,
--     --   max_prefix_length = 15,     -- prefix used when a buffer is de-duplicated
--     --   truncate_names = true,      -- whether or not tab names should be truncated
--     --   tab_size = 18,
--     --   diagnostics = "nvim_lsp",
--     --   diagnostics_update_in_insert = false,
--     --   offsets = {
--     --     {
--     --       filetype = "neo-tree",
--     --       text = "Finder",
--     --       highlight = "Directory",
--     --       separator = true
--     --     },
--     --   },
--     color_icons = true,       -- whether or not to add the filetype icon highlights
--     show_buffer_icons = true, -- disable filetype icons for buffers
--     --   show_buffer_close_icons = false,
--     --   show_close_icon = false,
--     --   show_tab_indicators = false,
--     --   show_duplicate_prefix = false,       -- whether to show duplicate buffer prefix
--     --   duplicates_across_groups = true,     -- whether to consider duplicate paths in different groups as duplicates
--     --   persist_buffer_sort = true,          -- whether or not custom sorted buffers should persist
--     --   move_wraps_at_ends = false,          -- whether or not the move command "wraps" at the first or last position
--     --   -- can also be a table containing 2 custom separators
--     --   -- [focused and unfocused]. eg: { '|', '|' }
--     --   separator_style = "slant",     -- | "slope" | "thick" | "thin" | { 'any', 'any' },
--     --   enforce_regular_tabs = false,
--     always_show_bufferline = true,
--     --   auto_toggle_bufferline = true,
--     --   hover = {
--     --     enabled = true,
--     --     delay = 200,
--     --     reveal = { 'close' }
--     --   },
--   },
-- }
-- end
-- }
