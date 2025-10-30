#!/usr/bin/env fish
set -x REDIS_CONFIG_FILE $HOME/.redis_config
source (brew --prefix)/share/redish/fish/functions/redish.fish
redis $argv