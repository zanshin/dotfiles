-- Neovim Configuration
-- December 10, 2023

-- Bootstrap Lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Must set this ahead of initializing Lazy
vim.g.mapleader = " "

require("lazy").setup("plugins", {
  change_detection = {
    enabled = true,
    nofity = false,
  },
})

-- use nvim-notify as the default notify function
vim.notify = require("notify")

-- These are my personal settings
require("zanshin.options")  -- anything that gets set
require("zanshin.mappings") -- mappings
require("zanshin.autocmds") -- autocommands
-- require("zanshin.helpers")  -- functions to wrap commands
-- require("zanshin.keymaps")  -- Plugin mappings
-- require("zanshin.lazy")     -- manage plugins
-- require("zanshin.colors")   -- color theme
-- require("zanshin.diagnostics") -- LSP diagnostic settings
