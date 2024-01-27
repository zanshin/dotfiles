return {
  "akinsho/bufferline.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons"
  },
  opts = {
    indicator = {
      icon = '>> ',
      style = 'icon',
    },
  },
  config = function()
    require("bufferline").setup {}
  end
}
