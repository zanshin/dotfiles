" Neovim Configuration
"
" author: Mark Nichols <mark@zanshin.net>
" source: https://github.com/zanshin/dotfiles/nvim/init.vim
"

" ----- Preamble {{{
if has('autocmd')
  filetype plugin indent on
endif

" }}}
" ----- Vim-Plug core {{{
" Automatically install Vim-Plug if not already present
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Enable plugin manager
call plug#begin(expand('~/.config/nvim/plugged'))

" }}}
" ----- Plugins {{{
"
" Appearance
Plug 'itchyny/landscape.vim'
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'
Plug 'ayu-theme/ayu-vim'
Plug 'hzchirs/vim-material'
Plug 'bluz71/vim-nightfly-guicolors'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'jsit/toast.vim'

" Syntax
Plug 'Yggdroot/indentline'
Plug 'stephpy/vim-yaml'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'hashivim/vim-terraform'

" Git helpers
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'Xuyuanp/nerdtree-git-plugin'

" Utilities
Plug 'sjl/gundo.vim'
Plug 'scrooloose/nerdtree', { 'om': 'NERDTreeToggle' }
Plug 'tpope/vim-surround'
Plug 'tomtom/tcomment_vim'

" Go Language
Plug 'fatih/vim-go'

" Rust Language
Plug 'cespare/vim-toml'

" Neovim stuff
Plug 'kassio/neoterm'

" Ansible
Plug 'pearofducks/ansible-vim'

" End of plugins
call plug#end()

" }}}
" ----- Color scheme {{{
" Enable true color support
if(has("termguicolors"))
  set termguicolors
endif

" Enable cursor shape change on inset mode
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

" Highlight comments in light blue color (may get overridden by colorscheme)
if has('syntax')
  if !exists('g:syntax_on')
    syntax enable
  endif
  hi Comment ctermfg=LightBlue
endif

set background=dark
" colorscheme nightfly
colorscheme toast

" silent! colorscheme landscape

" let ayucolor="light"
" let ayucolor="mirage"
" let ayucolor="dark"
" silent! colorscheme ayu

" }}}
" ----- Basic options {{{

" Change map <leader> from \ to " " (space)
:let mapleader = " "

" Map ; to : to omit needing the shift key
nnoremap ; :
nnoremap ;; ;

" Adjust mapping time out to 1 second (1000) and key codes to 1/2 second (500)
set timeout timeoutlen=1000 ttimeoutlen=500

" Encoding
set termencoding=utf-8                           " we like UTF-8
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8

set showtabline=2                                " always show tabline
set laststatus=2                                 " always show the status line
set cmdheight=2                                  " make status two-lines tall
set showcmd                                      " show the command
set noshowmode                                   " don't show the mode - lightline will do that

set autoindent                                   " yes, please
set smartindent                                  " does the right thing, usually

set linespace=3                                  " prefer a slightly higher line height
set linebreak                                    " wrap intelligently - no hard line breaks
set wrap                                         " use line wrapping ...
set textwidth=79                                 " ... at column 79

set ruler                                        " show current cursor position
set cursorline                                   " highlight line where cursor is

set nolist                                       " hide invisible characters
set listchars=tab:▸\ ,eol:¬,trail:⋅,nbsp:␣,extends:❯,precedes:❮

set showmatch                                    " show matching brackets [{()}]
set matchpairs+=<:>                              " match beyond default [ { (

if exists("&relativenumber")
  set relativenumber                             " use relative line numbers ...
endif
set number                                       " ... use absolute line number on current line

set backspace=indent,eol,start                   " make backspace behave in a sane manner

set mousehide                                    " hide the mouse when typing

set foldenable                                   " enable code folding

set history=1000

set ffs=unix,mac,dos                             " default file types, in order

if exists("&cryptmethod")
  set cryptmethod=blowfish                       " string encryption is good
endif

" Relative number / absolute number toggle
nnoremap <F10> :set relativenumber! number! number?<CR>

" Code folding settings
set foldcolumn=3                                 " room for fold markers
set foldmethod=marker                            " use standard 3 curly braces as markers

" Map Shift-Tab to za (open/close) fold
nnoremap <s-tab> za

" Change option: set $ at end of change range
" https://www.reddit.com/r/vim/comments/3b7324/insert_dollar_sign_at_end_of_change_command/
set cpoptions+=$

" Setup automatic text formatting/wrapping
set formatoptions=
set formatoptions-=t                             " don't autowrap text
set formatoptions+=c                             " do autowrap comments
" set formatoptions+=r                             " automatically continue comments
" set formatoptions+=o                             " automatically continue comments with o/O
set formatoptions+=q                             " allow formatting of comments with `gq`
set formatoptions+=n                             " recognize number lists
set formatoptions+=l                             " don't break long lines that were already there

" File focus settings
set autowrite                                    " write out old file when switching between files
set autoread                                     " reload files changed on disk
au FocusLost * :wa!                              " save file when Neovim loses focus
set hidden                                       " switch between buffers without saving

" Backups
set backup                                       " enable backups
set noswapfile                                   " it's the 21st century already

if has('persistent_undo')
  set undodir=~/.config/nvim/tmp/undo//          " undo files go here
  if !isdirectory(expand(&undodir))              " make the directory if necessary
    call mkdir(expand(&undodir), "p")
  endif
endif

set backupdir=~/.config/nvim/tmp/backup//        " backups go here
if !isdirectory(expand(&backupdir))
  call mkdir(expand(&backupdir), "p")
endif

set directory=~/.config/nvim/tmp/swap//          " swap files go here
if !isdirectory(expand(&directory))
  call mkdir(expand(&directory), "p")
endif

" Tab stops
set tabstop=2                                    " 2 spaces for tab - used when opening files
set shiftwidth=2                                 " 2 spaces for autoindenting
set softtabstop=2                                " 2 spaces inserted for <tab> / also removed by backspace
set expandtab                                    " expand tabs to spaces, filetype can overload

" Scrolling
set scrolloff=5                                  " show content above/below cursor line
set sidescrolloff=10                             " number of cols from horizontal edge to start scrolling
set sidescroll=1                                 " number of cols to scroll at a time

" Searching
set gdefault                                     " apply substitutions globally - use 'g' for old style
set incsearch                                    " use incremental search
set hlsearch                                     " highlight search results
set ignorecase                                   " ignore case when searching
set smartcase                                    " ignore if search term is all lowercase, otherwise case-sensitive

" Remove search highlighting with <leader>/
nnoremap <silent> <leader>/ :nohlsearch<CR>

" }}}
" ----- Navigation and movement {{{
" Diable arrow keys and make semi-snarky comment instead
nnoremap <Left>  :echo "Use h"<CR>
nnoremap <Right> :echo "Use l"<CR>
nnoremap <Up>    :echo "Use k"<CR>
nnoremap <Down>  :echo "Use j"<CR>

" Use Control-hjkl to swtich between splits
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Move line(s) up or down via Control-j and Control-k respectively
" Normal mode
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==

" Insert mode
nnoremap <C-j> :m <ESC>:m .+1<CR>==gi
nnoremap <C-k> :m <ESC>:m .-2<CR>==gi

" Visual mode
nnoremap <C-j> :m '>+1<CR>gv=gv
nnoremap <C-k> :m '>-2<CR>gv=gv

" Move to first non-blank or last non-blank character in current line
nnoremap H ^
nnoremap L g_

" }}}
" ----- Buffers and Tabs {{{
nnoremap <leader>be :enew<CR>                    " create a new empty buffer
nnoremap <leader>bn :bnext<CR>                   " move to the next buffer
nnoremap <leader>bp :bprevious<CR>               " move to the previous buffer
nnoremap <leader>bc :bp <BAR> bd #<CR>           " move to previous buffer and close current one

" Use TAB to move between buffers
nnoremap <TAB> :bnext<CR>                        " move to next buffer
nnoremap <S-TAB> :bprevious<CR>                  " move to previous buffer

" }}}
" ----- Help {{{
" Show help in tabs
augroup HelpInTabs
  autocmd!
  autocmd BufEnter *.txt call HelpInNewTab()
augroup END

" only apply to help files
function! HelpInNewTab()
  if &buftype == 'help'
    " convert window to tab
    execute "normal \<C-W>T"
  endif
endfunction

" }}}
" ----- Miscellaneous {{{
" Sudo to write protected file
cnoremap w!! w !sudo tee % >/dev/null

" Toggle listchars on/off
nnoremap <leader>l :set list!<CR>

" Fix regex handling to be "normal"
nnoremap / /\v
vnoremap / /\v

" Use paste mode to prevent autoindenting of pasted lines
set pastetoggle=<F2>

" Better pasting from clipboard
" http://tilvim.com/2014/03/18/a-better-paste.html
nnoremap <leader>p :set paste<CR>0<ESC>"*]p:set nopaste<CR>
set clipboard=unnamed                            " yank and paste with system clipboard

" Show cursorline only in active window
if has("autocmd")
  autocmd WinLeave * set nocursorline
  autocmd WinEnter * set cursorline
endif

" Map escape to jj -- faster to type
inoremap jj <ESC>

" Python
let g:python_host_prog = '/usr/bin/python'

" }}}
" ----- Functions {{{
" ----- Trailing white space removal {{{
" Do not trim white space from file type 'mail' - the trailing spaces are
" how paragraphs are formed, along with formatoption "w"
function! TrimWhitespace()
  if &ft != 'mail'
    %s/\s\+$//e
  endif
endfunction

nnoremap <silent> <leader>tws :call TrimWhitespace()<CR>

autocmd FileWritePre   * :call TrimWhitespace()
autocmd FileAppendPre  * :call TrimWhitespace()
autocmd FilterWritePre * :call TrimWhitespace()
autocmd BufWritePre    * :call TrimWhitespace()
" }}}
" ----- Writing mode {{{
function! WordProcessorMode()
  setlocal formatoptions=1
  setlocal noexpandtab
  map j gj
  map k gk
  setlocal spell spelllang=en_us
"  set thesaurus+=/Users/me/.vim/thesaurus/mytheasur.txt
  set complete+=s
  set formatprg=par
  setlocal wrap
  setlocal linebreak
endfunction

com! WP call WordProcessorMode()
" }}}
" ----- Vimscript {{{
" syntax toggle
function! ToggleSyntax()
  if exists("g:syntax_on")
    syntax off
  else
    syntax enable
  endif
endfunction

nnoremap <silent> <leader>s :call ToggleSyntax()<CR>
" }}}

" }}}
" ----- Mappings {{{
" Splits
nnoremap <leader>v <C-w>w<C-w>l                  " open a vertical split and switch to it
nnoremap <leader>h <C-w>s<C-w>j                  " open a horizontal split and swtich to it

" Open (Neo)vim configuration tile in new tab for editing
nnoremap <leader>ev :e $MYVIMRC<CR>

" Reload (Neo)vim configuration
nnoremap <silent> <leader>sv :source ~/.config/nvim/init.vim<CR>:filetype detect<CR>:exe ":echo 'init.vim reloaded'"<CR>

" System clipboard
nnoremap <leader>y "+y"

" }}}
" ----- Command line completion {{{
" Search down into subfolders
" Provides tab-completion for all filer-related tasks
set path+=**

set wildmenu                                     " navigate <left> and <right> through completion list
set wildignore+=.git                             " ignore Git repository
set wildignore+=*.jpg,*.png,*.gif,*,jpeg,*.bmp   " ignore image files
set wildignore+=*.sw?                            " ignore swap files
set wildignore+=*.DS_Store                       " ignore macOS clutter

" }}}
" ----- Filetype settings {{{
" Control preferences based on file type
if has("autocmd")
  " Enable filetype detection
  filetype on

  " Prevent Neovim from auto-indenting comment on subsequent lines
  autocmd FileType * setlocal formatoptions-=r formatoptions-=o

  " make files
  autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab

  " YAML files
  autocmd BufNewFile,BufReadPost *.{yaml,yml} setfiletype=yaml foldmethod=indent
  autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab indentkeys-=<:>

  " Setup for mutt mail
  autocmd FileType mail setlocal formatoptions+=aw
  autocmd FileType mail setlocal spell spelllang=en_us
  autocmd FileType mail setlocal noautoindent nolist
  autocmd FileType mail setlocal nobackup noswapfile nowritebackup

  " Treat RSS files as XML
  autocmd BufNewFile,BufRead *.rss,*.atom setfiletype xml

  " Git: spell check commit messages, start commit messages in insert mode
  autocmd BufRead COMMIT_EDITMSG setlocal spell spelllang=en_us
  autocmd BufNewFile,BufRead COMMIT_EDITMSG call feedkeys('ggi', 't')

  " Markdown files
  autocmd BufNewFile,BufRead *.md,*.mkd,*.markdown setfiletype markdown
  autocmd FileType markdown set spell spelllang=en_us
  autocmd FileType markdown setlocal tw=100

  " Vim-Surround for Markdown
  autocmd FileType markdown let b:surround_{char2nr('i')} = "*\r*"
  autocmd FileType markdown let b:surround_{char2nr('b')} = "**\r**"

  " Ruby related files
  autocmd BufNewFile,BufRead Gemfile,Gemfile.lock,Guardfile setfiletype ruby
  autocmd BufNewFile,BufRead Thorfile,config.ru,Vagrantfile setfiletype ruby
  autocmd BufNewFile,BufRead Berksfile,Berksfile.lock setfiletype ruby
  autocmd BufNewFile,BufRead Rakefile,*.rake setfiletype rake
  autocmd BufNewFile,BufRead Rakefile,*.rake set syntax=ruby

  " Python
  let NERDTreeIgnore = ['\.pyc$', '\~$', '\.rbc$']
  autocmd BufNewFile,BufRead *.py set ts=2 sts=2 sw=2 expandtab

  " Enable syntax coloration for diffs
  autocmd FileType diff syntax enable

  " Add spell check to text files
  autocmd BufNewFile,BufRead *.txt set spell spelllang=en_us

  " Go Language
  autocmd BufNewFile,BufRead *.go setlocal ts=4 sts=4 sw=4 noexpandtab

endif

" }}}
" ----- NetRW {{{
let g:netrw_liststyle=3                " tree view style
let g:netrw_banner=0                   " disable annoying banner
let g:netrw_browse_split=4
let g:netrw_altv=1
let g:metrw_winsize=25

" }}}
" ----- Plugin Settings {{{

" ----- Lightline {{{
let g:lightline = {
  \ 'colorscheme': 'material',
  \ 'active': {
  \    'left': [ [ 'mode', 'paste'],
  \              [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
  \  },
  \ 'component_function': {
  \    'gitbranch': 'FugitiveHead'
  \  }
  \ }

let g:lightline#bufferline#show_number       = 0
let g:lightline#bufferline#shorten_path      = 0
let g:lightline#bufferline#unnamed           = '[No Name]'
let g:lightline#bufferline#filename_modifier = ':t'

let g:lightline.tabline          = {'left': [['buffers']], 'right': [['close']]}
let g:lightline.component_expand = {'buffers': 'lightline#bufferline#buffers'}
let g:lightline.component_type   = {'buffers': 'tabsel'}

" Mappings to use <leader>+# to move to buffer
" nmap <Leader>1 <Plug>lightline#bufferline#go(1)
" nmap <Leader>2 <Plug>lightline#bufferline#go(2)
" nmap <Leader>3 <Plug>lightline#bufferline#go(3)
" nmap <Leader>4 <Plug>lightline#bufferline#go(4)
" nmap <Leader>5 <Plug>lightline#bufferline#go(5)
" nmap <Leader>6 <Plug>lightline#bufferline#go(6)
" nmap <Leader>7 <Plug>lightline#bufferline#go(7)
" nmap <Leader>8 <Plug>lightline#bufferline#go(8)
" nmap <Leader>9 <Plug>lightline#bufferline#go(9)
" nmap <Leader>0 <Plug>lightline#bufferline#go(10)

" }}}
" ----- Airline {{{
" let g:airline_theme                                     = 'landscape'
" let g:airline_left_sep                                  = ''
" let g:airline_right_sep                                 = ''
" let g:airline#extensions#whitespace#trailing_format     = 'trailing[%s]'
" let g:airline#extensions#whitespace#mixed_indent_format = 'mixed-indent[%s]'
" let g:airline#extensions#branch#enabled                 = 1
" let g:airline#extensions#branch#empty_message           = ''

" Enable the list of buffers
" let g:airline#extensions#tabline#enabled = 1

" Hide function display (don't use it)
" let g:airline#extensions#tagbar#enabled = 0

" Show just the file name
" let g:airline#extensions#tabline#fnamemod = ':t'

" let g:airline_theme='dark'

" }}}
" ----- Vim-fugitive {{{
" need some settings here

" }}}
" ----- Markdown {{{
" Highlight YAML front matter as usd by Jekyll
" let g:bim_markdown_frontmatter = 1

" }}}
" ----- Git Gutter {{{
" hi clear SignColumn                            " required after changing
" colorscheme
" In Airline, only display "hunks" if the diff is non-zero
" let g:airline#extensions#hunks#non_zero_only = 1

" }}}
" ----- Gundo {{{
nnoremap <leader>U :GundoToggle<CR>

" }}}
" ----- NERDTree {{{
nnoremap <c-n> :NERDTreeToggle<CR>

" Some custom indicators for file state
" let g:NERDTreeIndicatorMapCustom = {
let g:NERDTreeGitStatusIndicatorMapCustom = {
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
" ----- Indentline {{{
let g:indentLine_color_term = 239
let g:indentLine_char       = "|"
nnoremap <leader>i :IndentLinesToggle<CR>

" Improve Indentline performance
let g:indentLine_faster     = 1
let g:indentLine_setConceal = 0

" }}}
" ----- Vim-surround {{{
" The automd FileType statements taht define 'i' and 'b' are in the FileType
" section.
" Mapping to put Markdown italics (*) characters around current word
nnoremap <leader>mi :execute "normal \<Plug>Ysurroundiwi"<CR>

" Mapping to put Markdown bold (**) characters around current work
nnoremap <leader>mb :execute "normal \<Plug>Ysurroundiwb"<CR>

" }}}
" ----- Neoterm {{{
" Always scroll to latest output
let g:neoterm_autoscroll = '1'

" Manage the size of the neoterm buffer
let g:neoterm_size = 16

" Open new terminal if none is open, or existing one
command! -nargs=+ TT Topen | T
nnoremap \ :TT

" Interact with the REPL
vnoremap <leader>2 :TREPLSendSelection
nnoremap <leader>2 :TREPLSendLine
nnoremap <leader>3 :Tmap
nnoremap <leader>0 :Ttoggle
let g:neoterm_automap_keys = '<F5>'

" }}}
" ----- Vim-GO {{{
let g:go_fmt_fail_silently           = 0
let g:go_fmt_command                 = "goimports"
let g:go_autodetect_gopath           = 1
let g:go_term_enabled                = 1
" let g:go_snippet_engine             = "neosnippet"
let g:go_highlight_build_constraints = 0
let g:go_highlight_extra_types       = 0
let g:go_highlight_fields            = 0
let g:go_highlight_functions         = 0
let g:go_highlight_methods           = 0
let g:go_highlight_operators         = 0
let g:go_highlight_structs           = 0
let g:go_highlight_types             = 0
let g:go_highlight_space_tab_error   = 0
let g:go_highlight_array_whitespace_error = 0
let g:go_highlight_trailing_whitespace_error = 0

let g:go_auto_sameids = 1

au Filetype go nmap <leader>s <Plug>(go-def-split)
au Filetype go nmap <leader>v <Plug>(go-def-vertical)
au Filetype go nmap <leader>i <Plug>(go-info)
au Filetype go nmap <leader>l <Plug>(go-metalinter)

au Filetype go nmap <leader>r <Plug>(go-run)

au Filetype go nmap <leader>b <Plug>(go-build)
au Filetype go nmap <leader>t <Plug>(go-test)
au Filetype go nmap <leader>dt <Plug>(go-test-compile)
au Filetype go nmap <leader>d <Plug>(go-doc)

au Filetype go nmap <leader>e <Plug>(go-rename)

" neovim specific
if has('nvim')
  au FileType go nmap <leader>rt <Plug>(go-run-tab)
  au FileType go nmap <leader>rs <Plug>(go-run-split)
  au FileType go nmap <leader>rv <Plug>(go-run-vertical)
endif

" Alternates
augroup go
  autocmd!
  autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
  autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
  autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
augroup END

" }}}

" vim: foldmethod=marker foldlevel=0 tabstop=4 softtabstop=4 expandtab
