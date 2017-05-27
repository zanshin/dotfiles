" Change map <leader> from \ to " " (space)
:let mapleader = " "

" Time out mappings after 1 second (1000) and key codes after 1/2 second (500)
set timeout timeoutlen=1000 ttimeoutlen=500

" Encoding
set termencoding=utf-8
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8

set laststatus=2                       " always show the status line
set cmdheight=2                        " two-line tall status line
set showcmd                            " show the command
set noshowmode                         " don't show the mode, vim-airline will do that
set autoindent                         " turn autoindenting on
set smartindent                        " does the right thing, mostly
set linespace=3                        " prefer a slightly higher line height
set linebreak                          " wrap intelligently, won't insert hard line breaks
set wrap                               " use line wrapping ...
set textwidth=79                       " ... at column 79
set ruler                              " display current cursor position
set list                               " show invisible characters
set listchars=tab:▸\ ,eol:¬,trail:⋅,nbsp:␣,extends:❯,precedes:❮
set showmatch                          " show matching brackets [{()}]
if exists("&relativenumber")
  set relativenumber                   " use relative line numbering ...
endif
set number                             " ... except for the current line - absolute number there
set backspace=indent,eol,start         " make backspace behave in a sane manner
set mousehide                          " hide the mouse when typing
set foldenable                         " enable code folding
set history=1000
set ffs=unix,mac,dos                   " order of filetypes
if exists("&cryptmethods")
  set cryptmethod=blowfish             " strong encryption is good
endif
set cursorline                         " highlight the line where the cursor is

" Code folding settings
set foldcolumn=3                       " room for the fold markers
set foldmethod=marker                  " use standard 3 curly braces as markers

" Change options: set $ at end of change range
" https://www.reddit.com/r/vim/comments/3b7324/insert_dollar_sign_at_end_of_change_command/
set cpoptions+=$

" Setup automatic text formatting/wrapping
set formatoptions=
set formatoptions-=t                   " don't autowrap text
set formatoptions+=c                   " do autowrap comments
set formatoptions-=r                   " don't automatically continue comments
set formatoptions-=o                   " don't automatically continue comments when hitting 'o' or 'O'
set formatoptions+=q                   " allow formatting of comments with 'gq'
set formatoptions+=n                   " recognize number lists
set formatoptions+=l                   " don't break long lines that were already there

" Set match pairs beyond default [...], {,,,}, and (...)
set matchpairs+=<:>

" Files and focus
set autowrite                          " write out old file when switching between files
set autoread                           " reload files changed on disk, e.g., via 'git checkout'
au FocusLost * :wa                     " save file when Neovim loses focus
set hidden                             " switch between buffers without saving

" Backup
set backup                             " enable backups
set noswapfile                         " it's the 21st century already
if has('persistent_undo')
  set undodir=~/.config/nvim/tmp/undo//     " undo files go here
  if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), "p")
  endif
endif
set backupdir=~/.config/nvim/tmp/backup//   " backups go here
if !isdirectory(expand(&backupdir))
  call mkdir(expand(&backupdir), "p")
endif
set directory=~/.config/nvim/tmp/swap//     " swap files
if !isdirectory(expand(&directory))
  call mkdir(expand(&directory), "p")
endif

" Tabstops
set tabstop=2                          " 2 spaces for tab - used when opening a file having <tabs>s in it
set shiftwidth=2                       " 2 spaces for autoindenting
set softtabstop=2                      " 2 spaces inserted for <tab> / also # removed by backspace
set expandtab                          " expand tabs to spaces, we're not animals (overloadable by file type)

" Scrolling
set scrolloff=5                        " show context above/below cursor line
set sidescrolloff=10                   " number of columns from horizontal edge to start scrolling
set sidescroll=1                       " nubmer of colums to scroll at a time

" Search down into sub-folders
" provides tab-completion for all file-related tasks
set path+=**

set wildmenu                           " navigate <left> & <right> through completion lists
set wildignore+=.git                   " ignore Git repositories
set wildignore+=*.jpg,*.png,*.gif,*,jpeg,*.bmp     " ignore image files
set wildignore+=*.sw?                  " ignore swap files
set wildignore+=*.DS_Store             " ignore macOS clutter

" Searching
set gdefault                           " apply substitutions globally by default. add 'g' for old style
set incsearch                          " use incremental search
set hlsearch                           " highlight search results
set ignorecase                         " ignore case when searching
set smartcase                          " ignore case if search string is all lower case, otw case-sensitive

" Pasting
set pastetoggle=<F2>
set clipboard=unnamed                  " yank and paste with the system clipboard
