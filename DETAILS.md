# Configuration details

Notes on each configuration in this repository: what it does, where it is
linked, and anything worth knowing. For the quick start, see the
[README](README.md).

**Linking.** `install.sh` (or `setup.sh`) links the tools marked **(install.sh)** below. The
commands shown are for linking a tool by hand. All links point into
`~/.dotfiles`. Commands that link a directory use `ln -sn`: if the destination
is already a link to a directory, `-n` replaces that link instead of creating a
new link inside the directory it points to. If the destination is a real
directory, move it aside first.

**Contents**

- [Shell](#shell): [Bash](#bash), [Starship](#starship)
- [Editors](#editors): [Neovim](#neovim), [Neovim cheat sheet](#neovim-cheat-sheet), [Zed](#zed)
- [Version control](#version-control): [Git](#git), [Jujutsu](#jujutsu)
- [Terminals](#terminals): [Ghostty](#ghostty), [tmux](#tmux), [WezTerm](#wezterm), [Kitty](#kitty), [Alacritty](#alacritty), [Ayu for Blink](#ayu-for-blink)
- [Mail](#mail): [Mutt](#mutt)
- [Other tools](#other-tools): [Homebrew](#homebrew), [SSH](#ssh), [GnuPG](#gnupg), [RubyGems](#rubygems), [Fonts](#fonts)
- [Repository files](#repository-files)

---

## Shell

### Bash

**(install.sh)**

```sh
ln -s ~/.dotfiles/bash/bash_profile ~/.bash_profile
ln -s ~/.dotfiles/bash/bashrc ~/.bashrc
ln -sn ~/.dotfiles/bash/bash.d ~/.config/bash.d
```

`.bash_profile` only sources `.bashrc`, so login and non-login shells get the
same configuration. `.bashrc` sets shell options, then sources the files in
`~/.config/bash.d`, which keeps `$HOME` down to `.bash_profile`, `.bashrc`, and
`.bash_history`. For interactive shells it also starts Starship, loads Homebrew's
completions, completes SSH host names from `~/.ssh/config`, and binds the up and
down arrows to search history for what you've already typed.

| File               | Contents                                                                                                                                                             |
| ------------------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `bash.d/paths`     | Builds `$PATH` (see below).                                                                                                                                          |
| `bash.d/exports`   | Environment variables: XDG directories, editor and pager, locale, tool settings, history, `LS_COLORS`, and color variables (`$Red`, `$BBlue`, …) for use in scripts. |
| `bash.d/aliases`   | Aliases, grouped by tool. macOS-only and Linux-only aliases sit in OS blocks.                                                                                        |
| `bash.d/functions` | Functions, grouped by tool: anything that needs arguments goes here rather than in `aliases`.                                                                        |
| `bash.d/work`      | Work-only aliases and functions (Chef/knife, VPN, AWS, EKS). Not sourced here; it's copied into my work dotfiles repository.                                         |
| `deprecated/`      | Earlier versions of these files, kept for reference.                                                                                                                 |

The files work on both macOS and Linux. Anything specific to one OS checks
`$OSTYPE` first.

**How `paths` builds `$PATH`.** On macOS it resets `PATH` and rebuilds the system
part with `path_helper` (from `/etc/paths` and `/etc/paths.d`). It then
assembles the final `PATH` from three lists:

1. `_path_front`: directories that should win name collisions (`~/.local/bin`,
   Cargo, Go, Homebrew).
2. The system directories, in their original order.
3. `_path_back`: everything else (`~/bin` and its subdirectories, Go,
   protobuf, Rex).

Directories that don't exist are skipped, duplicates are dropped, and anything
matching `_path_skip` is left out, so a stale entry disappears on its own. To add
a directory, put it in the right list. Run `path` to see the result, one entry
per line.

### Starship

**(install.sh)**

```sh
ln -s ~/.dotfiles/starship/starship.toml ~/.config/starship.toml
```

A two-line prompt: user, host (shown in red over SSH), directory, version
control state, and how long the last command took. Starship's own Git modules
are turned off. A custom module runs
`jj-starship` to show Jujutsu or Git status, so `jj-starship` must be installed.

---

## Editors

### Neovim

**(install.sh)**

```sh
ln -sn ~/.dotfiles/nvim ~/.config/nvim
```

Loosely based on [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim).
`init.lua` bootstraps [lazy.nvim](https://github.com/folke/lazy.nvim), loads one
plugin spec per file from `lua/plugins/`, then my own settings from `lua/my/`
(options, mappings, autocommands, and weasel-word highlighting).
`after/ftplugin/` holds per-filetype settings. Highlights:

- Language servers through Mason, completion with blink.cmp, and rustaceanvim
  for Rust.
- Treesitter, Telescope (with fzf and undo history), gitsigns, which-key,
  toggleterm, and render-markdown.
- Debugging with nvim-dap, plus Claude Code (claudecode.nvim) and gen.nvim.
- hardtime.nvim, to break bad motion habits.

It needs Neovim 0.12 or later, Node (for some language servers), and a Nerd
Font (I use Intel One Mono). See [nvim/README.md](nvim/README.md) for the layout
and troubleshooting.

### Neovim cheat sheet

A help page of Neovim commands I tend to forget. Neovim only finds it when the
directory is on the runtime path, for example as a package:

```sh
mkdir -p ~/.local/share/nvim/site/pack/my/start && ln -sn ~/.dotfiles/nvim-cheatsheet ~/.local/share/nvim/site/pack/my/start/cheatsheet
```

Then `:help myhelp` opens it.

### Zed

```sh
mkdir -p ~/.config/zed && for f in settings keymap tasks; do ln -s ~/.dotfiles/zed/$f.json ~/.config/zed/$f.json; done
```

Zed in Vim mode, with keymaps and settings mapped from my Neovim setup.
[`neovim-to-zed-migration-notes.md`](zed/neovim-to-zed-migration-notes.md)
explains each mapping. `tasks.json` adds global tasks that run the current line
or selection with HTTPie. `settings-old.json` is the previous configuration.

---

## Version control

### Git

**(install.sh)**

```sh
ln -sn ~/.dotfiles/git ~/.config/git
```

Git reads `~/.config/git/` automatically, so no `~/.gitconfig` is needed.

| File              | Contents                                                                                   |
| ----------------- | ------------------------------------------------------------------------------------------ |
| `config`          | Aliases, colors, editor and diff tool (nvim), merge and push behavior, SSH commit signing. |
| `ignore`          | Global ignores (macOS, Jujutsu, editor, and language cruft).                               |
| `attributes`      | Treats Xcode `.pbxproj` files as binary.                                                   |
| `allowed_signers` | Keys trusted for verifying SSH-signed commits.                                             |

My name and email aren't in the repo. `config` includes
`~/.local/config/git.config`, which each machine provides.

Several shell aliases depend on Git aliases defined here: `gh` uses `git hist`,
and `gt` uses `git today`.

### Jujutsu

**(install.sh)**

```sh
ln -sn ~/.dotfiles/jj ~/.config/jj
```

My [Jujutsu](https://docs.jj-vcs.dev/latest/) configuration: `jj` alone runs
`jj status`, Neovim is the editor, and there are short and long log aliases plus
`jj history`, a compact one-line log. `exports` sets `JJ_CONFIG` to this
directory, so jj uses the same location on macOS and Linux. jj creates
`jj/repos/` for per-repository settings; it's ignored by Git.

---

## Terminals

### Ghostty

My current terminal.

```sh
ln -sn ~/.dotfiles/ghostty ~/.config/ghostty
```

Intel One Mono at 15 pt, the Ayu theme on a black background, tabs in the title
bar, and a quick-terminal toggle on <kbd>Ctrl</kbd>+<kbd>Opt</kbd>+<kbd>Cmd</kbd>+<kbd>\\</kbd>.
<kbd>Cmd</kbd>+<kbd>K</kbd> is unbound because it intercepted <kbd>Ctrl</kbd>+<kbd>K</kbd>;
<kbd>Cmd</kbd>+<kbd>L</kbd> clears the screen instead.

To make Ghostty's terminfo available on a remote host, run `ghostsync HOST`
(from `functions`).

### tmux

**(install.sh)**

```sh
ln -sn ~/.dotfiles/tmux ~/.config/tmux
```

The prefix is the backtick (<kbd>`</kbd>); press it twice to type a literal
backtick. Windows and panes are numbered from 1. <kbd>|</kbd> and <kbd>-</kbd>
split panes, <kbd>h</kbd><kbd>j</kbd><kbd>k</kbd><kbd>l</kbd> move between
them, and <kbd>Ctrl</kbd>+<kbd>J</kbd> opens an fzf popup for switching
sessions. tmux 3.1 or later reads `~/.config/tmux/tmux.conf`.

### WezTerm

```sh
ln -sn ~/.dotfiles/wezterm ~/.config/wezterm
```

The Ayu color scheme, Intel One Mono, and a plain tab bar.

### Kitty

```sh
ln -sn ~/.dotfiles/kitty ~/.config/kitty
```

Kitty's full annotated default configuration, with my changes (Intel One Mono,
no cursor blink, larger scrollback).

### Alacritty

**(install.sh)**

```sh
ln -sn ~/.dotfiles/alacritty ~/.config/alacritty
```

Mostly an Ayu-style color scheme. Rarely used.

### Ayu for Blink

A fork of the Ayu Dark theme for [Blink](https://blink.sh), an iOS terminal.
It's added from within Blink rather than linked.

---

## Mail

### Mutt

```sh
ln -sn ~/.dotfiles/mutt ~/.mutt
```

NeoMutt (or Mutt) with a separate configuration file for each account in
`accounts/`. Mail is synced between local Maildirs and IMAP with mbsync
(`mbsyncrc`), and sent with msmtp (`msmtprc`). Account passwords are stored
GPG-encrypted in `passwords/`. `themes/` holds color schemes, `scripts/` holds
mail-check and attachment helpers, and `unitfiles/` has a systemd timer for
checking mail on Linux. `offlineimap/` is from before the switch to mbsync.

This setup is specific to my accounts and machines. **Don't copy it as is.**
[MUTT.md](MUTT.md) has the full list of requirements.

---

## Other tools

### Homebrew

```sh
brew bundle --file=~/.dotfiles/brew/Brewfile
```

`Brewfile` is the current list of taps, formulae, casks, and Mac App Store
apps. To update it after installing something, run
`brew bundle dump --force --file=~/.dotfiles/brew/Brewfile`.

`Brewfile-danube`, `Brewfile-fugazi`, and `Brewfile-fugue` are 2023 snapshots
from individual machines. `Brewfile+` uses an old format that current Homebrew
no longer reads.

You don't need to edit `/etc/paths` to put Homebrew first: `bash.d/paths` places
`/opt/homebrew/bin` ahead of the system directories.

### SSH

**(install.sh)**

```sh
ln -s ~/.dotfiles/ssh/config ~/.ssh/config
```

Host aliases for the machines I connect to. Bash uses this file to tab-complete
host names for `ssh`, `scp`, and `sftp`. SSH refuses a `config` file that other
users can write to. If permissions change after a pull, the `cssh` alias resets
them to 600.

### GnuPG

```sh
mkdir -p ~/.gnupg && chmod 700 ~/.gnupg && ln -s ~/.dotfiles/gnupg/gpg.conf ~/.gnupg/gpg.conf
```

Hardened defaults (SHA-512 and AES-256 preferences, long key IDs with
fingerprints, no version or comment headers), heavily commented so I remember
what each option does. Sets my default key and keyserver.

### RubyGems

**(install.sh)**

```sh
ln -s ~/.dotfiles/gem/gemrc ~/.gemrc
```

Stops `gem install` and `gem update` from generating documentation.

### Fonts

`fonts/.fonts` holds older font files (Anonymous Pro, Droid, San Francisco
Display, Font Awesome). On Linux they can go in `~/.fonts`. On macOS, install
fonts with Font Book or Homebrew instead. My current font, Intel One Mono,
comes from Homebrew (`brew install font-intel-one-mono`).

---

## Repository files

| File                | Purpose                                                                                                                                                                                                                                           |
| ------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `install.sh`        | The setup script described in the [README](README.md).                                                                                                                                                                                            |
| `setup.sh`          | A newer version of `install.sh` that links the same tools. It backs up real files before replacing them (as `NAME.bak.<timestamp>`), leaves correct links alone, and takes `-n` for a dry run and `-y` to accept every default without prompting. |
| `ansible.tgz`       | An archived Ansible playbook from an earlier attempt to manage these files, with roles for Bash, Git, Neovim, tmux, SSH, and the terminals.                                                                                                       |
| `MUTT.md`           | Requirements and status of the mail setup.                                                                                                                                                                                                        |
| `package-lock.json` | Empty. Left over from running npm in the repository root; safe to delete.                                                                                                                                                                         |
