# :zap: asa1984.nvim

My personal Neovim configuration.

Run the following command:

```bash
nix run github:asa1984/asa1984.nvim
```

then, Neovim starts with pre-configured settings!

![asa1984.nvim startup window](./_image/neovim_startup_widow.png)

## :rocket: Features

- Pre-configured settings
- Pre-installed plugins & development tools with [Nix](https://nixos.org/)
- Lazy loading with [lazy.nvim](https://github.com/folke/lazy.nvim) (Startup time is less than **20ms**)

## :package: Packages

| Name           | Description                                    |
| -------------- | ---------------------------------------------- |
| neovim-minimal | Neovim without any development tools (default) |
| neovim-light   | Neovim + Primary development tools             |
| neovim-full    | Neovim + All development tools                 |
| config         | The configuration files                        |

## :book: References

- [一般構築魔法(Nix)のVimへの応用について](https://zenn.dev/natsukium/articles/b4899d7b1e6a9a)
- [natsukium/dotfiles](https://github.com/natsukium/dotfiles)
- [Nixpkgs Reference Manual 24.11](https://nixos.org/manual/nixpkgs/stable/)
- [lazy.nvim on NixOS - Nixalted Website](https://nixalted.com)
