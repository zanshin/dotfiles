-- Parker plugin manager

-- helper function for plugin configurations
local function get_config(name)
  return string.format("require(\"config/%s\")", name)
end

-- Automatically install packer.nvim
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path,
  }
  print "Installing Packer, close and reopen Neovim."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand to reload neovim when the plugins.lua file is saved
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  vim.notify("Packer require failed.")
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

return packer.startup(function(use)
  --
  --  Use Packer to manage itself
  use {
    'wbthomason/packer.nvim' --, opt = true
  }

  -- Colorscheme
  use {
    'pacokwon/onedarkhc.vim',
    -- event = 'VimEnter'
  }

  -- Snazzy glyphs
  use {
    'kyazdani42/nvim-web-devicons',
    -- event = 'VimEnter',
  }

  -- Lualine
  use {
    'nvim-lualine/lualine.nvim',
    config = get_config('lualine'),
    -- event = 'VimEnter',
    -- requires = {'kyazdani42/nvim-web-devicons', opt = true}
    -- requires = {'kyazdani42/nvim-web-devicons' },
  }

  -- Tabline
  use {
    'kdheepak/tabline.nvim',
    config = get_config('tabline')
  }

  -- Syntax
  use { 'Yggdroot/indentline' }
  use { 'stephpy/vim-yaml' }
  use { 'hashivim/vim-terraform' }

  -- Git helpers
  -- use {
  --   'lewis6991/gitsigns.nvim',
  -- --  config = get_config('gitsigns'),
  --   requires = { 'nvim-lua/plenary.nvim' }
  -- }

  -- use {
  --   'tpope/vim-fugitive',
  --   config = get_config('fugitive')
  -- }
  --
  -- use { 'airblade/vim-gitgutter' }

  -- Utilities
  use {
    'terrortylor/nvim-comment',
    config = get_config("nvim-comment")
  }

  use {
    'sjl/gundo.vim',
    config = get_config("gundo")
  }

  use { 'tpope/vim-surround' }
  use { 'jiangmiao/auto-pairs' }
  -- use { 'tweekmonster/startuptime.vim' }
  use {
    'folke/which-key.nvim',
    config = get_config("which-key")
  }

  -- Language Server Protocol (LSP)
  use {
    'neovim/nvim-lspconfig',
    -- config = get_config('lspconfig')
  }
  use { 'williamboman/nvim-lsp-installer' }   -- simple to use language server installer

  -- -- Neovim stuff
  -- use { 'kassio/neoterm' }

  -- Telescope
  use {
    'nvim-telescope/telescope.nvim',
    requires = { { "nvim-lua/popup.nvim" }, { "nvim-lua/plenary.nvim" } },
    config = get_config("telescope")
  }

  -- -- Treesitter
  -- use { 'nvim-treesitter/nvim-treesitter' }
  -- use { 'nvim-treesitter/playground' }

  -- Completion
  use {
    'hrsh7th/nvim-cmp',
    requires = { { "nvim-lua/popup.nvim" }, { "nvim-lua/plenary.nvim" } },
    config = get_config("cmp")
  }
  use { 'hrsh7th/cmp-buffer' }     -- buffer completions
  use { 'hrsh7th/cmp-path' }       -- path completions
  use { 'hrsh7th/cmp-cmdline' }    -- command line completions
  use { 'hrsh7th/cmp-nvim-lua' }   -- lua completions
  use { 'hrsh7th/cmp-nvim-lsp' }   -- lsp completions

  -- snippets
  use { 'L3MON4D3/LuaSnip' }       --snippet engine
  use { 'rafamadriz/friendly-snippets' } -- a bunch of snippets to use

  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end
end)
