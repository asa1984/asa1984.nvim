pkgs:
let
  normalizePname =
    pname:
    builtins.replaceStrings
      [
        "-"
        "."
      ]
      [
        "_"
        "_"
      ]
      (pkgs.lib.toLower pname);

  pkgListToAttr =
    pkgList: pkgs.lib.foldl' (acc: pkg: acc // { "${normalizePname pkg.pname}" = pkg; }) { } pkgList;

  plugins = with pkgs.vimPlugins; [
    # Overlays
    copilot-lua
    conform-nvim
    hlchunk-nvim
    noice-nvim
    nvim-lspconfig
    snacks-nvim
    tailwind-tools-nvim
    ts-error-translator-nvim
    vim-stylus
    vimdoc-ja

    # Plugin manager
    lazy-nvim

    # Colorscheme
    tokyonight-nvim

    # Syntax highlighting
    nvim-treesitter

    # Core
    better-escape-nvim
    herdr-splits-nvim
    nvim-hlslens
    smart-splits-nvim
    sort-nvim
    which-key-nvim

    # Coding
    nvim-autopairs
    nvim-ts-autotag
    ts-comments-nvim

    # LSP
    SchemaStore-nvim
    lspsaga-nvim
    neoconf-nvim
    neodev-nvim
    tiny-inline-diagnostic-nvim
    trouble-nvim

    # Lean
    lean-nvim

    # Rust
    rustaceanvim
    crates-nvim

    # Completion
    blink-cmp
    luasnip

    # Git
    gitsigns-nvim
    gitlinker-nvim

    # UI
    alpha-nvim
    heirline-nvim
    neo-tree-nvim
    nvim-scrollbar
    nvim-ufo
    nvim-web-devicons
    statuscol-nvim
    toggleterm-nvim

    # Misc
    twilight-nvim
    zen-mode-nvim
    nvim-highlight-colors
    hmts-nvim

    # Internal libraries
    dressing-nvim
    plenary-nvim
    promise-async
    render-markdown-nvim
    nui-nvim
  ];
in
pkgListToAttr plugins
