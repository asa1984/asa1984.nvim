pkgs: {
  primarry = with pkgs; [
    # Neovim plugin dependencies
    lazygit
    ripgrep

    # Language servers and formatters
    biome
    deno
    eslint
    graphql-language-service-cli
    just-lsp
    lua-language-server
    mdx-language-server
    nil
    nixfmt-rfc-style
    astro-language-server
    tailwindcss-language-server
    dockerfile-language-server-nodejs
    prettier
    vscode-langservers-extracted
    prisma-language-server
    pyright
    ruff
    shellcheck
    shfmt
    stylua
    taplo
    vtsls
  ];

  secondary = with pkgs; [
    # Bash
    bash-language-server

    # C/C++
    clang-tools

    # Go
    gopls

    # Haskell
    haskell-language-server
    haskellPackages.fourmolu

    # OCaml
    ocamlPackages.ocaml-lsp
    ocamlformat

    # Pkl
    pkl
    pkl-lsp

    # Protocol Buffers
    buf

    # Typst
    tinymist
    typstyle

    # Zig
    zls
  ];
}
