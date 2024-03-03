-- Mappings
-- Modes
--   normal_mode = "n"
--   insert_mode = "i"
--   visual_mode = "v"
--   visual_block_mode = "x"
--   term_mode = "t"
--   command_mode = "c"

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message.' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

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
vim.keymap.set('n', 'F', '^', { desc = 'Move to first non-blank character in the line' })
vim.keymap.set('n', 'L', 'g_', { desc = 'Move to last non-blank character in the line' })

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
vim.keymap.set('n', '<F10>', ':set relativenumber! number! number?<CR>',
  { desc = 'Toggle between number and relative number' })
vim.keymap.set('n', 'nn', ':set norelativenumber<cr>', { desc = 'Turn relative line numbering off' })
vim.keymap.set('n', 'rr', ':set relativenumber<cr>', { desc = 'Turn relative line numbering on' })

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
vim.keymap.set('n', '<leader>v', '<C-w>v<C-w>l', { desc = 'Open a [V]ertical split and move focus there' })   -- open a vertical split and switch to it
vim.keymap.set('n', '<leader>h', '<C-w>s<C-w>j', { desc = 'Open a [H]orizontal split and move focus there' }) -- open a horizontal split and switch to it

-- System clipboard
-- map('n', '<leader>y', '"+y')
-- map('n', '<leader>p', '"+p')
-- map('n', '<leader>d', '"+d')

-- Use jq to format JSON
vim.keymap.set('n', '<leader>jq', ':%!jq .<cr>', { desc = 'Format current buffer using JQ' })

-- Neovim configuration file
vim.keymap.set('n', '<leader>ev', '<cmd>e $MYVIMRC<CR>', { desc = 'Open NVIM configuration file for editing' })
vim.keymap.set('n', '<silent><leader>sv', ':source ~/.config/nvim/init.lua<CR>:filetype detect<CR>',
  { desc = 'Source NVIM configuration file' })

-- Quickfix navigation
vim.keymap.set('n', '<leader>qn', ':cnext<cr>', { desc = 'Move to the [N]ext Quickfix list item' })
vim.keymap.set('n', '<leader>qp', ':cprev<cr>', { desc = 'Move to the [P]revious Quickfix list item' })

-- -----------------------------------------------------------------------
-- Plugin mappings
-- -----------------------------------------------------------------------
-- Treesitter mappings
vim.keymap.set('n', '<leader>tsp', ':TSPlaygroundToggle<CR>', { desc = '[T]oggle [T]ree[S]itter playground' })
vim.keymap.set('n', '<leader>tsh', ':TSHighlightCapturesUnderCursor<CR>', { desc = '[T]ree[S]itter [H]ighlight' })

-- Telescope mappings
vim.keymap.set('n', '<leader>U', ':Telescope undo<cr>', { desc = '[U]ndo using Telescope' })
vim.keymap.set('n', '<leader>ff', ':Telescope find_files<CR>', { desc = 'Telescope [F]ind [F]iles' })
vim.keymap.set('n', '<leader>fh', ':Telescope help_tags<CR>', { desc = 'Telescop open help' })
vim.keymap.set('n', '<leader>fw', ':Telescope live_grep<CR>', { desc = 'Telescop live grep' })
vim.keymap.set('n', '<Leader>fb', ':Telescope buffers<CR>', { desc = 'Telescope list buffers' })
vim.keymap.set('n', '<Leader>fo', ':Telescope commands<CR>', { desc = 'Telescope list commands' })
vim.keymap.set('n', '<Leader>fgs', ':Telescope git_status<CR>', { desc = 'Telescope Git status' })
vim.keymap.set('n', '<Leader>fgf', ':Telescope git_files<CR>', { desc = 'Telescope Git files' })
vim.keymap.set('n', '<Leader>fgc', ':Telescope git_commits<CR>', { desc = 'Telescope Display Git Commit History' })
vim.keymap.set('n', '<Leader>fgb', ':Telescope git_branches<CR>', { desc = 'Telescope Display Git branches' })
-- vim.keymap.set('n', '<Leader>fgt', ':Telescope git_stash<CR>', { desc = 'Telescope Git Stash' })

-- Neo-tree
vim.keymap.set('n', '\\', ':Neotree reveal<cr>', { desc = 'Reveal Neotree window' })
vim.keymap.set('n', '<C-n>', ':Neotree toggle<cr>', { desc = 'Toggle [N]eotree window' })

-- nvim-tree
-- map('n', '<C-n>', ':NvimTreeToggle<cr>')
-- map('n', '<leader>r', ':NvimTreeRefresh')

-- DAP mappings -- moved to plugin configs
vim.keymap.set("n", "<leader>dt", ":lua require'dapui'.DapUiToggle<cr>", { desc = 'DAP [T]oggle UI' })
vim.keymap.set("n", "<leader>dc", ":lua require'dap'.continue()<cr>", { desc = 'DAP [C]ontinue' })
vim.keymap.set("n", "<leader>dsi", ":lua require'dap'.step_into()<cr>", { desc = 'DAP [S]tep [I]nto' })
vim.keymap.set("n", "<leader>dso", ":lua require'dap'.step_over()<cr>", { desc = 'DAP [S]tep [O]ver' })
vim.keymap.set("n", "<leader>dsu", ":lua require'dap'.step_out()<cr>", { desc = 'DAP [S]tep o[U]t' })
vim.keymap.set("n", "<leader>db", ":lua require'dap'.toggle_breakpoint()<cr>", { desc = 'DAP toggle [B]reakpoint' })
-- map("n", "<leader>dr", ":lua require'dap'.repl.open()<cr>")
vim.keymap.set("n", "<leader>dr", ":lua require'dapui'.open({reset = true})<cr>", { desc = 'DAP [R]eset UI' })

-- Git Blame
vim.keymap.set("n", "<leader>gb", ":GitBlameToggle<cr>", { desc = 'Toggle Git [B]lame on / off' })
