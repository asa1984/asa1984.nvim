# asa1984.nvim

asa1984's personal Neovim package, bundling Neovim configuration and plugins into a single package using Nix.

## Quick Commands

```bash
nix build           # Build neovim
nix run             # Build and run
nix fmt             # Format Nix code
nvfetcher Update    # Update plugin sources
stylua nvim/        # Format Lua code
```

## Project Structure

- `flake.nix`
- `nix/` - Nix package definitions for Neovim, plugins, language server and some tools.
- `nvim/` - Neovim configurations in Lua.
- `_sources` - Generated code by nvfetcher.

## Tips

- Since Nix flakes track files via Git, you must stage them before running nix build.
