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
    gitlinker-nvim
    hlchunk-nvim
    noice-nvim
    nvim-lspconfig
    snacks-nvim
    tailwind-tools-nvim
    ts-error-translator-nvim
    vim-stylus
    vimdoc-ja

    # Agent
    avante-nvim

    # Plugin manager
    lazy-nvim

    # Colorscheme
    tokyonight-nvim

    # Syntax highlighting
    nvim-treesitter

    # Core
    better-escape-nvim
    nvim-hlslens
    smart-splits-nvim
    sort-nvim
    which-key-nvim

    # Coding
    comment-nvim
    nvim-ts-context-commentstring
    nvim-autopairs
    nvim-ts-autotag
    ts-comments-nvim

    # LSP
    SchemaStore-nvim
    lspkind-nvim
    lspsaga-nvim
    neoconf-nvim
    neodev-nvim
    rust-tools-nvim
    tiny-inline-diagnostic-nvim
    trouble-nvim

    # Rust
    rustaceanvim
    crates-nvim

    # Formatter
    conform-nvim

    # Completion
    blink-cmp
    cmp-buffer
    cmp-cmdline
    cmp-nvim-lsp
    cmp-path
    cmp_luasnip
    copilot-cmp
    luasnip
    nvim-cmp

    # GitHub Copilot
    # copilot-lua
    CopilotChat-nvim

    # Git
    gitsigns-nvim
    gitlinker-nvim

    # UI
    alpha-nvim
    heirline-nvim
    nvim-scrollbar
    nvim-ufo
    nvim-web-devicons
    statuscol-nvim
    toggleterm-nvim

    # Misc
    denops-vim
    markdown-nvim
    twilight-nvim
    zen-mode-nvim
    nvim-highlight-colors
    hmts-nvim
    presence-nvim

    # Internal libraries
    dressing-nvim
    plenary-nvim
    promise-async
    render-markdown-nvim
    nui-nvim
  ];
in
pkgListToAttr plugins
