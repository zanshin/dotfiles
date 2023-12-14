-- Indent Blankline (has better JSON formatting)
-- https://github.com/lukas-reineke/indent-blankline.nvim
return {
  'lukas-reineke/indent-blankline.nvim',
  event = "InsertEnter",
  opts = {
    main = 'ibl',
  },
}
