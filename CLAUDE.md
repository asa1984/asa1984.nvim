# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a sophisticated Neovim configuration repository that uses Nix flakes for reproducible package management. The configuration features lazy loading with startup times under 20ms and includes comprehensive development tools.

## Common Commands

### Building and Testing

```bash
# Build the default minimal package
nix build

# Build specific variants
nix build .#neovim-light     # With primary dev tools
nix build .#neovim-full      # With all dev tools
nix build .#config           # Just the configuration

# Test the configuration
nix run                      # Run minimal version
nix run .#neovim-light       # Run light version
nix run .#neovim-full        # Run full version

# Format Nix code
nix fmt

# Update plugin sources
nvfetcher update

# Format Lua code
stylua nvim/
```

### Development Workflow

```bash
# Update flake lock file
nix flake update

# Check flake validity
nix flake check

# Show package info
nix flake show
```

## Architecture

### Core Technologies

- **Nix Flakes**: Package management and reproducible builds
- **lazy.nvim**: Plugin manager with lazy loading
- **nvfetcher**: Plugin version management
- **Lua**: Configuration language

### Directory Structure

- `flake.nix`: Main Nix flake definition with 4 package variants
- `nvfetcher.toml`: Plugin source definitions for custom plugins
- `nix/`: Nix configuration files
  - `plugins.nix`: 120+ plugin definitions organized by category
  - `tools.nix`: Development tools (primary and secondary)
  - `config.nix`: Main configuration builder
  - `lib/make-neovim-wrapper.nix`: Neovim wrapper builder
- `nvim/`: Neovim Lua configuration
  - `init.lua`: Entry point
  - `lua/base.lua`: Basic settings
  - `lua/keymap.lua`: Key mappings
  - `lua/plugins/`: Plugin-specific configurations

### Package Variants

1. **neovim-minimal**: Base Neovim without dev tools (default)
2. **neovim-light**: + Primary development tools
3. **neovim-full**: + All development tools
4. **config**: Just configuration files

### Plugin Management

- Custom plugins managed via `nvfetcher.toml`
- Mainstream plugins via nixpkgs
- All plugins configured in `nix/plugins.nix`
- Plugin configurations in `nvim/lua/plugins/`

## Development Tools

### Primary Tools (neovim-light)

- ripgrep, lazygit
- Language servers: HTML/CSS, TypeScript/JavaScript, Lua, Nix
- Formatters: Biome, Prettier, Stylua, nixfmt
- Specialized: Tailwind CSS, GraphQL, TOML support

### Secondary Tools (neovim-full)

- Additional language servers: Go, Haskell, Python, C/C++, OCaml
- Protocol Buffers, Typst, Zig support

## Key Features

### AI Integration

- **claudecode-nvim**: Claude AI integration
- **copilot-lua**: GitHub Copilot support
- **avante-nvim**: AI agent functionality

### Modern Development

- Multiple completion engines (blink-cmp, nvim-cmp)
- Comprehensive LSP setup with 15+ language servers
- Advanced UI with noice.nvim and snacks.nvim
- Git integration with gitsigns and gitlinker

### Performance

- Lazy loading for all plugins
- Startup time < 20ms
- Optimized fold configuration and settings

## Configuration Conventions

### Lua Formatting

- Use Stylua with 4-space indentation
- Sort requires enabled
- Run `stylua nvim/` before committing

### Nix Formatting

- Use nixfmt-rfc-style
- Run `nix fmt` before committing

### Plugin Addition

1. Add source to `nvfetcher.toml` if custom
2. Add plugin definition to `nix/plugins.nix`
3. Create configuration in `nvim/lua/plugins/`
4. Update plugin sources with `nvfetcher update`

## Platform Support

- Linux: aarch64, x86_64
- macOS: aarch64 (Apple Silicon), x86_64 (Intel)

