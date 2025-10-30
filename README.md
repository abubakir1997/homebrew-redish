# redish

A Redis CLI wrapper with SSH-config-like host selection and autocomplete.

## Features

- **SSH config-style host management**: Store Redis connection info per host in a familiar format (`~/.redish_config`).
- **Shell autocompletion** for hosts and Redis commands (Fish shell).
- **Works in Bash, Zsh, and Fish** via a universal wrapper.
- **Homebrew installable**.
- **Secure password handling** (passwords not echoed in verbose mode).

## Installation

```sh
brew tap abubakir1997/redish
brew install redish
cp $(brew --prefix)/etc/redish_config ~/.redish_config
```

Then **edit your `~/.redish_config`** to add your Redis hosts and credentials.
See `redish_config.example` for the format.

## Update

```sh
brew update
brew upgrade redish
```
If that doesn't work, try...

```sh
brew remove redish
brew untap abubakir1997/redish
brew tap abubakir1997/redish
brew install redish
```

## Usage

```sh
redish <host> <command> [args...]
```

Example:
```sh
redish analytics-cache GET somekey
```

- Add `-v` or `--verbose` for verbose output about connection details.

## Configuration

Edit `~/.redish_config` to add your Redis hosts and credentials.  
See `redish_config.example` for the format.

## Autocompletion

Hostnames and common Redis commands will autocomplete after typing `redish`.

## Requirements

- [fish shell](https://fishshell.com/) (used for internal scripting, automatically detected and invoked by the wrapper)
- [redis-cli](https://redis.io/docs/manual/cli/) (installed automatically with Homebrew `redis`)
- Bash or Zsh for main wrapper usage (Fish for advanced completions)

## Security Note

Passwords in your config file are used only for connecting to Redis and are masked in verbose output.

## License

MIT

## Contributing

PRs welcome! Please file issues for bugs or feature requests.

## Deployment / Release

To publish a new version of `redish` to Homebrew:

1. **Make and commit your changes**  
   ```sh
   git add .
   git commit -m "Your change description"
   git push
   ```

2. **Tag a new release**  
   Choose a new version number (e.g., `v1.0.2`):
   ```sh
   git tag v1.0.2
   git push origin v1.0.2
   ```

3. **Draft a release on GitHub (optional but recommended)**  
   - Go to your repo’s Releases page.
   - Click "Draft a new release" and select your new tag.

4. **Update the Homebrew formula (`Formula/redish.rb`)**  
   - Get the sha256 for the new tarball:
     ```sh
     curl -L https://github.com/abubakir1997/homebrew-redish/archive/refs/tags/v1.0.2.tar.gz -o v1.0.2.tar.gz
     shasum -a 256 v1.0.2.tar.gz
     rm v1.0.2.tar.gz
     ```
   - Update the `url` and `sha256` in `Formula/redish.rb`:
      ```ruby
      url "https://github.com/abubakir1997/homebrew-redish/archive/refs/tags/v1.0.2.tar.gz"
      sha256 "<COPIED_SHA_256>"
      ```

5. **Commit and push the updated formula**
   ```sh
   git add Formula/redish.rb
   git commit -m "chore: update formula for v1.0.2"
   git push
   ```

6. **Users can upgrade**
   ```sh
   brew update
   brew upgrade redish
   ```

---

**Summary Table**

| Step                | Command/Action                                                                 |
|---------------------|-------------------------------------------------------------------------------|
| Commit changes      | `git add . && git commit -m "..." && git push`                                 |
| Tag new version     | `git tag v1.0.2 && git push origin v1.0.2`                                    |
| Get tarball & SHA   | `curl -L ... -o v1.0.2.tar.gz` & `shasum -a 256 v1.0.2.tar.gz`                |
| Update formula      | Edit `Formula/redish.rb` with new URL/SHA                                     |
| Push formula        | `git add Formula/redish.rb && git commit -m "..." && git push`                |
| User upgrade        | `brew upgrade redish`                                                          |

---

If you have any issues with releases or upgrading, see the Troubleshooting section below or file an issue!

## Troubleshooting

- Ensure `fish` and `redis-cli` are installed and in your PATH.
- Ensure your `~/.redish_config` file is present and properly formatted.
- For Fish autocompletion to work, make sure `fish/config.fish` is loaded in your Fish configuration.

### Error: invalid attribute for formula 'abubakir1997/redish/redish': version (nil)

Untap before installing

```sh
brew untap abubakir1997/redish
brew tap abubakir1997/redish
brew install redish
```