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
" Plug 'trevordmiller/nova-vim'
" Plug 'chriskempson/base16-vim'
Plug 'ayu-theme/ayu-vim'
" Plug 'romainl/Apprentice'
" Plug 'kyoz/purify'
" Plug 'joshdick/onedark'

" ----- Syntax & Highlighting
Plug 'Yggdroot/indentline'
Plug 'stephpy/vim-yaml'

" ----- Git helpers
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'Xuyuanp/nerdtree-git-plugin'

" ----- Undo
Plug 'sjl/gundo.vim'

" ----- Go Language
Plug 'fatih/vim-go'

" ----- Utilities
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'tpope/vim-surround'
Plug 'tomtom/tcomment_vim'

" ----- Neovim stuff
Plug 'kassio/neoterm'

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
set nolist                             " show invisible characters
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

" Map Shift-Tab to za (open/close) fold
nnoremap <s-tab> za

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
" Poor man's bracket matching {{{
" inoremap " ""<left>
" inoremap ' ''<left>
" inoremap ( ()<left>
" inoremap [ []<left>
" inoremap { {}<left>
" inoremap {<CR> {<CR>}<ESC>O
" inoremap {;<CR> {<CR>};<ESC>O

" }}}
" Navigation and Movement {{{

" Disable arrow keys and make semi-snarky comment instead
nnoremap <Left> :echo "Use h"<CR>
nnoremap <Right> :echo "Use l"<CR>
nnoremap <Up> :echo "Use k"<CR>
nnoremap <Down> :echo "Use j"<CR>

" Use <C>hjkl to switch between splits
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

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
" System clipboard {{{
" map <leadr>y to be "+y
nnoremap <leader>y "+y

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
" Do not trim whitespace from filetype mail - the trailing spaces are how
" paragraphs are formed, along with formatoptions "w"
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
    autocmd FileType mail setlocal noautoindent nolist
    autocmd FileType mail setlocal nobackup noswapfile nowritebackup

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

    " vim-surround for markdown
    autocmd FileType markdown let b:surround_{char2nr('i')} = "*\r*"
    autocmd FileType markdown let b:surround_{char2nr('b')} = "**\r**"

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

    " Add spell check to txt files
    autocmd BufNewFile,BufRead *.txt set spell spelllang=en_us

    " Go Language
    autocmd BufNewFile,BufRead *.go setlocal noet ts=4 sw=4 sts=4

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
" silent! colorscheme landscape
" silent! colorscheme nova
" silent! colorscheme apprentice
" silent! colorscheme purify
" silent! colorscheme onedark

" Base16 Chalk
" let base16colorspace=256
" silent! colorscheme base16-chalk

" let ayucolor="light"   " for light version of theme
" let ayucolor="mirage"  " for mirage version of theme
let ayucolor="dark"    " for dark version of theme

silent! colorscheme ayu

" if filereadable(expand("~/.nvim_theme"))
"   let base16colorspace=256
"   source ~/.nvim_theme
" endif
"
" nnoremap <leader>c :source ~/.nvim_theme<CR>

" Base16 setup
" function CheckColorScheme()
"
"   colorscheme base16-default-dark
"   "if filereadable(expand("~/.vimrc_background"))
"   if filereadable(expand("~/.config/nvim/.nvim_background"))
"   " if filereadable("~/.config/nvim/.nvim_background")
"     let base16colorspace=256
"     source ~/.config/nvim/.nvim_background
"   endif
"   doautocmd ColorScheme
" endfunction
"
" if has('autocmd')
"   augroup MyAutocolor
"     autocmd!
"     autocmd FocusGained * call CheckColorScheme()
"   augroup END
"   call CheckColorScheme()
" endif

" Redraw to catch any color change
" autocmd FocusGained * :redraw!

" function s:CheckColorScheme()
"   let g:base16colorspace=256
"
"   let s:config_file = expand('~/.config/.base16')
"
"   if filereadable(s:config_file)
"     let s:config = readfile(s:config_file, '', 1)
"
"     if s:config =~ 'light'
"       execute 'set background=light'
"     else
"       execute 'set background=dark'
"     endif
"
"     if filereadable(expand('~/.config/nvim/plugged/base16-vim/colors/base16-' . s:config_file[1] . '.vim'))
" "      execute 'color base16-' . s:config_file[1]
"       execute 'color base16-' . readfile(expand('~/.config/.base16'))
"     else
"       echoerr 'Bad color scheme' . s:config_file[1]
"     endif
"   else
"     set background=dark
"     color base16-material-darker
"   endif
"
"   doautocmd ColorScheme
" endfunction
"
" if v:progname !=# 'vi'
"   if has('autocmd')
"     augroup MyAutocolor
"       autocmd!
"       autocmd FocusGained * call s:CheckColorScheme()
"     augroup END
"   endif
"
"   call s:CheckColorScheme()
" endif

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
" Vim-surround {{{
" The autocmd FileType statements that define 'i' and 'b' are in the FileType
" section.
" Mapping to put Markdown italics (*) characters around current word
nnoremap <leader>mi :execute "normal \<Plug>Ysurroundiwi"<cr>
" Mapping to put Markdown bold (**) characters around current word
nnoremap <leader>mb :execute "normal \<Plug>Ysurroundiwb"<cr>

" }}}
" Neoterm {{{
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
" Vim-go {{{
let g:go_fmt_fail_silently = 0
let g:go_fmt_command = "goimports"
let g:go_autodetect_gopath = 1
let g:go_term_enabled = 1
" let g:go_snippet_engine = "neosnippet"
let g:go_highlight_space_tab_error = 0
let g:go_highlight_array_whitespace_error = 0
let g:go_highlight_trailing_whitespace_error = 0
let g:go_highlight_extra_types = 0
let g:go_highlight_operators = 0
let g:go_highlight_build_constraints = 1

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
" finis {{{

" }}}
"
" vim: foldmethod=marker foldlevel=0 tabstop=4 softtabstop=4 expandtab
