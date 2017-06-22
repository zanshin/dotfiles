" neovim configuration
"
" author: Mark Nichols <mark@zanshin.net>
" source: http://github.com/zanshin/dotfiles/nvim/init.vim
"
" Vim-Plug core {{{
if has('vim_starting')
    set nocompatible
endif

" Required
call plug#begin(expand('~/.config/nvim/plugged'))

" }}}
" Plug install packages {{{

" ----- Make Neovim look good
Plug 'itchyny/landscape.vim'
" Plug 'itchyny/lightline.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'trevordmiller/nova-vim'

" ----- Syntax & Highlighting
Plug 'Yggdroot/indentline'

" ----- Git helpers
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'Xuyuanp/nerdtree-git-plugin'

" ----- Undo
Plug 'sjl/gundo.vim'

" ----- Utilities
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'tpope/vim-surround'
Plug 'tomtom/tcomment_vim'

call plug#end()

" turn things on
if has('autocmd')
    filetype plugin indent on
endif

if has('syntax') && !exists('g:syntx_on')
    syntax on
    " Unfortunately this gets over laid by the colorscheme. Shrug
    hi Comment ctermfg=LightBlue

endif

" }}}
" Neovim Settings {{{
" Enable True Color support
if (has("termguicolors"))
 set termguicolors
endif

" Enable shape cursor on insert mode
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

" }}}
" Basic options {{{

" change map <leader> from \ to " " (space)
:let mapleader = " "

" Map ; to : to save needing the shift key
nnoremap ; :
nnoremap ;; ;

" time out mappings after 1 second (1000) and key codes after 1/2 second (500)
set timeout timeoutlen=1000 ttimeoutlen=500

" Encoding
set termencoding=utf-8                 " we like UTF-8
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8

set laststatus=2                       " always show the status line
set cmdheight=2                        " two-line tall status line
set showcmd                            " show the command
set noshowmode                         " don't show the mode, vim-airline will do that
set autoindent                         " turn it on
set smartindent                        " does the right thing, usually
set linespace=3                        " prefer a slightly higher line height
set linebreak                          " wrap intelligently, won't insert hard line breaks
set wrap                               " use line wrapping ...
set textwidth=79                       " ... at column 79
set ruler                              " display current curson position
set list                               " show invisible characters
set listchars=tab:▸\ ,eol:¬,trail:⋅,nbsp:␣,extends:❯,precedes:❮
set showmatch                          " show matching brackets [{()}]
if exists("&relativenumber")
    set relativenumber                 " use relative line numbers ...
endif
set number                             " ... except for the current line - absolute number there
set backspace=indent,eol,start         " make backspace behave in a sane manner
set mousehide                          " hide the mouse when typing
set foldenable                         " enable code folding
set history=1000
set ffs=unix,mac,dos                   " default filetypes
if exists("&cryptmethod")
    set cryptmethod=blowfish           " strong encryption is good
endif
set cursorline                         " highlight the line where the cursor is

" Relative number / number toggle
nnoremap <F10> :set relativenumber! number! number?<CR>

" Folding settings
set foldcolumn=3                       " room for fold markers
set foldmethod=marker                  " use standard 3 curly braces as markers

" Change options: set $ at end of change range
" https://www.reddit.com/r/vim/comments/3b7324/insert_dollar_sign_at_end_of_change_command/
set cpoptions+=$

" Setup automatic text formatting/wrapping
set formatoptions=
set formatoptions-=t                   " don't autowrap text
set formatoptions+=c                   " do autowrap comments
" set formatoptions+=r                   " automatically continue comments
" set formatoptions+=o                   " automatically continue comments when hitting 'o' or 'O'
set formatoptions+=q                   " allow formatting of comments with 'gq'
set formatoptions+=n                   " recognize number lists
set formatoptions+=l                   " don't break long lines that were already there

" Set match pairs beyond default [...], {...}, and (...)
set matchpairs+=<:>

" }}}
" Navigation and Movement {{{

" Disable arrow keys and make semi-snarky comment instead
nnoremap <Left> :echo "Use h"<CR>
nnoremap <Right> :echo "Use l"<CR>
nnoremap <Up> :echo "Use k"<CR>
nnoremap <Down> :echo "Use j"<CR>

" Use <C>HJKL to switch between splits
nnoremap <C-H> <C-w>h
nnoremap <C-J> <C-w>j
nnoremap <C-K> <C-w>k
nnoremap <C-L> <C-w>l

" Move line(s) up or down via C-j and C-k respectively
" Normal mode
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==

" Insert mode
inoremap <C-j> :m <ESC>:m .+1<CR>==gi
inoremap <C-k> :m <ESC>:m .-2<CR>==gi

" Visual mode
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '>-2<CR>gv=gv

" Move to first non-blank or last non-blank character in current line
nnoremap H ^
nnoremap L g_

" }}}
" Buffers and Tabs {{{
nnoremap <leader>be :enew<CR>          " create new empty buffer
nnoremap <leader>bn :bnext<CR>         " move to next buffer
nnoremap <leader>bp :bprevious<CR>     " move to previous buffer
nnoremap <leader>bq :bp <BAR> bd #<CR> " move to previous buffer and close buffer

" }}}
" File focus {{{

" What to do with files and focus
set autowrite                          " write out old file when switching between files
set autoread                           " reload files changed on disk, i.e., via 'git checkout'
au FocusLost * :wa                     " save file when Neovim loses focus
set hidden                             " switch bwteen buffers without saving

" }}}
" Backups {{{
set backup                             " enable backups
set noswapfile                         " It's the 21st century already

if has('persistent_undo')
    set undodir=~/.config/nvim/tmp/undo//   " undo files go here
    if !isdirectory(expand(&undodir))
        call mkdir(expand(&undodir), "p")
    endif
endif

set backupdir=~/.config/nvim/tmp/backup//   " backups go here
if !isdirectory(expand(&backupdir))
    call mkdir(expand(&backupdir), "p")
endif

set directory=~/.config/nvim/tmp/swap//     "" swap files
if !isdirectory(expand(&directory))
    call mkdir(expand(&directory), "p")
endif

" }}}
" Tabstops {{{
set tabstop=2                          " 2 spaces for tab - used when opening a file having <tab>s in it
set shiftwidth=2                       " 2 spaces for autoindenting
set softtabstop=2                      " 2 spaces inserted for <tab> / also # removed by backspace
set expandtab                          " expand tabs to spaces (overloadable by file type)

" }}}
" Scrolling {{{
set scrolloff=5                        " show context above/below cursor line
set sidescrolloff=10                   " number of cols from horizontal edge to start scrolling
set sidescroll=1                       " number of cols to scroll at a time

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
cnoremap w!! w !sudo tee % >/dev/null

" Toggle listchars on or off
nnoremap <leader>l :set list!<CR>

" Fix regex handling
nnoremap / /\v
vnoremap / /\v

" Paste mode to prevent autoindentation of pasted lines
set pastetoggle=<F2>

" Better pasting from clipboard
" http://tilvim.com/2014/03/18/a-better-paste.html
noremap <leader>p :set paste<CR>0<ESC>"*]p:set nopaste<CR>

set clipboard=unnamed                  " yank and paste with the system clipboard

" Show cursorline only in active window
if has("autocmd")
    autocmd WinLeave * set nocursorline
    autocmd WinEnter * set cursorline
endif

" Map escape to jj -- faster to reach and type
inoremap jj <ESC>

" }}}
" Serching {{{
set gdefault                           " apply substitutions globally by default. add 'g' for old style
set incsearch                          " use incremental search
set hlsearch                           " highlight search results
set ignorecase                         " ignore case when searching
set smartcase                          " ignore case if search string is all lower case, case-sensitive otherwise

" Remove highlighting with <F3>
nnoremap <silent> <leader>/ :nohlsearch<CR>

" }}}
" Trailing whitespace {{{
" www.bestofwim.com/tip/trailing-whitespace/
function! TrimWhitespace()
    %s/\s\+$//e
endfunction

nnoremap <silent> <leader>tws :call TrimWhitespace()<CR>

autocmd FileWritePre   * :call TrimWhitespace()
autocmd FileAppendPre  * :call TrimWhitespace()
autocmd FilterWritePre * :call TrimWhitespace()
autocmd BufWritePre    * :call TrimWhitespace()

" }}}
" Splits {{{
nnoremap <leader>v <C-w>w<C-w>l        " open a vertical split and switch to it
nnoremap <leader>h <C-w>s<C-w>j        " open a horizontal split and switch to it

" }}}
" Configuration file shortcuts {{{

" Open init.vim in new tab for editing
nnoremap <leader>ev :e $MYVIMRC<CR>

" Automatically source init.vim when it is saved (from vimcasts.org #24)
" if has("autocmd")
"     autocmd! bufwritepost init.vim source $MYVIMRC<CR>:filetype detect<CR>:exe ":echo 'init.vim reloaded'"<CR>
" endif

" Reload init.vim
noremap <silent> <leader>sv :source ~/.config/nvim/init.vim<CR>:filetype detect<CR>:exe ":echo 'init.vim reloaded'"<CR>

" }}}
" Command line completion {{{

" Search down into subfolders
" provides tab-completion for all file-related tasks
set path+=**

set wildmenu                           " navigate <left> & <right> through completion lists
set wildignore+=.git                   " ignore Git repository
set wildignore+=*.jpg.*.png,*.gif,*.jpeg,*.bmp   " ignore image files
set wildignore+=*.sw?                  " ignore swap files
set wildignore+=*.DS_Store             " ignore masOS clutter

" }}}
" Filetype settings {{{

" Control whitespace preferences based on filetype
if has("autocmd")
    " enable file type detection
    filetype on

    " prevent Neovim from auto-indenting comment on subsequent lines
    autocmd FileType * setlocal formatoptions-=r formatoptions-=o

    " syntax of these languages is fussy over tabs Vs spaces
    autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
    autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

    " setup for mail
    autocmd FileType mail setlocal formatoptions+=aw
    autocmd FileType mail setlocal spell spelllang=en_us

    " treat .rss files as XML
    autocmd BufNewFile,BufRead *.rss,*.atom setfiletype xml

    " spell check Git commit messages
    autocmd BufRead COMMIT_EDITMSG setlocal spell spelllang=en_us

    " start commit messages in insert mode
    autocmd BufNewFile,BufRead COMMIT_EDITMSG call feedkeys('ggi', 't')

    " markdown files
    autocmd BufNewFile,BufRead *.md,*.mkd,*.markdown setfiletype markdown
    autocmd BufNewFile,BufRead *.md,*.mkd,*.markdown set spell spelllang=en_us
    autocmd FileType markdown setlocal tw=100

    " non Ruby files related to Ruby
    autocmd BufNewFile,BufRead Gemfile,Gemfile.lock,Guardfile setfiletype ruby
    autocmd BufNewFile,BufRead Thorfile,config.ru,Vagrantfile setfiletype ruby
    autocmd BufNewFile,BufRead Berksfile,Berksfile.lock setfiletype ruby
    autocmd BufNewFile,BufRead Rakefile setfiletype rake
    autocmd BufNewFile,BufRead Rakefile set syntax=ruby
    autocmd BufNewFile,BufRead *.rake setfiletype rake
    autocmd BufNewFile,BufRead *.rake set syntax=ruby

    " Chef uses Ruby, and this enabled Chef snippets
    " autocmd FileType ruby,eruby set filetype ruby.eruby.chef
    "
    " Python file
    let NERDTreeIgnore = ['\.pyc$', '\~$', '\.rbc$']
    autocmd BufNewFile,BufRead *.py set ts=2 sts=2 sw=2 expandtab

    " enable syntax highlighting for diffs
    autocmd FileType diff syntax enable

endif

" }}}
" Writing {{{
func! WordProcessorMode()
  setlocal formatoptions=1
  setlocal noexpandtab
  map j gj
  map k gk
  setlocal spell spelllang=en_us
  set thesaurus+=/Users/sbrown/.vim/thesaurus/mthesaur.txt
  set complete+=s
  set formatprg=par
  setlocal wrap
  setlocal linebreak
endfu
com! WP call WordProcessorMode()

" }}}
" NetRW {{{
let g:netrw_liststyle=3                " tree view style
let g:netrw_banner=0                   " disable annoying banner
let g:netrw_browse_split=4
let g:netrw_altv=1
let g:metrw_winsize=25

" }}}
" Vimscript {{{
" syntax toggle
function! ToggleSyntax()
    if exists("g:syntax_on")
        syntax off
    else
        syntax enable
    endif
endfunction

noremap <silent> <leader>s :call ToggleSyntax()<CR>

" }}}
" Color scheme {{{
set background=dark
silent! colorscheme landscape
" silent! colorscheme nova

" }}}
" Python {{{
let g:python_host_prog = '/usr/bin/python'

" }}}
" Lightline {{{
" let g:lightline = {
"       \ 'colorscheme': 'landscape',
"       \ 'active': {
"       \   'left': [ [ 'mode', 'paste' ],
"       \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
"       \ },
"       \ 'component_function': {
"       \   'gitbranch': 'fugitive#statusline'
"       \ },
"       \ }

" }}}
" Airline {{{
" let g:airline_theme='landscape'
" let g:airline_left_sep=''
" let g:airline_right_sep=''
" let g:airline#extensions#whitespace#trailing_format = 'trailing[%s]'
" let g:airline#extensions#whitespace#mixed_indent_format = 'mixed-indent[%s]'
" let g:airline#extensions#branch#enabled = 1
" let g:airline#extensions#branch#empty_message = ''

" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1

" Hide function display (don't use it)
let g:airline#extensions#tagbar#enabled = 0

" Show just the file name
let g:airline#extensions#tabline#fnamemod = ':t'

" let g:airline_theme='dark'

" }}}
" Vim-fugitive {{{
" need some settings here
" }}}
" Git gutter {{{
" hi clear SignColumn                  " required after changing colorscheme
" In Vim-airline, only display "hunks" if the diff is non-zero
" let g:airline#extensions#hunks#non_zero_only = 1

" }}}
" Markdown {{{
" HIghlight YAML front matter as used by Jekyll
" let g:vim_markdown_frontmatter=1

" }}}
" Gundo {{{
nnoremap <leader>U :GundoToggle<CR>

" }}}
" NERDTree {{{
noremap <C-n> :NERDTreeToggle<CR>

" Show hidden files
let NERDTreeShowHidden=1

" Some custom indicators for file state
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ "Unknown"   : "?"
    \ }

" Close nerdtree and vim on close file
" from https://github.com/jessfraz/.vim/blob/master/vimrc#L491
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" }}}
" Indentline {{{
let g:indentLine_color_term = 239
let g:indentLine_char = "|"
nnoremap <leader>i :IndentLinesToggle<CR>

" Improve indentLine performance
let g:indentLine_faster = 1
let g:indentLine_setConceal = 0

" }}}
" finis {{{

" }}}
"
" vim: foldmethod=marker foldlevel=0 tabstop=4 softtabstop=4 expandtab
