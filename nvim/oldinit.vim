" Neovim Configuration
"
" author: Mark Nichols <mark@zanshin.net>
" source: https://github.com/zanshin/dotfiles/nvim/init.vim
"

" ----- Basic options {{{


set mousehide                                    " hide the mouse when typing
set history=1000
set ffs=unix,mac,dos                             " default file types, in order

if exists("&cryptmethod")
  set cryptmethod=blowfish                       " string encryption is good
endif

" Map Shift-Tab to za (open/close) fold
nnoremap <s-tab> za

" Change option: set $ at end of change range
" https://www.reddit.com/r/vim/comments/3b7324/insert_dollar_sign_at_end_of_change_command/
set cpoptions+=$


au FocusLost * :wa!                              " save file when Neovim loses focus

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
" ----- Command line completion {{{
" Search down into subfolders
" Provides tab-completion for all filer-related tasks
" set path+=**
"
" set wildmenu                                     " navigate <left> and <right> through completion list
" set wildignore+=.git                             " ignore Git repository
" set wildignore+=*.jpg,*.png,*.gif,*,jpeg,*.bmp   " ignore image files
" set wildignore+=*.sw?                            " ignore swap files
" set wildignore+=*.DS_Store                       " ignore macOS clutter

" }}}
" ----- NetRW {{{
" let g:netrw_liststyle=3                " tree view style
" let g:netrw_banner=0                   " disable annoying banner
" let g:netrw_browse_split=4
" let g:netrw_altv=1
" let g:metrw_winsize=25

" }}}
" ----- Plugin Settings {{{

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
" nnoremap <c-n> :NERDTreeToggle<CR>
"
" let g:NERDTreeGitStatusIndicatorMapCustom = {
"     \ "Modified"  : "✹",
"     \ "Staged"    : "✚",
"     \ "Untracked" : "✭",
"     \ "Renamed"   : "➜",
"     \ "Unmerged"  : "═",
"     \ "Deleted"   : "✖",
"     \ "Dirty"     : "✗",
"     \ "Clean"     : "✔︎",
"     \ "Unknown"   : "?"
"     \ }
"
" " Start NERDTree when editor is started, put cursor in other window
" autocmd VimEnter * NERDTree | wincmd p
"
" " Close nerdtree and vim on close file
" " from https://github.com/jessfraz/.vim/blob/master/vimrc#L491
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
"
" " Exit Vim if NERDTree is the only window remaining in the only tab.
" autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
"
"
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

" }}}
" ----- Vim-Delve {{{
let g:delve_backend = "native"

" }}}
" ----- LanguageClient-neovim {{{
" let g:LanguageClient_serverCommands = {
"     \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
"     \ 'go': ['gopls' ],
"     \ 'python': ['/usr/local/bin/pyls'],
"     \ 'ruby': ['~/.rbenv/shims/solargraph', 'stdio'],
"     \ }

" let g:LanguageClient_serverCommands = {
"       \ 'go': ['gopls']
"       \ }

" nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
" nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
" nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

" }}}
" ----- Telescope {{{
" nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown({}))<cr>
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files({hidden = true})<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

" Map q to close the damn popup window
lua << EOF
local actions = require('telescope.actions')

require('telescope').setup {
defaults = {
  mappings = {
    i = {
      ["<esc>"] = actions.close,
      ["<C-[>"] = actions.close,
      ["<C-q>"] = actions.send_to_qflist,
      },
    },
  },
}
EOF

" Find files using Telescope command-line sugar.
" nnoremap <leader>ff <cmd>Telescope find_files<cr>
" nnoremap <leader>fg <cmd>Telescope live_grep<cr>
" nnoremap <leader>fb <cmd>Telescope buffers<cr>
" nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" }}}
" ----- Treesitter {{{
lua << EOF
local ts = require 'nvim-treesitter.configs'
ts.setup {
  ensure_installed = 'maintained',
  highligh = {
    enable = true,
    },
  playground = {
    enable = true,
    disable = {},
    updatetime = 25,           -- debounced time for highlighted nodes in playground from source code
    persist_queries = false,   -- whether the query persists across vim sessions
    keybindings = {
      toggle_query_editor = 'o',
      toggle_hl_groups = 'i',
      toggle_injected_languages = 't',
      toggle_anonymous_nodes = 'a',
      toggle_lanugage_display = 'I',
      focus_language = 'f',
      unfocus_language = 'F',
      update = 'R',
      goto_node = '<cr>',
      show_help = '?',
      },
    }
  }
EOF

" }}}
" ----- Completion {{{
set completeopt=menu,menuone,noselect

lua <<EOF
-- setup lspkind
local lspkind = require "lspkind"
lspkind.init()

-- Setup nvim-cmp.
local cmp = require "cmp"

cmp.setup {
  mapping = {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-e>'] = cmp.mapping.close(),
    ['<C-y>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    },

    ['<C-Space>'] = cmp.mapping.complete(),
  },

  sources = {
    -- Order ranks these
    -- These are global
    { name = "nvim_lsp" },
    { name = "path"  },
    { name = "nvm_lua"  },
    { name = "buffer", keyword_length = 5 },
  },

  formatting = {
    format = lspkind.cmp_format({with_text = true}),
    menu = {
      buffer = "[buf]",
      nvim_lsp = "[LSP]",
      nvim_lua = "[api]",
      path = "[path]",
    },
  },

  experimental = {
    -- New menu, better than the old menu
    native_menu = false,

    -- "ghost" completion
    ghost_text = true,
  },
}
EOF

" }}}
" ----- nvim-lspconfig {{{
lua << EOF
require'lspconfig'.bashls.setup{}          -- bash langauage server
require'lspconfig'.gopls.setup{}           -- go language server
require'lspconfig'.terraformls.setup{}     -- terraform language servers
require'lspconfig'.tflint.setup{}          -- terraform linter, and language server
EOF

lua << EOF
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'pyright', 'rust_analyzer', 'tsserver' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end
EOF

" }}}
" ----- nvim-tree {{{
let g:nvim_tree_ignore = [ '.git', 'node_modules', '.cache' ] "empty by default
let g:nvim_tree_gitignore = 1 "0 by default
let g:nvim_tree_quit_on_open = 1 "0 by default, closes the tree when you open a file
let g:nvim_tree_indent_markers = 1 "0 by default, this option shows indent markers when folders are open
let g:nvim_tree_hide_dotfiles = 1 "0 by default, this option hides files and folders starting with a dot `.`
let g:nvim_tree_git_hl = 1 "0 by default, will enable file highlight for git attributes (can be used without the icons).
let g:nvim_tree_highlight_opened_files = 1 "0 by default, will enable folder and file icon highlight for opened files/directories.
let g:nvim_tree_root_folder_modifier = ':~' "This is the default. See :help filename-modifiers for more options
let g:nvim_tree_add_trailing = 1 "0 by default, append a trailing slash to folder names
let g:nvim_tree_group_empty = 1 " 0 by default, compact folders that only contain a single folder into one node in the file tree
let g:nvim_tree_disable_window_picker = 1 "0 by default, will disable the window picker.
let g:nvim_tree_icon_padding = ' ' "one space by default, used for rendering the space between the icon and the filename. Use with caution, it could break rendering if you set an empty string depending on your font.
let g:nvim_tree_symlink_arrow = ' >> ' " defaults to ' ➛ '. used as a separator between symlinks' source and target.
let g:nvim_tree_respect_buf_cwd = 1 "0 by default, will change cwd of nvim-tree to that of new buffer's when opening nvim-tree.
let g:nvim_tree_create_in_closed_folder = 0 "1 by default, When creating files, sets the path of a file when cursor is on a closed folder to the parent folder when 0, and inside the folder when 1.
let g:nvim_tree_refresh_wait = 500 "1000 by default, control how often the tree can be refreshed, 1000 means the tree can be refresh once per 1000ms.
let g:nvim_tree_window_picker_exclude = {
    \   'filetype': [
    \     'notify',
    \     'packer',
    \     'qf'
    \   ],
    \   'buftype': [
    \     'terminal'
    \   ]
    \ }
" Dictionary of buffer option names mapped to a list of option values that
" indicates to the window picker that the buffer's window should not be
" selectable.
let g:nvim_tree_special_files = { 'README.md': 1, 'Makefile': 1, 'MAKEFILE': 1 } " List of filenames that gets highlighted with NvimTreeSpecialFile
let g:nvim_tree_show_icons = {
    \ 'git': 1,
    \ 'folders': 0,
    \ 'files': 0,
    \ 'folder_arrows': 0,
    \ }
"If 0, do not show the icons for one of 'git' 'folder' and 'files'
"1 by default, notice that if 'files' is 1, it will only display
"if nvim-web-devicons is installed and on your runtimepath.
"if folder is 1, you can also tell folder_arrows 1 to show small arrows next to the folder icons.
"but this will not work when you set indent_markers (because of UI conflict)

" default will show icon by default if no icon is provided
" default shows no icon by default
let g:nvim_tree_icons = {
    \ 'default': '',
    \ 'symlink': '',
    \ 'git': {
    \   'unstaged': "✗",
    \   'staged': "✓",
    \   'unmerged': "",
    \   'renamed': "➜",
    \   'untracked': "★",
    \   'deleted': "",
    \   'ignored': "◌"
    \   },
    \ 'folder': {
    \   'arrow_open': "",
    \   'arrow_closed': "",
    \   'default': "",
    \   'open': "",
    \   'empty': "",
    \   'empty_open': "",
    \   'symlink': "",
    \   'symlink_open': "",
    \   },
    \   'lsp': {
    \     'hint': "",
    \     'info': "",
    \     'warning': "",
    \     'error': "",
    \   }
    \ }

nnoremap <C-n> :NvimTreeToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>
nnoremap <leader>n :NvimTreeFindFile<CR>
" NvimTreeOpen, NvimTreeClose, NvimTreeFocus and NvimTreeResize are also available if you need them

" a list of groups can be found at `:help nvim_tree_highlight`
highlight NvimTreeFolderIcon guibg=blue

lua << EOF
  require'nvim-tree'.setup()
EOF

" }}}

" vim: foldmethod=marker foldlevel=0 tabstop=4 softtabstop=4 expandtab
