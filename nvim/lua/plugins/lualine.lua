-- Lualine status line
return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'linrongbin16/lsp-progress.nvim', -- LSP loading progress
    -- 'kdheepal/tabline.nvim',
  },
  opts = {
    options = {
      icons_enabled = true,
      theme = 'ayu',
    },
    extensions = {
      'toggleterm',
    },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = { 'branch' },
      lualine_c = { 'filename' },
      lualine_x = {
        { 'diagnostics', sources = { "nvim_lsp" }, symbols = { error = 'E', info = 'I', hint = 'H' } },
        'encoding', 'fileformat', 'filetype' },
      lualine_y = { 'progress' },
      lualine_z = { 'location' },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { 'filename' },
      lualine_x = { 'location' },
      lualine_y = {},
      lualine_z = {},
    },
    tabline = {}
    -- lualine_a = {},
    -- lualine_b = {},
    -- lualine_c = { 'buffers' },
    -- lualine_x = { 'tabs' },
    -- lualine_y = {},
    -- lualine_z = {}
    -- }
  }
}
