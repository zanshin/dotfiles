" .vimrc
" Author: Mark Nichols
" largely copied from Steve Losh (stevelosh.com)
" addition bits borrowed from https://github.com/nvie/vimrc/blob/master/vimrc
" further bits from http://vimcasts.org
" also, https://github.com/lukaszkorecki/DOtFiles 
"
" ---------------------------------------------------------------------------------
" use Vim settings rather than vi settings (must be first) 
" ---------------------------------------------------------------------------------
set nocompatible

" ---------------------------------------------------------------------------------
" setup Pathogen to manage plugins
" ---------------------------------------------------------------------------------
filetype off                  " force reloading after pathogen loaded
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()
filetype plugin indent on     " enable plugins, detection and indenting in one step

" ---------------------------------------------------------------------------------
" change mapleader from \ to , 
" ---------------------------------------------------------------------------------
let mapleader=','

" ---------------------------------------------------------------------------------
" basic options
" ---------------------------------------------------------------------------------
set encoding=utf-8
set modelines=0
set tabstop=4                   " a tab stop is 4 spaces
set shiftwidth=4                " number of spaces to use for autoindenting
set softtabstop=4               " when <BS>, pretend a tab is removed, even if spaces
set expandtab                   " expand tabs to spaces (overloadable by file type later)
set scrolloff=3                 " keep 3 lines off the edges of the screen when scrolling
set autoindent                  " always set autoindenting on
set showmode                    " always show what mode we're in
set showcmd
set hidden
set wildmenu
set wildmode=list:longest
set visualbell
set cursorline
set ttyfast
set ruler                       " show row,col in status area
set backspace=indent,eol,start  " allow backspacing over everything in insert mode
set history=1000
set undodir=~/.tmp/undodir      " set unfo file location
set undofile
set backupdir=~/.tmp            " set backup directory to ~/.tmp
set directory=~/.tmp
set ffs=unix,mac,dos            " default file types
set spell                       " turn spell check on

" use relatice (offset) line number only in active window split
set relativenumber
:au WinEnter * :setlocal relativenumber
:au WinLeave * :setlocal nonumber

" automatically resize vertical splits to maximize current split
:au WinEnter * :set winfixheight
:au WinEnter * :wincmd =

" ---------------------------------------------------------------------------------
" Editor layout
" ---------------------------------------------------------------------------------
set termencoding=utf-8
set encoding=utf-8
set lazyredraw                  " don't update the display while executing macros
set laststatus=2                " tell Vim to always put a status line in,
                                "   even if there is only one window
set cmdheight=2                 " ues a status bar that is two rows high 

" set options based on whether we're in the GUI or terminal
" Mostly we're hiding the toolbar in MacVim
if has("gui_running")
    set guioptions=egmrt
    set guioptions-=T
    set t_Co=256
    set background=dark
    colorscheme solarized
    set showtabline=2           " always show tabbar in gui
else
    colorscheme solarized
    set background=dark
endif

" Fonts
set gfn=Menlo:h11
set shell=/bin/zsh

" ---------------------------------------------------------------------------------
" moving and searching
" ---------------------------------------------------------------------------------
nnoremap / /\v
vnoremap / /\v
set ignorecase                  " ignore case while searching
set smartcase                   " ignore case if search string is all lower case
                                "    case-sensitive otherwise
set gdefault                    " search/replace globally (on a line) by default
set incsearch                   " allow search matches as you type
set showmatch                   " set show matching parens
set hlsearch                    " highlight search terms
nnoremap <leader><space> :noh<cr>
nnoremap <tab> %
vnoremap <tab> %

" ---------------------------------------------------------------------------------
" handle long lines
" ---------------------------------------------------------------------------------
set wrap
set textwidth=79
set formatoptions=qrn1
set colorcolumn=85

" show invisible characters ala TextMate
set list
set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮

" ---------------------------------------------------------------------------------
" add TextMate indentation key mappings
" ---------------------------------------------------------------------------------
nmap <D-[> <<
nmap <D-]> >>
nmap <D-[> <gv
nmap <d-]> >gv

" ---------------------------------------------------------------------------------
" force hjkl movement keys. painful but essential
" ---------------------------------------------------------------------------------
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <right> <nop>
inoremap <left> <nop>
nnoremap j gj
nnoremap k gk

" remap the help key
" inoremap <F1> <ESC>
" nnoremap <F1> <ESC>
" vnoremap <F1> <ESC>
"
" ---------------------------------------------------------------------------------
" remap ; to :, save a keystroke
" ---------------------------------------------------------------------------------
nnoremap ; :

" ---------------------------------------------------------------------------------
" save on losing focus
" ---------------------------------------------------------------------------------
au FocusLost * :wa

" ---------------------------------------------------------------------------------
" map jj to ESC for quicker escaping
" ---------------------------------------------------------------------------------
inoremap jj <ESC>

" ---------------------------------------------------------------------------------
" stuff for working with split windows
" ---------------------------------------------------------------------------------
nnoremap <leader>w <C-w>v<C-w>l
nnoremap <C-h> <C-w>h  
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" ---------------------------------------------------------------------------------
" shortcut to open vimrc file and stuff to automagically update it on the fly
" turned off as it takes a HUGELY long time to save the buffer with it on
" ---------------------------------------------------------------------------------
" if has("autocmd")
"    autocmd bufwritepost .vimrc source $MYVIMRC
" endif

" ---------------------------------------------------------------------------------
" shortcut to edit .vimrc file
" ---------------------------------------------------------------------------------
nmap <leader>v :tabedit $MYVIMRC<CR>

" ---------------------------------------------------------------------------------
" control whitespace preferences based on filetype, uses autocmd
" ---------------------------------------------------------------------------------
if has("autocmd")
    " enable file type detection
    filetype on

    " syntax of these languages is fussy over tabs Vs spaces
    autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
    autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

    " treat .rss files as XML
    autocmd BufNewFile,BufRead *.rss,*.atom setfiletype xml

    " markdown filetype
    autocmd BufNewFile,BufRead *.md, *.mkd, *.markdown setfiletype markdown
    autocmd BufNewFile,BufRead *.md, *.mkd, *.markdown set spell

    " non ruby files related to Ruby
    autocmd BufNewFile,BufRead Gemfile,Gemfile.lock,Guardfile setfiletype ruby

    autocmd BufNewFile,BufRead Rakefile setfiletype rake
    autocmd BufNewFile,BufRead Rakefile set syntax=ruby

    autocmd BufNewFile,BufRead *.rake setfiletype rake
    autocmd BufNewFile,BufRead *.rake set syntax=ruby

    " Python specific settings
    let NERDTreeIgnore = ['\.pyc$', '\~$', '\.rbc$']
    autocmd BufNewFile,BufRead *.py set ts=2 sts=2 sw=2 expandtav
endif

" ---------------------------------------------------------------------------------
" stuff for bundles
" ---------------------------------------------------------------------------------
" NERDTree
" toggle NERDTRee on or off via F2
map <F2> :NERDTreeToggle<CR>
let NERDTreeMinimalUI=1
let NERDTreeDirArrows=1
" let NERDTreeWinSize=40

" NERDCommenter
" <leader>c 
"
" Gundo
nnoremap <F5> :GundoToggle<CR>

" ---------------------------------------------------------------------------------
"  finis
" ---------------------------------------------------------------------------------
