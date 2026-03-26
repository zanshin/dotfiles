-- My Options
-- August 4, 2024
--

-- Add line numbers and relative line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Always show a wider sign column
vim.opt.signcolumn = "yes"
vim.opt.numberwidth = 6

-- Control indentation
vim.opt.autoindent = true -- Yes, please
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.shiftwidth = 2 -- Size of an indent
vim.opt.shiftround = true -- Round indent
vim.opt.smartindent = true -- Insert indents automatically
vim.opt.softtabstop = 2
vim.opt.tabstop = 2 -- Number of spaces tabs count for

-- Open splits to right or bottom
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Cursor line and ruler
vim.opt.ruler = true
vim.opt.cursorline = true

-- Decrease update and mapped sequence wait times
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

-- Minimum number of lines to keep on screen above/below cursor
vim.opt.scrolloff = 10

-- Case insensitive search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Apply substitutions globally
vim.opt.gdefault = true

-- Preview substitutions live
vim.opt.inccommand = "split"

-- Statusline
vim.opt.cmdheight = 2
vim.opt.showcmd = false

-- Encoding and Language
vim.opt.encoding = "utf-8"
vim.opt.spelllang = "en"
-- vim.opt.spellfile = vim.fn.expand("~/.config/nvim/spell/en.utf-8.add")
vim.opt.spellfile = vim.fs.joinpath(vim.fn.stdpath("config"), "spell/en.utf-8.add")

-- Folding
vim.opt.foldcolumn = "3"
vim.opt.foldenable = true
vim.opt.foldmethod = "marker"

-- Swap, backup, and undo
vim.opt.swapfile = false
vim.opt.backup = false
-- vim.opt.undodir = os.getenv('HOME') .. '/.local/share/nvim/undodir'
vim.opt.undodir = vim.fs.joinpath(vim.fn.stdpath("data"), "undodir")
vim.opt.undofile = true

-- Line width
vim.opt.textwidth = 79
vim.opt.linebreak = true
