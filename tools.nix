{ pkgs }:
{
  primarry = with pkgs; [
    # Inner tools
    ## For telescope.nvim
    ripgrep

    ## Git TUI
    lazygit

    # Web
    ## HTML/CSS
    nodePackages.vscode-langservers-extracted

    ## JavaScript/TypeScript/Frameworks
    biome
    deno
    eslint
    nodePackages.prettier
    nodePackages.typescript-language-server
    nodePackages."@astrojs/language-server"
    nodePackages."@tailwindcss/language-server"

    ## GraphQL
    nodePackages.graphql-language-service-cli

    # Programming languages
    ## Lua
    lua-language-server
    stylua

    ## Nix
    nil
    nixfmt-rfc-style

    # Configuration languages
    ## TOML
    taplo
  ];

  secondary = with pkgs; [
    # Bash
    nodePackages.bash-language-server

    # C/C++
    clang-tools

    # Docker
    nodePackages.dockerfile-language-server-nodejs

    # Go
    gopls

    # Haskell
    haskell-language-server
    haskellPackages.fourmolu

    # OCaml
    ocamlPackages.ocaml-lsp
    ocamlformat

    # Protocol Buffers
    buf-language-server

    # Python
    ruff
    pyright

    # Shell
    shellcheck
    shfmt

    # Typst
    typst-lsp
    typstfmt

    # Zig
    zls
  ];
}