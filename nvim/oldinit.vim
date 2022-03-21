
set mousehide                                    " hide the mouse when typing
set history=1000
set ffs=unix,mac,dos                             " default file types, in order

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
"
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

" Python
let g:python_host_prog = '/usr/bin/python'

" }}}

" vim: foldmethod=marker foldlevel=0 tabstop=4 softtabstop=4 expandtab
