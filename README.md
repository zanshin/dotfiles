# dotfiles

My configuration files, kept in one repository so I can set up any machine the
same way with one clone and one script.

macOS is my primary platform, and some of these configurations are tuned for
it. The Bash files also work on Linux. Linux-only configurations live in the
separate [neuepunkte](https://github.com/zanshin/neuepunkte) repository.

## Install

```sh
git clone https://github.com/zanshin/dotfiles.git ~/.dotfiles
cd ~/.dotfiles && ./install.sh
```

`install.sh` first pulls the latest `master` (skipped when no branch is checked
out, as in a Jujutsu-managed clone), then asks about each tool before linking
it. Each question has a default (shown as `Y/n` or `y/N`), so pressing Enter
through all of them gives my usual setup. It creates symlinks only; it
doesn't install any software.

`setup.sh` does the same job and adds a dry run (`./setup.sh -n`), automatic
backups of real files it would replace, and `-y` to accept every default.

Both scripts link Bash, Starship, Git, Jujutsu, Neovim, tmux, Alacritty, SSH,
and RubyGems. Everything else is linked by hand. [DETAILS.md](DETAILS.md) has
the commands for each tool.

## What's here

| Directory                       | What it configures                                                     |
| ------------------------------- | ---------------------------------------------------------------------- |
| `bash`                          | Bash: startup files plus `bash.d/` (PATH, exports, aliases, functions) |
| `starship`                      | [Starship](https://starship.rs) prompt, with Jujutsu status            |
| `nvim`                          | Neovim (lazy.nvim, LSP, Treesitter, Telescope, …)                      |
| `nvim-cheatsheet`               | A personal Neovim help page (`:help myhelp`)                           |
| `zed`                           | Zed editor settings, keymap, and tasks                                 |
| `git`                           | Git config, global ignores, attributes, SSH signing                    |
| `jj`                            | [Jujutsu](https://docs.jj-vcs.dev/latest/) config and aliases          |
| `ghostty`                       | Ghostty, my current terminal                                           |
| `tmux`                          | tmux                                                                   |
| `wezterm`, `kitty`, `alacritty` | Other terminals, rarely used                                           |
| `ayu`                           | Ayu Dark theme for Blink, an iOS terminal                              |
| `mutt`                          | Mutt/NeoMutt mail, with mbsync and msmtp (see [MUTT.md](MUTT.md))      |
| `ssh`                           | SSH client config                                                      |
| `gnupg`                         | GnuPG settings                                                         |
| `gem`                           | RubyGems settings                                                      |
| `brew`                          | Homebrew `Brewfile`s                                                   |
| `fonts`                         | Old font files                                                         |

[DETAILS.md](DETAILS.md) covers each one: what it does, where it's linked, and
anything to watch out for.
