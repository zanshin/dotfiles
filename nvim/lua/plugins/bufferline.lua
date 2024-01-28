return {
  "akinsho/bufferline.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons"
  },
  options = {
    offsets = {
      {
        filetype = "neo-tree",
        text = "Finder",
        -- text = function()
        --   return vim.fn.getcwd()
        -- end,
        highlight = "Directory",
        separator = true
      },
    },
    -- indicator = {
    --   icon = '| ',
    --   style = 'icon',
    -- },
  },
  config = function()
    require("bufferline").setup {}
  end
}
