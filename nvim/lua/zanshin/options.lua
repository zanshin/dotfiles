-- Options

-- Indentation
opt.autoindent = true -- Yes, please
opt.expandtab = true -- Use spaces instead of tabs
opt.shiftwidth = 2 -- Size of an indent
opt.shiftround = true -- Round indent
opt.smartindent = true -- Insert indents automatically
opt.softtabstop = 2
opt.tabstop = 2 -- Number of spaces tabs count for

-- Buffers
opt.hidden = true -- buffer switch without saving

-- Swap,backup, undo
opt.swapfile = false -- no swap file
opt.backup = false -- no backup file either
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true -- let's have an undo file, at the location above

-- Search
opt.ignorecase = true -- Ignore case
opt.smartcase = true -- Set 'noignorecae' if search pattern contains an uppercase letter
opt.gdefault = true -- apply substitutions globbaly - use 'g' for old style
opt.incsearch = true -- use incremental search
opt.hlsearch = true -- highlight search results

-- UI
opt.number = true -- Show line numbers
opt.relativenumber = true -- Relative line numbers
opt.numberwidth = 4 -- set number column width to 4. default is 2
opt.signcolumn = "yes" -- always show to prevent text shifting
opt.ruler = true -- show current cursor position
opt.linebreak = true -- wrap intelligently - no hard line breaks
opt.linespace = 3 -- prefer a slightly higher line height
opt.wrap = true -- Disable line wrap
opt.showmode = false -- Disable native mode indicator
--opt.showtabline = 2                    -- always show tabline
opt.pumheight = 10 -- pop up menu height

opt.list = true -- Show some invisible characters
opt.listchars = { -- Strings to use when 'list' option set.
  tab = '│ ', -- Characters to be used to show a tab.
  nbsp = '␣', -- Character to show for a non-breakable space character.
  extends = '❯', -- Character to show in last column, when 'wrap' is off
  precedes = '❮', -- Character to show in first visible column
  eol = '¬', -- Character to show at end of line
  trail = '⋅', -- Character to show trailing spaces
}

opt.ruler = true -- show current cursor position
opt.cursorline = true -- highlight line where cursor is
opt.showmatch = true -- show matching brackets [{()}]
opt.lazyredraw = true -- Redraw only when necessary
opt.termguicolors = true -- True color support
opt.textwidth = 79 -- ... at column 79

-- UX
opt.pastetoggle = "<F2>" -- toggle paste mode on/off
opt.splitbelow = true -- Put new windows below current
opt.splitright = true -- Put new windows right of current
opt.joinspaces = false -- No double spaces with join

opt.backspace = { -- Make backspace behave in a sane manner
  'indent',
  'eol',
  'start'
}

opt.foldcolumn = "3" -- Room for fold markers
opt.foldenable = true -- Enable folding
opt.foldmethod = "marker" -- Standard 3 curly braces as markers
opt.formatoptions = table.concat {
  'c', -- Auto-wrap comments
  'q', -- allow formatting of comments with `gq
  'n', -- recognize number lists
  'l', -- don't break long lines that were already there
  --  '-t',                                -- don't autowrap text
}

opt.cpoptions = table.concat {
  '$', -- set $ at end of change range
}

opt.showmatch = true -- show matching brackets [{()}]
-- opt.matchpairs = '<:>' -- also match < and >
opt.timeoutlen = 500 -- Time in milliseconds to wait for a mapped sequence to complete
opt.ttimeoutlen = 50 -- Key code time out

-- Messages
opt.shortmess:append {
  I = true, -- No splash screen
  --  W = true,                            -- Don't print "written" when editing
  a = true, -- Use abbreviations in messages ([RO] intead of [readonly])
  c = true, -- Do not show ins-completion-menu messages (match 1 of 2)
}

-- Navigation
opt.scrolloff = 5 -- Lines of context
opt.sidescrolloff = 10 -- Columns of context
opt.sidescroll = 1 -- number of columns to scroll at a time

-- Status
opt.laststatus = 2 -- always show the status line
opt.showcmd = true -- show the command
opt.cmdheight = 2 -- make status two-lines tall

-- File focus
opt.autowrite = true -- write out old file when switching between files
opt.autoread = true -- reload files changed on disk

-- Spelling
-- opt.spellfile = "~/.config/nvim/spell/en.uft-8.add"
opt.encoding = "utf-8"
opt.spelllang = "en"

-- Encoding - we like UTF-8
opt.fileencoding = "utf-8"
--
-- opt.termencoding = "utf-8"
-- opt.encoding=utf-8
-- opt.noshowmode                   -- don't show the mode - lightline will do that
