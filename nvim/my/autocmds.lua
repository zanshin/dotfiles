-- Autocmds
-- August 5, 2025
--

-- Remove `r` and `o` from format options to prevent continuing comment leaders automatically
-- Default formatoptions were: `jcroql`
vim.api.nvim_create_autocmd('FileType', {
  desc = 'Set format options',
  group = vim.api.nvim_create_augroup('my-formatoptions', { clear = true }),
  pattern = '*',
  command = "setlocal formatoptions-=ro"
})

-- Enable spelling for Git commit messages
vim.api.nvim_create_autocmd('BufRead', {
  desc = 'Enable spell check for Git commit messages',
  group = vim.api.nvim_create_augroup('my-git-spelling', { clear = true }),
  pattern = "COMMIT_EDITMSG",
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = "en_us"
    vim.api.nvim_feedkeys("ggi", "t", true)
  end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  group = vim.api.nvim_create_augroup('my-highlight-yank', { clear = true}),
  callback = function()
    vim.hl.on_yank()
  end,
})
