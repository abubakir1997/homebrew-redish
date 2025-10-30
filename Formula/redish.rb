class Redish < Formula
  desc "Redis CLI wrapper with SSH-like host config and autocomplete"
  homepage "https://github.com/abubakir1997/homebrew-redish"
  url "https://github.com/abubakir1997/homebrew-redish/archive/refs/tags/v1.0.0.tar.gz"
  version "1.0.0"
  sha256 "94b7520f89858f0497b1b55aca9103b3dd5c98097cc97558b23b771525b2e490"
  license "MIT"

  depends_on "fish"
  depends_on "redis"

  def install
    (share/"redish/fish/functions").install "fish/functions/redish.fish"
    (share/"redish/fish").install "fish/config.fish"
    bin.install "bin/redish"
    bin.install "bin/redish.fish"
    etc.install "redis_config.example" => "redish_config"
  end

  def caveats
    <<~EOS
      Copy the example config to your home directory:
        cp #{etc}/redish_config ~/.redis_config

      The redish script expects Fish shell and redis-cli to be installed.
      You may need to add ~/.redis_config and customize your passwords.

      Use 'redish' from any shell, or 'redish.fish' in Fish shell.
    EOS
  end
end