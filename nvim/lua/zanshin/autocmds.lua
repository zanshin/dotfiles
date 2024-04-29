-- Create some helpers
local agrp = vim.api.nvim_create_augroup
local acmd = vim.api.nvim_create_autocmd

-- ----- Filetype settings
-- Control preferences based on file type

-- General autocmds
local _general = agrp("_general", { clear = true })
acmd({ "FocusLost" },
  {
    pattern = "*",
    command = ":wa",
    group = _general
  })

acmd({ "FocusLost" },
  {
    pattern = "*",
    command = "set mouse=",
    group = _general
  })

acmd({ "FocusGained" },
  {
    pattern = "*",
    command = "set mouse+=a",
    group = _general
  })

acmd({ "FileType" },
  {
    pattern = "*",
    command = "set formatoptions-=ro noswapfile",
    group = _general
  })

acmd({ "BufWritePre" },
  {
    pattern = "*",
    callback = function()
      vim.lsp.buf.format()
    end,
    group = _general
  })

acmd({ "BufWinEnter" },
  {
    pattern = "*",
    command = "set modifiable",
    group = _general
  })

-- For diagnostics for specific cursor position
-- https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization#show-line-diagnostics-automatically-in-hover-window
-- acmd({ "CursorHold,CursorHoldI" },
acmd({ "CursorHold" },
  {
    pattern = "*",
    callback = function()
      -- vim.diagnostic.open_float(nil, {focus=false})
      vim.diagnostic.open_float(nil, { focus = false, scope = "cursor" })
    end,
    group = _general
  })
acmd({ "CursorHoldI" },
  {
    pattern = "*",
    callback = function()
      -- vim.diagnostic.open_float(nil, {focus=false})
      vim.diagnostic.open_float(nil, { focus = false, scope = "cursor" })
    end,
    group = _general
  })

-- gopass security
local _gopass = agrp("_gopass", { clear = true })
acmd({ "BufNewFile", "BufRead" },
  {
    pattern = "/private/**/gopass**",
    command = 'setlocal noswapfile nobackup noundofile shada=""',
    group = _gopass
  })

-- makefile autocmds
local _makefile = agrp("_makefile", { clear = true })
acmd({ "FileType" },
  {
    pattern = "make",
    command = "setlocal ts=8 sts=8 sw=8 noexpandtab",
    group = _makefile
  })

-- YAML autocmds
local _yaml = agrp("_yaml", { clear = true })
acmd({ "BufNewFile", "BufReadPost" },
  {
    pattern = "*.{yaml.yml}",
    command = "setfiletype=yaml foldmethod=indent",
    group = _yaml
  })

acmd({ "FileType" },
  {
    pattern = "yaml",
    command = "setlocal ts=2 sts=2 sw=2 expandtab indentkeys-=<:>",
    group = _yaml
  })

-- Rust
local _rust = agrp("_rust", { clear = true })
acmd({ "FileType" },
  {
    pattern = "rs",
    command = "setlocal ts=4, sts=4, sw=4 expandtab",
    group = _rust
  })

-- mail (mutt) autocmds
local _mutt = agrp("_mutt", { clear = true })
acmd({ "FileType" },
  {
    pattern = "mail",
    command = "formatoptions+=aw spell spelllang=en_us noautoindent nolist nobackup noswapfile nowritebackup",
    group = _mutt
  })

-- RSS
local _rss = agrp("_rss", { clear = true })
acmd({ "BufNewFile", "BufRead" },
  {
    pattern = "*.rss,*.atom",
    command = "setfiletype = xml",
    group = _rss
  })

-- Git
local _git = agrp("_git", { clear = true })
acmd({ "BufRead" },
  {
    pattern = "COMMIT_EDITMSG",
    command = "setlocal spell spelllang=en_us",
    group = _git
  })

acmd({ "BufNewFile", "BufRead" },
  {
    pattern = "COMMIT_EDITMSG",
    command = "call feedkeys('ggi', 't')",
    group = _git
  })

-- markdown autocmds
local _markdown = agrp("_markdown", { clear = true })
-- acmd({ "BufNewFile", "BufRead" },
--   { pattern = "*.md,*.mkd,*.markdown",
--     command = "setfiletype = markdown",
--     group = _markdown })

acmd({ "FileType" },
  {
    pattern = "markdown",
    command = "set spell spelllang=en_us tw=100",
    group = _markdown
  })

-- Ruby autocmds
local _ruby = agrp("_ruby", { clear = true })
acmd({ "BufNewFile", "BufRead" },
  {
    pattern = "Gemfile,Gemfile.lock,Guardifile,Thorfile,config.ru,Vagrantfile,Berksfile,Berksfile.lock",
    command = "setfiletype ruby",
    group = _ruby
  })

acmd({ "BufNewFile", "BufRead" },
  {
    pattern = "Rakefile,*.rake",
    command = "setfiletype rake",
    group = _ruby
  })

acmd({ "BufNewFile", "BufRead" },
  {
    pattern = "Rakefile,*.rake",
    command = "set syntax=ruby",
    group = _ruby
  })

-- Python autocmds
local _python = agrp("_python", { clear = true })
acmd({ "BufNewFile", "BufRead" },
  {
    pattern = "*.py",
    command = "set ts=2 sts=2 sw=2 expandtab",
    group = _python
  })

-- diff autocmds
local _diff = agrp("_diff", { clear = true })
acmd({ "FileType" },
  {
    pattern = "diff",
    command = "syntax enable",
    group = _diff
  })

-- text file autocmds
local _spell = agrp("_spell", { clear = true })
acmd({ "BufNewFile", "BufRead" },
  {
    pattern = "*.txt",
    command = "set spell spelllang=en_us",
    group = _spell
  })

-- Text files
local _text = agrp("_text", { clear = true })
acmd({ "BufNewFile", "BufRead" },
  {
    pattern = "*.txt",
    command = "lua require('cmp').setup { completion = { autocomplete = false }}",
    group = _text
  })

-- Go autocmds
local _go = agrp("_go", { clear = true })
acmd({ "BufNewFile", "BufRead" },
  {
    pattern = "*.go",
    command = "setlocal ts=4 sts=4 sw=4 noexpandtab",
    group = _go
  })

-- acmd({ "BufWritePre" },
--   {
--     pattern = "*.go",
--     command = "lua OrgImports(1000)",
--     group = _go
--   })

-- Help in vertical split autocmds
local _help = agrp("_help", { clear = true })
acmd({ "FileType" },
  {
    pattern = "help",
    command = "wincmd L",
    group = _help
  })

-- Whitespace removal autocmds
local _whitespace = agrp("_whitespace", { clear = true })
acmd({ "FileWritePre", "FileAppendPre", "FilterWritePre", "BufWritePre" },
  {
    pattern = "*",
    command = ":call TrimWhitespace()",
    group = _whitespace
  })


--Trailing white space removal
-- Do not trim white space from file type 'mail' - the trailing spaces are
-- how paragraphs are formed, along with formatoption "w"
vim.api.nvim_exec([[
    function! TrimWhitespace()
      if &ft != 'mail'
        %s/\s\+$//e
      endif
    endfunction
  ]], false)

-- Organize Go imports
-- https://github.com/golang/tools/blob/master/gopls/doc/vim.md#neovim-imports
function OrgImports(wait_ms)
  local params = vim.lsp.util.make_range_params()
  params.context = { only = { "source.organizeImports" } }
  local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
  for _, res in pairs(result or {}) do
    for _, r in pairs(res.result or {}) do
      if r.edit then
        vim.lsp.util.apply_workspace_edit(r.edit, "UTF-8")
      else
        vim.lsp.buf.execute_command(r.command)
      end
    end
  end
end
