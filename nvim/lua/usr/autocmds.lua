-- Create some helpers
local autogrp= vim.api.nvim_create_augroup
local aucmd= vim.api.nvim_create_autocmd

-- ----- Filetype settings
-- Control preferences based on file type

-- General autocmds
local _general = autogrp("_general", { clear = true })
aucmd({ "FocusLost" },
      { pattern = "*",
        command = ":wa",
        group = _general })

aucmd({ "FileType" },
      { pattern = "*",
        command = "setlocal formatoptions-=ro",
        group = _general })

-- makefile autocmds
local _makefile = autogrp("_makefile", { clear = true  })
aucmd({ "FileType" },
      { pattern = "make",
        command = "setlocal ts=8 sts=8 sw=8 noexpandtab",
        group = _makefile })

-- YAML autocmds
local _yaml = autogrp("_yaml", { clear = true  })
aucmd({ "BufNewFile", "BufReadPost" },
      { pattern = "*.{yaml.yml}",
        command = "setfiletype=yaml foldmethod=indent",
        group = _yaml  })

aucmd({ "FileType"  },
      { pattern = "yaml",
        command = "setlocal ts=2 sts=2 sw=2 expandtab indentkeys-=<:>",
        group = _yaml })

-- mail (mutt) autocmds
local _mutt = autogrp("_mutt", { clear = true })
aucmd({ "FileType"  },
      { pattern = "mail",
        command = "formatoptions+=aw spell spelllang=en_us noautoindent nolist nobackup noswapfile nowritebackup",
        group = _mutt  })

local _rss = autogrp("_rss", { clear = true  })
aucmd({ "BufNewFile", "BufRead" },
      { pattern = "*.rss,*.atom",
        command = "setfiletype = xml",
        group = _rss })

local _git = autogrp("_git", { clear = true  })
aucmd({ "BufRead"},
      { pattern = "COMMIT_EDITMSG",
        command = "setlocal spell spelllang=en_us",
        group = _git })

aucmd({ "BufNewFile", "BufRead"  },
      { pattern = "COMMIT_EDITMSG",
        command = "call feedkeys('ggi', 't')",
        group = _git })

-- markdown autocmds
local _markdown = autogrp("_markdown", { clear = true  })
aucmd({ "BufNewFile", "BufRead" },
      { pattern = "*.md,*mkd,*.markdown",
        command = "set filetype markdown",
        group = _markdown })

aucmd({ "FileType"  },
      { pattern = "markdown",
        command = "set spell spelllang=en_us tw=100",
        group = _markdown })

-- Ruby autocmds
local _ruby = autogrp("_ruby", { clear = true  })
aucmd({ "BufNewFile", "BufRead" },
      { pattern = "Gemfile,Gemfile.lock,Guardifile,Thorfile,config.ru,Vagrantfile,Berksfile,Berksfile.lock",
        command = "setfiletype ruby",
        group = _ruby })

aucmd({ "BufNewFile", "BufRead" },
      { pattern = "Rakefile,*.rake",
        command = "setfiletype rake",
        group = _ruby })

aucmd({ "BufNewFile", "BufRead" },
      { pattern = "Rakefile,*.rake",
        command = "set syntax=ruby",
        group = _ruby })

-- Python autocmds
local _python = autogrp("_python", { clear = true  })
aucmd({ "BufNewFile", "BufRead" },
      { pattern = "*.py",
        command = "set ts=2 sts=2 sw=2 expandtab",
        group = _python })

-- diff autocmds
local _diff = autogrp("_diff", { clear = true  })
aucmd({ "FileType" },
      { pattern = "diff",
        command = "syntax enable",
        group = _diff })

-- text file autocmds
local _spell = autogrp("_spell", { clear = true })
aucmd({ "BufNewFile", "BufRead" },
      { pattern = "*.txt",
        command = "set spell spelllang=en_us",
        group = _spell})

-- Go autocmds
local _go = autogrp("_go", { clear = true  })
aucmd({ "BufNewFile", "BufRead" },
      { pattern = "*.go",
        command = "setlocal ts=4 sts=4 sw=4 noexpandtab",
        group = _go })

-- Help in vertical split autocmds
local _help = autogrp("_help", { clear = true })
aucmd({ "FileType" },
      { pattern = "help",
        command = "wincmd L",
        group = _help })

-- Whitespace removal autocmds
local _whitespace = autogrp("_whitespace", { clear = true })
aucmd({ "FileWritePre", "FileAppendPre", "FilterWritePre", "BufWritePre" },
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

