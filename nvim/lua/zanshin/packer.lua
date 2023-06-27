-- Automatically install packer.nvim
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
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
  --  Use Packer to manage itself
  use { 'wbthomason/packer.nvim' }


  -- Colorscheme
  use { 'Shatur/neovim-ayu' }

  -- Snazzy glyphs
  use { 'kyazdani42/nvim-web-devicons' }

  use { 'nvim-lualine/lualine.nvim' }
  use { 'kdheepak/tabline.nvim' }

  -- Syntax
  use { 'Yggdroot/indentline' }
  use { 'stephpy/vim-yaml' }
  use { 'hashivim/vim-terraform' }

  -- Git
  use {
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' }
  }
  use { 'tpope/vim-fugitive' }

  -- Utilities
  use { 'terrortylor/nvim-comment' }
  use { 'sjl/gundo.vim' }
  use { 'tpope/vim-surround' }
  use { 'jiangmiao/auto-pairs' }
  use { 'folke/which-key.nvim' }

  -- Language Server Protocol (LSP)
  -- use { 'williamboman/nvim-lsp-installer' }
  use { 'neovim/nvim-lspconfig' }

  -- Mason
  use { 'williamboman/mason.nvim' }
  use { 'williamboman/mason-lspconfig.nvim' }

  use { 'simrat39/rust-tools.nvim' }

  -- Telescope
  use {
    'nvim-telescope/telescope.nvim',
    requires = { { "nvim-lua/popup.nvim" }, { "nvim-lua/plenary.nvim" } }
  }

  -- Treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  use { 'nvim-treesitter/playground' }
  use { 'nvim-treesitter/nvim-treesitter-textobjects' }

  -- Completion
  use {
    'hrsh7th/nvim-cmp',
    requires = { { "nvim-lua/popup.nvim" }, { "nvim-lua/plenary.nvim" } }
  }
  use { 'hrsh7th/cmp-nvim-lsp' }                -- lsp completions

  use { 'hrsh7th/cmp-nvim-lua' }                -- lua completions
  use { 'hrsh7th/cmp-nvim-lsp-signature-help' } -- lsp signature completions
  use { 'hrsh7th/cmp-vsnip' }                   -- VSCode(LSP)'s snippet feature in vim/nvim
  use { 'hrsh7th/cmp-path' }                    -- path completions
  use { 'hrsh7th/cmp-buffer' }                  -- buffer completions
  -- use { 'hrsh7th/cmp-cmdline' }  -- command line completions

  use { 'onsails/lspkind-nvim' } -- vscode-like pictograms

  -- snippets
  use { 'hrsh7th/vim-vsnip' }
  -- use { 'L3MON4D3/LuaSnip' }             --snippet engine
  -- use { 'saadparwaiz1/cmp_luasnip' }
  -- use { 'rafamadriz/friendly-snippets' } -- a bunch of snippets to use

  -- File system access
  use {
    'kyazdani42/nvim-tree.lua',
    requires = { "kyazdani42/nvim-web-devicons" }
  }

  -- neo-tree
  -- Unless you are still migrating, remove the deprecated commands from v1.x
  vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

  use {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    }
  }

  -- netman.nvim - remote file system access
  use { 'miversen33/netman.nvim' }

  -- terminal
  use { 'akinsho/toggleterm.nvim' }
  use { 'voldikss/vim-floaterm' }

  -- debugging
  use { 'mfussenegger/nvim-dap' }
  use { 'leoluz/nvim-dap-go' }
  use {
    'rcarriga/nvim-dap-ui',
    requires = { "mfussenegger/nvim-dap" }
  }
  use { 'theHamsta/nvim-dap-virtual-text' }
  use { 'nvim-telescope/telescope-dap.nvim' }

  -- Symbols
  use { 'simrat39/symbols-outline.nvim' }

  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end
end)
