-- Neovim Configuration
-- December 10, 2023

-- Must set this ahead of initializing Lazy
vim.g.mapleader = " "
vim.g.maplocalleader = " "

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

-- use nvim-notify as the default notify function
vim.notify = require("notify")

-- These are my personal settings
require("zanshin.options")     -- anything that gets set
require("zanshin.mappings")    -- mappings
require("zanshin.diagnostics") -- LSP diagnostic settings
require("zanshin.snippets")    -- Snippet settings
require("zanshin.lint")        -- Add Linters


-- require("zanshin.autocmds") -- autocommands
-- require("zanshin.helpers")  -- functions to wrap commands
-- require("zanshin.keymaps")  -- Plugin mappings
-- require("zanshin.lazy")     -- manage plugins
-- require("zanshin.colors")   -- color theme
