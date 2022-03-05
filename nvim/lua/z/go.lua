cmd [[ 
" ----- Vim-GO {{{
" Use cnext and cprev to move through errors in quickfix list
" f = forward, b = backward
" au Filetype go nmap <C-f> :cnext<CR>
au Filetype go nmap <m-f> :cnext<CR>
" au Filetype go nmap <C-b> :cprevious<CR>
au Filetype go nmap <m-b> :cprevious<CR>
au Filetype go nnoremap <leader>a :cclose<CR>

" b for GoBuild and r for GoRun
au Filetype go nmap <leader>b <Plug>(go-build)
au Filetype go nmap <leader>r <Plug>(go-run)

" t for GoTest, dt for Test compile
au Filetype go nmap <leader>t <Plug>(go-test)
au Filetype go nmap <leader>dt <Plug>(go-test-compile)

" GoAlternate mappings
au Filetype go nmap <leader>ga <Plug>(go-alternate-edit)
au Filetype go nmap <leader>gah <Plug>(go-alternate-split)
au Filetype go nmap <leader>gav <Plug>(go-alternate-vertical)

" Force all lists to be quickfix, don't use location for go lang
let g:go_list_type                   = "quickfix"

" Vim is not async, set limit on test run time. Default is 10 seconds
let g:go_test_timeout                = '10s'

let g:go_fmt_fail_silently           = 0

" Automatically insert missing imports on buffer save
let g:go_fmt_command                 = "goimports"

" Don't show fmt errors in quickfix window
let g:go_fmt_fail_silently           = 0

let g:go_autodetect_gopath           = 1
let g:go_term_enabled                = 1
" let g:go_snippet_engine             = "neosnippet"

" Highlighting controls. Having these on (1) can negatively impact performance
let g:go_highlight_build_constraints         = 0
let g:go_highlight_extra_types               = 0
let g:go_highlight_fields                    = 0
let g:go_highlight_functions                 = 1
let g:go_highlight_methods                   = 0
let g:go_highlight_operators                 = 0
let g:go_highlight_structs                   = 1
let g:go_highlight_types                     = 1
let g:go_highlight_space_tab_error           = 0
let g:go_highlight_array_whitespace_error    = 0
let g:go_highlight_trailing_whitespace_error = 0

" Folding
" let g:go_fold_enable = ['block', 'import', 'varconst', 'package_comment']
" let g:go_fold_enable = ['block']

let g:go_auto_sameids = 0

" Automatically show type info in status line
let g:go_auto_type_info = 0

" Linting
" let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
" let g:go_metalinter_autosave = 1
" let g:go_metalinter_deadline = "5s"

au Filetype go nmap <leader>s <Plug>(go-def-split)
au Filetype go nmap <leader>v <Plug>(go-def-vertical)
au Filetype go nmap <leader>i <Plug>(go-info)
au Filetype go nmap <leader>l <Plug>(go-metalinter)

" d shows docs, i shows info in status line
au Filetype go nmap <leader>d <Plug>(go-doc)
au Filetype go nmap <leader>i <Plug>(go-info)

au Filetype go nmap <leader>e <Plug>(go-rename)

" Toggle highlight of all matching objects under cursor
au Filetype go nmap <leader>h :GoSameIdsToggle<CR>

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

]]
