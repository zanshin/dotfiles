-- ----- Filetype settings

-- Control preferences based on file type

-- Prevent Neovim from auto-indenting comment on subsequent lines
cmd [[autocmd FileType * setlocal formatoptions-=r formatoptions-=o]]

-- make files
cmd [[autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab]]

-- YAML files
cmd [[autocmd BufNewFile,BufReadPost *.{yaml,yml} setfiletype=yaml foldmethod=indent]]
cmd [[autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab indentkeys-=<:>]]

-- Setup for mutt mail
cmd [[autocmd FileType mail setlocal formatoptions+=aw]]
cmd [[autocmd FileType mail setlocal spell spelllang=en_us]]
cmd [[autocmd FileType mail setlocal noautoindent nolist]]
cmd [[autocmd FileType mail setlocal nobackup noswapfile nowritebackup]]

-- Treat RSS files as XML
cmd [[autocmd BufNewFile,BufRead *.rss,*.atom setfiletype xml]]

-- Git: spell check commit messages, start commit messages in insert mode
cmd [[autocmd BufRead COMMIT_EDITMSG setlocal spell spelllang=en_us]]
cmd [[autocmd BufNewFile,BufRead COMMIT_EDITMSG call feedkeys('ggi', 't')]]

-- Markdown files
cmd [[autocmd BufNewFile,BufRead *.md,*.mkd,*.markdown setfiletype markdown]]
cmd [[autocmd FileType markdown set spell spelllang=en_us]]
cmd [[autocmd FileType markdown setlocal tw=100]]

-- Vim-Surround for Markdown
cmd [[autocmd FileType markdown let b:surround_{char2nr('i')} = "*\r*"]]
cmd [[autocmd FileType markdown let b:surround_{char2nr('b')} = "**\r**"]]

-- Ruby related files
cmd [[autocmd BufNewFile,BufRead Gemfile,Gemfile.lock,Guardfile setfiletype ruby]]
cmd [[autocmd BufNewFile,BufRead Thorfile,config.ru,Vagrantfile setfiletype ruby]]
cmd [[autocmd BufNewFile,BufRead Berksfile,Berksfile.lock setfiletype ruby]]
cmd [[autocmd BufNewFile,BufRead Rakefile,*.rake setfiletype rake]]
cmd [[autocmd BufNewFile,BufRead Rakefile,*.rake set syntax=ruby]]

-- Python
-- let NERDTreeIgnore = ['\.pyc$', '\~$', '\.rbc$']
cmd [[autocmd BufNewFile,BufRead *.py set ts=2 sts=2 sw=2 expandtab]]

-- Enable syntax coloration for diffs
cmd [[autocmd FileType diff syntax enable]]

-- Add spell check to text files
cmd [[autocmd BufNewFile,BufRead *.txt set spell spelllang=en_us]]

-- Go Language
cmd [[autocmd BufNewFile,BufRead *.go setlocal ts=4 sts=4 sw=4 noexpandtab]]

