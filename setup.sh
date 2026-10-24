#!/usr/bin/env bash
# Link config files from the dotfiles repository into $HOME and $HOME/.config
#
# Usage: setup.sh [-y] [-n]
#   -y  don't prompt; accept each group's default
#   -n  dry run; show what would happen without changing anything
set -euo pipefail
shopt -s nullglob

DOTFILES="${DOTFILES:-$HOME/.dotfiles}"
XDG="${XDG_CONFIG_HOME:-$HOME/.config}"
STAMP="$(date +%Y%m%d%H%M%S)"
ASSUME_DEFAULTS=0
DRY_RUN=0

while getopts "yn" opt; do
  case "$opt" in
    y) ASSUME_DEFAULTS=1 ;;
    n) DRY_RUN=1 ;;
    *) echo "Usage: $0 [-y] [-n]" >&2; exit 2 ;;
  esac
done

# --- Helpers

# run CMD...: run a command, or just print it in dry-run mode
run() {
  if (( DRY_RUN )); then echo "    would run: $*"; else "$@"; fi
}

# ask "Question" Y|N: returns 0 for yes, 1 for no
ask() {
  local default="${2:-}" prompt reply
  case "$default" in
    Y) prompt="Y/n" ;;
    N) prompt="y/N" ;;
    *) prompt="y/n" ;;
  esac

  # Non-interactive: -y given, or no terminal to ask on
  if (( ASSUME_DEFAULTS )) || ! { : </dev/tty; } 2>/dev/null; then
    echo "$1 [$prompt] $default (default)"
    [[ "$default" == Y ]]
    return
  fi

  while true; do
    read -r -p "$1 [$prompt] " reply </dev/tty
    reply="${reply:-$default}"
    case "$reply" in
      [Yy]*) return 0 ;;
      [Nn]*) return 1 ;;
    esac
  done
}

# link SRC DEST
#   SRC is relative to $DOTFILES; DEST is an absolute path.
#   A link that's already correct is left alone, any other symlink is
#   replaced, and a real file or directory is moved aside to
#   DEST.bak.<timestamp>.
link() {
  local src="$DOTFILES/$1" dest="$2"

  if [[ ! -e "$src" ]]; then
    echo "  missing $src (skipped)"
    return
  fi

  if [[ -L "$dest" && "$(readlink "$dest")" == "$src" ]]; then
    echo "  ok      $dest"
    return
  fi

  if [[ -L "$dest" ]]; then
    run rm "$dest"
  elif [[ -e "$dest" ]]; then
    echo "  backup  $dest -> $dest.bak.$STAMP"
    run mv "$dest" "$dest.bak.$STAMP"
  fi

  run mkdir -p "$(dirname "$dest")"
  run ln -s "$src" "$dest"
  echo "  linked  $dest"
}

# group NAME DEFAULT SPEC...
#   Each SPEC is "source:destination".
#   A source ending in /* links every file in that directory, and the
#   destination is used as a prefix, e.g. "gem/*:$HOME/." -> ~/.gemrc
group() {
  local name="$1" default="$2" spec src dest f
  shift 2

  echo
  ask "Set up $name?" "$default" || return 0

  for spec in "$@"; do
    src="${spec%%:*}"
    dest="${spec#*:}"
    if [[ "$src" == */\* ]]; then
      for f in "$DOTFILES/${src%/\*}"/*; do
        link "${src%/\*}/$(basename "$f")" "$dest$(basename "$f")"
      done
    else
      link "$src" "$dest"
    fi
  done
}

# --- Main

[[ -d "$DOTFILES/.git" ]] || { echo "No git repo at $DOTFILES" >&2; exit 1; }

# Pull only when a branch is checked out. In a Jujutsu-managed (colocated)
# repo, HEAD is detached and a plain `git pull` would fail.
if git -C "$DOTFILES" symbolic-ref -q HEAD >/dev/null; then
  echo "Updating $DOTFILES"
  run git -C "$DOTFILES" pull --ff-only
else
  echo "Skipping update: $DOTFILES has no branch checked out (use jj git fetch)"
fi

# One line per group: name, default, then what gets linked where.
group gem       N "gem/*:$HOME/."
group git       Y "git:$XDG/git"
group tmux      Y "tmux:$XDG/tmux"
group nvim      Y "nvim:$XDG/nvim"
group alacritty Y "alacritty:$XDG/alacritty"
group starship  Y "starship/starship.toml:$XDG/starship.toml"
group jujutsu   Y "jj:$XDG/jj"
group bash      Y "bash/bash.d:$XDG/bash.d" \
                  "bash/bashrc:$HOME/.bashrc" \
                  "bash/bash_profile:$HOME/.bash_profile"

# ~/.ssh needs restrictive permissions if we end up creating it
[[ -d "$HOME/.ssh" ]] || run install -d -m 700 "$HOME/.ssh"
group ssh       Y "ssh/config:$HOME/.ssh/config"

echo
echo "Finished."
