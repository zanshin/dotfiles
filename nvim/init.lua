-- Bare Bones Neovim Configuration
-- August 4, 2025

-- Set leader and local leader to <space>
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Flag to indicate nerd font is installed
vim.g.have_nerd_font = true

-- Use Lazy for plugin management
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

-- Initialize Lazy
require("lazy").setup("plugins", {
  change_detection = {
    enabled = true,
    nofity = false,
  },
  ui = {
    border = "rounded",
  },
})

-- Use nvim-notify as the default notify function
vim.notify = require("notify")

-- Fold in my preferences
require('my.options')
require('my.mappings')
require('my.autocmds')
