return {

	-- Colorscheme
	'Shatur/neovim-ayu',

	-- Snazzy glyphs
	'kyazdani42/nvim-web-devicons',

	-- Lualine
	'nvim-lualine/lualine.nvim',
	'kdheepak/tabline.nvim',

	-- Syntax
	'Yggdroot/indentline',
	'stephpy/vim-yaml',
	'hashivim/vim-terraform',

	-- Git
	{
		'lewis6991/gitsigns.nvim',
		dependencies = {
			'nvim-lua/plenary.nvim',
		},
	},
	'tpope/vim-fugitive',

	-- Utilities
	'terrortylor/nvim-comment',
	'sjl/gundo.vim',
	'tpope/vim-surround',
	'jiangmiao/auto-pairs',
	-- 'folke/which-key.nvim',

	-- Language Server Protocol (LSP)
	-- use { 'williamboman/nvim-lsp-installer' }
	'neovim/nvim-lspconfig',

	-- Mason
	'williamboman/mason.nvim',
	'williamboman/mason-lspconfig.nvim',

	-- Rusty things
	'simrat39/rust-tools.nvim',

	-- Telescope
	{
		'nvim-telescope/telescope.nvim',
		dependencies = {
			'nvim-lua/popup.nvim',
			'nvim-lua/plenary.nvim',
		},
	},

	-- Treesitter
	'nvim-treesitter/nvim-treesitter',
	--     run = ':TSUpdate'
	'nvim-treesitter/playground',
	'nvim-treesitter/nvim-treesitter-textobjects',

	-- Completion
	{
		'hrsh7th/nvim-cmp',
		dependencies = {
			'nvim-lua/popup.nvim',
			'nvim-lua/plenary.nvim',
		},
	},
	'hrsh7th/cmp-nvim-lsp',               -- lsp completions
	'hrsh7th/cmp-nvim-lua',               -- lua completions
	'hrsh7th/cmp-nvim-lsp-signature-help', -- lsp signature completions
	'hrsh7th/cmp-vsnip',                  -- VSCode(LSP)'s snippet feature in vim/nvim
	'hrsh7th/cmp-path',                   -- path completions
	'hrsh7th/cmp-buffer',                 -- buffer completions
	-- 'hrsh7th/cmp-cmdline',  -- command line completions

	'onsails/lspkind-nvim', -- vscode-like pictograms

	-- snippets
	'hrsh7th/vim-vsnip',
	-- 'L3MON4D3/LuaSnip',             --snippet engine
	-- 'saadparwaiz1/cmp_luasnip',
	-- 'rafamadriz/friendly-snippets', -- a bunch of snippets to use
	--
	-- File system access
	-- nvim-tree
	-- { 'kyazdani42/nvim-tree.lua',
	--   dependencies = {
	--     'kyazdani42/nvim-web-devicons'
	--   },
	-- },

	-- neo-tree
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
			-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
		},
	},

	-- terminal
	'akinsho/toggleterm.nvim',
	'voldikss/vim-floaterm',

	-- debugging
	'mfussenegger/nvim-dap',
	'leoluz/nvim-dap-go',
	{
		'rcarriga/nvim-dap-ui',
		dependencies = {
			'mfussenegger/nvim-dap',
		},
	},

	'theHamsta/nvim-dap-virtual-text',
	'nvim-telescope/telescope-dap.nvim',

	-- Symbols
	'simrat39/symbols-outline.nvim',

	-- Neorg
	-- https://github.com/nvim-neorg/neorg
	-- 'nvim-neorg/neorg',
	--     run = ":Neorg sync-parsers",
	--     requires = { "nvim-lua/plenary.nvim" }
}
