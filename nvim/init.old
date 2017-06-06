" neovim configuration
"
" author: Mark Nichols <mark@zanshin.net>
" source: http://github.com/zanshin/dotfiles/nvim/init.vim
"
" Vim-Plug core {{{
if has('vim_starting')
    set nocompatible
endif

" Required:
call plug#begin(expand('~/.config/nvim/plugged'))

" }}}
" Plug install packages {{{

" ----- Make Neovim look good
Plug 'itchyny/landscape.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" ----- Syntax & Highlighting
Plug 'Yggdroot/indentline'

" ----- Git helpers
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'Xuyuanp/nerdtree-git-plugin'

" ----- Undo
Plug 'sjl/gundo.vim'

" ----- Utilities
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-surround'
Plug 'tomtom/tcomment_vim'

call plug#end()

" turn things on
if has('autocmd')
    filetype plugin indent on
endif

if has('syntax') && !exists('g:syntx_on')
    syntax on
endif

" }}}
" Help {{{
" Show help in tabs
augroup HelpInTabs
    autocmd!
    autocmd BufEnter *.txt call HelpInNewTab()
augroup END

" only apply to help file ...
function! HelpInNewTab()
    if &buftype == 'help'
        " convert help window to tab
        execute "normal \<C-W>T"
    endif
endfunction

" }}}
" Miscellaneous {{{

" Sudo to write 
" cnoremap w!! w !sudo tee % >/dev/null

" Toggle listchars on or off
" nnoremap <leader>l :set list!<CR>

" Fix regex handling
" nnoremap / /\v
" vnoremap / /\v

" Paste mode to prevent autoindentation of pasted lines
" set pastetoggle=<F2>

" Better pasting from clipboard
" http://tilvim.com/2014/03/18/a-better-paste.html
" noremap <leader>p :set paste<CR>0<ESC>"*]p:set nopaste<CR>

" set clipboard=unnamed                  " yank and paste with the system clipboard

" Show cursorline only in active window
if has("autocmd")
    autocmd WinLeave * set nocursorline
    autocmd WinEnter * set cursorline
endif

" Map escape to jj -- faster to reach and type
" inoremap jj <ESC>

" }}}
" Configuration file shortcuts {{{

" Open init.vim in new tab for editing
" nnoremap <leader>ev :tabedit $MYVIMRC<CR>

" Automatically source init.vim when it is saved (from vimcasts.org #24)
if has("autocmd")
    autocmd! bufwritepost init.vim source $MYVIMRC
endif

" Reload init.vim
" noremap <silent> <leader>V :source ~/.config/nvim/init.vim<CR>:filetype detect<CR>:exe ":echo 'init.vim reloaded'"<CR>

" }}}
"
" vim: foldmethod=marker foldlevel=0 tabstop=4 softtabstop=4 expandtab
