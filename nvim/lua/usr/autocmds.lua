-- Create some helpers
local agrp = vim.api.nvim_create_augroup
local acmd = vim.api.nvim_create_autocmd

-- ----- Filetype settings
-- Control preferences based on file type

-- General autocmds
local _general = agrp("_general", { clear = true })
acmd({ "FocusLost" },
      { pattern = "*",
        command = ":wa",
        group = _general })

acmd({ "FileType" },
      { pattern = "*",
        command = "setlocal formatoptions-=ro",
        group = _general })

-- makefile autocmds
local _makefile = agrp("_makefile", { clear = true  })
acmd({ "FileType" },
      { pattern = "make",
        command = "setlocal ts=8 sts=8 sw=8 noexpandtab",
        group = _makefile })

-- YAML autocmds
local _yaml = agrp("_yaml", { clear = true  })
acmd({ "BufNewFile", "BufReadPost" },
      { pattern = "*.{yaml.yml}",
        command = "setfiletype=yaml foldmethod=indent",
        group = _yaml  })

acmd({ "FileType"  },
      { pattern = "yaml",
        command = "setlocal ts=2 sts=2 sw=2 expandtab indentkeys-=<:>",
        group = _yaml })

-- mail (mutt) autocmds
local _mutt = agrp("_mutt", { clear = true })
acmd({ "FileType"  },
      { pattern = "mail",
        command = "formatoptions+=aw spell spelllang=en_us noautoindent nolist nobackup noswapfile nowritebackup",
        group = _mutt  })

local _rss = agrp("_rss", { clear = true  })
acmd({ "BufNewFile", "BufRead" },
      { pattern = "*.rss,*.atom",
        command = "setfiletype = xml",
        group = _rss })

local _git = agrp("_git", { clear = true  })
acmd({ "BufRead"},
      { pattern = "COMMIT_EDITMSG",
        command = "setlocal spell spelllang=en_us",
        group = _git })

acmd({ "BufNewFile", "BufRead"  },
      { pattern = "COMMIT_EDITMSG",
        command = "call feedkeys('ggi', 't')",
        group = _git })

-- markdown autocmds
local _markdown = agrp("_markdown", { clear = true  })
acmd({ "BufNewFile", "BufRead" },
      { pattern = "*.md,*mkd,*.markdown",
        command = "setfiletype = markdown",
        group = _markdown })

acmd({ "FileType"  },
      { pattern = "markdown",
        command = "set spell spelllang=en_us tw=100",
        group = _markdown })

-- Ruby autocmds
local _ruby = agrp("_ruby", { clear = true  })
acmd({ "BufNewFile", "BufRead" },
      { pattern = "Gemfile,Gemfile.lock,Guardifile,Thorfile,config.ru,Vagrantfile,Berksfile,Berksfile.lock",
        command = "setfiletype ruby",
        group = _ruby })

acmd({ "BufNewFile", "BufRead" },
      { pattern = "Rakefile,*.rake",
        command = "setfiletype rake",
        group = _ruby })

acmd({ "BufNewFile", "BufRead" },
      { pattern = "Rakefile,*.rake",
        command = "set syntax=ruby",
        group = _ruby })

-- Python autocmds
local _python = agrp("_python", { clear = true  })
acmd({ "BufNewFile", "BufRead" },
      { pattern = "*.py",
        command = "set ts=2 sts=2 sw=2 expandtab",
        group = _python })

-- diff autocmds
local _diff = agrp("_diff", { clear = true  })
acmd({ "FileType" },
      { pattern = "diff",
        command = "syntax enable",
        group = _diff })

-- text file autocmds
local _spell = agrp("_spell", { clear = true })
acmd({ "BufNewFile", "BufRead" },
      { pattern = "*.txt",
        command = "set spell spelllang=en_us",
        group = _spell})

-- Go autocmds
local _go = agrp("_go", { clear = true  })
acmd({ "BufNewFile", "BufRead" },
      { pattern = "*.go",
        command = "setlocal ts=4 sts=4 sw=4 noexpandtab",
        group = _go })

acmd({ "BufWritePre" },
     { pattern = "*.go",
       command = "lua vim.lsp.buf.formatting_sync()",
       group = _go})

-- Text files
local _text = agrp("_text", { clear = true  })
acmd({ "BufNewFile", "BufRead"  },
      { pattern = "*.txt",
        command = "lua require('cmp').setup.buffer{ enable = false }",
        group = _text})

-- Help in vertical split autocmds
local _help = agrp("_help", { clear = true })
acmd({ "FileType" },
      { pattern = "help",
        command = "wincmd L",
        group = _help })

-- Whitespace removal autocmds
local _whitespace = agrp("_whitespace", { clear = true })
acmd({ "FileWritePre", "FileAppendPre", "FilterWritePre", "BufWritePre" },
      { pattern = "*",
        command = ":call TrimWhitespace()",
        group = _whitespace })


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

