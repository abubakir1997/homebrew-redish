#!/usr/bin/env fish
set -x REDISH_CONFIG_FILE $HOME/.redish_config
source (brew --prefix)/share/redish/fish/functions/redish.fish
redish $argv