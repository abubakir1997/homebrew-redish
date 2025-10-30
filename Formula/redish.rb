class Redish < Formula
  desc "Redis CLI wrapper with SSH-like host config and autocomplete"
  homepage "https://github.com/abubakir1997/homebrew-redish"
  url "https://github.com/abubakir1997/homebrew-redish/archive/refs/tags/v1.0.1.tar.gz"
  sha256 "e35b981478d508ffb362d871c5947706e6a83daa102c68db437c255310116ab7"
  license "MIT"

  depends_on "fish"
  depends_on "redis"

  def install
    (share/"redish/fish/functions").install "fish/functions/redish.fish"
    (share/"redish/fish").install "fish/config.fish"
    bin.install "bin/redish"
    bin.install "bin/redish.fish"
    etc.install "redish_config.example" => "redish_config"
  end

  def caveats
    <<~EOS
      Copy the example config to your home directory:
        cp #{etc}/redish_config ~/.redish_config

      The redish script expects Fish shell and redis-cli to be installed.
      You may need to add ~/.redish_config and customize your passwords.

      Use 'redish' from any shell, or 'redish.fish' in Fish shell.
    EOS
  end
end