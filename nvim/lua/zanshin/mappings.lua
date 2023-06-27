-- Mappings
--
-- Modes
--   normal_mode = "n"
--   insert_mode = "i"
--   visual_mode = "v"
--   visual_block_mode = "x"
--   term_mode = "t"
--   command_mode = "c"

map("", "<Space>", "<Nop>") -- map Space to a no-op
g.mapleader = ' '           -- space for leader
g.maplocalleader = ' '      -- space for local leader too
map('n', ';', ':')          -- use ; for : in normal mode
map('n', ';;', ';')         -- use ;; for ; in normal mode

-- Disable arrow keys and make semi-snarky comment instead
map('n', '<Left>', ':echo "Use h"<CR>')
map('n', '<Right>', ':echo "Use l"<CR>')
map('n', '<Up>', ':echo "Use k"<CR>')
map('n', '<Down>', ':echo "Use j"<CR>')

-- Use Control-hjkl to switch between splits
map('n', '<C-h>', '<C-w>h')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-l>', '<C-w>l')

-- Move to first non-blank or last non-blank character in current line
map('n', 'H', '^')
map('n', 'L', 'g_')

-- Fix regex handling to be "normal"
-- map('n', '/', '/\v')
-- map('v', '/', '/\v')

-- Map escape to jj -- faster to type
--Also, jk and kj. The more the merrier
map('i', 'jj', '<ESC>')
map('i', 'jk', '<ESC>')
map('i', 'kj', '<ESC>')

-- Remove search highlighting with <leader>/
map('n', '<leader>/', ':nohlsearch<CR>')
-- nnoremap <silent> <leader>/ :nohlsearch<CR>
--
-- -- Relative number / absolue numbr toggle
map('n', '<F10>', ':set relativenumber! number! number?<CR>')
map('n', 'nn', ':set norelativenumber<cr>')
map('n', 'rr', ':set relativenumber<cr>')

-- Move line(s) up or down via J and K respectively
map('v', 'J', ":m '>+1<CR>gv=gv")
map('v', 'K', ":m '<-2<CR>gv=gv")

-- Scroll 1/2 a page and center
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- Override n/N to show next/previous search result, but centered
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Buffers and tabs
map('n', '<leader>be', ':enew<CR>')          -- create new empty buffer
map('n', '<leader>bn', ':bnext<CR>')         -- move to next buffer
map('n', '<leader>bp', ':bprevious<CR>')     -- move to previous buffer
map('n', '<leader>bc', ':bp <BAR> bd $<CR>') -- move to previous buffer, and close current

map('n', '<S-n>', ':bnext<CR>')              -- move to next buffer
map('n', '<S-p>', ':bprevious<CR>')          -- move to previous buffer

-- Neovim configuration file
map('n', '<leader>ev', '<cmd>e $MYVIMRC<CR>') -- open configuration file for editing
-- map('n', '<leader>sv', ':luafile %<CR>')      -- source nvim configuration
map('n', '<silent><leader>sv', ':source ~/.config/nvim/init.lua<CR>:filetype detect<CR>')

-- Treesitter mappings
map('n', '<leader>tsp', ':TSPlaygroundToggle<CR>')
map('n', '<leader>tsh', ':TSHighlightCapturesUnderCursor<CR>')

-- Telescope mappings
-- map('n', '<leader>ff', ':Telescope find_files<CR>')
-- map('n', '<leader>fgg', ':Telescope live_grep<CR>')
-- map('n', '<Leader>fb', ':Telescope buffers<CR>')
-- map('n', '<Leader>fo', ':Telescope commands<CR>')
-- map('n', '<Leader>fgs', ':Telescope git_status<CR>')
-- map('n', '<Leader>fgf', ':Telescope git_files<CR>')
-- map('n', '<Leader>fgc', ':Telescope git_commits<CR>')
-- map('n', '<Leader>fgb', ':Telescope git_branches<CR>')
-- map('n', '<Leader>fgt', ':Telescope git_stash<CR>')

-- From kickstart.nvim
-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>+', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[+] Fuzzily search in current buffer]' })

vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })

vim.keymap.set('n', '<leader>sgs', require('telescope.builtin').git_status, { desc = '[S]earch [G]it [S]tatus' })
vim.keymap.set('n', '<leader>sgf', require('telescope.builtin').git_files, { desc = '[S]earch [G]it [F]iles' })
vim.keymap.set('n', '<leader>sgc', require('telescope.builtin').git_commits, { desc = '[S]earch [G]it [C]ommits' })
vim.keymap.set('n', '<leader>sgb', require('telescope.builtin').git_branches, { desc = '[S]earch [G]it [B]ranches' })
vim.keymap.set('n', '<leader>sgt', require('telescope.builtin').git_stash, { desc = '[S]earch [G]it s[T]ash' })

vim.keymap.set('n', '<leader>so', require('telescope.builtin').commands, { desc = '[S]earch c[O]mmands' })
-- map('n', '<Leader>s', 'require("telescope.builtin").spell_suggest(require("telescope.themes").get_cursor({}))')


-- Sudo to write protected file
map('c', 'w!!', '!sudo tee % >/dev/null')

-- Toggle listchars on / off
map('n', '<leader>l', ':set list!<cr>')

-- Splits
map('n', '<leader>v', '<C-w>v<C-w>l') -- open a vertical split and switch to it
map('n', '<leader>h', '<C-w>s<C-w>j') -- open a horizontal split and switch to it

-- System clipboard
map('n', '<leader>y', '"+y')
map('n', '<leader>p', '"+p')
map('n', '<leader>d', '"+d')

-- Use jq to format JSON
map('n', 'jq', ':%!jq .<cr>')

-- File System access
-- nvim-tree
-- map('n', '<C-n>', ':NvimTreeToggle<cr>')
-- map('n', '<C-n>', ':NvimTreeFindFileToggle<cr>')
-- map('n', '<leader>r', ':NvimTreeRefresh')

-- neo-tree
-- map('n', '\\', ':Neotree reveal<cr>')
map('n', '<C-n>', ':Neotree toggle<cr>')

-- DAP mappings -- moved to plugin configs
-- map("n", "<leader>dt", ":lua require'dapui'.DapUiToggle<cr>")
-- map("n", "<leader>dc", ":lua require'dap'.continue()<cr>")
-- map("n", "<leader>dsi", ":lua require'dap'.step_into()<cr>")
-- map("n", "<leader>dso", ":lua require'dap'.step_over()<cr>")
-- map("n", "<leader>dsu", ":lua require'dap'.step_out()<cr>")
-- map("n", "<leader>db", ":lua require'dap'.toggle_breakpoint()<cr>")
-- -- map("n", "<leader>dr", ":lua require'dap'.repl.open()<cr>")
-- map("n", "<leader>dr", ":lua require'dapui'.open({reset = true})<cr>")

-- Floating Terminal
map('n', "<leader>ft", ":FloatermNew --name=myfloat --height=0.8 --width=0.7 --autoclose=2 bash <CR> ")
map('n', "t", ":FloatermToggle myfloat<CR>")
-- map('t', "<Esc>", "<C-\\><C-n>:q<CR>")
map('t', "<Esc>", "exit<CR><C-c>")
