-- ----- Filetype settings

-- Control preferences based on file type
cmd [[

  augroup _general
    autocmd FileType * setlocal formatoptions-=ro   " Prevent Neovim from auto-indenting comment on subsequent lines
    autocmd FocusLost * :wa                         " Save all buffers when Neovim loses focus
  augroup end

  " make files
  augroup _makefile
    autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
  augroup end

  " YAML files
  augroup _yaml
    autocmd BufNewFile,BufReadPost *.{yaml,yml} setfiletype=yaml foldmethod=indent
    autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab indentkeys-=<:>
  augroup end

  " Setup for mutt mail
  augroup _mutt
    autocmd FileType mail setlocal formatoptions+=aw
    autocmd FileType mail setlocal spell spelllang=en_us
    autocmd FileType mail setlocal noautoindent nolist
    autocmd FileType mail setlocal nobackup noswapfile nowritebackup
  augroup end

  " Treat RSS files as XML
  augroup _rss
    autocmd BufNewFile,BufRead *.rss,*.atom setfiletype xml
  augroup end

  " Git: spell check commit messages, start commit messages in insert mode
  augroup _git
    autocmd BufRead COMMIT_EDITMSG setlocal spell spelllang=en_us
    autocmd BufNewFile,BufRead COMMIT_EDITMSG call feedkeys('ggi', 't')
  augroup end

  " Markdown files
  augroup _markdown
    autocmd BufNewFile,BufRead *.md,*.mkd,*.markdown setfiletype markdown
    autocmd FileType markdown set spell spelllang=en_us
    autocmd FileType markdown setlocal tw=100
  augroup end

  " Ruby related files
  augroup _ruby
    autocmd BufNewFile,BufRead Gemfile,Gemfile.lock,Guardfile setfiletype ruby
    autocmd BufNewFile,BufRead Thorfile,config.ru,Vagrantfile setfiletype ruby
    autocmd BufNewFile,BufRead Berksfile,Berksfile.lock setfiletype ruby
    autocmd BufNewFile,BufRead Rakefile,*.rake setfiletype rake
    autocmd BufNewFile,BufRead Rakefile,*.rake set syntax=ruby
  augroup end

  " Python
  augroup _python
    autocmd BufNewFile,BufRead *.py set ts=2 sts=2 sw=2 expandtab
  augroup end

  " Enable syntax coloration for diffs
  augroup _diff
    autocmd FileType diff syntax enable
  augroup end

  " Add spell check to text files
  augroup _spelling
    autocmd BufNewFile,BufRead *.txt set spell spelllang=en_us
  augroup end

  " Go Language
  augroup _golang
    autocmd BufNewFile,BufRead *.go setlocal ts=4 sts=4 sw=4 noexpandtab
  augroup end

  " Help in vertical split
  augroup _vertical_help
    autocmd!
    autocmd FileType help wincmd L
  augroup end

  " Whitespace removal
  augroup _whitespace
    autocmd FileWritePre   * :call TrimWhitespace()
    autocmd FileAppendPre  * :call TrimWhitespace()
    autocmd FilterWritePre * :call TrimWhitespace()
    autocmd BufWritePre    * :call TrimWhitespace()
  augroup end

]]

  --Trailing white space removal
  -- Do not trim white space from file type 'mail' - the trailing spaces are
  -- how paragraphs are formed, along with formatoption "w"
  vim.api.nvim_exec([[
    function! TrimWhitespace()
      if &ft != 'mail'
        %s/\s\+$//e
      endif
    endfunction
  ]], false)

