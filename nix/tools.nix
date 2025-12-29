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
    lua-language-server
    mdx-language-server
    nil
    nixfmt-rfc-style
    nodePackages."@astrojs/language-server"
    nodePackages."@tailwindcss/language-server"
    nodePackages.dockerfile-language-server-nodejs
    nodePackages.prettier
    nodePackages.vscode-langservers-extracted
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
    nodePackages.bash-language-server

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

    # Protocol Buffers
    buf

    # Typst
    tinymist
    typstyle

    # Zig
    zls
  ];
}
