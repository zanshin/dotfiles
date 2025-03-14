-- Mappings
-- Modes
--   normal_mode = "n"
--   insert_mode = "i"
--   visual_mode = "v"
--   visual_block_mode = "x"
--   term_mode = "t"
--   command_mode = "c"

-- Diagnostic keymaps
-- Now builtin
-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
-- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message.' })
--
-- Built-in uses <C-w> d (and <C-w><C-D) to open float
-- vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- map("", "<Space>", "<Nop>") -- map Space to a no-op
-- g.mapleader = ' '           -- space for leader
-- g.maplocalleader = ' '      -- space for local leader too
vim.keymap.set('n', ';', ':', { desc = 'Map ; to be :' })
vim.keymap.set('n', ';;', ';', { desc = 'Map ;; to be ;' })

-- Disable arrow keys and make semi-snarky comment instead
vim.keymap.set('n', '<Left>', '<cmd>echo "Use h"<CR>')
vim.keymap.set('n', '<Right>', '<cmd>:echo "Use l"<CR>')
vim.keymap.set('n', '<Up>', '<cmd>echo "Use k"<CR>')
vim.keymap.set('n', '<Down>', '<cmd>echo "Use j"<CR>')

-- Use Control-hjkl to switch between splits
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the upper window' })

-- Move to first non-blank or last non-blank character in current line
-- vim.keymap.set('n', 'F', '^', { desc = 'Move to first non-blank character in the line' })
-- vim.keymap.set('n', 'L', 'g_', { desc = 'Move to last non-blank character in the line' })

-- Fix regex handling to be "normal"
-- map('n', '/', '/\v')
-- map('v', '/', '/\v')

-- Map escape to jj -- faster to type
--Also, jk and kj. The more the merrier
vim.keymap.set('i', 'jj', '<ESC>', { desc = 'Use jj as an ESC key substitute' })
vim.keymap.set('i', 'jk', '<ESC>', { desc = 'Use jk as an ESC key substitute' })
vim.keymap.set('i', 'kj', '<ESC>', { desc = 'Use kj as an ESC key substitute' })

-- Remove search highlighting with <leader>/
vim.keymap.set('n', '<leader>/', ':nohlsearch<CR>', { desc = 'Remove search highlighting' })

-- Relative number / absolue numbr toggle
-- vim.keymap.set('n', '<F10>', ':set relativenumber! number! number?<CR>',
vim.keymap.set('n', '<F10>', ':set relativenumber!<CR>', { desc = 'Toggle between number and relative number' })
vim.keymap.set('n', 'nn', ':set norelativenumber<cr>', { desc = 'Turn relative line numbering off' })
vim.keymap.set('n', 'nr', ':set relativenumber<cr>', { desc = 'Turn relative line numbering on' })

-- Move line(s) up or down via J and K respectively
-- map('v', '<C-j>', ":m '>+1<CR>gv=gv")
-- map('v', '<C-k>', ":m '<-2<CR>gv=gv")
-- Normal mode
-- map('n', '<C-D>', ':m .+1<cr>==')
-- map('n', '<C-U>', ':m .-2<cr>==')

-- Insert mode
-- map('i', '<C-d>', '<ESV>:m .+1<cr>==gi')
-- map('i', '<C-u>', '<ESV>:m .-2<cr>==gi')

-- Visual mode
-- map('v', '<C-d>', ':m >+1<cr>gv=gv')
-- map('v', '<C-u>', ':m >-2<cr>gv=gv')

-- Scroll 1/2 a page and center
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = 'Scroll [D]own half a page and then center that line' })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = 'Scroll [U]p half a page and then center that line' })

-- Override n/N to show next/previous search result, but centered
vim.keymap.set("n", "n", "nzzzv", { desc = 'Move to [N] search result and center in the window' })
vim.keymap.set("n", "N", "Nzzzv", { desc = 'Move to [N] search result and center in the window' })

-- Buffers and tabs
vim.keymap.set('n', '<leader>be', ':enew<CR>', { desc = 'Create a new empty buffer' })
vim.keymap.set('n', '<leader>bn', ':bnext<CR>', { desc = 'Move to the next buffer' })
vim.keymap.set('n', '<leader>bp', ':bprevious<CR>', { desc = 'Move to the previous buffer' })
vim.keymap.set('n', '<leader>bc', ':bp <BAR> bd $<CR>', { desc = 'Move to the previous buffer, and close the current' })

vim.keymap.set('n', '<S-n>', ':bnext<CR>', { desc = 'Move to the [N]ext buffer' })
vim.keymap.set('n', '<S-p>', ':bprevious<CR>', { desc = 'Move to the [P]revious buffer' })

-- Sudo to write protected file
vim.keymap.set('c', 'w!!', '!sudo tee % >/dev/null', { desc = 'Use sudo to write protected file' })

-- Toggle listchars on / off
vim.keymap.set('n', '<leader>l', ':set list!<cr>', { desc = 'Toggle [L]istchars on or off' })

-- Splits
vim.keymap.set('n', '<leader>v', '<C-w>v<C-w>l', { desc = 'Open a [V]ertical split and move focus there' })
vim.keymap.set('n', '<leader>h', '<C-w>s<C-w>j', { desc = 'Open a [H]orizontal split and move focus there' })

-- System clipboard
vim.keymap.set('v', 'Y', '"+y', { desc = '[Y]ank to system clipboard in visual mode' })
vim.keymap.set('n', '<leader>y', '\"+y', { desc = '[y]ank to system clipboard in normal node' })
vim.keymap.set('n', '<leader>p', '\"+p', { desc = '[p]aste from system clipboard in normal node' })
vim.keymap.set('n', '<leader>d', '\"+d', { desc = '[d]elete to system clipboard in normal node' })

-- Use jq to format JSON
vim.keymap.set('n', '<leader>jq', ':%!jq .<cr>', { desc = 'Format current buffer using JQ' })

-- Neovim configuration file
vim.keymap.set('n', '<leader>ev', '<cmd>e $MYVIMRC<CR>', { desc = 'Open NVIM configuration file for editing' })
vim.keymap.set('n', '<leader>sv', ':source ~/.config/nvim/init.lua<CR>:filetype detect<CR>',
  { desc = 'Source NVIM configuration file' })

vim.keymap.set("n", "<leader>x", "<cmd>.lua<CR>", { desc = "Execute the current line" })
vim.keymap.set("n", "<leader><leader>x", "<cmd>source %<CR>", { desc = "Execute the current file" })

-- Quickfix navigation
vim.keymap.set('n', '<leader>qn', ':cnext<cr>', { desc = 'Move to the [N]ext Quickfix list item' })
vim.keymap.set('n', '<leader>qp', ':cprev<cr>', { desc = 'Move to the [P]revious Quickfix list item' })
vim.keymap.set('n', '<leader>qo', ':copen<cr>', { desc = '[Q]uicklist [o]pen' })
vim.keymap.set('n', '<leader>qc', ':cclose<cr>', { desc = '[Q]uicklist [c]lose' })

-- -----------------------------------------------------------------------
-- Plugin mappings
-- -----------------------------------------------------------------------
-- Treesitter mappings
vim.keymap.set('n', '<leader>tsp', ':TSPlaygroundToggle<CR>', { desc = '[T]oggle [T]ree[S]itter playground' })
vim.keymap.set('n', '<leader>tsh', ':TSHighlightCapturesUnderCursor<CR>', { desc = '[T]ree[S]itter [H]ighlight' })

-- Telescope mappings
local builtin = require 'telescope.builtin'
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope [F]ind [F]iles' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescop open help' })
vim.keymap.set('n', '<leader>fw', builtin.live_grep, { desc = 'Telescop live grep' })
vim.keymap.set('n', '<Leader>fb', builtin.buffers, { desc = 'Telescope list buffers' })
vim.keymap.set('n', '<Leader>fo', builtin.commands, { desc = 'Telescope list commands' })

-- Git things
vim.keymap.set('n', '<Leader>fgs', builtin.git_status, { desc = 'Telescope Git status' })
vim.keymap.set('n', '<Leader>fgf', builtin.git_files, { desc = 'Telescope Git files' })
vim.keymap.set('n', '<Leader>fgc', builtin.git_commits, { desc = 'Telescope Display Git Commit History' })
vim.keymap.set('n', '<Leader>fgb', builtin.git_branches, { desc = 'Telescope Display Git branches' })
-- vim.keymap.set('n', '<Leader>fgt', builtin.git_stash, { desc = 'Telescope Git Stash' })

-- Neo-tree
-- (need to escape \ with another \)
vim.keymap.set('n', '<leader>\\', ':Neotree reveal<cr>', { desc = 'Reveal Neotree window' })
-- vim.keymap.set('n', '<C-n>', ':Neotree toggle<cr>', { desc = 'Toggle [N]eotree window' })


-- Git Blame
vim.keymap.set("n", "<leader>gB", ":GitBlameToggle<cr>", { desc = 'Toggle Git [B]lame on / off' })

-- Neogit
vim.keymap.set("n", "<leader>gs", ":Neogit<cr>", { desc = '[g]it [s]tatus' })
vim.keymap.set("n", "<leader>gc", ":Neogit commit<cr>", { desc = '[g]it [c]ommit' })
vim.keymap.set("n", "<leader>gp", ":Neogit pull<cr>", { desc = '[g]it [p]ull' })
vim.keymap.set("n", "<leader>gP", ":Neogit pull<cr>", { desc = '[g]it [P]ush' })
vim.keymap.set("n", "<leader>gb", "builtin.git_branches<cr>", { desc = '[g]it [b]ranches' })

-- Trouble
vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>", { silent = true, noremap = true, desc = 'Toggle Trouble' })
vim.keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", { silent = true, noremap = true, desc = 'Workspace Diagnostics' })
vim.keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", { silent = true, noremap = true, desc = 'Document Diagnostics' })
vim.keymap.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>", { silent = true, noremap = true, desc = 'Local List' })
vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", { silent = true, noremap = true, desc = 'Quickfix Diagnostics' })
vim.keymap.set("n", "gR", "<cmd>TroubleToggle lsp_references<cr>", { silent = true, noremap = true, desc = 'LSP References' })
