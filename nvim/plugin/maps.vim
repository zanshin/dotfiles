" Map ; to : to save needing the shift key
nnoremap ; :
nnoremap ;; ;

" Relative number / number toggle
nnoremap <F10> :set relativenumber! number! number?<CR>

" Disable arrow keys and make semi-snarky comment instead
nnoremap <Left> :echo "Use h"<CR>
nnoremap <Right> :echo "Use l"<CR>
nnoremap <Up> :echo "Use k"<CR>
nnoremap <Down> :echo "Use j"<CR>

" Use <C>-hjkl to swtich between splits
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Move line(s) up or down via C-j and C-k repectively
" Normal mode
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
" Insert mode
inoremap <C-j> :m <ESC>:m .+1<CR>==gi
inoremap <C-k> :m <ESC>:m .-2<CR>==gi
" Visual mode
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '>-2<CR>gv=gv

" Buffers and Tabs
nnoremap <leader>be :enew<CR>          " create new empty buffer
nnoremap <leader>bn :bnext<CR>         " move to next buffer
nnoremap <leader>bp :bprevious<CR>     " move to previous buffer
nnoremap <leader>bq :bp <BAR> bd #<CR> " move to previous buffer and close buffer

" Sudo to write (when you forgot to use sudo vim ... )
cnoremap w!! w !sudo tee % >/dev/null

" Toggle listchars on or off
nnoremap <leader>l :set list!<CR>

" Sane regex (irony) handling
nnoremap / /\v
vnoremap / /\v

" Better pasting from clipbpard
" http://tilvim.com/2014/03/18/a-better-paste.html
nnoremap <leader>p :set paste<CR>0<ESC>"*]p:set nopaste<CR>

" Map escape to - faster to type adn easier to reach
inoremap jj <ESC>

" Remove search highlighting with <leader>+/
nnoremap <silent> <leader>/ :nohlsearch<CR>

" Trailing whitespace
" www.bestofvim.com/tip/trailing-whitespace/
function! TrimWhitespace()
  %s/\s\+$//e
endfunction
nnoremap <silent> <leader>tws :call TrimWhitespace()<CR>

" Splits
nnoremap <leader>v <C-w>w<C-w>l        " open a vertical split and switch to it
nnoremap <leader>h <C-w>s<C-w>j        " open a horizontal split and switch to it

" Open init.vim in a new tab for editting
nnoremap <leader>ev :tabedit $MYVIMRC<CR>

" Syntax toggle
function! ToggleSyntax()
  if exists("g:syntax_on")
    syntax off
  else
    syntax enable
  endif
endfunction
nmap <silent> <leader>s :call ToggleSyntax()<CR>

" Gundo
nnoremap <leader>U :GundoToggle<CR>

" NERDTree
noremap <C-n> :NERDTreeToggle<CR>

" IndentLine
nnoremap <leader>i :IndentLinesToggle<CR>
