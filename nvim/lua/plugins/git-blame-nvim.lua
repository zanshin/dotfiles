-- Git Blame
return {
  -- https://github.com/f-person/git-blame.nvim
  'f-person/git-blame.nvim',
  event = 'VeryLazy',
  opts = {
    enabled = false, -- trigger only with keymap
    date_format = '%m/%d/%y %H:%M:%S',
  }
}
