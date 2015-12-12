" .nvimrc
" Author: Mark Nichols <mark@zanshin.net>
" Source: http://github.com/zanshin/dotfiles/neovim/nvimrc
"
" Plugins {{{
call plug#begin('~/.config/nvim/plugged')

" -- Make Neovim look good
Plug 'itchyny/landscape.vim'
Plug 'bling/vim-airline'
"Plug 'mhartington/oceanic-next'

" -- Syntax & Highlighting
Plug 'plasticboy/vim-markdown'
Plug 'Yggdroot/indentLine'

" -- Git helpers
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'Xuyuanp/nerdtree-git-plugin'

" -- Undo
Plug 'sjl/gundo.vim'

" -- Utilities
Plug 'scrooloose/nerdtree'
Plug 'rizzatti/dash.vim'
Plug 'tpope/vim-surround'
Plug 'tomtom/tcomment_vim'

" Encryption
Plug 'jamessan/vim-gnupg'

" Markdown
Plug 'junegunn/goyo.vim'
Plug 'reedes/vim-pencil'

" Add plugins to &runtimepath
call plug#end()

" Turn things on
if has ('autocmd')
	filetype plugin indent on
endif

if has ('syntax') && !exists('g:syntax_on')
	syntax on
endif

" }}}
" Color {{{
set background=dark
silent! colorscheme landscape

" }}}
" Basics {{{
" Change map <leader> from \ to ` ` (space)
:let mapleader = " "

nnoremap ; :
noremap ;; ;

"set laststatus=2                            " always show the status line
set cmdheight=2                             " and use a 2-line tall status line
"set showcmd                                 " show the command
set noshowmode                              " don't show the mode, airline will
set autoindent                              " turns it on
set smartindent                             " does the right thing, mostly
set linespace=3                             " prefer a slightly higher line height
set linebreak                               " wrap intelligently, won't insert hard line breaks
set wrap                                    " use line wrapping
set textwidth=79                            " at colmun 79
set ruler                                   " display current cursor position
set list                                    " show invisible characters, listed next
set listchars=tab:▸\ ,eol:¬,trail:⋅,nbsp:␣,extends:❯,precedes:❮
set showmatch                               " show matching brackets [{()}]
set matchpairs+=<:>                         " add <> to matching brackets
if exists("&relativenumber")
	set relativenumber                  " use relative line numbers
endif
set number                                  " except for the current line - absolute number there
set backspace=indent,eol,start              " make backspace behave in a sane manner
set mousehide                               " hide mouse when typing
set foldenable                              " enable code folding
set history=1000
set ffs=unix,mac,dos                        " default file types
set autoread                                " automatically update file when editted outside of nvim
set cursorline                              " highlight the line where the cursor is

" Relative number/number toggle
nnoremap <F10> :set relativenumber! number! number?<CR>

" Code folding settings
set foldcolumn=3                            " room for fold markers
set foldmethod=marker                       " use standard 3 curly braces as markers

" Encoding anyone?
set termencoding=utf-8                      " we like utf-8

" Change options: set $ at end of change range
" https://www.reddit.com/r/vim/comments/3b7324/insert_dollar_sign_at_end_of_chage_command/
set cpoptions+=$

" Model lines
set modeline

" Setup automatic text formatting/wrapping
set formatoptions=
set formatoptions-=t                        " don't autowrap text
set formatoptions+=c                        " do autowrap comments
"set formatoptions+=r                        " automatically continue comments
"set formatoptions+=o                        " automatically continue commnets with 'o' or 'O'
set formatoptions+=q                        " allow formatting of comments with 'gq'
set formatoptions+=n                        " recognize numbered lists
set formatoptions+=l                        " don't break longs lines that were already there

" }}}
" Vimrc {{{
" Reload .nvimrc
"map <silent> <leader>R :source ~/.config/nvim/init.vim<CR>:filetype detect<CR>:exe ":echo 'init.vim reloaded'"<CR>
map <silent> <leader>R :source $MYVIMRC<CR>:filetype detect<CR>:exe ":echo 'init.vim reloaded'"<CR>

" }}}
" Movement {{{

" Disable arrow keys and make snarky comments.
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" Use <C>hjkl to switch between splits
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Move lines up or down via <C>-j and <C>-k respectively
" Normal mode
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==

" Insert mode
inoremap <C-j> <ESC>:m .+1<CR>==gi
inoremap <C-k> <ESC>:m .-2<CR>==gi

" Visual mode
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" }}}
" Buffers {{{
nmap <leader>be :enew<cr>                   " create new empty buffer
nmap <leader>bn :bnext<cr>                  " move to next buffer
nmap <leader>bp :bprevious<cr>              " move to previous buffer
nmap <leader>bq :bp <BAR> bd #<cr>          " move to previous and close buffer

noremap <C-t> :tabnew<cr>                   " new tab
noremap <C-p> :tabprevious<cr>              " previous tab
noremap <C-n> :tabnext<cr>                  " next tab
inoremap <C-t> :<ESC>:tabnew<cr>            " insert mode, new tab
inoremap <C-p> :<ESC>:tabprevious<cr>i      " insert mode, previous tab
inoremap <C-n> :<ESC>:tabnext<cr>i          " insert mode, next tab

" }}}
" Focus {{{
" What to do with files and focus
set autowrite                               " write out old file when switching between files
set autoread                                " reload files changed on disk, i.e., via `git checkout`
au FocusLost * :wa                          " save file when Neovim loses focus
set hidden                                  " switch between buffers without saving

" }}}
" Backups {{{
set backup                                  " enable backups
set noswapfile                              " It's the 21st century already

if has('persistent_undo')
	set undodir=~/.config/nvim/tmp/undo//
	if !isdirectory(expand(&undodir))
		call mkdir(expand(&undodir), "p")
	endif
endif

set backupdir=~/.config/nvim/tmp/backup//   " backups
if !isdirectory(expand(&backupdir))
	call mkdir(expand(&backupdir), "p")
endif

set directory=~/.config/nvim/tmp/swap       " swap files
if !isdirectory(expand(&directory))
	call mkdir(expand(&directory), "p")
endif

" }}}
" Tabstops {{{
set tabstop=2                               " 2 spaces for a tab - used when nvim opens a file having <tab>s in it
set shiftwidth=2                            " 2 spaces for autoindenting
set softtabstop=2                           " 2 spaces inserted for <tab> when editing a file, also # removed by backspace
set expandtab                               " expand tabs to spaces (overloadable by file type settings)

" }}}
" Scrolling  {{{
set scrolloff=5                             " show content above/below cursor line
set sidescrolloff=10                        " number of cols from horizontal edge to start scrolling
set sidescroll=1                            " number of cols to scroll at a time

" }}}
" Help {{{
" Only apply to .txt files
augroup HelpInTabs
  autocmd!
  autocmd BufEnter *.txt call HelpInNewTab()
augroup END

" Only apply to helo files...
function! HelpInNewTab()
  if &buftype == 'help'
    " convert helpt window to a tab
    execute "normal \<C-W>T"
  endif
endfunction

" }}}
" Miscellaneous {{{
" Sudo to write
cmap w!! w !sudo tee % >/dev/null

" Toggle listchars on or off
noremap <leader>i :set list!<cr>

" Fix regex handling
nnoremap / /\v
vnoremap / /\v

" Paste mode to prevent autoindentation of pasted lines
set pastetoggle=<F2>

" Better pasting from clipboard
" http://tilvim.com/2014/03/18/a-better-paste.html
map <leader>p :set paste<cr>o<esc>"*]p:set nopaste<cr>
set clipboard=unnamed                       " yank and paste with the system clipboard

" Show cursorline only in active window
if has("autocmd")
  autocmd WinLeave * set nocursorline
  autocmd WinEnter * set cursorline
endif

" Map escape to jj -- much faster to type and to reach
imap jj <esc>

" }}}
" Searching {{{
set gdefault                                " apply substitution globally by default. add `g` for old behavior
set incsearch                               " use incrementail search
set hlsearch                                " highlight search results
set ignorecase                              " ignore case when searching
set smartcase                               " ignore case if search string is all lower case, case-sensitive otherwise

" Remove search highlighting with <leader>/
nnoremap <silent> <leader>/ :nohlsearch<cr>

" }}}
" Splits {{{
noremap <leader>v <C-w>v<C-w>l              " open a vertical split and switch to it
noremap <leader>h <C-w>s<C-w>j              " open a horizontal split and swtich to it 

" }}}
" Completion {{{
set wildmenu                                " navigate <left> & <right> through completion lists
set wildmode=full                           " complete first full match, next match (default)

set wildignore+=.git                        " ignore .git repository directory
set wildignore+=*.jpg,*.png,*.gif,*.jpeg,*.bmp  " ignore image files
set wildignore+=*.sw?                       " ignore swap files
set wildignore+=*.DS_Store                  " ignore OS X clutter

" }}}
" Filetype {{{
" Control whitespace preferences based on filetype
if has("autocmd")
  "enable file type detection
  filetype on

  " prevent Neovim from auto-inserting comment on subsequent lines
  " http://tilvim.com/2013/12/30/remove-comment-prefix-2.html
  autocmd FileType * setlocal formatoptions-=r formatoptions-=o

  " Syntax of these languages is fussy over tabs vs. spaces
  autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
  autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

  " Setup for mail (mutt)
  autocmd FileType mail setlocal formatoptions+=aw
  autocmd FileType mial setlocal spell spelllang=en_us

  " Treat .rss files as XML
  autocmd BufNewFile,BufRead *.rss,*.atom setfiletype xml

  " Spell check Git commit messages
  autocmd BufRead COMMIT_EDITMSG sestlocal spell spelllang=en_us

  " Start commit messages in insert mode
  autocmd BufNewFile,BufRead COMMIT_EDITMSG call feedkeys('ggi', 't')

  " Markdown files
  autocmd BufNewFile,BufRead *.md,*.mkd,*.markdown setfiletype markdown
  autocmd BufNewFile,BufRead *.md,*.mkd,*.markdown set spell spelllang=en_us
  autocmd FileType markdown setlocal tw=100

  " Non Ruby files related to Ruby
  autocmd BufNewFile,BufRead Gemfile,Gemfile.lock,Guardfile setfiletype ruby
  autocmd BufNewFile,BufRead Thorfile,config.ru,Vagrantfile setfiletype ruby
  autocmd BufNewFile,BufRead Berksfile,Berksfile.lock setfiletype ruby
  autocmd BufNewFile,BufRead Rakefile setfiletype rake
  autocmd BufNewFile,BufRead Rakefile set syntax=ruby
  autocmd BufNewFile,BufRead *.rake setfiletype rake
  autocmd BufNewFile,BufRead *.rake set syntax=ruby

  " Chef uses Ruby, and this will enable Chef snippets
  autocmd FileType ruby,eruby set filetype=ruby.eruby.chef

  " Python files
  let NERDTreeIgnore = ['\.pyc$', '\~$', '\.rbc$']
  autocmd BufNewFile,BufRead *.py set ts=2 sts=2 sw=2 expandtab

  " Ensure syntax highlighting for diffs
  autocmd FileType diff syntax enable

endif

" }}}
" NetRW {{{
let g:netrw_liststyle=3

" }}}
" Python {{{
let g:python_host_prog = '/usr/bin/python'

" }}}
" Airline {{{
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline#extensions#whitespace#trailing_format = 'trailing[%s]'
let g:airline#extensions#whitespace#mixed_indent_format = 'mixed-indent[%s]'
let g:airline#extensions#brtanch#enabled = 1
let g:airline#extensions#branch#empty_message = ''

" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1

" Hide function display, don't use it
let g:airline#extensions#tabbar#enabled = 0

" Show just the file name
let g:airline#extensions#tabline#fnamemod = ':t'

" Use dark theme
let g:airline_theme='dark'

" }}}
" Markdown {{{
" Highligh YAML frontmatter as used by Jekyll
let g:vim_markdown_frontmatter=1

" }}}
" Gundo {{{
nnoremap <leader>U :GundoToggle<cr>

" }}}
" Nerdtree {{{
map <C-n> :NERDTreeToggle<cr>

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

" }}}
" Dash  {{{
nmap <silent><leader>d <Plug>DashSearch

" }}}
" Goyo {{{
let g:goyo_width=100
let g:goyo_height=90

" }}}
" Pencil {{{
augroup pencil
  autocmd!
  autocmd FileType markdown,mkd call pencil#init()
  autocmd FileType text         call pencil#init()
augroup END

" }}}
" indentLine {{{
let g:indentLine_color_term = 239
let g:indentLine_char = '|'
nmap <leader>i :IndentLinesToggle<cr>

" }}}
