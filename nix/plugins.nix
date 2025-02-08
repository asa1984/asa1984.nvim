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
    hlchunk-nvim
    mini-bufremove
    noice-nvim
    tailwind-tools-nvim
    ts-error-translator-nvim
    vimdoc-ja
    vim-stylus

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
    nvim-lspconfig
    lspkind-nvim
    lspsaga-nvim
    rust-tools-nvim
    crates-nvim
    neodev-nvim
    trouble-nvim
    SchemaStore-nvim
    tiny-inline-diagnostic-nvim
    neoconf-nvim

    # Formatter
    conform-nvim

    # Completion
    nvim-cmp
    cmp-nvim-lsp
    cmp-buffer
    cmp-cmdline
    cmp-path
    cmp_luasnip
    copilot-cmp
    luasnip

    # GitHub Copilot
    copilot-lua
    CopilotChat-nvim

    # Git
    gitsigns-nvim

    # UI
    alpha-nvim
    heirline-nvim
    neo-tree-nvim
    nvim-scrollbar
    nvim-ufo
    nvim-web-devicons
    statuscol-nvim
    telescope-file-browser-nvim
    telescope-nvim
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
