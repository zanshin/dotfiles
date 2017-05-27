let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline#extensions#whitespace#trailing_format = 'trailing[%s]'
let g:airline#extensions#whitespace#mixed_indent_format = 'mixed-indent[%s]'
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#branch#empty_message = ''

" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1

" Hide function display (don't use it)
let g:airline#extensions#tagbar#enabled = 0

" Show only the file name
let g:airline#extensions#tabline#fnamemod = ':t'

let g:airline_theme = 'dark'
