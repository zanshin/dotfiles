# Introduction

This repository holds my configuration files so that I can clone them to other machines
easily.

My primary OS is macOS and some of these configurations are tuned to work on that platform.
Configurations I no longer actively use, or that have been replaced, can be found in the
`deprecated` directory. Linux specific configurations are located in the `neuepunkte` repository. 


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

