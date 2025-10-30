# redish

A Redis CLI wrapper with SSH-config-like host selection and autocomplete.

## Features

- **SSH config-style host management**: Store Redis connection info per host in a familiar format (`~/.redis_config`).
- **Shell autocompletion** for hosts and Redis commands (Fish shell).
- **Works in Bash, Zsh, and Fish** via a universal wrapper.
- **Homebrew installable**.
- **Secure password handling** (passwords not echoed in verbose mode).

## Installation

```sh
brew tap asalem987-comcast/redish
brew install redish
cp $(brew --prefix)/etc/redish_config ~/.redis_config
```

Then **edit your `~/.redis_config`** to add your Redis hosts and credentials.
See `redis_config.example` for the format.

## Usage

```sh
redish <host> <command> [args...]
```

Example:
```sh
redish mlx-customer-states GET somekey
```

- Add `-v` or `--verbose` for verbose output about connection details.

## Configuration

Edit `~/.redis_config` to add your Redis hosts and credentials.  
See `redis_config.example` for the format.

## Autocompletion (Fish Shell)

If you use Fish shell, hostnames and common Redis commands will autocomplete after typing `redish` thanks to the included `fish/config.fish`.

## Requirements

- [fish shell](https://fishshell.com/) (used for internal scripting, automatically detected and invoked by the wrapper)
- [redis-cli](https://redis.io/docs/manual/cli/) (installed automatically with Homebrew `redis`)
- Bash or Zsh for main wrapper usage (Fish for advanced completions)

## Advanced

- Fish users can use autocompletion for host and command selection.
- Bash/Zsh users use the `redish` command, which internally calls Fish.

## Security Note

Passwords in your config file are used only for connecting to Redis and are masked in verbose output.

## License

MIT

## Contributing

PRs welcome! Please file issues for bugs or feature requests.

## Troubleshooting

- Ensure `fish` and `redis-cli` are installed and in your PATH.
- Ensure your `~/.redis_config` file is present and properly formatted.
- For Fish autocompletion to work, make sure `fish/config.fish` is loaded in your Fish configuration.
