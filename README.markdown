# Introduction

This repository holds my configuration files so that I can clone them to other machines
easily.

My primary OS is macOS and some of these configurations are tuned to work on that platform. From about July 2011 until January 2016 `zsh` was my shell of choice. Recently I've switched back to `bash` since my working self maintains servers using `bash`. As I am more and more working on Linux computers, I am slowly updating configurations to be, if not OS agnostic, at least flexible.

I've incorporated the Base16 color scheme in to my setup, meaning there are several dependencies
that aren't held within this repository. Please see the [Base16](BASE16.markdown) file for more
information.

## Installation

    git clone git://github.com/zanshin/dotfiles.git ~/.dotfiles

## Setup

The `install.sh` script will setup the dotfiles I use on most machines. It asks about each tool,
defaulting to yes for those I typically use, and no for those I no longer use, or use as much.

    cd ~/.dotfiles
    ./install.sh

This script supersedes the older `make.sh` script which accomplished the same thing, albeit less
gracefully.

For manual setup, and more details about the dotfiles, please read the [Details](DETAILS.markdown)
file.

