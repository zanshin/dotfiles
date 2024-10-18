-- Markdown specific settings
vim.opt.spell = true
vim.opt.spelllang = "en_us"

vim.opt.wrap = true        -- wrap text
vim.opt.breakindent = true -- match indent on line break
vim.opt.linebreak = true   -- line break on while words

-- Allow j/k when navigating wrapped lines
vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')

-- Obsidian requires this
-- 0 - default, 1 or 2 are optional values see help
vim.opt.conceallevel = 1
