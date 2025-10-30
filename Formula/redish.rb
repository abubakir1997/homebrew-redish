class Redish < Formula
  desc "Redis CLI wrapper with SSH-like host config and autocomplete"
  homepage "https://github.com/abubakir1997/homebrew-redish"
  url "https://github.com/abubakir1997/homebrew-redish/archive/refs/tags/v1.0.2.tar.gz"
  sha256 "32128b0c94f538ae056072d3c23b5e66fcbc3ede5fc7582c9abe67235161ea35"
  license "MIT"

  depends_on "fish"
  depends_on "redis"

  def install
    fish_completion.install "fish/config.fish" => "redish.fish"
    bash_completion.install "completion/redish.bash"
    zsh_completion.install "completion/_redish"

    (share/"redish/fish/functions").install "fish/functions/redish.fish"
    bin.install "bin/redish"
    etc.install "redish_config.example" => "redish_config"
  end

  def caveats
    <<~EOS
      Copy the example config to your home directory:
        cp #{etc}/redish_config ~/.redish_config

      The redish script expects Fish shell and redis-cli to be installed.
      You may need to add ~/.redish_config and customize your passwords.

      By default, redish expects your config at ~/.redish_config.
      To customize the path, set REDISH_CONFIG_FILE in your shell config.
      For Fish, add: set -gx REDISH_CONFIG_FILE ~/.redish_config to ~/.config/fish/config.fish
      For Bash/Zsh, add: export REDISH_CONFIG_FILE=~/.redish_config to ~/.bashrc or ~/.zshrc

      To enable bash completion for redish, ensure you have bash-completion installed:
        brew install bash-completion@2
      Then, add the following to your ~/.bash_profile or ~/.bashrc:
        if [ -f $(brew --prefix)/etc/bash_completion ]; then
          . $(brew --prefix)/etc/bash_completion
        fi
      After updating your config, restart your terminal or run:
        source ~/.bash_profile
        # or
        source ~/.bashrc

      
      To enable zsh completion for redish, ensure you have zsh installed and add the following to your ~/.zshrc:
        fpath+=($(brew --prefix)/share/zsh/site-functions)
        autoload -Uz compinit
        compinit
      After updating your config, restart your terminal or run:
        source ~/.zshrc
    EOS
  end
end